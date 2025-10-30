import 'dart:io'; // File class
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final String _currentUserId;

  ProfileRepositoryImpl(this._remoteDataSource, this._currentUserId);

  @override
  Future<ProfileEntity> getProfile(String userId) async {
    final profileModel = await _remoteDataSource.getProfile(userId);
    return profileModel.toEntity();
  }

  @override
  Future<ProfileEntity> updateProfile({
    String? username,
    String? fullName,
    String? bio,
  }) async {
    final profileModel = await _remoteDataSource.updateProfile(
      userId: _currentUserId,
      username: username,
      fullName: fullName,
      bio: bio,
    );
    return profileModel.toEntity();
  }

  @override
  Future<String> uploadAvatar(File imageFile) async {
    return await _remoteDataSource.uploadAvatar(_currentUserId, imageFile);
  }

  @override
  Future<void> followUser(String userId) async {
    await _remoteDataSource.followUser(_currentUserId, userId);
  }

  @override
  Future<void> unfollowUser(String userId) async {
    await _remoteDataSource.unfollowUser(_currentUserId, userId);
  }

  @override
  Future<bool> isFollowing(String userId) async {
    return await _remoteDataSource.isFollowing(_currentUserId, userId);
  }

  @override
  Future<List<ProfileEntity>> getFollowers(String userId) async {
    final profileModels = await _remoteDataSource.getFollowers(userId);
    return profileModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ProfileEntity>> getFollowing(String userId) async {
    final profileModels = await _remoteDataSource.getFollowing(userId);
    return profileModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<int> getFollowerCount(String userId) async {
    return await _remoteDataSource.getFollowerCount(userId);
  }

  @override
  Future<int> getFollowingCount(String userId) async {
    return await _remoteDataSource.getFollowingCount(userId);
  }
}
