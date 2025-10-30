import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_social_app/features/post/presentation/providers/post_providers.dart';
import 'package:supabase_social_app/features/post/presentation/widgets/post_card.dart';
import 'package:supabase_social_app/features/profile/presentation/widgets/profile_header.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(userId));
    final currentUserAsync = ref.watch(currentUserProvider);
    final userPostsAsync = ref.watch(userPostsProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: profileAsync.when(
        data: (profile) {
          final isOwnProfile = currentUserAsync.value?.id == profile.id;

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(profileProvider(userId));
              ref.invalidate(userPostsProvider(userId));
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ProfileHeader(
                    profile: profile,
                    isOwnProfile: isOwnProfile,
                  ),
                ),
                userPostsAsync.when(
                  data: (posts) {
                    if (posts.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('Henüz gönderi yok')),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return PostCard(post: posts[index]);
                      }, childCount: posts.length),
                    );
                  },
                  loading: () =>
                      const SliverFillRemaining(child: LoadingWidget()),
                  error: (error, stack) => SliverFillRemaining(
                    child: ErrorStateWidget(
                      message: 'Gönderiler yüklenirken hata oluştu',
                      onRetry: () {
                        ref.invalidate(userPostsProvider(userId));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) => ErrorStateWidget(
          message: 'Profil yüklenirken hata oluştu',
          onRetry: () {
            ref.invalidate(profileProvider(userId));
          },
        ),
      ),
    );
  }
}
