import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/like_entity.dart';

part 'like_model.freezed.dart';
part 'like_model.g.dart';

@freezed
abstract class LikeModel with _$LikeModel {
  const LikeModel._();

  const factory LikeModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'post_id') required String postId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);

  LikeEntity toEntity() {
    return LikeEntity(
      id: id,
      userId: userId,
      postId: postId,
      createdAt: createdAt,
    );
  }
}
