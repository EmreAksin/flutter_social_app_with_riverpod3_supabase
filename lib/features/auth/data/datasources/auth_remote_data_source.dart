import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_social_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;
  AuthRemoteDataSource(this._supabaseClient);

  Future<UserModel?> getCurrentUser() async {
    final user = _supabaseClient.auth.currentUser;

    if (user == null) return null;

    return UserModel(id: user.id, email: user.email!);
  }

  Stream<UserModel?> authStateChanges() {
    return _supabaseClient.auth.onAuthStateChange.map((data) {
      final user = data.session?.user;
      if (user == null) return null;

      return UserModel(id: user.id, email: user.email!);
    });
  }

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) throw Exception('Sign in failed');

    return UserModel(id: user.id, email: user.email!);
  }

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    String? fullName,
  }) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {'username': username, 'full_name': fullName},
    );

    final user = response.user;

    if (user == null) {
      throw Exception('Sign up failed');
    }

    return UserModel(id: user.id, email: user.email!);
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
