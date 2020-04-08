// GENERATED CODE - DO NOT MODIFY BY HAND

part of preference_category;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PreferenceCategory> _$preferenceCategorySerializer =
    new _$PreferenceCategorySerializer();

class _$PreferenceCategorySerializer
    implements StructuredSerializer<PreferenceCategory> {
  @override
  final Iterable<Type> types = const [PreferenceCategory, _$PreferenceCategory];
  @override
  final String wireName = 'PreferenceCategory';

  @override
  Iterable<Object> serialize(Serializers serializers, PreferenceCategory object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'preference_category',
      serializers.serialize(object.category,
          specifiedType: const FullType(
              BuiltList, const [const FullType(PreferenceItem)])),
    ];

    return result;
  }

  @override
  PreferenceCategory deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreferenceCategoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'preference_category':
          result.category.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PreferenceItem)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$PreferenceCategory extends PreferenceCategory {
  @override
  final BuiltList<PreferenceItem> category;

  factory _$PreferenceCategory(
          [void Function(PreferenceCategoryBuilder) updates]) =>
      (new PreferenceCategoryBuilder()..update(updates)).build();

  _$PreferenceCategory._({this.category}) : super._() {
    if (category == null) {
      throw new BuiltValueNullFieldError('PreferenceCategory', 'category');
    }
  }

  @override
  PreferenceCategory rebuild(
          void Function(PreferenceCategoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreferenceCategoryBuilder toBuilder() =>
      new PreferenceCategoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreferenceCategory && category == other.category;
  }

  @override
  int get hashCode {
    return $jf($jc(0, category.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreferenceCategory')
          ..add('category', category))
        .toString();
  }
}

class PreferenceCategoryBuilder
    implements Builder<PreferenceCategory, PreferenceCategoryBuilder> {
  _$PreferenceCategory _$v;

  ListBuilder<PreferenceItem> _category;
  ListBuilder<PreferenceItem> get category =>
      _$this._category ??= new ListBuilder<PreferenceItem>();
  set category(ListBuilder<PreferenceItem> category) =>
      _$this._category = category;

  PreferenceCategoryBuilder();

  PreferenceCategoryBuilder get _$this {
    if (_$v != null) {
      _category = _$v.category?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreferenceCategory other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PreferenceCategory;
  }

  @override
  void update(void Function(PreferenceCategoryBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreferenceCategory build() {
    _$PreferenceCategory _$result;
    try {
      _$result = _$v ?? new _$PreferenceCategory._(category: category.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'category';
        category.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PreferenceCategory', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
