import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';

@freezed
abstract class PostEntity with _$PostEntity {
  const factory PostEntity({
    required String id,
    required String userId,
    required String content,
    String? imageUrl,
    required int likesCount,
    required int commentsCount,
    required DateTime createdAt,
    required DataCell updatedAt,
    String? username,
    String? userAvatarUrl,
    bool? isLikedByCurrentUser,
  }) = _PostEntity;
}
