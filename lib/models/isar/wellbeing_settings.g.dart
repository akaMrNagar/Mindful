// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wellbeing_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWellBeingSettingsCollection on Isar {
  IsarCollection<WellBeingSettings> get wellBeingSettings => this.collection();
}

const WellBeingSettingsSchema = CollectionSchema(
  name: r'WellBeingSettings',
  id: 3070160543092878003,
  properties: {
    r'allowedShortContentTimeSec': PropertySchema(
      id: 0,
      name: r'allowedShortContentTimeSec',
      type: IsarType.long,
    ),
    r'blockFbReels': PropertySchema(
      id: 1,
      name: r'blockFbReels',
      type: IsarType.bool,
    ),
    r'blockInstaReels': PropertySchema(
      id: 2,
      name: r'blockInstaReels',
      type: IsarType.bool,
    ),
    r'blockNsfwSites': PropertySchema(
      id: 3,
      name: r'blockNsfwSites',
      type: IsarType.bool,
    ),
    r'blockSnapSpotlight': PropertySchema(
      id: 4,
      name: r'blockSnapSpotlight',
      type: IsarType.bool,
    ),
    r'blockYtShorts': PropertySchema(
      id: 5,
      name: r'blockYtShorts',
      type: IsarType.bool,
    ),
    r'blockedWebsites': PropertySchema(
      id: 6,
      name: r'blockedWebsites',
      type: IsarType.stringList,
    )
  },
  estimateSize: _wellBeingSettingsEstimateSize,
  serialize: _wellBeingSettingsSerialize,
  deserialize: _wellBeingSettingsDeserialize,
  deserializeProp: _wellBeingSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _wellBeingSettingsGetId,
  getLinks: _wellBeingSettingsGetLinks,
  attach: _wellBeingSettingsAttach,
  version: '3.1.0+1',
);

