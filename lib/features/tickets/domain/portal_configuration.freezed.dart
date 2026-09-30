// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portal_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttachmentConfig {

/// Allowed MIME types. Empty = all types allowed.
 List<String> get allowedMimeTypes;/// Allowed file extensions (e.g. ['.pdf', '.jpg']). Empty = all allowed.
 List<String> get allowedExtensions;/// Max size per file in bytes. Null = no limit.
 int? get maxFileSizeBytes;/// Max total number of attachments per ticket. Null = no limit.
 int? get maxFiles;
/// Create a copy of AttachmentConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttachmentConfigCopyWith<AttachmentConfig> get copyWith => _$AttachmentConfigCopyWithImpl<AttachmentConfig>(this as AttachmentConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttachmentConfig&&const DeepCollectionEquality().equals(other.allowedMimeTypes, allowedMimeTypes)&&const DeepCollectionEquality().equals(other.allowedExtensions, allowedExtensions)&&(identical(other.maxFileSizeBytes, maxFileSizeBytes) || other.maxFileSizeBytes == maxFileSizeBytes)&&(identical(other.maxFiles, maxFiles) || other.maxFiles == maxFiles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allowedMimeTypes),const DeepCollectionEquality().hash(allowedExtensions),maxFileSizeBytes,maxFiles);

@override
String toString() {
  return 'AttachmentConfig(allowedMimeTypes: $allowedMimeTypes, allowedExtensions: $allowedExtensions, maxFileSizeBytes: $maxFileSizeBytes, maxFiles: $maxFiles)';
}


}

/// @nodoc
abstract mixin class $AttachmentConfigCopyWith<$Res>  {
  factory $AttachmentConfigCopyWith(AttachmentConfig value, $Res Function(AttachmentConfig) _then) = _$AttachmentConfigCopyWithImpl;
@useResult
$Res call({
 List<String> allowedMimeTypes, List<String> allowedExtensions, int? maxFileSizeBytes, int? maxFiles
});




}
/// @nodoc
class _$AttachmentConfigCopyWithImpl<$Res>
    implements $AttachmentConfigCopyWith<$Res> {
  _$AttachmentConfigCopyWithImpl(this._self, this._then);

  final AttachmentConfig _self;
  final $Res Function(AttachmentConfig) _then;

/// Create a copy of AttachmentConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allowedMimeTypes = null,Object? allowedExtensions = null,Object? maxFileSizeBytes = freezed,Object? maxFiles = freezed,}) {
  return _then(_self.copyWith(
allowedMimeTypes: null == allowedMimeTypes ? _self.allowedMimeTypes : allowedMimeTypes // ignore: cast_nullable_to_non_nullable
as List<String>,allowedExtensions: null == allowedExtensions ? _self.allowedExtensions : allowedExtensions // ignore: cast_nullable_to_non_nullable
as List<String>,maxFileSizeBytes: freezed == maxFileSizeBytes ? _self.maxFileSizeBytes : maxFileSizeBytes // ignore: cast_nullable_to_non_nullable
as int?,maxFiles: freezed == maxFiles ? _self.maxFiles : maxFiles // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttachmentConfig].
extension AttachmentConfigPatterns on AttachmentConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttachmentConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttachmentConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttachmentConfig value)  $default,){
final _that = this;
switch (_that) {
case _AttachmentConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttachmentConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AttachmentConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> allowedMimeTypes,  List<String> allowedExtensions,  int? maxFileSizeBytes,  int? maxFiles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttachmentConfig() when $default != null:
return $default(_that.allowedMimeTypes,_that.allowedExtensions,_that.maxFileSizeBytes,_that.maxFiles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> allowedMimeTypes,  List<String> allowedExtensions,  int? maxFileSizeBytes,  int? maxFiles)  $default,) {final _that = this;
switch (_that) {
case _AttachmentConfig():
return $default(_that.allowedMimeTypes,_that.allowedExtensions,_that.maxFileSizeBytes,_that.maxFiles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> allowedMimeTypes,  List<String> allowedExtensions,  int? maxFileSizeBytes,  int? maxFiles)?  $default,) {final _that = this;
switch (_that) {
case _AttachmentConfig() when $default != null:
return $default(_that.allowedMimeTypes,_that.allowedExtensions,_that.maxFileSizeBytes,_that.maxFiles);case _:
  return null;

}
}

}

/// @nodoc


class _AttachmentConfig implements AttachmentConfig {
  const _AttachmentConfig({final  List<String> allowedMimeTypes = const [], final  List<String> allowedExtensions = const [], this.maxFileSizeBytes, this.maxFiles}): _allowedMimeTypes = allowedMimeTypes,_allowedExtensions = allowedExtensions;
  

/// Allowed MIME types. Empty = all types allowed.
 final  List<String> _allowedMimeTypes;
/// Allowed MIME types. Empty = all types allowed.
@override@JsonKey() List<String> get allowedMimeTypes {
  if (_allowedMimeTypes is EqualUnmodifiableListView) return _allowedMimeTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedMimeTypes);
}

/// Allowed file extensions (e.g. ['.pdf', '.jpg']). Empty = all allowed.
 final  List<String> _allowedExtensions;
/// Allowed file extensions (e.g. ['.pdf', '.jpg']). Empty = all allowed.
@override@JsonKey() List<String> get allowedExtensions {
  if (_allowedExtensions is EqualUnmodifiableListView) return _allowedExtensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedExtensions);
}

/// Max size per file in bytes. Null = no limit.
@override final  int? maxFileSizeBytes;
/// Max total number of attachments per ticket. Null = no limit.
@override final  int? maxFiles;

/// Create a copy of AttachmentConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentConfigCopyWith<_AttachmentConfig> get copyWith => __$AttachmentConfigCopyWithImpl<_AttachmentConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachmentConfig&&const DeepCollectionEquality().equals(other._allowedMimeTypes, _allowedMimeTypes)&&const DeepCollectionEquality().equals(other._allowedExtensions, _allowedExtensions)&&(identical(other.maxFileSizeBytes, maxFileSizeBytes) || other.maxFileSizeBytes == maxFileSizeBytes)&&(identical(other.maxFiles, maxFiles) || other.maxFiles == maxFiles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allowedMimeTypes),const DeepCollectionEquality().hash(_allowedExtensions),maxFileSizeBytes,maxFiles);

@override
String toString() {
  return 'AttachmentConfig(allowedMimeTypes: $allowedMimeTypes, allowedExtensions: $allowedExtensions, maxFileSizeBytes: $maxFileSizeBytes, maxFiles: $maxFiles)';
}


}

