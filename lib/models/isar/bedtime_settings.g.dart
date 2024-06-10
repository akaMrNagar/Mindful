// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bedtime_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBedtimeSettingsCollection on Isar {
  IsarCollection<BedtimeSettings> get bedtimeSettings => this.collection();
}

const BedtimeSettingsSchema = CollectionSchema(
  name: r'BedtimeSettings',
  id: -8048450760107525397,
  properties: {
    r'distractingApps': PropertySchema(
      id: 0,
      name: r'distractingApps',
      type: IsarType.stringList,
    ),
    r'endTimeInSec': PropertySchema(
      id: 1,
      name: r'endTimeInSec',
      type: IsarType.long,
    ),
    r'isScheduleOn': PropertySchema(
      id: 2,
      name: r'isScheduleOn',
      type: IsarType.bool,
    ),
    r'scheduleDays': PropertySchema(
      id: 3,
      name: r'scheduleDays',
      type: IsarType.boolList,
    ),
    r'shouldBlockInternet': PropertySchema(
      id: 4,
      name: r'shouldBlockInternet',
      type: IsarType.bool,
    ),
    r'shouldPauseApps': PropertySchema(
      id: 5,
      name: r'shouldPauseApps',
      type: IsarType.bool,
    ),
    r'shouldStartDnd': PropertySchema(
      id: 6,
      name: r'shouldStartDnd',
      type: IsarType.bool,
    ),
    r'startTimeInSec': PropertySchema(
      id: 7,
      name: r'startTimeInSec',
      type: IsarType.long,
    )
  },
  estimateSize: _bedtimeSettingsEstimateSize,
  serialize: _bedtimeSettingsSerialize,
  deserialize: _bedtimeSettingsDeserialize,
  deserializeProp: _bedtimeSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bedtimeSettingsGetId,
  getLinks: _bedtimeSettingsGetLinks,
  attach: _bedtimeSettingsAttach,
  version: '3.1.0+1',
);

