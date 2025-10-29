import 'package:supabase_social_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> authStateChanges();
  Future<UserEntity> signInWithEmailAndPasword({
    required String email,
    required String password,
  });

  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    String? fullName,
  });

  Future<void> signOut();
}
