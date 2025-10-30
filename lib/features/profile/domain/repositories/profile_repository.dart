import 'dart:io';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(String userId);

  Future<ProfileEntity> updateProfile({
    String? username,
    String? fullName,
    String? bio,
  });

  Future<String> uploadAvatar(File imageFile);

  Future<void> followUser(String userId);

  Future<void> unfollowUser(String userId);

  Future<bool> isFollowing(String userId);

  Future<List<ProfileEntity>> getFollowers(String userId);

  Future<List<ProfileEntity>> getFollowing(String userId);

  Future<int> getFollowerCount(String userId);

  Future<int> getFollowingCount(String userId);
}
