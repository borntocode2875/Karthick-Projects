// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zia_chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZiaChatMessage {

 String get id; ZiaMessageRole get role; String get content; DateTime get timestamp;/// Proposed action attached to this message, if any.
 String? get actionId;
/// Create a copy of ZiaChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZiaChatMessageCopyWith<ZiaChatMessage> get copyWith => _$ZiaChatMessageCopyWithImpl<ZiaChatMessage>(this as ZiaChatMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZiaChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.actionId, actionId) || other.actionId == actionId));
}


@override
int get hashCode => Object.hash(runtimeType,id,role,content,timestamp,actionId);

@override
String toString() {
  return 'ZiaChatMessage(id: $id, role: $role, content: $content, timestamp: $timestamp, actionId: $actionId)';
}


}

/// @nodoc
abstract mixin class $ZiaChatMessageCopyWith<$Res>  {
  factory $ZiaChatMessageCopyWith(ZiaChatMessage value, $Res Function(ZiaChatMessage) _then) = _$ZiaChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, ZiaMessageRole role, String content, DateTime timestamp, String? actionId
});




}
/// @nodoc
class _$ZiaChatMessageCopyWithImpl<$Res>
    implements $ZiaChatMessageCopyWith<$Res> {
  _$ZiaChatMessageCopyWithImpl(this._self, this._then);

  final ZiaChatMessage _self;
  final $Res Function(ZiaChatMessage) _then;

/// Create a copy of ZiaChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? content = null,Object? timestamp = null,Object? actionId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ZiaMessageRole,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,actionId: freezed == actionId ? _self.actionId : actionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ZiaChatMessage].
extension ZiaChatMessagePatterns on ZiaChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZiaChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZiaChatMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZiaChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ZiaChatMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZiaChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ZiaChatMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ZiaMessageRole role,  String content,  DateTime timestamp,  String? actionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZiaChatMessage() when $default != null:
return $default(_that.id,_that.role,_that.content,_that.timestamp,_that.actionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ZiaMessageRole role,  String content,  DateTime timestamp,  String? actionId)  $default,) {final _that = this;
switch (_that) {
case _ZiaChatMessage():
return $default(_that.id,_that.role,_that.content,_that.timestamp,_that.actionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ZiaMessageRole role,  String content,  DateTime timestamp,  String? actionId)?  $default,) {final _that = this;
switch (_that) {
case _ZiaChatMessage() when $default != null:
return $default(_that.id,_that.role,_that.content,_that.timestamp,_that.actionId);case _:
  return null;

}
}

}

/// @nodoc


class _ZiaChatMessage implements ZiaChatMessage {
  const _ZiaChatMessage({required this.id, required this.role, required this.content, required this.timestamp, this.actionId});
  

@override final  String id;
@override final  ZiaMessageRole role;
@override final  String content;
@override final  DateTime timestamp;
/// Proposed action attached to this message, if any.
@override final  String? actionId;

/// Create a copy of ZiaChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZiaChatMessageCopyWith<_ZiaChatMessage> get copyWith => __$ZiaChatMessageCopyWithImpl<_ZiaChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZiaChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.actionId, actionId) || other.actionId == actionId));
}


@override
int get hashCode => Object.hash(runtimeType,id,role,content,timestamp,actionId);

@override
String toString() {
  return 'ZiaChatMessage(id: $id, role: $role, content: $content, timestamp: $timestamp, actionId: $actionId)';
}


}

/// @nodoc
abstract mixin class _$ZiaChatMessageCopyWith<$Res> implements $ZiaChatMessageCopyWith<$Res> {
  factory _$ZiaChatMessageCopyWith(_ZiaChatMessage value, $Res Function(_ZiaChatMessage) _then) = __$ZiaChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, ZiaMessageRole role, String content, DateTime timestamp, String? actionId
});




}
/// @nodoc
class __$ZiaChatMessageCopyWithImpl<$Res>
    implements _$ZiaChatMessageCopyWith<$Res> {
  __$ZiaChatMessageCopyWithImpl(this._self, this._then);

  final _ZiaChatMessage _self;
  final $Res Function(_ZiaChatMessage) _then;

/// Create a copy of ZiaChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? content = null,Object? timestamp = null,Object? actionId = freezed,}) {
  return _then(_ZiaChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as ZiaMessageRole,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,actionId: freezed == actionId ? _self.actionId : actionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