int _wellBeingSettingsEstimateSize(
  WellBeingSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.blockedWebsites.length * 3;
  {
    for (var i = 0; i < object.blockedWebsites.length; i++) {
      final value = object.blockedWebsites[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _wellBeingSettingsSerialize(
  WellBeingSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.allowedShortContentTimeSec);
  writer.writeBool(offsets[1], object.blockFbReels);
  writer.writeBool(offsets[2], object.blockInstaReels);
  writer.writeBool(offsets[3], object.blockNsfwSites);
  writer.writeBool(offsets[4], object.blockSnapSpotlight);
  writer.writeBool(offsets[5], object.blockYtShorts);
  writer.writeStringList(offsets[6], object.blockedWebsites);
}

WellBeingSettings _wellBeingSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WellBeingSettings(
    allowedShortContentTimeSec:
        reader.readLongOrNull(offsets[0]) ?? 8 * 60 * 60,
    blockFbReels: reader.readBoolOrNull(offsets[1]) ?? false,
    blockInstaReels: reader.readBoolOrNull(offsets[2]) ?? false,
    blockNsfwSites: reader.readBoolOrNull(offsets[3]) ?? false,
    blockSnapSpotlight: reader.readBoolOrNull(offsets[4]) ?? false,
    blockYtShorts: reader.readBoolOrNull(offsets[5]) ?? false,
    blockedWebsites: reader.readStringList(offsets[6]) ?? const [],
  );
  return object;
}

P _wellBeingSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 8 * 60 * 60) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readStringList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _wellBeingSettingsGetId(WellBeingSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _wellBeingSettingsGetLinks(
    WellBeingSettings object) {
  return [];
}

void _wellBeingSettingsAttach(
    IsarCollection<dynamic> col, Id id, WellBeingSettings object) {}

extension WellBeingSettingsQueryWhereSort
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QWhere> {
  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WellBeingSettingsQueryWhere
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QWhereClause> {
  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterWhereClause>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterWhereClause>
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

extension WellBeingSettingsQueryFilter
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QFilterCondition> {
  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      allowedShortContentTimeSecEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allowedShortContentTimeSec',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      allowedShortContentTimeSecGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allowedShortContentTimeSec',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      allowedShortContentTimeSecLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allowedShortContentTimeSec',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      allowedShortContentTimeSecBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allowedShortContentTimeSec',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      blockFbReelsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockFbReels',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      blockInstaReelsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockInstaReels',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      blockNsfwSitesEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockNsfwSites',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      blockSnapSpotlightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockSnapSpotlight',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      blockYtShortsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockYtShorts',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      blockedWebsitesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      blockedWebsitesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'blockedWebsites',
        value: '',
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterFilterCondition>
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

extension WellBeingSettingsQueryObject
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QFilterCondition> {}

extension WellBeingSettingsQueryLinks
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QFilterCondition> {}

extension WellBeingSettingsQuerySortBy
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QSortBy> {
  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByAllowedShortContentTimeSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedShortContentTimeSec', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByAllowedShortContentTimeSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedShortContentTimeSec', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockFbReels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockFbReels', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockFbReelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockFbReels', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockInstaReels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockInstaReels', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockInstaReelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockInstaReels', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockSnapSpotlight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockSnapSpotlight', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockSnapSpotlightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockSnapSpotlight', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockYtShorts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockYtShorts', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      sortByBlockYtShortsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockYtShorts', Sort.desc);
    });
  }
}

extension WellBeingSettingsQuerySortThenBy
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QSortThenBy> {
  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByAllowedShortContentTimeSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedShortContentTimeSec', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByAllowedShortContentTimeSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allowedShortContentTimeSec', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockFbReels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockFbReels', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockFbReelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockFbReels', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockInstaReels() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockInstaReels', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockInstaReelsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockInstaReels', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockNsfwSitesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockNsfwSites', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockSnapSpotlight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockSnapSpotlight', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockSnapSpotlightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockSnapSpotlight', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockYtShorts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockYtShorts', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByBlockYtShortsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blockYtShorts', Sort.desc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension WellBeingSettingsQueryWhereDistinct
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct> {
  QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct>
      distinctByAllowedShortContentTimeSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allowedShortContentTimeSec');
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct>
      distinctByBlockFbReels() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockFbReels');
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct>
      distinctByBlockInstaReels() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockInstaReels');
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct>
      distinctByBlockNsfwSites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockNsfwSites');
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct>
      distinctByBlockSnapSpotlight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockSnapSpotlight');
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct>
      distinctByBlockYtShorts() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockYtShorts');
    });
  }

  QueryBuilder<WellBeingSettings, WellBeingSettings, QDistinct>
      distinctByBlockedWebsites() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blockedWebsites');
    });
  }
}

extension WellBeingSettingsQueryProperty
    on QueryBuilder<WellBeingSettings, WellBeingSettings, QQueryProperty> {
  QueryBuilder<WellBeingSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WellBeingSettings, int, QQueryOperations>
      allowedShortContentTimeSecProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allowedShortContentTimeSec');
    });
  }

  QueryBuilder<WellBeingSettings, bool, QQueryOperations>
      blockFbReelsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockFbReels');
    });
  }

  QueryBuilder<WellBeingSettings, bool, QQueryOperations>
      blockInstaReelsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockInstaReels');
    });
  }

  QueryBuilder<WellBeingSettings, bool, QQueryOperations>
      blockNsfwSitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockNsfwSites');
    });
  }

  QueryBuilder<WellBeingSettings, bool, QQueryOperations>
      blockSnapSpotlightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockSnapSpotlight');
    });
  }

  QueryBuilder<WellBeingSettings, bool, QQueryOperations>
      blockYtShortsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockYtShorts');
    });
  }

  QueryBuilder<WellBeingSettings, List<String>, QQueryOperations>
      blockedWebsitesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blockedWebsites');
    });
  }
}
