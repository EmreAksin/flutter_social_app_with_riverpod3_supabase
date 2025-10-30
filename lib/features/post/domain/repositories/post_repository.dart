import 'dart:io';
import '../entities/post_entity.dart';
import '../entities/comment_entity.dart';

abstract class PostRepository {
  Stream<List<PostEntity>> getPostsStream();

  Future<List<PostEntity>> getPostsByUserId(String userId);

  Future<PostEntity> getPost(String postId);

  Future<PostEntity> createPost({required String content, File? imageFile});

  Future<void> deletePost(String postId);

  Future<void> likePost(String postId);

  Future<void> unlikePost(String postId);

  Future<bool> isPostLiked(String postId);

  Future<List<CommentEntity>> getComments(String postId);

  Future<CommentEntity> addComment({
    required String postId,
    required String content,
  });

  Future<void> deleteComment(String commentId);
}
