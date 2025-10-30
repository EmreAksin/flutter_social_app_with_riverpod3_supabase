import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow_entity.freezed.dart';

@freezed
abstract class FollowEntity with _$FollowEntity {
  const factory FollowEntity({
    required String id,
    required String followerId,
    required String followingId,
    required DateTime createdAt,
  }) = _FollowEntity;
}