/// @nodoc
abstract mixin class _$AttachmentConfigCopyWith<$Res> implements $AttachmentConfigCopyWith<$Res> {
  factory _$AttachmentConfigCopyWith(_AttachmentConfig value, $Res Function(_AttachmentConfig) _then) = __$AttachmentConfigCopyWithImpl;
@override @useResult
$Res call({
 List<String> allowedMimeTypes, List<String> allowedExtensions, int? maxFileSizeBytes, int? maxFiles
});




}
/// @nodoc
class __$AttachmentConfigCopyWithImpl<$Res>
    implements _$AttachmentConfigCopyWith<$Res> {
  __$AttachmentConfigCopyWithImpl(this._self, this._then);

  final _AttachmentConfig _self;
  final $Res Function(_AttachmentConfig) _then;

/// Create a copy of AttachmentConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allowedMimeTypes = null,Object? allowedExtensions = null,Object? maxFileSizeBytes = freezed,Object? maxFiles = freezed,}) {
  return _then(_AttachmentConfig(
allowedMimeTypes: null == allowedMimeTypes ? _self._allowedMimeTypes : allowedMimeTypes // ignore: cast_nullable_to_non_nullable
as List<String>,allowedExtensions: null == allowedExtensions ? _self._allowedExtensions : allowedExtensions // ignore: cast_nullable_to_non_nullable
as List<String>,maxFileSizeBytes: freezed == maxFileSizeBytes ? _self.maxFileSizeBytes : maxFileSizeBytes // ignore: cast_nullable_to_non_nullable
as int?,maxFiles: freezed == maxFiles ? _self.maxFiles : maxFiles // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$PortalConfiguration {

 String get portalId; String get portalName; String get accountId;/// Fields shown on the create-ticket form.
 List<DynamicField> get createTicketFields;/// Fields available as list filters (subset of createTicketFields + standard).
 List<DynamicField> get filterFields; List<TicketStatus> get availableStatuses; List<TicketPriority> get availablePriorities; List<String> get products;/// product name → list of category names.
 Map<String, List<String>> get categories; AttachmentConfig get attachmentConfig; TicketPermissions get defaultPermissions;
/// Create a copy of PortalConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortalConfigurationCopyWith<PortalConfiguration> get copyWith => _$PortalConfigurationCopyWithImpl<PortalConfiguration>(this as PortalConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortalConfiguration&&(identical(other.portalId, portalId) || other.portalId == portalId)&&(identical(other.portalName, portalName) || other.portalName == portalName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&const DeepCollectionEquality().equals(other.createTicketFields, createTicketFields)&&const DeepCollectionEquality().equals(other.filterFields, filterFields)&&const DeepCollectionEquality().equals(other.availableStatuses, availableStatuses)&&const DeepCollectionEquality().equals(other.availablePriorities, availablePriorities)&&const DeepCollectionEquality().equals(other.products, products)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.attachmentConfig, attachmentConfig) || other.attachmentConfig == attachmentConfig)&&(identical(other.defaultPermissions, defaultPermissions) || other.defaultPermissions == defaultPermissions));
}


@override
int get hashCode => Object.hash(runtimeType,portalId,portalName,accountId,const DeepCollectionEquality().hash(createTicketFields),const DeepCollectionEquality().hash(filterFields),const DeepCollectionEquality().hash(availableStatuses),const DeepCollectionEquality().hash(availablePriorities),const DeepCollectionEquality().hash(products),const DeepCollectionEquality().hash(categories),attachmentConfig,defaultPermissions);

@override
String toString() {
  return 'PortalConfiguration(portalId: $portalId, portalName: $portalName, accountId: $accountId, createTicketFields: $createTicketFields, filterFields: $filterFields, availableStatuses: $availableStatuses, availablePriorities: $availablePriorities, products: $products, categories: $categories, attachmentConfig: $attachmentConfig, defaultPermissions: $defaultPermissions)';
}


}

/// @nodoc
abstract mixin class $PortalConfigurationCopyWith<$Res>  {
  factory $PortalConfigurationCopyWith(PortalConfiguration value, $Res Function(PortalConfiguration) _then) = _$PortalConfigurationCopyWithImpl;
@useResult
$Res call({
 String portalId, String portalName, String accountId, List<DynamicField> createTicketFields, List<DynamicField> filterFields, List<TicketStatus> availableStatuses, List<TicketPriority> availablePriorities, List<String> products, Map<String, List<String>> categories, AttachmentConfig attachmentConfig, TicketPermissions defaultPermissions
});


$AttachmentConfigCopyWith<$Res> get attachmentConfig;

}
/// @nodoc
class _$PortalConfigurationCopyWithImpl<$Res>
    implements $PortalConfigurationCopyWith<$Res> {
  _$PortalConfigurationCopyWithImpl(this._self, this._then);

  final PortalConfiguration _self;
  final $Res Function(PortalConfiguration) _then;

/// Create a copy of PortalConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? portalId = null,Object? portalName = null,Object? accountId = null,Object? createTicketFields = null,Object? filterFields = null,Object? availableStatuses = null,Object? availablePriorities = null,Object? products = null,Object? categories = null,Object? attachmentConfig = null,Object? defaultPermissions = null,}) {
  return _then(_self.copyWith(
portalId: null == portalId ? _self.portalId : portalId // ignore: cast_nullable_to_non_nullable
as String,portalName: null == portalName ? _self.portalName : portalName // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,createTicketFields: null == createTicketFields ? _self.createTicketFields : createTicketFields // ignore: cast_nullable_to_non_nullable
as List<DynamicField>,filterFields: null == filterFields ? _self.filterFields : filterFields // ignore: cast_nullable_to_non_nullable
as List<DynamicField>,availableStatuses: null == availableStatuses ? _self.availableStatuses : availableStatuses // ignore: cast_nullable_to_non_nullable
as List<TicketStatus>,availablePriorities: null == availablePriorities ? _self.availablePriorities : availablePriorities // ignore: cast_nullable_to_non_nullable
as List<TicketPriority>,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<String>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,attachmentConfig: null == attachmentConfig ? _self.attachmentConfig : attachmentConfig // ignore: cast_nullable_to_non_nullable
as AttachmentConfig,defaultPermissions: null == defaultPermissions ? _self.defaultPermissions : defaultPermissions // ignore: cast_nullable_to_non_nullable
as TicketPermissions,
  ));
}
/// Create a copy of PortalConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttachmentConfigCopyWith<$Res> get attachmentConfig {
  
  return $AttachmentConfigCopyWith<$Res>(_self.attachmentConfig, (value) {
    return _then(_self.copyWith(attachmentConfig: value));
  });
}
}


