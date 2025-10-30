import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/profile_model.dart';

class ProfileRemoteDataSource {
  final SupabaseClient _supabaseClient;

  ProfileRemoteDataSource(this._supabaseClient);

  Future<ProfileModel> getProfile(String userId) async {
    try {
      final response = await _supabaseClient
          .from('profiles')
          .select() // Tüm alanlar
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        throw Exception('Profil bulunamadı');
      }

      return ProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileModel> updateProfile({
    required String userId,
    String? username,
    String? fullName,
    String? bio,
  }) async {
    final updates = <String, dynamic>{};
    if (username != null) updates['username'] = username;
    if (fullName != null) updates['full_name'] = fullName;
    if (bio != null) updates['bio'] = bio;

    final response = await _supabaseClient
        .from('profiles')
        .update(updates)
        .eq('id', userId)
        .select()
        .single();

    return ProfileModel.fromJson(response);
  }

  Future<String> uploadAvatar(String userId, File imageFile) async {
    final fileExt = imageFile.path.split('.').last;

    final fileName =
        '$userId/${DateTime.now().millisecondsSinceEpoch}.$fileExt';

    await _supabaseClient.storage
        .from(AppConstants.avatarsBucket)
        .upload(fileName, imageFile);

    final publicUrl = _supabaseClient.storage
        .from(AppConstants.avatarsBucket)
        .getPublicUrl(fileName);

    await _supabaseClient
        .from('profiles')
        .update({'avatar_url': publicUrl})
        .eq('id', userId);

    return publicUrl;
  }

  Future<void> followUser(String followerId, String followingId) async {
    await _supabaseClient.from('follows').insert({
      'follower_id': followerId,
      'following_id': followingId,
    });
  }

  Future<void> unfollowUser(String followerId, String followingId) async {
    await _supabaseClient
        .from('follows')
        .delete()
        .eq('follower_id', followerId)
        .eq('following_id', followingId);
  }

  Future<bool> isFollowing(String followerId, String followingId) async {
    final response = await _supabaseClient
        .from('follows')
        .select()
        .eq('follower_id', followerId)
        .eq('following_id', followingId);

    return response.isNotEmpty;
  }

  Future<List<ProfileModel>> getFollowers(String userId) async {
    final response = await _supabaseClient
        .from('follows')
        .select('follower_id, profiles!follows_follower_id_fkey(*)')
        .eq('following_id', userId);

    return response
        .map((item) => ProfileModel.fromJson(item['profiles']))
        .toList();
  }

  Future<List<ProfileModel>> getFollowing(String userId) async {
    final response = await _supabaseClient
        .from('follows')
        .select('following_id, profiles!follows_following_id_fkey(*)')
        .eq('follower_id', userId);

    return response
        .map((item) => ProfileModel.fromJson(item['profiles']))
        .toList();
  }

  Future<int> getFollowerCount(String userId) async {
    final response = await _supabaseClient
        .from('follows')
        .select('id')
        .eq('following_id', userId)
        .count();

    return response.count;
  }

  Future<int> getFollowingCount(String userId) async {
    final response = await _supabaseClient
        .from('follows')
        .select('id')
        .eq('follower_id', userId)
        .count();

    return response.count;
  }
}
