// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zia_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ZiaAction {

 String get id; ZiaActionType get type; String get confirmLabel;/// Target ticket ID (null for createTicket actions).
 String? get ticketId; String? get ticketSubject;/// For changeStatus: the current status.
 TicketStatus? get fromStatus;/// For changeStatus: the proposed status.
 TicketStatus? get toStatus;/// For changePriority: the current priority.
 TicketPriority? get fromPriority;/// For changePriority: the proposed priority.
 TicketPriority? get toPriority;/// For addComment: the comment text.
 String? get commentContent;/// For createTicket: the prefilled input.
 CreateTicketInput? get createInput; bool get isConfirmed; bool get isRejected;
/// Create a copy of ZiaAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZiaActionCopyWith<ZiaAction> get copyWith => _$ZiaActionCopyWithImpl<ZiaAction>(this as ZiaAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZiaAction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.confirmLabel, confirmLabel) || other.confirmLabel == confirmLabel)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.ticketSubject, ticketSubject) || other.ticketSubject == ticketSubject)&&(identical(other.fromStatus, fromStatus) || other.fromStatus == fromStatus)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.fromPriority, fromPriority) || other.fromPriority == fromPriority)&&(identical(other.toPriority, toPriority) || other.toPriority == toPriority)&&(identical(other.commentContent, commentContent) || other.commentContent == commentContent)&&(identical(other.createInput, createInput) || other.createInput == createInput)&&(identical(other.isConfirmed, isConfirmed) || other.isConfirmed == isConfirmed)&&(identical(other.isRejected, isRejected) || other.isRejected == isRejected));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,confirmLabel,ticketId,ticketSubject,fromStatus,toStatus,fromPriority,toPriority,commentContent,createInput,isConfirmed,isRejected);

@override
String toString() {
  return 'ZiaAction(id: $id, type: $type, confirmLabel: $confirmLabel, ticketId: $ticketId, ticketSubject: $ticketSubject, fromStatus: $fromStatus, toStatus: $toStatus, fromPriority: $fromPriority, toPriority: $toPriority, commentContent: $commentContent, createInput: $createInput, isConfirmed: $isConfirmed, isRejected: $isRejected)';
}


}

/// @nodoc
abstract mixin class $ZiaActionCopyWith<$Res>  {
  factory $ZiaActionCopyWith(ZiaAction value, $Res Function(ZiaAction) _then) = _$ZiaActionCopyWithImpl;
@useResult
$Res call({
 String id, ZiaActionType type, String confirmLabel, String? ticketId, String? ticketSubject, TicketStatus? fromStatus, TicketStatus? toStatus, TicketPriority? fromPriority, TicketPriority? toPriority, String? commentContent, CreateTicketInput? createInput, bool isConfirmed, bool isRejected
});


$CreateTicketInputCopyWith<$Res>? get createInput;

}
/// @nodoc
class _$ZiaActionCopyWithImpl<$Res>
    implements $ZiaActionCopyWith<$Res> {
  _$ZiaActionCopyWithImpl(this._self, this._then);

  final ZiaAction _self;
  final $Res Function(ZiaAction) _then;

/// Create a copy of ZiaAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? confirmLabel = null,Object? ticketId = freezed,Object? ticketSubject = freezed,Object? fromStatus = freezed,Object? toStatus = freezed,Object? fromPriority = freezed,Object? toPriority = freezed,Object? commentContent = freezed,Object? createInput = freezed,Object? isConfirmed = null,Object? isRejected = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ZiaActionType,confirmLabel: null == confirmLabel ? _self.confirmLabel : confirmLabel // ignore: cast_nullable_to_non_nullable
as String,ticketId: freezed == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String?,ticketSubject: freezed == ticketSubject ? _self.ticketSubject : ticketSubject // ignore: cast_nullable_to_non_nullable
as String?,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as TicketStatus?,toStatus: freezed == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as TicketStatus?,fromPriority: freezed == fromPriority ? _self.fromPriority : fromPriority // ignore: cast_nullable_to_non_nullable
as TicketPriority?,toPriority: freezed == toPriority ? _self.toPriority : toPriority // ignore: cast_nullable_to_non_nullable
as TicketPriority?,commentContent: freezed == commentContent ? _self.commentContent : commentContent // ignore: cast_nullable_to_non_nullable
as String?,createInput: freezed == createInput ? _self.createInput : createInput // ignore: cast_nullable_to_non_nullable
as CreateTicketInput?,isConfirmed: null == isConfirmed ? _self.isConfirmed : isConfirmed // ignore: cast_nullable_to_non_nullable
as bool,isRejected: null == isRejected ? _self.isRejected : isRejected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ZiaAction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreateTicketInputCopyWith<$Res>? get createInput {
    if (_self.createInput == null) {
    return null;
  }

  return $CreateTicketInputCopyWith<$Res>(_self.createInput!, (value) {
    return _then(_self.copyWith(createInput: value));
  });
}
}


