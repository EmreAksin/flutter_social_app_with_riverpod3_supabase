import 'dart:convert';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_social_app/core/constants/app_constants.dart';
import 'package:supabase_social_app/features/post/data/models/comment_model.dart';
import 'package:supabase_social_app/features/post/data/models/post_model.dart';

class PostRemoteDataSource {
  final SupabaseClient _supabaseClient;
  PostRemoteDataSource(this._supabaseClient);

  Stream<List<PostModel>> getPostsStream() async* {
    try {
      await for (final data
          in _supabaseClient
              .from('posts')
              .stream(primaryKey: ['id'])
              .order('created_at', ascending: false)) {
        final enrichedPosts = await Future.wait(
          data.map((json) async {
            final userId = json['user_id'];
            try {
              final profileData = await _supabaseClient
                  .from('profiles')
                  .select('username, avatar_url')
                  .eq('id', userId)
                  .maybeSingle();

              return PostModel.fromJson({
                ...json,
                if (profileData != null) 'username': profileData['username'],
                if (profileData != null)
                  'user_avatar_url': profileData['avatar_url'],
              });
            } catch (e) {
              throw Exception(e);
            }
          }),
        );

        yield enrichedPosts;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PostModel>> getAllPosts() async {
    final response = await _supabaseClient
        .from('posts')
        .select('*,profiles!posts_user_id_fkey(username,avatar_url)')
        .order('created_at', ascending: false);
    return response.map<PostModel>((json) {
      final profile = json['profiles'] as Map<String, dynamic>?;
      return PostModel.fromJson({
        ...json,
        'username': profile?['username'],
        'user_avatar_url': profile?['avatar_url'],
      });
    }).toList();
  }

  Future<List<PostModel>> getPostsByUserId(String userId) async {
    final response = await _supabaseClient
        .from('posts')
        .select('*, profiles!posts_user_id_fkey(username,avatar_url)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return response.map<PostModel>((json) {
      final profile = json['profiles'] as Map<String, dynamic>?;
      return PostModel.fromJson({
        ...json,
        'username': profile?['username'],
        'user_avatar_url': profile?['avatar_url'],
      });
    }).toList();
  }

  Future<PostModel> getPost(String postId) async {
    final response = await _supabaseClient
        .from('posts')
        .select('*, profiles!posts_user_id_fkey(username, avatar_url)')
        .eq('id', postId)
        .single();

    final profile = response['profiles'] as Map<String, dynamic>?;
    return PostModel.fromJson({
      ...response,
      'username': profile?['username'],
      'user_avatar_url': profile?['avatar_url'],
    });
  }

  Future<PostModel> createPost({
    required String userId,
    required String content,
    String? imageUrl,
  }) async {
    final response = await _supabaseClient
        .from('posts')
        .insert({
          'user_id': userId,
          'content': content,
          if (imageUrl != null) 'image_url': imageUrl,
        })
        .select()
        .single();
    return PostModel.fromJson(response);
  }

  Future<String> uploadPostImage(String userId, File imageFile) async {
    final fileExt = imageFile.path.split('.').last;

    final fileName =
        '$userId/${DateTime.now().microsecondsSinceEpoch}.$fileExt';

    await _supabaseClient.storage
        .from(AppConstants.postsBucket)
        .update(fileName, imageFile);
    return _supabaseClient.storage
        .from(AppConstants.postsBucket)
        .getPublicUrl(fileName);
  }

  Future<void> deletePost(String postId) async {
    await _supabaseClient.from('posts').delete().eq('id', postId);
  }

  Future<void> likePost(String userId, String postId) async {
    await _supabaseClient.from('likes').insert({
      'user_id': userId,
      'post_id': postId,
    });

    await _supabaseClient
        .rpc(
          'exec_sql',
          params: {
            'sql':
                'UPDATE posts SET likes_count = likes_count + 1 WHERE id = \'$postId\' ',
          },
        )
        .catchError((_) async {
          final current = await _supabaseClient
              .from('posts')
              .select('likes_count')
              .eq('id', postId)
              .single();

          await _supabaseClient
              .from('posts')
              .update({'likes_count': (current['likes_count'] as int) + 1})
              .eq('id', postId);
        });
  }

  Future<void> unlikePost(String userId, String postId) async {
    await _supabaseClient
        .from('likes')
        .delete()
        .eq('user_id', userId)
        .eq('post_id', postId);

    final current = await _supabaseClient
        .from('posts')
        .select('likes_count')
        .eq('id', postId)
        .single();

    final newCount = ((current['likes_count'] as int) - 1).clamp(0, 999999);
    await _supabaseClient
        .from('posts')
        .update({'likes_count': newCount})
        .eq('id', postId);
  }

  Future<bool> isPostLiked(String userId, String postId) async {
    final response = await _supabaseClient
        .from('likes')
        .select() // Tüm alanlar (sadece varlık kontrolü)
        .eq('user_id', userId)
        .eq('post_id', postId);

    return response.isNotEmpty;
  }

  Future<List<CommentModel>> getComments(String postId) async {
    final response = await _supabaseClient
        .from('comments')
        .select('*, profiles!comments_user_id_fkey(username, avatar_url)')
        .eq('post_id', postId) // WHERE post_id = postId
        .order('created_at', ascending: false); // Yeniden eskiye

    return response.map<CommentModel>((json) {
      final profile = json['profiles'] as Map<String, dynamic>?;
      return CommentModel.fromJson({
        ...json,
        'username': profile?['username'],
        'user_avatar_url': profile?['avatar_url'],
      });
    }).toList();
  }

  Future<CommentModel> addComment({
    required String userId,
    required String postId,
    required String content,
  }) async {
    final response = await _supabaseClient
        .from('comments')
        .insert({'user_id': userId, 'post_id': postId, 'content': content})
        .select() // Oluşturulan kaydı döndür
        .single();

    final current = await _supabaseClient
        .from('posts')
        .select('comments_count')
        .eq('id', postId)
        .single();

    await _supabaseClient
        .from('posts')
        .update({'comments_count': (current['comments_count'] as int) + 1})
        .eq('id', postId);

    return CommentModel.fromJson(response);
  }

  Future<void> deleteComment(String commentId) async {
    final comment = await _supabaseClient
        .from('comments')
        .select('post_id')
        .eq('id', commentId)
        .maybeSingle(); // Null olabilir (comment silinmişse)

    await _supabaseClient.from('comments').delete().eq('id', commentId);

    if (comment != null) {
      final postId = comment['post_id'] as String;

      final current = await _supabaseClient
          .from('posts')
          .select('comments_count')
          .eq('id', postId)
          .single();

      final newCount = ((current['comments_count'] as int) - 1).clamp(
        0,
        999999,
      );
      await _supabaseClient
          .from('posts')
          .update({'comments_count': newCount})
          .eq('id', postId);
    }
  }
}
