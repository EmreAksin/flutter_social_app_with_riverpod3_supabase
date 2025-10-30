import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_entity.freezed.dart';

@freezed
abstract class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    required String id,
    required String userId,
    required String postId,
    required String content,
    required DateTime createdAt,
    String? username,
    String? userAvatarUrl,
  }) = _CommentEntity;
}
