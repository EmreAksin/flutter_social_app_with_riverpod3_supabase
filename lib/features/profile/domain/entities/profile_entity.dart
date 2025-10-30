import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';

@freezed
abstract class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String id,
    required String username,
    String? fullName,
    String? bio,
    String? avatarUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProfileEntity;
}