/// Adds pattern-matching-related methods to [PortalConfiguration].
extension PortalConfigurationPatterns on PortalConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortalConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortalConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortalConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _PortalConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortalConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _PortalConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String portalId,  String portalName,  String accountId,  List<DynamicField> createTicketFields,  List<DynamicField> filterFields,  List<TicketStatus> availableStatuses,  List<TicketPriority> availablePriorities,  List<String> products,  Map<String, List<String>> categories,  AttachmentConfig attachmentConfig,  TicketPermissions defaultPermissions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortalConfiguration() when $default != null:
return $default(_that.portalId,_that.portalName,_that.accountId,_that.createTicketFields,_that.filterFields,_that.availableStatuses,_that.availablePriorities,_that.products,_that.categories,_that.attachmentConfig,_that.defaultPermissions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String portalId,  String portalName,  String accountId,  List<DynamicField> createTicketFields,  List<DynamicField> filterFields,  List<TicketStatus> availableStatuses,  List<TicketPriority> availablePriorities,  List<String> products,  Map<String, List<String>> categories,  AttachmentConfig attachmentConfig,  TicketPermissions defaultPermissions)  $default,) {final _that = this;
switch (_that) {
case _PortalConfiguration():
return $default(_that.portalId,_that.portalName,_that.accountId,_that.createTicketFields,_that.filterFields,_that.availableStatuses,_that.availablePriorities,_that.products,_that.categories,_that.attachmentConfig,_that.defaultPermissions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String portalId,  String portalName,  String accountId,  List<DynamicField> createTicketFields,  List<DynamicField> filterFields,  List<TicketStatus> availableStatuses,  List<TicketPriority> availablePriorities,  List<String> products,  Map<String, List<String>> categories,  AttachmentConfig attachmentConfig,  TicketPermissions defaultPermissions)?  $default,) {final _that = this;
switch (_that) {
case _PortalConfiguration() when $default != null:
return $default(_that.portalId,_that.portalName,_that.accountId,_that.createTicketFields,_that.filterFields,_that.availableStatuses,_that.availablePriorities,_that.products,_that.categories,_that.attachmentConfig,_that.defaultPermissions);case _:
  return null;

}
}

}

