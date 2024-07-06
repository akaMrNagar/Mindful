// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusSettingsCollection on Isar {
  IsarCollection<FocusSettings> get focusSettings => this.collection();
}

const FocusSettingsSchema = CollectionSchema(
  name: r'FocusSettings',
  id: -930078290915607717,
  properties: {
    r'appPackage': PropertySchema(
      id: 0,
      name: r'appPackage',
      type: IsarType.string,
    ),
    r'emergencyCounter': PropertySchema(
      id: 1,
      name: r'emergencyCounter',
      type: IsarType.long,
    ),
    r'lastEmergencyTime': PropertySchema(
      id: 2,
      name: r'lastEmergencyTime',
      type: IsarType.dateTime,
    ),
    r'timer': PropertySchema(
      id: 3,
      name: r'timer',
      type: IsarType.long,
    )
  },
  estimateSize: _focusSettingsEstimateSize,
  serialize: _focusSettingsSerialize,
  deserialize: _focusSettingsDeserialize,
  deserializeProp: _focusSettingsDeserializeProp,
  idName: r'id',
  indexes: {
    r'appPackage': IndexSchema(
      id: 8254477229228441021,
      name: r'appPackage',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'appPackage',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _focusSettingsGetId,
  getLinks: _focusSettingsGetLinks,
  attach: _focusSettingsAttach,
  version: '3.1.0+1',
);

int _focusSettingsEstimateSize(
  FocusSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appPackage.length * 3;
  return bytesCount;
}

void _focusSettingsSerialize(
  FocusSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appPackage);
  writer.writeLong(offsets[1], object.emergencyCounter);
  writer.writeDateTime(offsets[2], object.lastEmergencyTime);
  writer.writeLong(offsets[3], object.timer);
}

FocusSettings _focusSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusSettings(
    appPackage: reader.readString(offsets[0]),
    emergencyCounter: reader.readLongOrNull(offsets[1]) ?? 0,
    lastEmergencyTime: reader.readDateTimeOrNull(offsets[2]),
    timer: reader.readLongOrNull(offsets[3]) ?? 0,
  );
  return object;
}

P _focusSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _focusSettingsGetId(FocusSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusSettingsGetLinks(FocusSettings object) {
  return [];
}

void _focusSettingsAttach(
    IsarCollection<dynamic> col, Id id, FocusSettings object) {}

extension FocusSettingsByIndex on IsarCollection<FocusSettings> {
  Future<FocusSettings?> getByAppPackage(String appPackage) {
    return getByIndex(r'appPackage', [appPackage]);
  }

  FocusSettings? getByAppPackageSync(String appPackage) {
    return getByIndexSync(r'appPackage', [appPackage]);
  }

  Future<bool> deleteByAppPackage(String appPackage) {
    return deleteByIndex(r'appPackage', [appPackage]);
  }

  bool deleteByAppPackageSync(String appPackage) {
    return deleteByIndexSync(r'appPackage', [appPackage]);
  }

  Future<List<FocusSettings?>> getAllByAppPackage(
      List<String> appPackageValues) {
    final values = appPackageValues.map((e) => [e]).toList();
    return getAllByIndex(r'appPackage', values);
  }

  List<FocusSettings?> getAllByAppPackageSync(List<String> appPackageValues) {
    final values = appPackageValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'appPackage', values);
  }

  Future<int> deleteAllByAppPackage(List<String> appPackageValues) {
    final values = appPackageValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'appPackage', values);
  }

  int deleteAllByAppPackageSync(List<String> appPackageValues) {
    final values = appPackageValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'appPackage', values);
  }

  Future<Id> putByAppPackage(FocusSettings object) {
    return putByIndex(r'appPackage', object);
  }

  Id putByAppPackageSync(FocusSettings object, {bool saveLinks = true}) {
    return putByIndexSync(r'appPackage', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAppPackage(List<FocusSettings> objects) {
    return putAllByIndex(r'appPackage', objects);
  }

  List<Id> putAllByAppPackageSync(List<FocusSettings> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'appPackage', objects, saveLinks: saveLinks);
  }
}

