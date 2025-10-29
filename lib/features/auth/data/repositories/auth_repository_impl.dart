import 'package:supabase_social_app/features/auth/data/datasources/auth_remote_data_source.dart';

import '../../domain/entities/user_entity.dart'; // Domain entity
import '../../domain/repositories/auth_repository.dart'; // Interface (5.1)

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await _remoteDataSource.getCurrentUser();

    return userModel?.toEntity();
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return _remoteDataSource.authStateChanges().map(
      (userModel) => userModel?.toEntity(),
    );
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userModel = await _remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userModel.toEntity();
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    String? fullName,
  }) async {
    final userModel = await _remoteDataSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
      username: username,
      fullName: fullName,
    );
    return userModel.toEntity();
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }
}
