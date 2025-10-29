import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_social_app/core/providers/supabase_provider.dart';
import 'package:supabase_social_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:supabase_social_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:supabase_social_app/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_social_app/features/auth/domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);

  return AuthRemoteDataSource(supabaseClient);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);

  return AuthRepositoryImpl(remoteDataSource);
}

@riverpod
Stream<UserEntity?> authStateChanges(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges();
}

@riverpod
Future<UserEntity?> currentUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.getCurrentUser();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);

      await repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    String? fullName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final reposiyory = ref.read(authRepositoryProvider);

      await reposiyory.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
      );
    });
  }

  Future<void> signOut() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
  }
}
