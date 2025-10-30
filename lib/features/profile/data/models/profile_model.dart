import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entity.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    required String id,
    required String username,
    @JsonKey(name: 'full_name') String? fullName,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      username: username,
      fullName: fullName,
      bio: bio,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      username: entity.username,
      fullName: entity.fullName,
      bio: entity.bio,
      avatarUrl: entity.avatarUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
