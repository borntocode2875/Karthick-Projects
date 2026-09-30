// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Ticket {

 String get id; String get ticketNumber; String get subject; String get description; TicketStatus get status; TicketPriority get priority; String get accountId; String get portalId; DataCenter get dataCenter;/// The contact ID that owns this ticket.
 String get contactId; String get contactName; String get contactEmail; DateTime get createdAt; DateTime get updatedAt; int get commentCount; int get attachmentCount; bool get hasUnread;/// Portal-defined custom field values, keyed by field key.
 Map<String, Object?> get customFieldValues; String? get product; String? get category; String? get subCategory; DateTime? get dueDate; DateTime? get closedAt;
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCopyWith<Ticket> get copyWith => _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketNumber, ticketNumber) || other.ticketNumber == ticketNumber)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.portalId, portalId) || other.portalId == portalId)&&(identical(other.dataCenter, dataCenter) || other.dataCenter == dataCenter)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.attachmentCount, attachmentCount) || other.attachmentCount == attachmentCount)&&(identical(other.hasUnread, hasUnread) || other.hasUnread == hasUnread)&&const DeepCollectionEquality().equals(other.customFieldValues, customFieldValues)&&(identical(other.product, product) || other.product == product)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,ticketNumber,subject,description,status,priority,accountId,portalId,dataCenter,contactId,contactName,contactEmail,createdAt,updatedAt,commentCount,attachmentCount,hasUnread,const DeepCollectionEquality().hash(customFieldValues),product,category,subCategory,dueDate,closedAt]);

