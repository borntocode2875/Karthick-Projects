// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ongoing_issue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IssueUpdate {

 String get id; String get content; IssueStatus get status; DateTime get timestamp;
/// Create a copy of IssueUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IssueUpdateCopyWith<IssueUpdate> get copyWith => _$IssueUpdateCopyWithImpl<IssueUpdate>(this as IssueUpdate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IssueUpdate&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,status,timestamp);

@override
String toString() {
  return 'IssueUpdate(id: $id, content: $content, status: $status, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $IssueUpdateCopyWith<$Res>  {
  factory $IssueUpdateCopyWith(IssueUpdate value, $Res Function(IssueUpdate) _then) = _$IssueUpdateCopyWithImpl;
@useResult
$Res call({
 String id, String content, IssueStatus status, DateTime timestamp
});




}
/// @nodoc
class _$IssueUpdateCopyWithImpl<$Res>
    implements $IssueUpdateCopyWith<$Res> {
  _$IssueUpdateCopyWithImpl(this._self, this._then);

  final IssueUpdate _self;
  final $Res Function(IssueUpdate) _then;

/// Create a copy of IssueUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? status = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IssueStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [IssueUpdate].
extension IssueUpdatePatterns on IssueUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IssueUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IssueUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IssueUpdate value)  $default,){
final _that = this;
switch (_that) {
case _IssueUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IssueUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _IssueUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String content,  IssueStatus status,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IssueUpdate() when $default != null:
return $default(_that.id,_that.content,_that.status,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String content,  IssueStatus status,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _IssueUpdate():
return $default(_that.id,_that.content,_that.status,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String content,  IssueStatus status,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _IssueUpdate() when $default != null:
return $default(_that.id,_that.content,_that.status,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _IssueUpdate implements IssueUpdate {
  const _IssueUpdate({required this.id, required this.content, required this.status, required this.timestamp});
  

@override final  String id;
@override final  String content;
@override final  IssueStatus status;
@override final  DateTime timestamp;

/// Create a copy of IssueUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IssueUpdateCopyWith<_IssueUpdate> get copyWith => __$IssueUpdateCopyWithImpl<_IssueUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IssueUpdate&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,content,status,timestamp);

@override
String toString() {
  return 'IssueUpdate(id: $id, content: $content, status: $status, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$IssueUpdateCopyWith<$Res> implements $IssueUpdateCopyWith<$Res> {
  factory _$IssueUpdateCopyWith(_IssueUpdate value, $Res Function(_IssueUpdate) _then) = __$IssueUpdateCopyWithImpl;
@override @useResult
$Res call({
 String id, String content, IssueStatus status, DateTime timestamp
});




}
/// @nodoc
class __$IssueUpdateCopyWithImpl<$Res>
    implements _$IssueUpdateCopyWith<$Res> {
  __$IssueUpdateCopyWithImpl(this._self, this._then);

  final _IssueUpdate _self;
  final $Res Function(_IssueUpdate) _then;

/// Create a copy of IssueUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? content = null,Object? status = null,Object? timestamp = null,}) {
  return _then(_IssueUpdate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IssueStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$OngoingIssue {

 String get id; String get title; String get description; IssueStatus get status; IssueSeverity get severity; List<String> get affectedProducts; List<DataCenter> get affectedDataCenters; DateTime get startedAt; DateTime? get resolvedAt; DateTime? get scheduledFor; DateTime get updatedAt; List<IssueUpdate> get timeline;
/// Create a copy of OngoingIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OngoingIssueCopyWith<OngoingIssue> get copyWith => _$OngoingIssueCopyWithImpl<OngoingIssue>(this as OngoingIssue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OngoingIssue&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.severity, severity) || other.severity == severity)&&const DeepCollectionEquality().equals(other.affectedProducts, affectedProducts)&&const DeepCollectionEquality().equals(other.affectedDataCenters, affectedDataCenters)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.scheduledFor, scheduledFor) || other.scheduledFor == scheduledFor)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.timeline, timeline));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,status,severity,const DeepCollectionEquality().hash(affectedProducts),const DeepCollectionEquality().hash(affectedDataCenters),startedAt,resolvedAt,scheduledFor,updatedAt,const DeepCollectionEquality().hash(timeline));

@override
String toString() {
  return 'OngoingIssue(id: $id, title: $title, description: $description, status: $status, severity: $severity, affectedProducts: $affectedProducts, affectedDataCenters: $affectedDataCenters, startedAt: $startedAt, resolvedAt: $resolvedAt, scheduledFor: $scheduledFor, updatedAt: $updatedAt, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class $OngoingIssueCopyWith<$Res>  {
  factory $OngoingIssueCopyWith(OngoingIssue value, $Res Function(OngoingIssue) _then) = _$OngoingIssueCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, IssueStatus status, IssueSeverity severity, List<String> affectedProducts, List<DataCenter> affectedDataCenters, DateTime startedAt, DateTime? resolvedAt, DateTime? scheduledFor, DateTime updatedAt, List<IssueUpdate> timeline
});




}
/// @nodoc
class _$OngoingIssueCopyWithImpl<$Res>
    implements $OngoingIssueCopyWith<$Res> {
  _$OngoingIssueCopyWithImpl(this._self, this._then);

  final OngoingIssue _self;
  final $Res Function(OngoingIssue) _then;

/// Create a copy of OngoingIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? status = null,Object? severity = null,Object? affectedProducts = null,Object? affectedDataCenters = null,Object? startedAt = null,Object? resolvedAt = freezed,Object? scheduledFor = freezed,Object? updatedAt = null,Object? timeline = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IssueStatus,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as IssueSeverity,affectedProducts: null == affectedProducts ? _self.affectedProducts : affectedProducts // ignore: cast_nullable_to_non_nullable
as List<String>,affectedDataCenters: null == affectedDataCenters ? _self.affectedDataCenters : affectedDataCenters // ignore: cast_nullable_to_non_nullable
as List<DataCenter>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledFor: freezed == scheduledFor ? _self.scheduledFor : scheduledFor // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<IssueUpdate>,
  ));
}

}


/// Adds pattern-matching-related methods to [OngoingIssue].
extension OngoingIssuePatterns on OngoingIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OngoingIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OngoingIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OngoingIssue value)  $default,){
final _that = this;
switch (_that) {
case _OngoingIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OngoingIssue value)?  $default,){
final _that = this;
switch (_that) {
case _OngoingIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  IssueStatus status,  IssueSeverity severity,  List<String> affectedProducts,  List<DataCenter> affectedDataCenters,  DateTime startedAt,  DateTime? resolvedAt,  DateTime? scheduledFor,  DateTime updatedAt,  List<IssueUpdate> timeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OngoingIssue() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.status,_that.severity,_that.affectedProducts,_that.affectedDataCenters,_that.startedAt,_that.resolvedAt,_that.scheduledFor,_that.updatedAt,_that.timeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  IssueStatus status,  IssueSeverity severity,  List<String> affectedProducts,  List<DataCenter> affectedDataCenters,  DateTime startedAt,  DateTime? resolvedAt,  DateTime? scheduledFor,  DateTime updatedAt,  List<IssueUpdate> timeline)  $default,) {final _that = this;
switch (_that) {
case _OngoingIssue():
return $default(_that.id,_that.title,_that.description,_that.status,_that.severity,_that.affectedProducts,_that.affectedDataCenters,_that.startedAt,_that.resolvedAt,_that.scheduledFor,_that.updatedAt,_that.timeline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  IssueStatus status,  IssueSeverity severity,  List<String> affectedProducts,  List<DataCenter> affectedDataCenters,  DateTime startedAt,  DateTime? resolvedAt,  DateTime? scheduledFor,  DateTime updatedAt,  List<IssueUpdate> timeline)?  $default,) {final _that = this;
switch (_that) {
case _OngoingIssue() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.status,_that.severity,_that.affectedProducts,_that.affectedDataCenters,_that.startedAt,_that.resolvedAt,_that.scheduledFor,_that.updatedAt,_that.timeline);case _:
  return null;

}
}

}

/// @nodoc


class _OngoingIssue extends OngoingIssue {
  const _OngoingIssue({required this.id, required this.title, required this.description, required this.status, required this.severity, required final  List<String> affectedProducts, required final  List<DataCenter> affectedDataCenters, required this.startedAt, this.resolvedAt, this.scheduledFor, required this.updatedAt, final  List<IssueUpdate> timeline = const []}): _affectedProducts = affectedProducts,_affectedDataCenters = affectedDataCenters,_timeline = timeline,super._();
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  IssueStatus status;
@override final  IssueSeverity severity;
 final  List<String> _affectedProducts;
@override List<String> get affectedProducts {
  if (_affectedProducts is EqualUnmodifiableListView) return _affectedProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_affectedProducts);
}

