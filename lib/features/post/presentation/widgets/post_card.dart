import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:supabase_social_app/features/auth/presentation/providers/auth_providers.dart';
import '../providers/post_providers.dart';
import '../../../../core/utils/error_utils.dart';
import '../../domain/entities/post_entity.dart';

class PostCard extends ConsumerWidget {
  final PostEntity post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final isLikedAsync = ref.watch(isPostLikedProvider(post.id));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: post.userAvatarUrl != null
                  ? CachedNetworkImageProvider(post.userAvatarUrl!)
                  : null,
              child: post.userAvatarUrl == null
                  ? Text(post.username?.substring(0, 1).toUpperCase() ?? 'U')
                  : null,
            ),
            title: Text(
              post.username ?? 'Anonim',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              _formatDate(post.createdAt),
              style: const TextStyle(fontSize: 12),
            ),
            trailing: currentUserAsync.value?.id == post.userId
                ? PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) async {
                      if (value == 'delete') {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Gönderiyi Sil'),
                            content: const Text(
                              'Bu gönderiyi silmek istediğinize emin misiniz?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('İptal'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Sil',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true && context.mounted) {
                          try {
                            await ref
                                .read(postControllerProvider.notifier)
                                .deletePost(post.id);
                          } catch (e) {
                            if (context.mounted) {
                              ErrorUtils.showErrorSnackBar(
                                context,
                                'Gönderi silinemedi',
                              );
                            }
                          }
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Sil', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  )
                : null,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(post.content, style: const TextStyle(fontSize: 14)),
          ),

          if (post.imageUrl != null) ...[
            const SizedBox(height: 8),
            CachedNetworkImage(
              imageUrl: post.imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                isLikedAsync.when(
                  data: (isLiked) => IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : null,
                    ),
                    onPressed: () async {
                      try {
                        if (isLiked) {
                          await ref
                              .read(postControllerProvider.notifier)
                              .unlikePost(post.id);
                        } else {
                          await ref
                              .read(postControllerProvider.notifier)
                              .likePost(post.id);
                        }
                        ref.invalidate(isPostLikedProvider(post.id));
                        ref.invalidate(postsStreamProvider);
                      } catch (e) {
                        if (context.mounted) {
                          ErrorUtils.showErrorSnackBar(context, e);
                        }
                      }
                    },
                  ),
                  loading: () => IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: null,
                  ),
                  error: (_, __) => IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: null,
                  ),
                ),
                Text('${post.likesCount}'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    context.push('/post/${post.id}/comments');
                  },
                ),
                Text('${post.commentsCount}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return DateFormat('dd MMM yyyy').format(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} gün önce';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} saat önce';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} dakika önce';
    } else {
      return 'Şimdi';
    }
  }
}