@override
String toString() {
  return 'Ticket(id: $id, ticketNumber: $ticketNumber, subject: $subject, description: $description, status: $status, priority: $priority, accountId: $accountId, portalId: $portalId, dataCenter: $dataCenter, contactId: $contactId, contactName: $contactName, contactEmail: $contactEmail, createdAt: $createdAt, updatedAt: $updatedAt, commentCount: $commentCount, attachmentCount: $attachmentCount, hasUnread: $hasUnread, customFieldValues: $customFieldValues, product: $product, category: $category, subCategory: $subCategory, dueDate: $dueDate, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res>  {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) = _$TicketCopyWithImpl;
@useResult
$Res call({
 String id, String ticketNumber, String subject, String description, TicketStatus status, TicketPriority priority, String accountId, String portalId, DataCenter dataCenter, String contactId, String contactName, String contactEmail, DateTime createdAt, DateTime updatedAt, int commentCount, int attachmentCount, bool hasUnread, Map<String, Object?> customFieldValues, String? product, String? category, String? subCategory, DateTime? dueDate, DateTime? closedAt
});




}
/// @nodoc
class _$TicketCopyWithImpl<$Res>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._self, this._then);

  final Ticket _self;
  final $Res Function(Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ticketNumber = null,Object? subject = null,Object? description = null,Object? status = null,Object? priority = null,Object? accountId = null,Object? portalId = null,Object? dataCenter = null,Object? contactId = null,Object? contactName = null,Object? contactEmail = null,Object? createdAt = null,Object? updatedAt = null,Object? commentCount = null,Object? attachmentCount = null,Object? hasUnread = null,Object? customFieldValues = null,Object? product = freezed,Object? category = freezed,Object? subCategory = freezed,Object? dueDate = freezed,Object? closedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticketNumber: null == ticketNumber ? _self.ticketNumber : ticketNumber // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,portalId: null == portalId ? _self.portalId : portalId // ignore: cast_nullable_to_non_nullable
as String,dataCenter: null == dataCenter ? _self.dataCenter : dataCenter // ignore: cast_nullable_to_non_nullable
as DataCenter,contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,attachmentCount: null == attachmentCount ? _self.attachmentCount : attachmentCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,customFieldValues: null == customFieldValues ? _self.customFieldValues : customFieldValues // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ticket].
extension TicketPatterns on Ticket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ticket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ticket value)  $default,){
final _that = this;
switch (_that) {
case _Ticket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ticket value)?  $default,){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ticketNumber,  String subject,  String description,  TicketStatus status,  TicketPriority priority,  String accountId,  String portalId,  DataCenter dataCenter,  String contactId,  String contactName,  String contactEmail,  DateTime createdAt,  DateTime updatedAt,  int commentCount,  int attachmentCount,  bool hasUnread,  Map<String, Object?> customFieldValues,  String? product,  String? category,  String? subCategory,  DateTime? dueDate,  DateTime? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.ticketNumber,_that.subject,_that.description,_that.status,_that.priority,_that.accountId,_that.portalId,_that.dataCenter,_that.contactId,_that.contactName,_that.contactEmail,_that.createdAt,_that.updatedAt,_that.commentCount,_that.attachmentCount,_that.hasUnread,_that.customFieldValues,_that.product,_that.category,_that.subCategory,_that.dueDate,_that.closedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ticketNumber,  String subject,  String description,  TicketStatus status,  TicketPriority priority,  String accountId,  String portalId,  DataCenter dataCenter,  String contactId,  String contactName,  String contactEmail,  DateTime createdAt,  DateTime updatedAt,  int commentCount,  int attachmentCount,  bool hasUnread,  Map<String, Object?> customFieldValues,  String? product,  String? category,  String? subCategory,  DateTime? dueDate,  DateTime? closedAt)  $default,) {final _that = this;
switch (_that) {
case _Ticket():
return $default(_that.id,_that.ticketNumber,_that.subject,_that.description,_that.status,_that.priority,_that.accountId,_that.portalId,_that.dataCenter,_that.contactId,_that.contactName,_that.contactEmail,_that.createdAt,_that.updatedAt,_that.commentCount,_that.attachmentCount,_that.hasUnread,_that.customFieldValues,_that.product,_that.category,_that.subCategory,_that.dueDate,_that.closedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ticketNumber,  String subject,  String description,  TicketStatus status,  TicketPriority priority,  String accountId,  String portalId,  DataCenter dataCenter,  String contactId,  String contactName,  String contactEmail,  DateTime createdAt,  DateTime updatedAt,  int commentCount,  int attachmentCount,  bool hasUnread,  Map<String, Object?> customFieldValues,  String? product,  String? category,  String? subCategory,  DateTime? dueDate,  DateTime? closedAt)?  $default,) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.ticketNumber,_that.subject,_that.description,_that.status,_that.priority,_that.accountId,_that.portalId,_that.dataCenter,_that.contactId,_that.contactName,_that.contactEmail,_that.createdAt,_that.updatedAt,_that.commentCount,_that.attachmentCount,_that.hasUnread,_that.customFieldValues,_that.product,_that.category,_that.subCategory,_that.dueDate,_that.closedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Ticket implements Ticket {
  const _Ticket({required this.id, required this.ticketNumber, required this.subject, required this.description, required this.status, required this.priority, required this.accountId, required this.portalId, required this.dataCenter, required this.contactId, required this.contactName, required this.contactEmail, required this.createdAt, required this.updatedAt, this.commentCount = 0, this.attachmentCount = 0, this.hasUnread = false, final  Map<String, Object?> customFieldValues = const {}, this.product, this.category, this.subCategory, this.dueDate, this.closedAt}): _customFieldValues = customFieldValues;
  

@override final  String id;
@override final  String ticketNumber;
@override final  String subject;
@override final  String description;
@override final  TicketStatus status;
@override final  TicketPriority priority;
@override final  String accountId;
@override final  String portalId;
@override final  DataCenter dataCenter;
/// The contact ID that owns this ticket.
@override final  String contactId;
@override final  String contactName;
@override final  String contactEmail;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  int commentCount;
@override@JsonKey() final  int attachmentCount;
@override@JsonKey() final  bool hasUnread;
/// Portal-defined custom field values, keyed by field key.
 final  Map<String, Object?> _customFieldValues;
/// Portal-defined custom field values, keyed by field key.
@override@JsonKey() Map<String, Object?> get customFieldValues {
  if (_customFieldValues is EqualUnmodifiableMapView) return _customFieldValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customFieldValues);
}

@override final  String? product;
@override final  String? category;
@override final  String? subCategory;
@override final  DateTime? dueDate;
@override final  DateTime? closedAt;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCopyWith<_Ticket> get copyWith => __$TicketCopyWithImpl<_Ticket>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ticket&&(identical(other.id, id) || other.id == id)&&(identical(other.ticketNumber, ticketNumber) || other.ticketNumber == ticketNumber)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.portalId, portalId) || other.portalId == portalId)&&(identical(other.dataCenter, dataCenter) || other.dataCenter == dataCenter)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.attachmentCount, attachmentCount) || other.attachmentCount == attachmentCount)&&(identical(other.hasUnread, hasUnread) || other.hasUnread == hasUnread)&&const DeepCollectionEquality().equals(other._customFieldValues, _customFieldValues)&&(identical(other.product, product) || other.product == product)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,ticketNumber,subject,description,status,priority,accountId,portalId,dataCenter,contactId,contactName,contactEmail,createdAt,updatedAt,commentCount,attachmentCount,hasUnread,const DeepCollectionEquality().hash(_customFieldValues),product,category,subCategory,dueDate,closedAt]);