/// @nodoc


class _PortalConfiguration implements PortalConfiguration {
  const _PortalConfiguration({required this.portalId, required this.portalName, required this.accountId, required final  List<DynamicField> createTicketFields, required final  List<DynamicField> filterFields, required final  List<TicketStatus> availableStatuses, required final  List<TicketPriority> availablePriorities, required final  List<String> products, final  Map<String, List<String>> categories = const {}, required this.attachmentConfig, required this.defaultPermissions}): _createTicketFields = createTicketFields,_filterFields = filterFields,_availableStatuses = availableStatuses,_availablePriorities = availablePriorities,_products = products,_categories = categories;
  

@override final  String portalId;
@override final  String portalName;
@override final  String accountId;
/// Fields shown on the create-ticket form.
 final  List<DynamicField> _createTicketFields;
/// Fields shown on the create-ticket form.
@override List<DynamicField> get createTicketFields {
  if (_createTicketFields is EqualUnmodifiableListView) return _createTicketFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_createTicketFields);
}

/// Fields available as list filters (subset of createTicketFields + standard).
 final  List<DynamicField> _filterFields;
/// Fields available as list filters (subset of createTicketFields + standard).
@override List<DynamicField> get filterFields {
  if (_filterFields is EqualUnmodifiableListView) return _filterFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filterFields);
}

 final  List<TicketStatus> _availableStatuses;
@override List<TicketStatus> get availableStatuses {
  if (_availableStatuses is EqualUnmodifiableListView) return _availableStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableStatuses);
}

 final  List<TicketPriority> _availablePriorities;
@override List<TicketPriority> get availablePriorities {
  if (_availablePriorities is EqualUnmodifiableListView) return _availablePriorities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePriorities);
}

 final  List<String> _products;
@override List<String> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

/// product name → list of category names.
 final  Map<String, List<String>> _categories;
/// product name → list of category names.
@override@JsonKey() Map<String, List<String>> get categories {
  if (_categories is EqualUnmodifiableMapView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categories);
}

@override final  AttachmentConfig attachmentConfig;
@override final  TicketPermissions defaultPermissions;

