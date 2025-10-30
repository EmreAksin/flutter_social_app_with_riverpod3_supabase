import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/follow_entity.dart';

part 'follow_model.freezed.dart';
part 'follow_model.g.dart';

@freezed
abstract class FollowModel with _$FollowModel {
  const FollowModel._();

  const factory FollowModel({
    required String id,
    @JsonKey(name: 'follower_id') required String followerId,
    @JsonKey(name: 'following_id') required String followingId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _FollowModel;

  factory FollowModel.fromJson(Map<String, dynamic> json) =>
      _$FollowModelFromJson(json);

  FollowEntity toEntity() {
    return FollowEntity(
      id: id,
      followerId: followerId,
      followingId: followingId,
      createdAt: createdAt,
    );
  }
}