@override
String toString() {
  return 'Ticket(id: $id, ticketNumber: $ticketNumber, subject: $subject, description: $description, status: $status, priority: $priority, accountId: $accountId, portalId: $portalId, dataCenter: $dataCenter, contactId: $contactId, contactName: $contactName, contactEmail: $contactEmail, createdAt: $createdAt, updatedAt: $updatedAt, commentCount: $commentCount, attachmentCount: $attachmentCount, hasUnread: $hasUnread, customFieldValues: $customFieldValues, product: $product, category: $category, subCategory: $subCategory, dueDate: $dueDate, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) = __$TicketCopyWithImpl;
@override @useResult
$Res call({
 String id, String ticketNumber, String subject, String description, TicketStatus status, TicketPriority priority, String accountId, String portalId, DataCenter dataCenter, String contactId, String contactName, String contactEmail, DateTime createdAt, DateTime updatedAt, int commentCount, int attachmentCount, bool hasUnread, Map<String, Object?> customFieldValues, String? product, String? category, String? subCategory, DateTime? dueDate, DateTime? closedAt
});




}
/// @nodoc
class __$TicketCopyWithImpl<$Res>
    implements _$TicketCopyWith<$Res> {
  __$TicketCopyWithImpl(this._self, this._then);

  final _Ticket _self;
  final $Res Function(_Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ticketNumber = null,Object? subject = null,Object? description = null,Object? status = null,Object? priority = null,Object? accountId = null,Object? portalId = null,Object? dataCenter = null,Object? contactId = null,Object? contactName = null,Object? contactEmail = null,Object? createdAt = null,Object? updatedAt = null,Object? commentCount = null,Object? attachmentCount = null,Object? hasUnread = null,Object? customFieldValues = null,Object? product = freezed,Object? category = freezed,Object? subCategory = freezed,Object? dueDate = freezed,Object? closedAt = freezed,}) {
  return _then(_Ticket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ticketNumber: null == ticketNumber ? _self.ticketNumber : ticketNumber // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,portalId: null == portalId ? _self.portalId : portalId // ignore: cast_nullable_to_non_nullable
as String,dataCenter: null == dataCenter ? _self.dataCenter : dataCenter // ignore: cast_nullable_to_non_nullable
as DataCenter,contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,attachmentCount: null == attachmentCount ? _self.attachmentCount : attachmentCount // ignore: cast_nullable_to_non_nullable
as int,hasUnread: null == hasUnread ? _self.hasUnread : hasUnread // ignore: cast_nullable_to_non_nullable
as bool,customFieldValues: null == customFieldValues ? _self._customFieldValues : customFieldValues // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