extension FocusSettingsQueryWhereSort
    on QueryBuilder<FocusSettings, FocusSettings, QWhere> {
  QueryBuilder<FocusSettings, FocusSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FocusSettingsQueryWhere
    on QueryBuilder<FocusSettings, FocusSettings, QWhereClause> {
  QueryBuilder<FocusSettings, FocusSettings, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterWhereClause>
      appPackageEqualTo(String appPackage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'appPackage',
        value: [appPackage],
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterWhereClause>
      appPackageNotEqualTo(String appPackage) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'appPackage',
              lower: [],
              upper: [appPackage],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'appPackage',
              lower: [appPackage],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'appPackage',
              lower: [appPackage],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'appPackage',
              lower: [],
              upper: [appPackage],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FocusSettingsQueryFilter
    on QueryBuilder<FocusSettings, FocusSettings, QFilterCondition> {
  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appPackage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appPackage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      appPackageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      emergencyCounterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emergencyCounter',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      emergencyCounterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emergencyCounter',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      emergencyCounterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emergencyCounter',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      emergencyCounterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emergencyCounter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      lastEmergencyTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastEmergencyTime',
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      lastEmergencyTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastEmergencyTime',
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      lastEmergencyTimeEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastEmergencyTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      lastEmergencyTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastEmergencyTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      lastEmergencyTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastEmergencyTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      lastEmergencyTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastEmergencyTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      timerEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timer',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      timerGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timer',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      timerLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timer',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterFilterCondition>
      timerBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FocusSettingsQueryObject
    on QueryBuilder<FocusSettings, FocusSettings, QFilterCondition> {}

extension FocusSettingsQueryLinks
    on QueryBuilder<FocusSettings, FocusSettings, QFilterCondition> {}

extension FocusSettingsQuerySortBy
    on QueryBuilder<FocusSettings, FocusSettings, QSortBy> {
  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> sortByAppPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      sortByAppPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.desc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      sortByEmergencyCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      sortByEmergencyCounterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.desc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      sortByLastEmergencyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      sortByLastEmergencyTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> sortByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> sortByTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.desc);
    });
  }
}

extension FocusSettingsQuerySortThenBy
    on QueryBuilder<FocusSettings, FocusSettings, QSortThenBy> {
  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> thenByAppPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      thenByAppPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.desc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      thenByEmergencyCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      thenByEmergencyCounterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.desc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      thenByLastEmergencyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy>
      thenByLastEmergencyTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.desc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> thenByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.asc);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QAfterSortBy> thenByTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.desc);
    });
  }
}

extension FocusSettingsQueryWhereDistinct
    on QueryBuilder<FocusSettings, FocusSettings, QDistinct> {
  QueryBuilder<FocusSettings, FocusSettings, QDistinct> distinctByAppPackage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appPackage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QDistinct>
      distinctByEmergencyCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emergencyCounter');
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QDistinct>
      distinctByLastEmergencyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEmergencyTime');
    });
  }

  QueryBuilder<FocusSettings, FocusSettings, QDistinct> distinctByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timer');
    });
  }
}

extension FocusSettingsQueryProperty
    on QueryBuilder<FocusSettings, FocusSettings, QQueryProperty> {
  QueryBuilder<FocusSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusSettings, String, QQueryOperations> appPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appPackage');
    });
  }

  QueryBuilder<FocusSettings, int, QQueryOperations>
      emergencyCounterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emergencyCounter');
    });
  }

  QueryBuilder<FocusSettings, DateTime?, QQueryOperations>
      lastEmergencyTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEmergencyTime');
    });
  }

  QueryBuilder<FocusSettings, int, QQueryOperations> timerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timer');
    });
  }
}
