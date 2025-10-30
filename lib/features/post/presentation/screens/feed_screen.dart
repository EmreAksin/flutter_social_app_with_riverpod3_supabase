import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/post_providers.dart';
import '../widgets/post_card.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsStream = ref.watch(postsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Social App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              final currentUser = await ref.read(currentUserProvider.future);
              if (currentUser != null && context.mounted) {
                context.push('/profile/${currentUser.id}');
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: postsStream.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyStateWidget(
              message: 'Henüz gönderi yok.\nİlk gönderiyi sen oluştur!',
              icon: Icons.article,
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(postsStreamProvider);
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCard(post: post);
              },
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) => ErrorStateWidget(
          message: 'Gönderiler yüklenirken hata oluştu',
          onRetry: () {
            ref.invalidate(postsStreamProvider);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create-post'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
