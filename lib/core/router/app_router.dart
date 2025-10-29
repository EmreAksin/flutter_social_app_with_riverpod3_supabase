import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 3.x
import 'package:go_router/go_router.dart'; // GoRouter (URL routing)
import '../../features/auth/presentation/providers/auth_providers.dart'; // Auth providers (6.1)
import '../../features/auth/presentation/screens/login_screen.dart'; // Screens
import '../../features/auth/presentation/screens/register_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/auth/login',

    redirect: (context, state) {
      final isAuthenticated = authState.value != null;

      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isAuthenticated && !isAuthRoute) {
        return '/auth/login';
      }

      if (isAuthenticated && isAuthRoute) {
        return '/feed';
      }

      return null; // No redirect
    },

    routes: [
      GoRoute(
        path: '/auth/login', // URL path
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoginScreen()),
      ),

      GoRoute(
        path: '/auth/register',
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreen()),
      ),

      GoRoute(
        path: '/feed',
        pageBuilder: (context, state) =>
            const MaterialPage(child: Center(child: Text("Home"))),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Hata')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Sayfa bulunamadı'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/feed'),
              child: const Text('Ana Sayfaya Dön'),
            ),
          ],
        ),
      ),
    ),
  );
});
