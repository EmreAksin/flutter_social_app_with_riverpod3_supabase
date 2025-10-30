import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/comment_entity.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentModel with _$CommentModel {
  const CommentModel._();

  const factory CommentModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'post_id') required String postId,
    required String content,
    @JsonKey(name: 'created_at') required DateTime createdAt,

    String? username,
    @JsonKey(name: 'user_avatar_url') String? userAvatarUrl,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  CommentEntity toEntity() {
    return CommentEntity(
      id: id,
      userId: userId,
      postId: postId,
      content: content,
      createdAt: createdAt,
      username: username,
      userAvatarUrl: userAvatarUrl,
    );
  }
}
