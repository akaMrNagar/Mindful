// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusModelCollection on Isar {
  IsarCollection<FocusModel> get focusModels => this.collection();
}

const FocusModelSchema = CollectionSchema(
  name: r'FocusModel',
  id: -5585598015803124310,
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
  estimateSize: _focusModelEstimateSize,
  serialize: _focusModelSerialize,
  deserialize: _focusModelDeserialize,
  deserializeProp: _focusModelDeserializeProp,
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
  getId: _focusModelGetId,
  getLinks: _focusModelGetLinks,
  attach: _focusModelAttach,
  version: '3.1.0+1',
);

int _focusModelEstimateSize(
  FocusModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appPackage.length * 3;
  return bytesCount;
}

void _focusModelSerialize(
  FocusModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appPackage);
  writer.writeLong(offsets[1], object.emergencyCounter);
  writer.writeDateTime(offsets[2], object.lastEmergencyTime);
  writer.writeLong(offsets[3], object.timer);
}

FocusModel _focusModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusModel(
    appPackage: reader.readString(offsets[0]),
    emergencyCounter: reader.readLong(offsets[1]),
    lastEmergencyTime: reader.readDateTime(offsets[2]),
    timer: reader.readLong(offsets[3]),
  );
  return object;
}

P _focusModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _focusModelGetId(FocusModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusModelGetLinks(FocusModel object) {
  return [];
}

void _focusModelAttach(IsarCollection<dynamic> col, Id id, FocusModel object) {}

extension FocusModelByIndex on IsarCollection<FocusModel> {
  Future<FocusModel?> getByAppPackage(String appPackage) {
    return getByIndex(r'appPackage', [appPackage]);
  }

  FocusModel? getByAppPackageSync(String appPackage) {
    return getByIndexSync(r'appPackage', [appPackage]);
  }

  Future<bool> deleteByAppPackage(String appPackage) {
    return deleteByIndex(r'appPackage', [appPackage]);
  }

  bool deleteByAppPackageSync(String appPackage) {
    return deleteByIndexSync(r'appPackage', [appPackage]);
  }

  Future<List<FocusModel?>> getAllByAppPackage(List<String> appPackageValues) {
    final values = appPackageValues.map((e) => [e]).toList();
    return getAllByIndex(r'appPackage', values);
  }

  List<FocusModel?> getAllByAppPackageSync(List<String> appPackageValues) {
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

  Future<Id> putByAppPackage(FocusModel object) {
    return putByIndex(r'appPackage', object);
  }

  Id putByAppPackageSync(FocusModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'appPackage', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAppPackage(List<FocusModel> objects) {
    return putAllByIndex(r'appPackage', objects);
  }

  List<Id> putAllByAppPackageSync(List<FocusModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'appPackage', objects, saveLinks: saveLinks);
  }
}

extension FocusModelQueryWhereSort
    on QueryBuilder<FocusModel, FocusModel, QWhere> {
  QueryBuilder<FocusModel, FocusModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FocusModelQueryWhere
    on QueryBuilder<FocusModel, FocusModel, QWhereClause> {
  QueryBuilder<FocusModel, FocusModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<FocusModel, FocusModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<FocusModel, FocusModel, QAfterWhereClause> appPackageEqualTo(
      String appPackage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'appPackage',
        value: [appPackage],
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterWhereClause> appPackageNotEqualTo(
      String appPackage) {
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

extension FocusModelQueryFilter
    on QueryBuilder<FocusModel, FocusModel, QFilterCondition> {
  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> appPackageEqualTo(
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> appPackageBetween(
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      appPackageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> appPackageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appPackage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      appPackageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      appPackageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      emergencyCounterEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emergencyCounter',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      lastEmergencyTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastEmergencyTime',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      lastEmergencyTimeGreaterThan(
    DateTime value, {
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      lastEmergencyTimeLessThan(
    DateTime value, {
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition>
      lastEmergencyTimeBetween(
    DateTime lower,
    DateTime upper, {
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> timerEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timer',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> timerGreaterThan(
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> timerLessThan(
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

  QueryBuilder<FocusModel, FocusModel, QAfterFilterCondition> timerBetween(
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

extension FocusModelQueryObject
    on QueryBuilder<FocusModel, FocusModel, QFilterCondition> {}

extension FocusModelQueryLinks
    on QueryBuilder<FocusModel, FocusModel, QFilterCondition> {}

extension FocusModelQuerySortBy
    on QueryBuilder<FocusModel, FocusModel, QSortBy> {
  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> sortByAppPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> sortByAppPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.desc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> sortByEmergencyCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy>
      sortByEmergencyCounterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.desc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> sortByLastEmergencyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy>
      sortByLastEmergencyTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.desc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> sortByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> sortByTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.desc);
    });
  }
}

extension FocusModelQuerySortThenBy
    on QueryBuilder<FocusModel, FocusModel, QSortThenBy> {
  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenByAppPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenByAppPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.desc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenByEmergencyCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy>
      thenByEmergencyCounterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emergencyCounter', Sort.desc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenByLastEmergencyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy>
      thenByLastEmergencyTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEmergencyTime', Sort.desc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.asc);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QAfterSortBy> thenByTimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timer', Sort.desc);
    });
  }
}

extension FocusModelQueryWhereDistinct
    on QueryBuilder<FocusModel, FocusModel, QDistinct> {
  QueryBuilder<FocusModel, FocusModel, QDistinct> distinctByAppPackage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appPackage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FocusModel, FocusModel, QDistinct> distinctByEmergencyCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emergencyCounter');
    });
  }

  QueryBuilder<FocusModel, FocusModel, QDistinct>
      distinctByLastEmergencyTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEmergencyTime');
    });
  }

  QueryBuilder<FocusModel, FocusModel, QDistinct> distinctByTimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timer');
    });
  }
}

extension FocusModelQueryProperty
    on QueryBuilder<FocusModel, FocusModel, QQueryProperty> {
  QueryBuilder<FocusModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusModel, String, QQueryOperations> appPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appPackage');
    });
  }

  QueryBuilder<FocusModel, int, QQueryOperations> emergencyCounterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emergencyCounter');
    });
  }

  QueryBuilder<FocusModel, DateTime, QQueryOperations>
      lastEmergencyTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEmergencyTime');
    });
  }

  QueryBuilder<FocusModel, int, QQueryOperations> timerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timer');
    });
  }
}