/// Create a copy of PortalConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortalConfigurationCopyWith<_PortalConfiguration> get copyWith => __$PortalConfigurationCopyWithImpl<_PortalConfiguration>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortalConfiguration&&(identical(other.portalId, portalId) || other.portalId == portalId)&&(identical(other.portalName, portalName) || other.portalName == portalName)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&const DeepCollectionEquality().equals(other._createTicketFields, _createTicketFields)&&const DeepCollectionEquality().equals(other._filterFields, _filterFields)&&const DeepCollectionEquality().equals(other._availableStatuses, _availableStatuses)&&const DeepCollectionEquality().equals(other._availablePriorities, _availablePriorities)&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.attachmentConfig, attachmentConfig) || other.attachmentConfig == attachmentConfig)&&(identical(other.defaultPermissions, defaultPermissions) || other.defaultPermissions == defaultPermissions));
}


@override
int get hashCode => Object.hash(runtimeType,portalId,portalName,accountId,const DeepCollectionEquality().hash(_createTicketFields),const DeepCollectionEquality().hash(_filterFields),const DeepCollectionEquality().hash(_availableStatuses),const DeepCollectionEquality().hash(_availablePriorities),const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_categories),attachmentConfig,defaultPermissions);

@override
String toString() {
  return 'PortalConfiguration(portalId: $portalId, portalName: $portalName, accountId: $accountId, createTicketFields: $createTicketFields, filterFields: $filterFields, availableStatuses: $availableStatuses, availablePriorities: $availablePriorities, products: $products, categories: $categories, attachmentConfig: $attachmentConfig, defaultPermissions: $defaultPermissions)';
}


}

/// @nodoc
abstract mixin class _$PortalConfigurationCopyWith<$Res> implements $PortalConfigurationCopyWith<$Res> {
  factory _$PortalConfigurationCopyWith(_PortalConfiguration value, $Res Function(_PortalConfiguration) _then) = __$PortalConfigurationCopyWithImpl;
@override @useResult
$Res call({
 String portalId, String portalName, String accountId, List<DynamicField> createTicketFields, List<DynamicField> filterFields, List<TicketStatus> availableStatuses, List<TicketPriority> availablePriorities, List<String> products, Map<String, List<String>> categories, AttachmentConfig attachmentConfig, TicketPermissions defaultPermissions
});


@override $AttachmentConfigCopyWith<$Res> get attachmentConfig;

}
/// @nodoc
class __$PortalConfigurationCopyWithImpl<$Res>
    implements _$PortalConfigurationCopyWith<$Res> {
  __$PortalConfigurationCopyWithImpl(this._self, this._then);

  final _PortalConfiguration _self;
  final $Res Function(_PortalConfiguration) _then;

/// Create a copy of PortalConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? portalId = null,Object? portalName = null,Object? accountId = null,Object? createTicketFields = null,Object? filterFields = null,Object? availableStatuses = null,Object? availablePriorities = null,Object? products = null,Object? categories = null,Object? attachmentConfig = null,Object? defaultPermissions = null,}) {
  return _then(_PortalConfiguration(
portalId: null == portalId ? _self.portalId : portalId // ignore: cast_nullable_to_non_nullable
as String,portalName: null == portalName ? _self.portalName : portalName // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,createTicketFields: null == createTicketFields ? _self._createTicketFields : createTicketFields // ignore: cast_nullable_to_non_nullable
as List<DynamicField>,filterFields: null == filterFields ? _self._filterFields : filterFields // ignore: cast_nullable_to_non_nullable
as List<DynamicField>,availableStatuses: null == availableStatuses ? _self._availableStatuses : availableStatuses // ignore: cast_nullable_to_non_nullable
as List<TicketStatus>,availablePriorities: null == availablePriorities ? _self._availablePriorities : availablePriorities // ignore: cast_nullable_to_non_nullable
as List<TicketPriority>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<String>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,attachmentConfig: null == attachmentConfig ? _self.attachmentConfig : attachmentConfig // ignore: cast_nullable_to_non_nullable
as AttachmentConfig,defaultPermissions: null == defaultPermissions ? _self.defaultPermissions : defaultPermissions // ignore: cast_nullable_to_non_nullable
as TicketPermissions,
  ));
}

/// Create a copy of PortalConfiguration
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttachmentConfigCopyWith<$Res> get attachmentConfig {
  
  return $AttachmentConfigCopyWith<$Res>(_self.attachmentConfig, (value) {
    return _then(_self.copyWith(attachmentConfig: value));
  });
}
}

// dart format on
