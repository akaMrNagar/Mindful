// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protection_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProtectionModelCollection on Isar {
  IsarCollection<ProtectionModel> get protectionModels => this.collection();
}

const ProtectionModelSchema = CollectionSchema(
  name: r'ProtectionModel',
  id: -7327399406332311139,
  properties: {
    r'blockAppsInternet': PropertySchema(
      id: 0,
      name: r'blockAppsInternet',
      type: IsarType.bool,
    ),
    r'blockCustomWebsites': PropertySchema(
      id: 1,
      name: r'blockCustomWebsites',
      type: IsarType.bool,
    ),
    r'blockNsfwSites': PropertySchema(
      id: 2,
      name: r'blockNsfwSites',
      type: IsarType.bool,
    ),
    r'blockedApps': PropertySchema(
      id: 3,
      name: r'blockedApps',
      type: IsarType.stringList,
    ),
    r'blockedWebsites': PropertySchema(
      id: 4,
      name: r'blockedWebsites',
      type: IsarType.stringList,
    )
  },
  estimateSize: _protectionModelEstimateSize,
  serialize: _protectionModelSerialize,
  deserialize: _protectionModelDeserialize,
  deserializeProp: _protectionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _protectionModelGetId,
  getLinks: _protectionModelGetLinks,
  attach: _protectionModelAttach,
  version: '3.1.0+1',
);

int _protectionModelEstimateSize(
  ProtectionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.blockedApps.length * 3;
  {
    for (var i = 0; i < object.blockedApps.length; i++) {
      final value = object.blockedApps[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.blockedWebsites.length * 3;
  {
    for (var i = 0; i < object.blockedWebsites.length; i++) {
      final value = object.blockedWebsites[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _protectionModelSerialize(
  ProtectionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.blockAppsInternet);
  writer.writeBool(offsets[1], object.blockCustomWebsites);
  writer.writeBool(offsets[2], object.blockNsfwSites);
  writer.writeStringList(offsets[3], object.blockedApps);
  writer.writeStringList(offsets[4], object.blockedWebsites);
}

ProtectionModel _protectionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProtectionModel(
    blockAppsInternet: reader.readBoolOrNull(offsets[0]) ?? false,
    blockCustomWebsites: reader.readBoolOrNull(offsets[1]) ?? false,
    blockNsfwSites: reader.readBoolOrNull(offsets[2]) ?? false,
    blockedApps: reader.readStringList(offsets[3]) ?? const [],
    blockedWebsites: reader.readStringList(offsets[4]) ?? const [],
  );
  return object;
}

P _protectionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readStringList(offset) ?? const []) as P;
    case 4:
      return (reader.readStringList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _protectionModelGetId(ProtectionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _protectionModelGetLinks(ProtectionModel object) {
  return [];
}

void _protectionModelAttach(
    IsarCollection<dynamic> col, Id id, ProtectionModel object) {}

extension ProtectionModelQueryWhereSort
    on QueryBuilder<ProtectionModel, ProtectionModel, QWhere> {
  QueryBuilder<ProtectionModel, ProtectionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProtectionModelQueryWhere
    on QueryBuilder<ProtectionModel, ProtectionModel, QWhereClause> {
  QueryBuilder<ProtectionModel, ProtectionModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterWhereClause>
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

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterWhereClause> idBetween(
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
}

extension ProtectionModelQueryFilter
    on QueryBuilder<ProtectionModel, ProtectionModel, QFilterCondition> {
  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockAppsInternetEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockAppsInternet',
        value: value,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockCustomWebsitesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockCustomWebsites',
        value: value,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockNsfwSitesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockNsfwSites',
        value: value,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedApps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedApps',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedApps',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedApps',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedApps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedApps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedApps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedApps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedApps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedAppsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedApps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedWebsites',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blockedWebsites',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blockedWebsites',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blockedWebsites',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'blockedWebsites',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'blockedWebsites',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedWebsites',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedWebsites',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedWebsites',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedWebsites',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedWebsites',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedWebsites',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedWebsites',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      blockedWebsitesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'blockedWebsites',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
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

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
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

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterFilterCondition>
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
}

extension ProtectionModelQueryObject
    on QueryBuilder<ProtectionModel, ProtectionModel, QFilterCondition> {}

extension ProtectionModelQueryLinks
    on QueryBuilder<ProtectionModel, ProtectionModel, QFilterCondition> {}

extension ProtectionModelQuerySortBy
    on QueryBuilder<ProtectionModel, ProtectionModel, QSortBy> {
  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      sortByBlockAppsInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockAppsInternet', Sort.asc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      sortByBlockAppsInternetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockAppsInternet', Sort.desc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      sortByBlockCustomWebsites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCustomWebsites', Sort.asc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      sortByBlockCustomWebsitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCustomWebsites', Sort.desc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      sortByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      sortByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }
}

extension ProtectionModelQuerySortThenBy
    on QueryBuilder<ProtectionModel, ProtectionModel, QSortThenBy> {
  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      thenByBlockAppsInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockAppsInternet', Sort.asc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      thenByBlockAppsInternetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockAppsInternet', Sort.desc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      thenByBlockCustomWebsites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCustomWebsites', Sort.asc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      thenByBlockCustomWebsitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockCustomWebsites', Sort.desc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      thenByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy>
      thenByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ProtectionModelQueryWhereDistinct
    on QueryBuilder<ProtectionModel, ProtectionModel, QDistinct> {
  QueryBuilder<ProtectionModel, ProtectionModel, QDistinct>
      distinctByBlockAppsInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockAppsInternet');
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QDistinct>
      distinctByBlockCustomWebsites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockCustomWebsites');
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QDistinct>
      distinctByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockNsfwSites');
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QDistinct>
      distinctByBlockedApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedApps');
    });
  }

  QueryBuilder<ProtectionModel, ProtectionModel, QDistinct>
      distinctByBlockedWebsites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedWebsites');
    });
  }
}

extension ProtectionModelQueryProperty
    on QueryBuilder<ProtectionModel, ProtectionModel, QQueryProperty> {
  QueryBuilder<ProtectionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProtectionModel, bool, QQueryOperations>
      blockAppsInternetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockAppsInternet');
    });
  }

  QueryBuilder<ProtectionModel, bool, QQueryOperations>
      blockCustomWebsitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockCustomWebsites');
    });
  }

  QueryBuilder<ProtectionModel, bool, QQueryOperations>
      blockNsfwSitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockNsfwSites');
    });
  }

  QueryBuilder<ProtectionModel, List<String>, QQueryOperations>
      blockedAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedApps');
    });
  }

  QueryBuilder<ProtectionModel, List<String>, QQueryOperations>
      blockedWebsitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedWebsites');
    });
  }
}
