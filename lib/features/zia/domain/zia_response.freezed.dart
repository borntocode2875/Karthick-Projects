// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zia_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZiaResponse {

 String get messageId; String get text;/// A proposed action, present when Zia wants the user to confirm something.
 ZiaAction? get proposedAction;/// Ticket IDs referenced in the response, for quick navigation.
 List<String> get referencedTicketIds;/// Issue IDs referenced in the response.
 List<String> get referencedIssueIds;
/// Create a copy of ZiaResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZiaResponseCopyWith<ZiaResponse> get copyWith => _$ZiaResponseCopyWithImpl<ZiaResponse>(this as ZiaResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZiaResponse&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.text, text) || other.text == text)&&(identical(other.proposedAction, proposedAction) || other.proposedAction == proposedAction)&&const DeepCollectionEquality().equals(other.referencedTicketIds, referencedTicketIds)&&const DeepCollectionEquality().equals(other.referencedIssueIds, referencedIssueIds));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,text,proposedAction,const DeepCollectionEquality().hash(referencedTicketIds),const DeepCollectionEquality().hash(referencedIssueIds));

@override
String toString() {
  return 'ZiaResponse(messageId: $messageId, text: $text, proposedAction: $proposedAction, referencedTicketIds: $referencedTicketIds, referencedIssueIds: $referencedIssueIds)';
}


}

/// @nodoc
abstract mixin class $ZiaResponseCopyWith<$Res>  {
  factory $ZiaResponseCopyWith(ZiaResponse value, $Res Function(ZiaResponse) _then) = _$ZiaResponseCopyWithImpl;
@useResult
$Res call({
 String messageId, String text, ZiaAction? proposedAction, List<String> referencedTicketIds, List<String> referencedIssueIds
});


$ZiaActionCopyWith<$Res>? get proposedAction;

}
/// @nodoc
class _$ZiaResponseCopyWithImpl<$Res>
    implements $ZiaResponseCopyWith<$Res> {
  _$ZiaResponseCopyWithImpl(this._self, this._then);

  final ZiaResponse _self;
  final $Res Function(ZiaResponse) _then;

/// Create a copy of ZiaResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? text = null,Object? proposedAction = freezed,Object? referencedTicketIds = null,Object? referencedIssueIds = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,proposedAction: freezed == proposedAction ? _self.proposedAction : proposedAction // ignore: cast_nullable_to_non_nullable
as ZiaAction?,referencedTicketIds: null == referencedTicketIds ? _self.referencedTicketIds : referencedTicketIds // ignore: cast_nullable_to_non_nullable
as List<String>,referencedIssueIds: null == referencedIssueIds ? _self.referencedIssueIds : referencedIssueIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ZiaResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZiaActionCopyWith<$Res>? get proposedAction {
    if (_self.proposedAction == null) {
    return null;
  }

  return $ZiaActionCopyWith<$Res>(_self.proposedAction!, (value) {
    return _then(_self.copyWith(proposedAction: value));
  });
}
}


