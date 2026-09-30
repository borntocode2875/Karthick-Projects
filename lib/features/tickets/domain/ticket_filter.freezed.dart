// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketFilter {

 List<TicketStatus> get statuses; List<TicketPriority> get priorities; String? get product; String? get category; String? get searchQuery; TicketSortField get sortField; SortDirection get sortDirection;
/// Create a copy of TicketFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketFilterCopyWith<TicketFilter> get copyWith => _$TicketFilterCopyWithImpl<TicketFilter>(this as TicketFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketFilter&&const DeepCollectionEquality().equals(other.statuses, statuses)&&const DeepCollectionEquality().equals(other.priorities, priorities)&&(identical(other.product, product) || other.product == product)&&(identical(other.category, category) || other.category == category)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortField, sortField) || other.sortField == sortField)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(statuses),const DeepCollectionEquality().hash(priorities),product,category,searchQuery,sortField,sortDirection);

@override
String toString() {
  return 'TicketFilter(statuses: $statuses, priorities: $priorities, product: $product, category: $category, searchQuery: $searchQuery, sortField: $sortField, sortDirection: $sortDirection)';
}


}

/// @nodoc
abstract mixin class $TicketFilterCopyWith<$Res>  {
  factory $TicketFilterCopyWith(TicketFilter value, $Res Function(TicketFilter) _then) = _$TicketFilterCopyWithImpl;
@useResult
$Res call({
 List<TicketStatus> statuses, List<TicketPriority> priorities, String? product, String? category, String? searchQuery, TicketSortField sortField, SortDirection sortDirection
});




}
/// @nodoc
class _$TicketFilterCopyWithImpl<$Res>
    implements $TicketFilterCopyWith<$Res> {
  _$TicketFilterCopyWithImpl(this._self, this._then);

  final TicketFilter _self;
  final $Res Function(TicketFilter) _then;

/// Create a copy of TicketFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statuses = null,Object? priorities = null,Object? product = freezed,Object? category = freezed,Object? searchQuery = freezed,Object? sortField = null,Object? sortDirection = null,}) {
  return _then(_self.copyWith(
statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TicketStatus>,priorities: null == priorities ? _self.priorities : priorities // ignore: cast_nullable_to_non_nullable
as List<TicketPriority>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,sortField: null == sortField ? _self.sortField : sortField // ignore: cast_nullable_to_non_nullable
as TicketSortField,sortDirection: null == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketFilter].
extension TicketFilterPatterns on TicketFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketFilter value)  $default,){
final _that = this;
switch (_that) {
case _TicketFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TicketFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TicketStatus> statuses,  List<TicketPriority> priorities,  String? product,  String? category,  String? searchQuery,  TicketSortField sortField,  SortDirection sortDirection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketFilter() when $default != null:
return $default(_that.statuses,_that.priorities,_that.product,_that.category,_that.searchQuery,_that.sortField,_that.sortDirection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TicketStatus> statuses,  List<TicketPriority> priorities,  String? product,  String? category,  String? searchQuery,  TicketSortField sortField,  SortDirection sortDirection)  $default,) {final _that = this;
switch (_that) {
case _TicketFilter():
return $default(_that.statuses,_that.priorities,_that.product,_that.category,_that.searchQuery,_that.sortField,_that.sortDirection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TicketStatus> statuses,  List<TicketPriority> priorities,  String? product,  String? category,  String? searchQuery,  TicketSortField sortField,  SortDirection sortDirection)?  $default,) {final _that = this;
switch (_that) {
case _TicketFilter() when $default != null:
return $default(_that.statuses,_that.priorities,_that.product,_that.category,_that.searchQuery,_that.sortField,_that.sortDirection);case _:
  return null;

}
}

}

/// @nodoc


class _TicketFilter extends TicketFilter {
  const _TicketFilter({final  List<TicketStatus> statuses = const [], final  List<TicketPriority> priorities = const [], this.product, this.category, this.searchQuery, this.sortField = TicketSortField.updatedAt, this.sortDirection = SortDirection.desc}): _statuses = statuses,_priorities = priorities,super._();
  

 final  List<TicketStatus> _statuses;
@override@JsonKey() List<TicketStatus> get statuses {
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statuses);
}

 final  List<TicketPriority> _priorities;
@override@JsonKey() List<TicketPriority> get priorities {
  if (_priorities is EqualUnmodifiableListView) return _priorities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_priorities);
}

@override final  String? product;
@override final  String? category;
@override final  String? searchQuery;
@override@JsonKey() final  TicketSortField sortField;
@override@JsonKey() final  SortDirection sortDirection;

/// Create a copy of TicketFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketFilterCopyWith<_TicketFilter> get copyWith => __$TicketFilterCopyWithImpl<_TicketFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketFilter&&const DeepCollectionEquality().equals(other._statuses, _statuses)&&const DeepCollectionEquality().equals(other._priorities, _priorities)&&(identical(other.product, product) || other.product == product)&&(identical(other.category, category) || other.category == category)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortField, sortField) || other.sortField == sortField)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_statuses),const DeepCollectionEquality().hash(_priorities),product,category,searchQuery,sortField,sortDirection);

@override
String toString() {
  return 'TicketFilter(statuses: $statuses, priorities: $priorities, product: $product, category: $category, searchQuery: $searchQuery, sortField: $sortField, sortDirection: $sortDirection)';
}


}

/// @nodoc
abstract mixin class _$TicketFilterCopyWith<$Res> implements $TicketFilterCopyWith<$Res> {
  factory _$TicketFilterCopyWith(_TicketFilter value, $Res Function(_TicketFilter) _then) = __$TicketFilterCopyWithImpl;
@override @useResult
$Res call({
 List<TicketStatus> statuses, List<TicketPriority> priorities, String? product, String? category, String? searchQuery, TicketSortField sortField, SortDirection sortDirection
});




}
/// @nodoc
class __$TicketFilterCopyWithImpl<$Res>
    implements _$TicketFilterCopyWith<$Res> {
  __$TicketFilterCopyWithImpl(this._self, this._then);

  final _TicketFilter _self;
  final $Res Function(_TicketFilter) _then;

/// Create a copy of TicketFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statuses = null,Object? priorities = null,Object? product = freezed,Object? category = freezed,Object? searchQuery = freezed,Object? sortField = null,Object? sortDirection = null,}) {
  return _then(_TicketFilter(
statuses: null == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<TicketStatus>,priorities: null == priorities ? _self._priorities : priorities // ignore: cast_nullable_to_non_nullable
as List<TicketPriority>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,sortField: null == sortField ? _self.sortField : sortField // ignore: cast_nullable_to_non_nullable
as TicketSortField,sortDirection: null == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as SortDirection,
  ));
}


}

// dart format on
