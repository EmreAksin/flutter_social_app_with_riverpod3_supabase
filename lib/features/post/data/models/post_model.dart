import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post_entity.dart'; // Domain entity (2.2)

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
abstract class PostModel with _$PostModel {
  const PostModel._();

  const factory PostModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,

    required String content,

    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'likes_count') required int likesCount,
    @JsonKey(name: 'comments_count') required int commentsCount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,

    String? username,
    @JsonKey(name: 'user_avatar_url') String? userAvatarUrl,
    @JsonKey(name: 'is_liked_by_current_user') bool? isLikedByCurrentUser,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      userId: userId,
      content: content,
      imageUrl: imageUrl,
      likesCount: likesCount,
      commentsCount: commentsCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      username: username,
      userAvatarUrl: userAvatarUrl,
      isLikedByCurrentUser: isLikedByCurrentUser,
    );
  }
}
