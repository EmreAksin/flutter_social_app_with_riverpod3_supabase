// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  content: json['content'] as String,
  imageUrl: json['image_url'] as String?,
  likesCount: (json['likes_count'] as num).toInt(),
  commentsCount: (json['comments_count'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
  username: json['username'] as String?,
  userAvatarUrl: json['user_avatar_url'] as String?,
  isLikedByCurrentUser: json['is_liked_by_current_user'] as bool?,
);

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'username': instance.username,
      'user_avatar_url': instance.userAvatarUrl,
      'is_liked_by_current_user': instance.isLikedByCurrentUser,
    };
