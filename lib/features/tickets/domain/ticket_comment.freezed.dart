// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketComment {

 String get id; String get ticketId; String get content; String get authorName; CommentAuthorType get authorType; DateTime get createdAt; List<String> get attachmentIds; bool get isPublic;
/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCommentCopyWith<TicketComment> get copyWith => _$TicketCommentCopyWithImpl<TicketComment>(this as TicketComment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketComment&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorType, authorType) || other.authorType == authorType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.attachmentIds, attachmentIds)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}


@override
int get hashCode => Object.hash(runtimeType,id,ticketId,content,authorName,authorType,createdAt,const DeepCollectionEquality().hash(attachmentIds),isPublic);

@override
String toString() {
  return 'TicketComment(id: $id, ticketId: $ticketId, content: $content, authorName: $authorName, authorType: $authorType, createdAt: $createdAt, attachmentIds: $attachmentIds, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class $TicketCommentCopyWith<$Res>  {
  factory $TicketCommentCopyWith(TicketComment value, $Res Function(TicketComment) _then) = _$TicketCommentCopyWithImpl;
@useResult
$Res call({
 String id, String ticketId, String content, String authorName, CommentAuthorType authorType, DateTime createdAt, List<String> attachmentIds, bool isPublic
});




}
/// @nodoc
class _$TicketCommentCopyWithImpl<$Res>
    implements $TicketCommentCopyWith<$Res> {
  _$TicketCommentCopyWithImpl(this._self, this._then);

  final TicketComment _self;
  final $Res Function(TicketComment) _then;

/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticketId = null,Object? content = null,Object? authorName = null,Object? authorType = null,Object? createdAt = null,Object? attachmentIds = null,Object? isPublic = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorType: null == authorType ? _self.authorType : authorType // ignore: cast_nullable_to_non_nullable
as CommentAuthorType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,attachmentIds: null == attachmentIds ? _self.attachmentIds : attachmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketComment].
extension TicketCommentPatterns on TicketComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketComment value)  $default,){
final _that = this;
switch (_that) {
case _TicketComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketComment value)?  $default,){
final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ticketId,  String content,  String authorName,  CommentAuthorType authorType,  DateTime createdAt,  List<String> attachmentIds,  bool isPublic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
return $default(_that.id,_that.ticketId,_that.content,_that.authorName,_that.authorType,_that.createdAt,_that.attachmentIds,_that.isPublic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ticketId,  String content,  String authorName,  CommentAuthorType authorType,  DateTime createdAt,  List<String> attachmentIds,  bool isPublic)  $default,) {final _that = this;
switch (_that) {
case _TicketComment():
return $default(_that.id,_that.ticketId,_that.content,_that.authorName,_that.authorType,_that.createdAt,_that.attachmentIds,_that.isPublic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ticketId,  String content,  String authorName,  CommentAuthorType authorType,  DateTime createdAt,  List<String> attachmentIds,  bool isPublic)?  $default,) {final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
return $default(_that.id,_that.ticketId,_that.content,_that.authorName,_that.authorType,_that.createdAt,_that.attachmentIds,_that.isPublic);case _:
  return null;

}
}

}

/// @nodoc


class _TicketComment implements TicketComment {
  const _TicketComment({required this.id, required this.ticketId, required this.content, required this.authorName, required this.authorType, required this.createdAt, final  List<String> attachmentIds = const [], this.isPublic = false}): _attachmentIds = attachmentIds;
  

@override final  String id;
@override final  String ticketId;
@override final  String content;
@override final  String authorName;
@override final  CommentAuthorType authorType;
@override final  DateTime createdAt;
 final  List<String> _attachmentIds;
@override@JsonKey() List<String> get attachmentIds {
  if (_attachmentIds is EqualUnmodifiableListView) return _attachmentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachmentIds);
}

@override@JsonKey() final  bool isPublic;

/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCommentCopyWith<_TicketComment> get copyWith => __$TicketCommentCopyWithImpl<_TicketComment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketComment&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorType, authorType) || other.authorType == authorType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._attachmentIds, _attachmentIds)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}


@override
int get hashCode => Object.hash(runtimeType,id,ticketId,content,authorName,authorType,createdAt,const DeepCollectionEquality().hash(_attachmentIds),isPublic);

@override
String toString() {
  return 'TicketComment(id: $id, ticketId: $ticketId, content: $content, authorName: $authorName, authorType: $authorType, createdAt: $createdAt, attachmentIds: $attachmentIds, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class _$TicketCommentCopyWith<$Res> implements $TicketCommentCopyWith<$Res> {
  factory _$TicketCommentCopyWith(_TicketComment value, $Res Function(_TicketComment) _then) = __$TicketCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String ticketId, String content, String authorName, CommentAuthorType authorType, DateTime createdAt, List<String> attachmentIds, bool isPublic
});




}
/// @nodoc
class __$TicketCommentCopyWithImpl<$Res>
    implements _$TicketCommentCopyWith<$Res> {
  __$TicketCommentCopyWithImpl(this._self, this._then);

  final _TicketComment _self;
  final $Res Function(_TicketComment) _then;

/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticketId = null,Object? content = null,Object? authorName = null,Object? authorType = null,Object? createdAt = null,Object? attachmentIds = null,Object? isPublic = null,}) {
  return _then(_TicketComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorType: null == authorType ? _self.authorType : authorType // ignore: cast_nullable_to_non_nullable
as CommentAuthorType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,attachmentIds: null == attachmentIds ? _self._attachmentIds : attachmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
