import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_providers.g.dart';

@riverpod
ProfileRemoteDataSource profileRemoteDataSource(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return ProfileRemoteDataSource(supabaseClient);
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final remoteDataSource = ref.watch(profileRemoteDataSourceProvider);

  final currentUser = ref.watch(currentUserProvider).value;

  if (currentUser == null) {
    throw Exception('User not authenticated');
  }

  return ProfileRepositoryImpl(remoteDataSource, currentUser.id);
}

@riverpod
Future<ProfileEntity> profile(Ref ref, String userId) {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfile(userId);
}

@riverpod
Future<ProfileEntity> currentUserProfile(Ref ref) async {
  final currentUser = await ref.watch(currentUserProvider.future);

  if (currentUser == null) {
    throw Exception('User not authenticated');
  }

  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfile(currentUser.id);
}

@riverpod
Future<bool> isFollowing(Ref ref, String userId) {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.isFollowing(userId);
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<void> build() {}

  Future<void> updateProfile({
    String? username,
    String? fullName,
    String? bio,
  }) async {
    final repository = ref.read(profileRepositoryProvider);
    await repository.updateProfile(
      username: username,
      fullName: fullName,
      bio: bio,
    );

    if (!ref.mounted) return;

    final currentUser = ref.read(currentUserProvider).value;
    ref.invalidate(currentUserProfileProvider);
    if (currentUser != null) {
      ref.invalidate(profileProvider(currentUser.id));
    }
  }

  Future<void> uploadAvatar(File imageFile) async {
    final repository = ref.read(profileRepositoryProvider);
    await repository.uploadAvatar(imageFile);

    if (!ref.mounted) return;

    final currentUser = ref.read(currentUserProvider).value;
    ref.invalidate(currentUserProfileProvider);
    if (currentUser != null) {
      ref.invalidate(profileProvider(currentUser.id));
    }
  }

  Future<void> followUser(String userId) async {
    final repository = ref.read(profileRepositoryProvider);
    await repository.followUser(userId);

    if (!ref.mounted) return;
    ref.invalidate(isFollowingProvider(userId));
  }

  Future<void> unfollowUser(String userId) async {
    final repository = ref.read(profileRepositoryProvider);
    await repository.unfollowUser(userId);

    if (!ref.mounted) return;
    ref.invalidate(isFollowingProvider(userId));
  }
}
