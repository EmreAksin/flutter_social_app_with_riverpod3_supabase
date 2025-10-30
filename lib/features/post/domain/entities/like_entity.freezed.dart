// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LikeEntity {

 String get id; String get userId; String get postId; DateTime get createdAt;
/// Create a copy of LikeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LikeEntityCopyWith<LikeEntity> get copyWith => _$LikeEntityCopyWithImpl<LikeEntity>(this as LikeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LikeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,postId,createdAt);

@override
String toString() {
  return 'LikeEntity(id: $id, userId: $userId, postId: $postId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LikeEntityCopyWith<$Res>  {
  factory $LikeEntityCopyWith(LikeEntity value, $Res Function(LikeEntity) _then) = _$LikeEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String postId, DateTime createdAt
});




}
/// @nodoc
class _$LikeEntityCopyWithImpl<$Res>
    implements $LikeEntityCopyWith<$Res> {
  _$LikeEntityCopyWithImpl(this._self, this._then);

  final LikeEntity _self;
  final $Res Function(LikeEntity) _then;

/// Create a copy of LikeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? postId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LikeEntity].
extension LikeEntityPatterns on LikeEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LikeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LikeEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LikeEntity value)  $default,){
final _that = this;
switch (_that) {
case _LikeEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LikeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LikeEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String postId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LikeEntity() when $default != null:
return $default(_that.id,_that.userId,_that.postId,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String postId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _LikeEntity():
return $default(_that.id,_that.userId,_that.postId,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String postId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LikeEntity() when $default != null:
return $default(_that.id,_that.userId,_that.postId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _LikeEntity implements LikeEntity {
  const _LikeEntity({required this.id, required this.userId, required this.postId, required this.createdAt});
  

@override final  String id;
@override final  String userId;
@override final  String postId;
@override final  DateTime createdAt;

/// Create a copy of LikeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LikeEntityCopyWith<_LikeEntity> get copyWith => __$LikeEntityCopyWithImpl<_LikeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LikeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,postId,createdAt);

@override
String toString() {
  return 'LikeEntity(id: $id, userId: $userId, postId: $postId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LikeEntityCopyWith<$Res> implements $LikeEntityCopyWith<$Res> {
  factory _$LikeEntityCopyWith(_LikeEntity value, $Res Function(_LikeEntity) _then) = __$LikeEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String postId, DateTime createdAt
});




}
/// @nodoc
class __$LikeEntityCopyWithImpl<$Res>
    implements _$LikeEntityCopyWith<$Res> {
  __$LikeEntityCopyWithImpl(this._self, this._then);

  final _LikeEntity _self;
  final $Res Function(_LikeEntity) _then;

/// Create a copy of LikeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? postId = null,Object? createdAt = null,}) {
  return _then(_LikeEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
