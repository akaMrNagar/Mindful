// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellbeing_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWellbeingSettingsCollection on Isar {
  IsarCollection<WellbeingSettings> get wellbeingSettings => this.collection();
}

const WellbeingSettingsSchema = CollectionSchema(
  name: r'WellbeingSettings',
  id: 72725640570335611,
  properties: {
    r'blockNsfwSites': PropertySchema(
      id: 0,
      name: r'blockNsfwSites',
      type: IsarType.bool,
    ),
    r'blockShortContent': PropertySchema(
      id: 1,
      name: r'blockShortContent',
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
    )
  },
  estimateSize: _wellbeingSettingsEstimateSize,
  serialize: _wellbeingSettingsSerialize,
  deserialize: _wellbeingSettingsDeserialize,
  deserializeProp: _wellbeingSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _wellbeingSettingsGetId,
  getLinks: _wellbeingSettingsGetLinks,
  attach: _wellbeingSettingsAttach,
  version: '3.1.0+1',
);

int _wellbeingSettingsEstimateSize(
  WellbeingSettings object,
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

void _wellbeingSettingsSerialize(
  WellbeingSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.blockNsfwSites);
  writer.writeBool(offsets[1], object.blockShortContent);
  writer.writeStringList(offsets[2], object.blockedApps);
  writer.writeStringList(offsets[3], object.blockedWebsites);
}

WellbeingSettings _wellbeingSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WellbeingSettings(
    blockNsfwSites: reader.readBoolOrNull(offsets[0]) ?? false,
    blockShortContent: reader.readBoolOrNull(offsets[1]) ?? false,
    blockedApps: reader.readStringList(offsets[2]) ?? const [],
    blockedWebsites: reader.readStringList(offsets[3]) ?? const [],
  );
  return object;
}

P _wellbeingSettingsDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _wellbeingSettingsGetId(WellbeingSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _wellbeingSettingsGetLinks(
    WellbeingSettings object) {
  return [];
}

void _wellbeingSettingsAttach(
    IsarCollection<dynamic> col, Id id, WellbeingSettings object) {}

extension WellbeingSettingsQueryWhereSort
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QWhere> {
  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WellbeingSettingsQueryWhere
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QWhereClause> {
  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterWhereClause>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterWhereClause>
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

extension WellbeingSettingsQueryFilter
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QFilterCondition> {
  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockNsfwSitesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockNsfwSites',
        value: value,
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockShortContentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockShortContent',
        value: value,
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockedAppsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'blockedApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockedAppsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'blockedApps',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockedAppsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedApps',
        value: '',
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockedAppsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedApps',
        value: '',
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockedWebsitesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      blockedWebsitesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterFilterCondition>
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

extension WellbeingSettingsQueryObject
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QFilterCondition> {}

extension WellbeingSettingsQueryLinks
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QFilterCondition> {}

extension WellbeingSettingsQuerySortBy
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QSortBy> {
  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      sortByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      sortByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      sortByBlockShortContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockShortContent', Sort.asc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      sortByBlockShortContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockShortContent', Sort.desc);
    });
  }
}

extension WellbeingSettingsQuerySortThenBy
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QSortThenBy> {
  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      thenByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      thenByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      thenByBlockShortContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockShortContent', Sort.asc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      thenByBlockShortContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockShortContent', Sort.desc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension WellbeingSettingsQueryWhereDistinct
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QDistinct> {
  QueryBuilder<WellbeingSettings, WellbeingSettings, QDistinct>
      distinctByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockNsfwSites');
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QDistinct>
      distinctByBlockShortContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockShortContent');
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QDistinct>
      distinctByBlockedApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedApps');
    });
  }

  QueryBuilder<WellbeingSettings, WellbeingSettings, QDistinct>
      distinctByBlockedWebsites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedWebsites');
    });
  }
}

extension WellbeingSettingsQueryProperty
    on QueryBuilder<WellbeingSettings, WellbeingSettings, QQueryProperty> {
  QueryBuilder<WellbeingSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WellbeingSettings, bool, QQueryOperations>
      blockNsfwSitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockNsfwSites');
    });
  }

  QueryBuilder<WellbeingSettings, bool, QQueryOperations>
      blockShortContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockShortContent');
    });
  }

  QueryBuilder<WellbeingSettings, List<String>, QQueryOperations>
      blockedAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedApps');
    });
  }

  QueryBuilder<WellbeingSettings, List<String>, QQueryOperations>
      blockedWebsitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedWebsites');
    });
  }
}
