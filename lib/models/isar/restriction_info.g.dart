// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restriction_info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRestrictionInfoCollection on Isar {
  IsarCollection<RestrictionInfo> get restrictionInfos => this.collection();
}

const RestrictionInfoSchema = CollectionSchema(
  name: r'RestrictionInfo',
  id: 7211120438130607134,
  properties: {
    r'appPackage': PropertySchema(
      id: 0,
      name: r'appPackage',
      type: IsarType.string,
    ),
    r'internetAccess': PropertySchema(
      id: 1,
      name: r'internetAccess',
      type: IsarType.bool,
    ),
    r'timerSec': PropertySchema(
      id: 2,
      name: r'timerSec',
      type: IsarType.long,
    )
  },
  estimateSize: _restrictionInfoEstimateSize,
  serialize: _restrictionInfoSerialize,
  deserialize: _restrictionInfoDeserialize,
  deserializeProp: _restrictionInfoDeserializeProp,
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
  getId: _restrictionInfoGetId,
  getLinks: _restrictionInfoGetLinks,
  attach: _restrictionInfoAttach,
  version: '3.1.0+1',
);

int _restrictionInfoEstimateSize(
  RestrictionInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appPackage.length * 3;
  return bytesCount;
}

void _restrictionInfoSerialize(
  RestrictionInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appPackage);
  writer.writeBool(offsets[1], object.internetAccess);
  writer.writeLong(offsets[2], object.timerSec);
}

RestrictionInfo _restrictionInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RestrictionInfo(
    appPackage: reader.readString(offsets[0]),
    internetAccess: reader.readBoolOrNull(offsets[1]) ?? true,
    timerSec: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  return object;
}

P _restrictionInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _restrictionInfoGetId(RestrictionInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _restrictionInfoGetLinks(RestrictionInfo object) {
  return [];
}

void _restrictionInfoAttach(
    IsarCollection<dynamic> col, Id id, RestrictionInfo object) {}

extension RestrictionInfoByIndex on IsarCollection<RestrictionInfo> {
  Future<RestrictionInfo?> getByAppPackage(String appPackage) {
    return getByIndex(r'appPackage', [appPackage]);
  }

  RestrictionInfo? getByAppPackageSync(String appPackage) {
    return getByIndexSync(r'appPackage', [appPackage]);
  }

  Future<bool> deleteByAppPackage(String appPackage) {
    return deleteByIndex(r'appPackage', [appPackage]);
  }

  bool deleteByAppPackageSync(String appPackage) {
    return deleteByIndexSync(r'appPackage', [appPackage]);
  }

  Future<List<RestrictionInfo?>> getAllByAppPackage(
      List<String> appPackageValues) {
    final values = appPackageValues.map((e) => [e]).toList();
    return getAllByIndex(r'appPackage', values);
  }

  List<RestrictionInfo?> getAllByAppPackageSync(List<String> appPackageValues) {
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

  Future<Id> putByAppPackage(RestrictionInfo object) {
    return putByIndex(r'appPackage', object);
  }

  Id putByAppPackageSync(RestrictionInfo object, {bool saveLinks = true}) {
    return putByIndexSync(r'appPackage', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAppPackage(List<RestrictionInfo> objects) {
    return putAllByIndex(r'appPackage', objects);
  }

  List<Id> putAllByAppPackageSync(List<RestrictionInfo> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'appPackage', objects, saveLinks: saveLinks);
  }
}

extension RestrictionInfoQueryWhereSort
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QWhere> {
  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RestrictionInfoQueryWhere
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QWhereClause> {
  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhereClause> idBetween(
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhereClause>
      appPackageEqualTo(String appPackage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'appPackage',
        value: [appPackage],
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterWhereClause>
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

extension RestrictionInfoQueryFilter
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QFilterCondition> {
  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      appPackageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appPackage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      appPackageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appPackage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      appPackageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      appPackageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appPackage',
        value: '',
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      internetAccessEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'internetAccess',
        value: value,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      timerSecEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timerSec',
        value: value,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      timerSecGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timerSec',
        value: value,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      timerSecLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timerSec',
        value: value,
      ));
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterFilterCondition>
      timerSecBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timerSec',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RestrictionInfoQueryObject
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QFilterCondition> {}

extension RestrictionInfoQueryLinks
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QFilterCondition> {}

extension RestrictionInfoQuerySortBy
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QSortBy> {
  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      sortByAppPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.asc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      sortByAppPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.desc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      sortByInternetAccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internetAccess', Sort.asc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      sortByInternetAccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internetAccess', Sort.desc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      sortByTimerSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerSec', Sort.asc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      sortByTimerSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerSec', Sort.desc);
    });
  }
}

extension RestrictionInfoQuerySortThenBy
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QSortThenBy> {
  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      thenByAppPackage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.asc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      thenByAppPackageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appPackage', Sort.desc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      thenByInternetAccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internetAccess', Sort.asc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      thenByInternetAccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'internetAccess', Sort.desc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      thenByTimerSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerSec', Sort.asc);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QAfterSortBy>
      thenByTimerSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerSec', Sort.desc);
    });
  }
}

extension RestrictionInfoQueryWhereDistinct
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QDistinct> {
  QueryBuilder<RestrictionInfo, RestrictionInfo, QDistinct>
      distinctByAppPackage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appPackage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QDistinct>
      distinctByInternetAccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'internetAccess');
    });
  }

  QueryBuilder<RestrictionInfo, RestrictionInfo, QDistinct>
      distinctByTimerSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timerSec');
    });
  }
}

extension RestrictionInfoQueryProperty
    on QueryBuilder<RestrictionInfo, RestrictionInfo, QQueryProperty> {
  QueryBuilder<RestrictionInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RestrictionInfo, String, QQueryOperations> appPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appPackage');
    });
  }

  QueryBuilder<RestrictionInfo, bool, QQueryOperations>
      internetAccessProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'internetAccess');
    });
  }

  QueryBuilder<RestrictionInfo, int, QQueryOperations> timerSecProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timerSec');
    });
  }
}
