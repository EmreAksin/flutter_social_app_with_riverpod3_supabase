// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FollowEntity {

 String get id; String get followerId; String get followingId; DateTime get createdAt;
/// Create a copy of FollowEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FollowEntityCopyWith<FollowEntity> get copyWith => _$FollowEntityCopyWithImpl<FollowEntity>(this as FollowEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FollowEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.followerId, followerId) || other.followerId == followerId)&&(identical(other.followingId, followingId) || other.followingId == followingId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,followerId,followingId,createdAt);

@override
String toString() {
  return 'FollowEntity(id: $id, followerId: $followerId, followingId: $followingId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FollowEntityCopyWith<$Res>  {
  factory $FollowEntityCopyWith(FollowEntity value, $Res Function(FollowEntity) _then) = _$FollowEntityCopyWithImpl;
@useResult
$Res call({
 String id, String followerId, String followingId, DateTime createdAt
});




}
/// @nodoc
class _$FollowEntityCopyWithImpl<$Res>
    implements $FollowEntityCopyWith<$Res> {
  _$FollowEntityCopyWithImpl(this._self, this._then);

  final FollowEntity _self;
  final $Res Function(FollowEntity) _then;

/// Create a copy of FollowEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? followerId = null,Object? followingId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,followerId: null == followerId ? _self.followerId : followerId // ignore: cast_nullable_to_non_nullable
as String,followingId: null == followingId ? _self.followingId : followingId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FollowEntity].
extension FollowEntityPatterns on FollowEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FollowEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FollowEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FollowEntity value)  $default,){
final _that = this;
switch (_that) {
case _FollowEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FollowEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FollowEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String followerId,  String followingId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FollowEntity() when $default != null:
return $default(_that.id,_that.followerId,_that.followingId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String followerId,  String followingId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _FollowEntity():
return $default(_that.id,_that.followerId,_that.followingId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String followerId,  String followingId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FollowEntity() when $default != null:
return $default(_that.id,_that.followerId,_that.followingId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _FollowEntity implements FollowEntity {
  const _FollowEntity({required this.id, required this.followerId, required this.followingId, required this.createdAt});
  

@override final  String id;
@override final  String followerId;
@override final  String followingId;
@override final  DateTime createdAt;

/// Create a copy of FollowEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowEntityCopyWith<_FollowEntity> get copyWith => __$FollowEntityCopyWithImpl<_FollowEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FollowEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.followerId, followerId) || other.followerId == followerId)&&(identical(other.followingId, followingId) || other.followingId == followingId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,followerId,followingId,createdAt);

@override
String toString() {
  return 'FollowEntity(id: $id, followerId: $followerId, followingId: $followingId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FollowEntityCopyWith<$Res> implements $FollowEntityCopyWith<$Res> {
  factory _$FollowEntityCopyWith(_FollowEntity value, $Res Function(_FollowEntity) _then) = __$FollowEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String followerId, String followingId, DateTime createdAt
});




}
/// @nodoc
class __$FollowEntityCopyWithImpl<$Res>
    implements _$FollowEntityCopyWith<$Res> {
  __$FollowEntityCopyWithImpl(this._self, this._then);

  final _FollowEntity _self;
  final $Res Function(_FollowEntity) _then;

/// Create a copy of FollowEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? followerId = null,Object? followingId = null,Object? createdAt = null,}) {
  return _then(_FollowEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,followerId: null == followerId ? _self.followerId : followerId // ignore: cast_nullable_to_non_nullable
as String,followingId: null == followingId ? _self.followingId : followingId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