int _bedtimeSettingsEstimateSize(
  BedtimeSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.distractingApps.length * 3;
  {
    for (var i = 0; i < object.distractingApps.length; i++) {
      final value = object.distractingApps[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.scheduleDays.length;
  return bytesCount;
}

void _bedtimeSettingsSerialize(
  BedtimeSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.distractingApps);
  writer.writeLong(offsets[1], object.endTimeInMins);
  writer.writeBool(offsets[2], object.isScheduleOn);
  writer.writeBoolList(offsets[3], object.scheduleDays);
  writer.writeBool(offsets[4], object.shouldBlockInternet);
  writer.writeBool(offsets[5], object.shouldPauseApps);
  writer.writeBool(offsets[6], object.shouldStartDnd);
  writer.writeLong(offsets[7], object.startTimeInMins);
}

BedtimeSettings _bedtimeSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BedtimeSettings(
    distractingApps: reader.readStringList(offsets[0]) ?? const [],
    endTimeInMins: reader.readLongOrNull(offsets[1]) ?? 0,
    isScheduleOn: reader.readBoolOrNull(offsets[2]) ?? false,
    scheduleDays: reader.readBoolList(offsets[3]) ??
        const [false, true, true, true, true, true, false],
    shouldBlockInternet: reader.readBoolOrNull(offsets[4]) ?? false,
    shouldPauseApps: reader.readBoolOrNull(offsets[5]) ?? false,
    shouldStartDnd: reader.readBoolOrNull(offsets[6]) ?? false,
    startTimeInMins: reader.readLongOrNull(offsets[7]) ?? 0,
  );
  return object;
}

P _bedtimeSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? const []) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readBoolList(offset) ??
          const [false, true, true, true, true, true, false]) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bedtimeSettingsGetId(BedtimeSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bedtimeSettingsGetLinks(BedtimeSettings object) {
  return [];
}

void _bedtimeSettingsAttach(
    IsarCollection<dynamic> col, Id id, BedtimeSettings object) {}

extension BedtimeSettingsQueryWhereSort
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QWhere> {
  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BedtimeSettingsQueryWhere
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QWhereClause> {
  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterWhereClause>
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

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterWhereClause> idBetween(
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

extension BedtimeSettingsQueryFilter
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QFilterCondition> {
  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distractingApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distractingApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distractingApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distractingApps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'distractingApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'distractingApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'distractingApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'distractingApps',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distractingApps',
        value: '',
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'distractingApps',
        value: '',
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractingApps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractingApps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractingApps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractingApps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractingApps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractingAppsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractingApps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      endTimeInSecEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTimeInSec',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      endTimeInSecGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTimeInSec',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      endTimeInSecLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTimeInSec',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      endTimeInSecBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTimeInSec',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
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

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
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

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
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

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      isScheduleOnEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isScheduleOn',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      scheduleDaysElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleDays',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      scheduleDaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scheduleDays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      scheduleDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scheduleDays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      scheduleDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scheduleDays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      scheduleDaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scheduleDays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      scheduleDaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scheduleDays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      scheduleDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'scheduleDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      shouldBlockInternetEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shouldBlockInternet',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      shouldPauseAppsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shouldPauseApps',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      shouldStartDndEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shouldStartDnd',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      startTimeInSecEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTimeInSec',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      startTimeInSecGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTimeInSec',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      startTimeInSecLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTimeInSec',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      startTimeInSecBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTimeInSec',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BedtimeSettingsQueryObject
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QFilterCondition> {}

extension BedtimeSettingsQueryLinks
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QFilterCondition> {}

extension BedtimeSettingsQuerySortBy
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QSortBy> {
  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByEndTimeInSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInSec', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByEndTimeInSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInSec', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByIsScheduleOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScheduleOn', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByIsScheduleOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScheduleOn', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByShouldBlockInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldBlockInternet', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByShouldBlockInternetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldBlockInternet', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByShouldPauseApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldPauseApps', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByShouldPauseAppsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldPauseApps', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByShouldStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByShouldStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartTimeInSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInSec', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartTimeInSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInSec', Sort.desc);
    });
  }
}

extension BedtimeSettingsQuerySortThenBy
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QSortThenBy> {
  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByEndTimeInSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInSec', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByEndTimeInSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInSec', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByIsScheduleOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScheduleOn', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByIsScheduleOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isScheduleOn', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByShouldBlockInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldBlockInternet', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByShouldBlockInternetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldBlockInternet', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByShouldPauseApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldPauseApps', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByShouldPauseAppsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldPauseApps', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByShouldStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByShouldStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartTimeInSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInSec', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartTimeInSecDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInSec', Sort.desc);
    });
  }
}

extension BedtimeSettingsQueryWhereDistinct
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct> {
  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByDistractingApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distractingApps');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByEndTimeInSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTimeInSec');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByIsScheduleOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isScheduleOn');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByScheduleDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleDays');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByShouldBlockInternet() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shouldBlockInternet');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByShouldPauseApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shouldPauseApps');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByShouldStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shouldStartDnd');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByStartTimeInSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTimeInSec');
    });
  }
}

extension BedtimeSettingsQueryProperty
    on QueryBuilder<BedtimeSettings, BedtimeSettings, QQueryProperty> {
  QueryBuilder<BedtimeSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BedtimeSettings, List<String>, QQueryOperations>
      distractingAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distractingApps');
    });
  }

  QueryBuilder<BedtimeSettings, int, QQueryOperations> endTimeInSecProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTimeInSec');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations> isScheduleOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isScheduleOn');
    });
  }

  QueryBuilder<BedtimeSettings, List<bool>, QQueryOperations>
      scheduleDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleDays');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations>
      shouldBlockInternetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shouldBlockInternet');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations>
      shouldPauseAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shouldPauseApps');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations>
      shouldStartDndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shouldStartDnd');
    });
  }

  QueryBuilder<BedtimeSettings, int, QQueryOperations>
      startTimeInSecProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimeInSec');
    });
  }
}
