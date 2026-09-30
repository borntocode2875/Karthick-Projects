// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'desk_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeskAccount {

 String get id; String get orgName; String get orgId; DataCenter get dataCenter;/// The specific API domain; defaults to [DataCenter.apiDomain].
 String get apiDomain; String get portalId; String get portalName;/// Hex color string for the org avatar (e.g. '#2F5BEA').
 String get avatarColor;/// Single uppercase letter shown in the avatar.
 String get avatarInitial;
/// Create a copy of DeskAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeskAccountCopyWith<DeskAccount> get copyWith => _$DeskAccountCopyWithImpl<DeskAccount>(this as DeskAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeskAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.dataCenter, dataCenter) || other.dataCenter == dataCenter)&&(identical(other.apiDomain, apiDomain) || other.apiDomain == apiDomain)&&(identical(other.portalId, portalId) || other.portalId == portalId)&&(identical(other.portalName, portalName) || other.portalName == portalName)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.avatarInitial, avatarInitial) || other.avatarInitial == avatarInitial));
}


@override
int get hashCode => Object.hash(runtimeType,id,orgName,orgId,dataCenter,apiDomain,portalId,portalName,avatarColor,avatarInitial);

@override
String toString() {
  return 'DeskAccount(id: $id, orgName: $orgName, orgId: $orgId, dataCenter: $dataCenter, apiDomain: $apiDomain, portalId: $portalId, portalName: $portalName, avatarColor: $avatarColor, avatarInitial: $avatarInitial)';
}


}

/// @nodoc
abstract mixin class $DeskAccountCopyWith<$Res>  {
  factory $DeskAccountCopyWith(DeskAccount value, $Res Function(DeskAccount) _then) = _$DeskAccountCopyWithImpl;
@useResult
$Res call({
 String id, String orgName, String orgId, DataCenter dataCenter, String apiDomain, String portalId, String portalName, String avatarColor, String avatarInitial
});




}
/// @nodoc
class _$DeskAccountCopyWithImpl<$Res>
    implements $DeskAccountCopyWith<$Res> {
  _$DeskAccountCopyWithImpl(this._self, this._then);

  final DeskAccount _self;
  final $Res Function(DeskAccount) _then;

/// Create a copy of DeskAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orgName = null,Object? orgId = null,Object? dataCenter = null,Object? apiDomain = null,Object? portalId = null,Object? portalName = null,Object? avatarColor = null,Object? avatarInitial = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,dataCenter: null == dataCenter ? _self.dataCenter : dataCenter // ignore: cast_nullable_to_non_nullable
as DataCenter,apiDomain: null == apiDomain ? _self.apiDomain : apiDomain // ignore: cast_nullable_to_non_nullable
as String,portalId: null == portalId ? _self.portalId : portalId // ignore: cast_nullable_to_non_nullable
as String,portalName: null == portalName ? _self.portalName : portalName // ignore: cast_nullable_to_non_nullable
as String,avatarColor: null == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String,avatarInitial: null == avatarInitial ? _self.avatarInitial : avatarInitial // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeskAccount].
extension DeskAccountPatterns on DeskAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeskAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeskAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeskAccount value)  $default,){
final _that = this;
switch (_that) {
case _DeskAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeskAccount value)?  $default,){
final _that = this;
switch (_that) {
case _DeskAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orgName,  String orgId,  DataCenter dataCenter,  String apiDomain,  String portalId,  String portalName,  String avatarColor,  String avatarInitial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeskAccount() when $default != null:
return $default(_that.id,_that.orgName,_that.orgId,_that.dataCenter,_that.apiDomain,_that.portalId,_that.portalName,_that.avatarColor,_that.avatarInitial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orgName,  String orgId,  DataCenter dataCenter,  String apiDomain,  String portalId,  String portalName,  String avatarColor,  String avatarInitial)  $default,) {final _that = this;
switch (_that) {
case _DeskAccount():
return $default(_that.id,_that.orgName,_that.orgId,_that.dataCenter,_that.apiDomain,_that.portalId,_that.portalName,_that.avatarColor,_that.avatarInitial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orgName,  String orgId,  DataCenter dataCenter,  String apiDomain,  String portalId,  String portalName,  String avatarColor,  String avatarInitial)?  $default,) {final _that = this;
switch (_that) {
case _DeskAccount() when $default != null:
return $default(_that.id,_that.orgName,_that.orgId,_that.dataCenter,_that.apiDomain,_that.portalId,_that.portalName,_that.avatarColor,_that.avatarInitial);case _:
  return null;

}
}

}

/// @nodoc


class _DeskAccount implements DeskAccount {
  const _DeskAccount({required this.id, required this.orgName, required this.orgId, required this.dataCenter, required this.apiDomain, required this.portalId, required this.portalName, required this.avatarColor, required this.avatarInitial});
  

@override final  String id;
@override final  String orgName;
@override final  String orgId;
@override final  DataCenter dataCenter;
/// The specific API domain; defaults to [DataCenter.apiDomain].
@override final  String apiDomain;
@override final  String portalId;
@override final  String portalName;
/// Hex color string for the org avatar (e.g. '#2F5BEA').
@override final  String avatarColor;
/// Single uppercase letter shown in the avatar.
@override final  String avatarInitial;

/// Create a copy of DeskAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeskAccountCopyWith<_DeskAccount> get copyWith => __$DeskAccountCopyWithImpl<_DeskAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeskAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.orgName, orgName) || other.orgName == orgName)&&(identical(other.orgId, orgId) || other.orgId == orgId)&&(identical(other.dataCenter, dataCenter) || other.dataCenter == dataCenter)&&(identical(other.apiDomain, apiDomain) || other.apiDomain == apiDomain)&&(identical(other.portalId, portalId) || other.portalId == portalId)&&(identical(other.portalName, portalName) || other.portalName == portalName)&&(identical(other.avatarColor, avatarColor) || other.avatarColor == avatarColor)&&(identical(other.avatarInitial, avatarInitial) || other.avatarInitial == avatarInitial));
}


@override
int get hashCode => Object.hash(runtimeType,id,orgName,orgId,dataCenter,apiDomain,portalId,portalName,avatarColor,avatarInitial);

@override
String toString() {
  return 'DeskAccount(id: $id, orgName: $orgName, orgId: $orgId, dataCenter: $dataCenter, apiDomain: $apiDomain, portalId: $portalId, portalName: $portalName, avatarColor: $avatarColor, avatarInitial: $avatarInitial)';
}


}

