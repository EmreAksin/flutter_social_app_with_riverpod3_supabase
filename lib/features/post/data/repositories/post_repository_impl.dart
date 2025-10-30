import 'dart:io';

import 'package:supabase_social_app/features/post/data/datasources/post_remote_data_source.dart';
import 'package:supabase_social_app/features/post/domain/entities/comment_entity.dart';
import 'package:supabase_social_app/features/post/domain/entities/post_entity.dart';
import 'package:supabase_social_app/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;
  final String _currentUserId;

  PostRepositoryImpl(this._remoteDataSource, this._currentUserId);

  @override
  Stream<List<PostEntity>> getPostsStream() {
    return _remoteDataSource.getPostsStream().map(
      (models) => models.map((model) => model.toEntity()).toList(),
    );
  }

  @override
  Future<List<PostEntity>> getPostsByUserId(String userId) async {
    final postModels = await _remoteDataSource.getPostsByUserId(userId);
    return postModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<PostEntity> getPost(String postId) async {
    final postModel = await _remoteDataSource.getPost(postId);
    return postModel.toEntity();
  }

  @override
  Future<PostEntity> createPost({
    required String content,
    File? imageFile,
  }) async {
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await _remoteDataSource.uploadPostImage(
        _currentUserId,
        imageFile,
      );
    }

    final postModel = await _remoteDataSource.createPost(
      userId: _currentUserId,
      content: content,
      imageUrl: imageUrl,
    );
    return postModel.toEntity();
  }

  @override
  Future<void> deletePost(String postId) async {
    await _remoteDataSource.deletePost(postId);
  }

  @override
  Future<void> likePost(String postId) async {
    await _remoteDataSource.likePost(_currentUserId, postId);
  }

  @override
  Future<void> unlikePost(String postId) async {
    await _remoteDataSource.unlikePost(_currentUserId, postId);
  }

  @override
  Future<bool> isPostLiked(String postId) async {
    return await _remoteDataSource.isPostLiked(_currentUserId, postId);
  }

  @override
  Future<List<CommentEntity>> getComments(String postId) async {
    final commentModels = await _remoteDataSource.getComments(postId);
    return commentModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<CommentEntity> addComment({
    required String postId,
    required String content,
  }) async {
    final commentModel = await _remoteDataSource.addComment(
      userId: _currentUserId,
      postId: postId,
      content: content,
    );
    return commentModel.toEntity();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await _remoteDataSource.deleteComment(commentId);
  }
}
