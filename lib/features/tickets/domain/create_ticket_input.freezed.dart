// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_ticket_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTicketInput {

 String get subject; String get description; TicketPriority get priority; String? get product; String? get category; String? get subCategory;/// Portal-specific custom field values, keyed by field key.
 Map<String, Object?> get customFieldValues; List<String> get attachmentIds;
/// Create a copy of CreateTicketInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTicketInputCopyWith<CreateTicketInput> get copyWith => _$CreateTicketInputCopyWithImpl<CreateTicketInput>(this as CreateTicketInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTicketInput&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.product, product) || other.product == product)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&const DeepCollectionEquality().equals(other.customFieldValues, customFieldValues)&&const DeepCollectionEquality().equals(other.attachmentIds, attachmentIds));
}


@override
int get hashCode => Object.hash(runtimeType,subject,description,priority,product,category,subCategory,const DeepCollectionEquality().hash(customFieldValues),const DeepCollectionEquality().hash(attachmentIds));

@override
String toString() {
  return 'CreateTicketInput(subject: $subject, description: $description, priority: $priority, product: $product, category: $category, subCategory: $subCategory, customFieldValues: $customFieldValues, attachmentIds: $attachmentIds)';
}


}

/// @nodoc
abstract mixin class $CreateTicketInputCopyWith<$Res>  {
  factory $CreateTicketInputCopyWith(CreateTicketInput value, $Res Function(CreateTicketInput) _then) = _$CreateTicketInputCopyWithImpl;
@useResult
$Res call({
 String subject, String description, TicketPriority priority, String? product, String? category, String? subCategory, Map<String, Object?> customFieldValues, List<String> attachmentIds
});




}
/// @nodoc
class _$CreateTicketInputCopyWithImpl<$Res>
    implements $CreateTicketInputCopyWith<$Res> {
  _$CreateTicketInputCopyWithImpl(this._self, this._then);

  final CreateTicketInput _self;
  final $Res Function(CreateTicketInput) _then;

/// Create a copy of CreateTicketInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subject = null,Object? description = null,Object? priority = null,Object? product = freezed,Object? category = freezed,Object? subCategory = freezed,Object? customFieldValues = null,Object? attachmentIds = null,}) {
  return _then(_self.copyWith(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,customFieldValues: null == customFieldValues ? _self.customFieldValues : customFieldValues // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,attachmentIds: null == attachmentIds ? _self.attachmentIds : attachmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTicketInput].
extension CreateTicketInputPatterns on CreateTicketInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTicketInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTicketInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTicketInput value)  $default,){
final _that = this;
switch (_that) {
case _CreateTicketInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTicketInput value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTicketInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subject,  String description,  TicketPriority priority,  String? product,  String? category,  String? subCategory,  Map<String, Object?> customFieldValues,  List<String> attachmentIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTicketInput() when $default != null:
return $default(_that.subject,_that.description,_that.priority,_that.product,_that.category,_that.subCategory,_that.customFieldValues,_that.attachmentIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subject,  String description,  TicketPriority priority,  String? product,  String? category,  String? subCategory,  Map<String, Object?> customFieldValues,  List<String> attachmentIds)  $default,) {final _that = this;
switch (_that) {
case _CreateTicketInput():
return $default(_that.subject,_that.description,_that.priority,_that.product,_that.category,_that.subCategory,_that.customFieldValues,_that.attachmentIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subject,  String description,  TicketPriority priority,  String? product,  String? category,  String? subCategory,  Map<String, Object?> customFieldValues,  List<String> attachmentIds)?  $default,) {final _that = this;
switch (_that) {
case _CreateTicketInput() when $default != null:
return $default(_that.subject,_that.description,_that.priority,_that.product,_that.category,_that.subCategory,_that.customFieldValues,_that.attachmentIds);case _:
  return null;

}
}

}

/// @nodoc


class _CreateTicketInput implements CreateTicketInput {
  const _CreateTicketInput({required this.subject, required this.description, required this.priority, this.product, this.category, this.subCategory, final  Map<String, Object?> customFieldValues = const {}, final  List<String> attachmentIds = const []}): _customFieldValues = customFieldValues,_attachmentIds = attachmentIds;
  

@override final  String subject;
@override final  String description;
@override final  TicketPriority priority;
@override final  String? product;
@override final  String? category;
@override final  String? subCategory;
/// Portal-specific custom field values, keyed by field key.
 final  Map<String, Object?> _customFieldValues;
/// Portal-specific custom field values, keyed by field key.
@override@JsonKey() Map<String, Object?> get customFieldValues {
  if (_customFieldValues is EqualUnmodifiableMapView) return _customFieldValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customFieldValues);
}

 final  List<String> _attachmentIds;
@override@JsonKey() List<String> get attachmentIds {
  if (_attachmentIds is EqualUnmodifiableListView) return _attachmentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attachmentIds);
}


/// Create a copy of CreateTicketInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTicketInputCopyWith<_CreateTicketInput> get copyWith => __$CreateTicketInputCopyWithImpl<_CreateTicketInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTicketInput&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.product, product) || other.product == product)&&(identical(other.category, category) || other.category == category)&&(identical(other.subCategory, subCategory) || other.subCategory == subCategory)&&const DeepCollectionEquality().equals(other._customFieldValues, _customFieldValues)&&const DeepCollectionEquality().equals(other._attachmentIds, _attachmentIds));
}


@override
int get hashCode => Object.hash(runtimeType,subject,description,priority,product,category,subCategory,const DeepCollectionEquality().hash(_customFieldValues),const DeepCollectionEquality().hash(_attachmentIds));

@override
String toString() {
  return 'CreateTicketInput(subject: $subject, description: $description, priority: $priority, product: $product, category: $category, subCategory: $subCategory, customFieldValues: $customFieldValues, attachmentIds: $attachmentIds)';
}


}

/// @nodoc
abstract mixin class _$CreateTicketInputCopyWith<$Res> implements $CreateTicketInputCopyWith<$Res> {
  factory _$CreateTicketInputCopyWith(_CreateTicketInput value, $Res Function(_CreateTicketInput) _then) = __$CreateTicketInputCopyWithImpl;
@override @useResult
$Res call({
 String subject, String description, TicketPriority priority, String? product, String? category, String? subCategory, Map<String, Object?> customFieldValues, List<String> attachmentIds
});




}
/// @nodoc
class __$CreateTicketInputCopyWithImpl<$Res>
    implements _$CreateTicketInputCopyWith<$Res> {
  __$CreateTicketInputCopyWithImpl(this._self, this._then);

  final _CreateTicketInput _self;
  final $Res Function(_CreateTicketInput) _then;

/// Create a copy of CreateTicketInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subject = null,Object? description = null,Object? priority = null,Object? product = freezed,Object? category = freezed,Object? subCategory = freezed,Object? customFieldValues = null,Object? attachmentIds = null,}) {
  return _then(_CreateTicketInput(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,subCategory: freezed == subCategory ? _self.subCategory : subCategory // ignore: cast_nullable_to_non_nullable
as String?,customFieldValues: null == customFieldValues ? _self._customFieldValues : customFieldValues // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,attachmentIds: null == attachmentIds ? _self._attachmentIds : attachmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