/// Adds pattern-matching-related methods to [ZiaAction].
extension ZiaActionPatterns on ZiaAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZiaAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZiaAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZiaAction value)  $default,){
final _that = this;
switch (_that) {
case _ZiaAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZiaAction value)?  $default,){
final _that = this;
switch (_that) {
case _ZiaAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ZiaActionType type,  String confirmLabel,  String? ticketId,  String? ticketSubject,  TicketStatus? fromStatus,  TicketStatus? toStatus,  TicketPriority? fromPriority,  TicketPriority? toPriority,  String? commentContent,  CreateTicketInput? createInput,  bool isConfirmed,  bool isRejected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZiaAction() when $default != null:
return $default(_that.id,_that.type,_that.confirmLabel,_that.ticketId,_that.ticketSubject,_that.fromStatus,_that.toStatus,_that.fromPriority,_that.toPriority,_that.commentContent,_that.createInput,_that.isConfirmed,_that.isRejected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ZiaActionType type,  String confirmLabel,  String? ticketId,  String? ticketSubject,  TicketStatus? fromStatus,  TicketStatus? toStatus,  TicketPriority? fromPriority,  TicketPriority? toPriority,  String? commentContent,  CreateTicketInput? createInput,  bool isConfirmed,  bool isRejected)  $default,) {final _that = this;
switch (_that) {
case _ZiaAction():
return $default(_that.id,_that.type,_that.confirmLabel,_that.ticketId,_that.ticketSubject,_that.fromStatus,_that.toStatus,_that.fromPriority,_that.toPriority,_that.commentContent,_that.createInput,_that.isConfirmed,_that.isRejected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ZiaActionType type,  String confirmLabel,  String? ticketId,  String? ticketSubject,  TicketStatus? fromStatus,  TicketStatus? toStatus,  TicketPriority? fromPriority,  TicketPriority? toPriority,  String? commentContent,  CreateTicketInput? createInput,  bool isConfirmed,  bool isRejected)?  $default,) {final _that = this;
switch (_that) {
case _ZiaAction() when $default != null:
return $default(_that.id,_that.type,_that.confirmLabel,_that.ticketId,_that.ticketSubject,_that.fromStatus,_that.toStatus,_that.fromPriority,_that.toPriority,_that.commentContent,_that.createInput,_that.isConfirmed,_that.isRejected);case _:
  return null;

}
}

}

/// @nodoc


class _ZiaAction implements ZiaAction {
  const _ZiaAction({required this.id, required this.type, required this.confirmLabel, this.ticketId, this.ticketSubject, this.fromStatus, this.toStatus, this.fromPriority, this.toPriority, this.commentContent, this.createInput, this.isConfirmed = false, this.isRejected = false});
  

@override final  String id;
@override final  ZiaActionType type;
@override final  String confirmLabel;
/// Target ticket ID (null for createTicket actions).
@override final  String? ticketId;
@override final  String? ticketSubject;
/// For changeStatus: the current status.
@override final  TicketStatus? fromStatus;
/// For changeStatus: the proposed status.
@override final  TicketStatus? toStatus;
/// For changePriority: the current priority.
@override final  TicketPriority? fromPriority;
/// For changePriority: the proposed priority.
@override final  TicketPriority? toPriority;
/// For addComment: the comment text.
@override final  String? commentContent;
/// For createTicket: the prefilled input.
@override final  CreateTicketInput? createInput;
@override@JsonKey() final  bool isConfirmed;
@override@JsonKey() final  bool isRejected;

/// Create a copy of ZiaAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZiaActionCopyWith<_ZiaAction> get copyWith => __$ZiaActionCopyWithImpl<_ZiaAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZiaAction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.confirmLabel, confirmLabel) || other.confirmLabel == confirmLabel)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.ticketSubject, ticketSubject) || other.ticketSubject == ticketSubject)&&(identical(other.fromStatus, fromStatus) || other.fromStatus == fromStatus)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.fromPriority, fromPriority) || other.fromPriority == fromPriority)&&(identical(other.toPriority, toPriority) || other.toPriority == toPriority)&&(identical(other.commentContent, commentContent) || other.commentContent == commentContent)&&(identical(other.createInput, createInput) || other.createInput == createInput)&&(identical(other.isConfirmed, isConfirmed) || other.isConfirmed == isConfirmed)&&(identical(other.isRejected, isRejected) || other.isRejected == isRejected));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,confirmLabel,ticketId,ticketSubject,fromStatus,toStatus,fromPriority,toPriority,commentContent,createInput,isConfirmed,isRejected);

@override
String toString() {
  return 'ZiaAction(id: $id, type: $type, confirmLabel: $confirmLabel, ticketId: $ticketId, ticketSubject: $ticketSubject, fromStatus: $fromStatus, toStatus: $toStatus, fromPriority: $fromPriority, toPriority: $toPriority, commentContent: $commentContent, createInput: $createInput, isConfirmed: $isConfirmed, isRejected: $isRejected)';
}


}

/// @nodoc
abstract mixin class _$ZiaActionCopyWith<$Res> implements $ZiaActionCopyWith<$Res> {
  factory _$ZiaActionCopyWith(_ZiaAction value, $Res Function(_ZiaAction) _then) = __$ZiaActionCopyWithImpl;
@override @useResult
$Res call({
 String id, ZiaActionType type, String confirmLabel, String? ticketId, String? ticketSubject, TicketStatus? fromStatus, TicketStatus? toStatus, TicketPriority? fromPriority, TicketPriority? toPriority, String? commentContent, CreateTicketInput? createInput, bool isConfirmed, bool isRejected
});


@override $CreateTicketInputCopyWith<$Res>? get createInput;

}
/// @nodoc
class __$ZiaActionCopyWithImpl<$Res>
    implements _$ZiaActionCopyWith<$Res> {
  __$ZiaActionCopyWithImpl(this._self, this._then);

  final _ZiaAction _self;
  final $Res Function(_ZiaAction) _then;

/// Create a copy of ZiaAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? confirmLabel = null,Object? ticketId = freezed,Object? ticketSubject = freezed,Object? fromStatus = freezed,Object? toStatus = freezed,Object? fromPriority = freezed,Object? toPriority = freezed,Object? commentContent = freezed,Object? createInput = freezed,Object? isConfirmed = null,Object? isRejected = null,}) {
  return _then(_ZiaAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ZiaActionType,confirmLabel: null == confirmLabel ? _self.confirmLabel : confirmLabel // ignore: cast_nullable_to_non_nullable
as String,ticketId: freezed == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String?,ticketSubject: freezed == ticketSubject ? _self.ticketSubject : ticketSubject // ignore: cast_nullable_to_non_nullable
as String?,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as TicketStatus?,toStatus: freezed == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as TicketStatus?,fromPriority: freezed == fromPriority ? _self.fromPriority : fromPriority // ignore: cast_nullable_to_non_nullable
as TicketPriority?,toPriority: freezed == toPriority ? _self.toPriority : toPriority // ignore: cast_nullable_to_non_nullable
as TicketPriority?,commentContent: freezed == commentContent ? _self.commentContent : commentContent // ignore: cast_nullable_to_non_nullable
as String?,createInput: freezed == createInput ? _self.createInput : createInput // ignore: cast_nullable_to_non_nullable
as CreateTicketInput?,isConfirmed: null == isConfirmed ? _self.isConfirmed : isConfirmed // ignore: cast_nullable_to_non_nullable
as bool,isRejected: null == isRejected ? _self.isRejected : isRejected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ZiaAction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreateTicketInputCopyWith<$Res>? get createInput {
    if (_self.createInput == null) {
    return null;
  }

  return $CreateTicketInputCopyWith<$Res>(_self.createInput!, (value) {
    return _then(_self.copyWith(createInput: value));
  });
}
}

// dart format on