 final  List<DataCenter> _affectedDataCenters;
@override List<DataCenter> get affectedDataCenters {
  if (_affectedDataCenters is EqualUnmodifiableListView) return _affectedDataCenters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_affectedDataCenters);
}

@override final  DateTime startedAt;
@override final  DateTime? resolvedAt;
@override final  DateTime? scheduledFor;
@override final  DateTime updatedAt;
 final  List<IssueUpdate> _timeline;
@override@JsonKey() List<IssueUpdate> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}


/// Create a copy of OngoingIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OngoingIssueCopyWith<_OngoingIssue> get copyWith => __$OngoingIssueCopyWithImpl<_OngoingIssue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OngoingIssue&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.severity, severity) || other.severity == severity)&&const DeepCollectionEquality().equals(other._affectedProducts, _affectedProducts)&&const DeepCollectionEquality().equals(other._affectedDataCenters, _affectedDataCenters)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.scheduledFor, scheduledFor) || other.scheduledFor == scheduledFor)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._timeline, _timeline));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,status,severity,const DeepCollectionEquality().hash(_affectedProducts),const DeepCollectionEquality().hash(_affectedDataCenters),startedAt,resolvedAt,scheduledFor,updatedAt,const DeepCollectionEquality().hash(_timeline));

@override
String toString() {
  return 'OngoingIssue(id: $id, title: $title, description: $description, status: $status, severity: $severity, affectedProducts: $affectedProducts, affectedDataCenters: $affectedDataCenters, startedAt: $startedAt, resolvedAt: $resolvedAt, scheduledFor: $scheduledFor, updatedAt: $updatedAt, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class _$OngoingIssueCopyWith<$Res> implements $OngoingIssueCopyWith<$Res> {
  factory _$OngoingIssueCopyWith(_OngoingIssue value, $Res Function(_OngoingIssue) _then) = __$OngoingIssueCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, IssueStatus status, IssueSeverity severity, List<String> affectedProducts, List<DataCenter> affectedDataCenters, DateTime startedAt, DateTime? resolvedAt, DateTime? scheduledFor, DateTime updatedAt, List<IssueUpdate> timeline
});




}
/// @nodoc
class __$OngoingIssueCopyWithImpl<$Res>
    implements _$OngoingIssueCopyWith<$Res> {
  __$OngoingIssueCopyWithImpl(this._self, this._then);

  final _OngoingIssue _self;
  final $Res Function(_OngoingIssue) _then;

/// Create a copy of OngoingIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? status = null,Object? severity = null,Object? affectedProducts = null,Object? affectedDataCenters = null,Object? startedAt = null,Object? resolvedAt = freezed,Object? scheduledFor = freezed,Object? updatedAt = null,Object? timeline = null,}) {
  return _then(_OngoingIssue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as IssueStatus,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as IssueSeverity,affectedProducts: null == affectedProducts ? _self._affectedProducts : affectedProducts // ignore: cast_nullable_to_non_nullable
as List<String>,affectedDataCenters: null == affectedDataCenters ? _self._affectedDataCenters : affectedDataCenters // ignore: cast_nullable_to_non_nullable
as List<DataCenter>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledFor: freezed == scheduledFor ? _self.scheduledFor : scheduledFor // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<IssueUpdate>,
  ));
}


}

// dart format on
