// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protection_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProtectionSettingsCollection on Isar {
  IsarCollection<ProtectionSettings> get protectionSettings =>
      this.collection();
}

const ProtectionSettingsSchema = CollectionSchema(
  name: r'ProtectionSettings',
  id: -5914651901244707324,
  properties: {
    r'appsInternetBlocker': PropertySchema(
      id: 0,
      name: r'appsInternetBlocker',
      type: IsarType.bool,
    ),
    r'blockNsfwSites': PropertySchema(
      id: 1,
      name: r'blockNsfwSites',
      type: IsarType.bool,
    ),
    r'blockedApps': PropertySchema(
      id: 2,
      name: r'blockedApps',
      type: IsarType.stringList,
    ),
    r'blockedWebsites': PropertySchema(
      id: 3,
      name: r'blockedWebsites',
      type: IsarType.stringList,
    ),
    r'websitesBlocker': PropertySchema(
      id: 4,
      name: r'websitesBlocker',
      type: IsarType.bool,
    )
  },
  estimateSize: _protectionSettingsEstimateSize,
  serialize: _protectionSettingsSerialize,
  deserialize: _protectionSettingsDeserialize,
  deserializeProp: _protectionSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _protectionSettingsGetId,
  getLinks: _protectionSettingsGetLinks,
  attach: _protectionSettingsAttach,
  version: '3.1.0+1',
);

int _protectionSettingsEstimateSize(
  ProtectionSettings object,
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

void _protectionSettingsSerialize(
  ProtectionSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.appsInternetBlocker);
  writer.writeBool(offsets[1], object.blockNsfwSites);
  writer.writeStringList(offsets[2], object.blockedApps);
  writer.writeStringList(offsets[3], object.blockedWebsites);
  writer.writeBool(offsets[4], object.websitesBlocker);
}

ProtectionSettings _protectionSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProtectionSettings(
    appsInternetBlocker: reader.readBoolOrNull(offsets[0]) ?? false,
    blockNsfwSites: reader.readBoolOrNull(offsets[1]) ?? false,
    blockedApps: reader.readStringList(offsets[2]) ?? const [],
    blockedWebsites: reader.readStringList(offsets[3]) ?? const [],
    websitesBlocker: reader.readBoolOrNull(offsets[4]) ?? false,
  );
  return object;
}

P _protectionSettingsDeserializeProp<P>(
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
      return (reader.readStringList(offset) ?? const []) as P;
    case 3:
      return (reader.readStringList(offset) ?? const []) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _protectionSettingsGetId(ProtectionSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _protectionSettingsGetLinks(
    ProtectionSettings object) {
  return [];
}

void _protectionSettingsAttach(
    IsarCollection<dynamic> col, Id id, ProtectionSettings object) {}

extension ProtectionSettingsQueryWhereSort
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QWhere> {
  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProtectionSettingsQueryWhere
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QWhereClause> {
  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterWhereClause>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterWhereClause>
      idBetween(
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

extension ProtectionSettingsQueryFilter
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QFilterCondition> {
  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      appsInternetBlockerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appsInternetBlocker',
        value: value,
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      blockNsfwSitesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockNsfwSites',
        value: value,
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      blockedAppsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      blockedAppsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedApps',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      blockedAppsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedApps',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      blockedAppsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedApps',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      blockedWebsitesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      blockedWebsitesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
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

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterFilterCondition>
      websitesBlockerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'websitesBlocker',
        value: value,
      ));
    });
  }
}

extension ProtectionSettingsQueryObject
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QFilterCondition> {}

extension ProtectionSettingsQueryLinks
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QFilterCondition> {}

extension ProtectionSettingsQuerySortBy
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QSortBy> {
  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      sortByAppsInternetBlocker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsInternetBlocker', Sort.asc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      sortByAppsInternetBlockerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsInternetBlocker', Sort.desc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      sortByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      sortByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      sortByWebsitesBlocker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'websitesBlocker', Sort.asc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      sortByWebsitesBlockerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'websitesBlocker', Sort.desc);
    });
  }
}

extension ProtectionSettingsQuerySortThenBy
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QSortThenBy> {
  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenByAppsInternetBlocker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsInternetBlocker', Sort.asc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenByAppsInternetBlockerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appsInternetBlocker', Sort.desc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenByWebsitesBlocker() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'websitesBlocker', Sort.asc);
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QAfterSortBy>
      thenByWebsitesBlockerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'websitesBlocker', Sort.desc);
    });
  }
}

extension ProtectionSettingsQueryWhereDistinct
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QDistinct> {
  QueryBuilder<ProtectionSettings, ProtectionSettings, QDistinct>
      distinctByAppsInternetBlocker() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appsInternetBlocker');
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QDistinct>
      distinctByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockNsfwSites');
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QDistinct>
      distinctByBlockedApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedApps');
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QDistinct>
      distinctByBlockedWebsites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedWebsites');
    });
  }

  QueryBuilder<ProtectionSettings, ProtectionSettings, QDistinct>
      distinctByWebsitesBlocker() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'websitesBlocker');
    });
  }
}

extension ProtectionSettingsQueryProperty
    on QueryBuilder<ProtectionSettings, ProtectionSettings, QQueryProperty> {
  QueryBuilder<ProtectionSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProtectionSettings, bool, QQueryOperations>
      appsInternetBlockerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appsInternetBlocker');
    });
  }

  QueryBuilder<ProtectionSettings, bool, QQueryOperations>
      blockNsfwSitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockNsfwSites');
    });
  }

  QueryBuilder<ProtectionSettings, List<String>, QQueryOperations>
      blockedAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedApps');
    });
  }

  QueryBuilder<ProtectionSettings, List<String>, QQueryOperations>
      blockedWebsitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedWebsites');
    });
  }

  QueryBuilder<ProtectionSettings, bool, QQueryOperations>
      websitesBlockerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'websitesBlocker');
    });
  }
}