/// @nodoc
abstract mixin class _$DeskAccountCopyWith<$Res> implements $DeskAccountCopyWith<$Res> {
  factory _$DeskAccountCopyWith(_DeskAccount value, $Res Function(_DeskAccount) _then) = __$DeskAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String orgName, String orgId, DataCenter dataCenter, String apiDomain, String portalId, String portalName, String avatarColor, String avatarInitial
});




}
/// @nodoc
class __$DeskAccountCopyWithImpl<$Res>
    implements _$DeskAccountCopyWith<$Res> {
  __$DeskAccountCopyWithImpl(this._self, this._then);

  final _DeskAccount _self;
  final $Res Function(_DeskAccount) _then;

/// Create a copy of DeskAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orgName = null,Object? orgId = null,Object? dataCenter = null,Object? apiDomain = null,Object? portalId = null,Object? portalName = null,Object? avatarColor = null,Object? avatarInitial = null,}) {
  return _then(_DeskAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orgName: null == orgName ? _self.orgName : orgName // ignore: cast_nullable_to_non_nullable
as String,orgId: null == orgId ? _self.orgId : orgId // ignore: cast_nullable_to_non_nullable
as String,dataCenter: null == dataCenter ? _self.dataCenter : dataCenter // ignore: cast_nullable_to_non_nullable
as DataCenter,apiDomain: null == apiDomain ? _self.apiDomain : apiDomain // ignore: cast_nullable_to_non_nullable
as String,portalId: null == portalId ? _self.portalId : portalId // ignore: cast_nullable_to_non_nullable
as String,portalName: null == portalName ? _self.portalName : portalName // ignore: cast_nullable_to_non_nullable
as String,avatarColor: null == avatarColor ? _self.avatarColor : avatarColor // ignore: cast_nullable_to_non_nullable
as String,avatarInitial: null == avatarInitial ? _self.avatarInitial : avatarInitial // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
