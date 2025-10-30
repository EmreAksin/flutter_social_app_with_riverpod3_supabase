import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/supabase_provider.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/post_remote_data_source.dart';
import '../../data/repositories/post_repository_impl.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/repositories/post_repository.dart';

part 'post_providers.g.dart';

@riverpod
PostRemoteDataSource postRemoteDataSource(Ref ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return PostRemoteDataSource(supabaseClient);
}

@riverpod
PostRepository postRepository(Ref ref) {
  final remoteDataSource = ref.watch(postRemoteDataSourceProvider);

  final currentUser = ref.watch(currentUserProvider).value;

  if (currentUser == null) {
    throw Exception('User not authenticated');
  }

  return PostRepositoryImpl(remoteDataSource, currentUser.id);
}

@riverpod
Stream<List<PostEntity>> postsStream(Ref ref) {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPostsStream();
}

@riverpod
Future<List<PostEntity>> posts(Ref ref) async {
  final dataSource = ref.watch(postRemoteDataSourceProvider);

  final response = await dataSource.getPostsStream().first;
  return response.map((model) => model.toEntity()).toList();
}

@riverpod
Future<List<PostEntity>> userPosts(Ref ref, String userId) {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPostsByUserId(userId);
}

@riverpod
Future<bool> isPostLiked(Ref ref, String postId) {
  final repository = ref.watch(postRepositoryProvider);
  return repository.isPostLiked(postId);
}

@riverpod
Future<List<CommentEntity>> postComments(Ref ref, String postId) {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getComments(postId);
}

@riverpod
class PostController extends _$PostController {
  @override
  FutureOr<void> build() {}

  Future<void> createPost({required String content, File? imageFile}) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.createPost(content: content, imageFile: imageFile);

    if (!ref.mounted) return;

    ref.invalidate(postsStreamProvider);
  }

  Future<void> deletePost(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.deletePost(postId);

    if (!ref.mounted) return;
    ref.invalidate(postsStreamProvider);
  }

  Future<void> likePost(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.likePost(postId);

    if (!ref.mounted) return;

    ref.invalidate(isPostLikedProvider(postId));
    ref.invalidate(postsStreamProvider);
  }

  Future<void> unlikePost(String postId) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.unlikePost(postId);

    if (!ref.mounted) return;
    ref.invalidate(isPostLikedProvider(postId));
    ref.invalidate(postsStreamProvider);
  }

  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.addComment(postId: postId, content: content);

    if (!ref.mounted) return;

    ref.invalidate(postCommentsProvider(postId));
    ref.invalidate(postsStreamProvider);
  }

  Future<void> deleteComment(String commentId, String postId) async {
    final repository = ref.read(postRepositoryProvider);
    await repository.deleteComment(commentId);

    if (!ref.mounted) return;
    ref.invalidate(postCommentsProvider(postId));
    ref.invalidate(postsStreamProvider);
  }
}
