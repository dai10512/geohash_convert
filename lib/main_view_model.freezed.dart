// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainViewModelState {
  dynamic get geoHashString => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainViewModelStateCopyWith<MainViewModelState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainViewModelStateCopyWith<$Res> {
  factory $MainViewModelStateCopyWith(
          MainViewModelState value, $Res Function(MainViewModelState) then) =
      _$MainViewModelStateCopyWithImpl<$Res, MainViewModelState>;
  @useResult
  $Res call({dynamic geoHashString, String? firstName});
}

/// @nodoc
class _$MainViewModelStateCopyWithImpl<$Res, $Val extends MainViewModelState>
    implements $MainViewModelStateCopyWith<$Res> {
  _$MainViewModelStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geoHashString = freezed,
    Object? firstName = freezed,
  }) {
    return _then(_value.copyWith(
      geoHashString: freezed == geoHashString
          ? _value.geoHashString
          : geoHashString // ignore: cast_nullable_to_non_nullable
              as dynamic,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MainViewModelStateCopyWith<$Res>
    implements $MainViewModelStateCopyWith<$Res> {
  factory _$$_MainViewModelStateCopyWith(_$_MainViewModelState value,
          $Res Function(_$_MainViewModelState) then) =
      __$$_MainViewModelStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic geoHashString, String? firstName});
}

/// @nodoc
class __$$_MainViewModelStateCopyWithImpl<$Res>
    extends _$MainViewModelStateCopyWithImpl<$Res, _$_MainViewModelState>
    implements _$$_MainViewModelStateCopyWith<$Res> {
  __$$_MainViewModelStateCopyWithImpl(
      _$_MainViewModelState _value, $Res Function(_$_MainViewModelState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geoHashString = freezed,
    Object? firstName = freezed,
  }) {
    return _then(_$_MainViewModelState(
      geoHashString:
          freezed == geoHashString ? _value.geoHashString! : geoHashString,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_MainViewModelState implements _MainViewModelState {
  const _$_MainViewModelState({this.geoHashString = '', this.firstName});

  @override
  @JsonKey()
  final dynamic geoHashString;
  @override
  final String? firstName;

  @override
  String toString() {
    return 'MainViewModelState(geoHashString: $geoHashString, firstName: $firstName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MainViewModelState &&
            const DeepCollectionEquality()
                .equals(other.geoHashString, geoHashString) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(geoHashString), firstName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MainViewModelStateCopyWith<_$_MainViewModelState> get copyWith =>
      __$$_MainViewModelStateCopyWithImpl<_$_MainViewModelState>(
          this, _$identity);
}

abstract class _MainViewModelState implements MainViewModelState {
  const factory _MainViewModelState(
      {final dynamic geoHashString,
      final String? firstName}) = _$_MainViewModelState;

  @override
  dynamic get geoHashString;
  @override
  String? get firstName;
  @override
  @JsonKey(ignore: true)
  _$$_MainViewModelStateCopyWith<_$_MainViewModelState> get copyWith =>
      throw _privateConstructorUsedError;
}
