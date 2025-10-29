import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_social_app/features/auth/domain/entities/user_entity.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({required String id, required String email}) =
      _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserEntity toEntity() {
    return UserEntity(id: id, email: email);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(id: entity.id, email: entity.email);
  }
}