/// Adds pattern-matching-related methods to [ZiaResponse].
extension ZiaResponsePatterns on ZiaResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZiaResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZiaResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZiaResponse value)  $default,){
final _that = this;
switch (_that) {
case _ZiaResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZiaResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ZiaResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String messageId,  String text,  ZiaAction? proposedAction,  List<String> referencedTicketIds,  List<String> referencedIssueIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZiaResponse() when $default != null:
return $default(_that.messageId,_that.text,_that.proposedAction,_that.referencedTicketIds,_that.referencedIssueIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String messageId,  String text,  ZiaAction? proposedAction,  List<String> referencedTicketIds,  List<String> referencedIssueIds)  $default,) {final _that = this;
switch (_that) {
case _ZiaResponse():
return $default(_that.messageId,_that.text,_that.proposedAction,_that.referencedTicketIds,_that.referencedIssueIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String messageId,  String text,  ZiaAction? proposedAction,  List<String> referencedTicketIds,  List<String> referencedIssueIds)?  $default,) {final _that = this;
switch (_that) {
case _ZiaResponse() when $default != null:
return $default(_that.messageId,_that.text,_that.proposedAction,_that.referencedTicketIds,_that.referencedIssueIds);case _:
  return null;

}
}

}

/// @nodoc


class _ZiaResponse implements ZiaResponse {
  const _ZiaResponse({required this.messageId, required this.text, this.proposedAction, final  List<String> referencedTicketIds = const [], final  List<String> referencedIssueIds = const []}): _referencedTicketIds = referencedTicketIds,_referencedIssueIds = referencedIssueIds;
  

@override final  String messageId;
@override final  String text;
/// A proposed action, present when Zia wants the user to confirm something.
@override final  ZiaAction? proposedAction;
/// Ticket IDs referenced in the response, for quick navigation.
 final  List<String> _referencedTicketIds;
/// Ticket IDs referenced in the response, for quick navigation.
@override@JsonKey() List<String> get referencedTicketIds {
  if (_referencedTicketIds is EqualUnmodifiableListView) return _referencedTicketIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_referencedTicketIds);
}

/// Issue IDs referenced in the response.
 final  List<String> _referencedIssueIds;
/// Issue IDs referenced in the response.
@override@JsonKey() List<String> get referencedIssueIds {
  if (_referencedIssueIds is EqualUnmodifiableListView) return _referencedIssueIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_referencedIssueIds);
}


/// Create a copy of ZiaResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZiaResponseCopyWith<_ZiaResponse> get copyWith => __$ZiaResponseCopyWithImpl<_ZiaResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZiaResponse&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.text, text) || other.text == text)&&(identical(other.proposedAction, proposedAction) || other.proposedAction == proposedAction)&&const DeepCollectionEquality().equals(other._referencedTicketIds, _referencedTicketIds)&&const DeepCollectionEquality().equals(other._referencedIssueIds, _referencedIssueIds));
}


@override
int get hashCode => Object.hash(runtimeType,messageId,text,proposedAction,const DeepCollectionEquality().hash(_referencedTicketIds),const DeepCollectionEquality().hash(_referencedIssueIds));

@override
String toString() {
  return 'ZiaResponse(messageId: $messageId, text: $text, proposedAction: $proposedAction, referencedTicketIds: $referencedTicketIds, referencedIssueIds: $referencedIssueIds)';
}


}

/// @nodoc
abstract mixin class _$ZiaResponseCopyWith<$Res> implements $ZiaResponseCopyWith<$Res> {
  factory _$ZiaResponseCopyWith(_ZiaResponse value, $Res Function(_ZiaResponse) _then) = __$ZiaResponseCopyWithImpl;
@override @useResult
$Res call({
 String messageId, String text, ZiaAction? proposedAction, List<String> referencedTicketIds, List<String> referencedIssueIds
});


@override $ZiaActionCopyWith<$Res>? get proposedAction;

}
/// @nodoc
class __$ZiaResponseCopyWithImpl<$Res>
    implements _$ZiaResponseCopyWith<$Res> {
  __$ZiaResponseCopyWithImpl(this._self, this._then);

  final _ZiaResponse _self;
  final $Res Function(_ZiaResponse) _then;

/// Create a copy of ZiaResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? text = null,Object? proposedAction = freezed,Object? referencedTicketIds = null,Object? referencedIssueIds = null,}) {
  return _then(_ZiaResponse(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,proposedAction: freezed == proposedAction ? _self.proposedAction : proposedAction // ignore: cast_nullable_to_non_nullable
as ZiaAction?,referencedTicketIds: null == referencedTicketIds ? _self._referencedTicketIds : referencedTicketIds // ignore: cast_nullable_to_non_nullable
as List<String>,referencedIssueIds: null == referencedIssueIds ? _self._referencedIssueIds : referencedIssueIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ZiaResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZiaActionCopyWith<$Res>? get proposedAction {
    if (_self.proposedAction == null) {
    return null;
  }

  return $ZiaActionCopyWith<$Res>(_self.proposedAction!, (value) {
    return _then(_self.copyWith(proposedAction: value));
  });
}
}

// dart format on
