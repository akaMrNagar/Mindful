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
    r'distractionApps': PropertySchema(
      id: 0,
      name: r'distractionApps',
      type: IsarType.stringList,
    ),
    r'endTimeInSec': PropertySchema(
      id: 1,
      name: r'endTimeInSec',
      type: IsarType.long,
    ),
    r'scheduleDays': PropertySchema(
      id: 2,
      name: r'scheduleDays',
      type: IsarType.boolList,
    ),
    r'scheduleStatus': PropertySchema(
      id: 3,
      name: r'scheduleStatus',
      type: IsarType.bool,
    ),
    r'startDnd': PropertySchema(
      id: 4,
      name: r'startDnd',
      type: IsarType.bool,
    ),
    r'startInternetLockdown': PropertySchema(
      id: 5,
      name: r'startInternetLockdown',
      type: IsarType.bool,
    ),
    r'startScreenLockdown': PropertySchema(
      id: 6,
      name: r'startScreenLockdown',
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
  bytesCount += 3 + object.distractionApps.length * 3;
  {
    for (var i = 0; i < object.distractionApps.length; i++) {
      final value = object.distractionApps[i];
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
  writer.writeStringList(offsets[0], object.distractionApps);
  writer.writeLong(offsets[1], object.endTimeInSec);
  writer.writeBoolList(offsets[2], object.scheduleDays);
  writer.writeBool(offsets[3], object.scheduleStatus);
  writer.writeBool(offsets[4], object.startDnd);
  writer.writeBool(offsets[5], object.startInternetLockdown);
  writer.writeBool(offsets[6], object.startScreenLockdown);
  writer.writeLong(offsets[7], object.startTimeInSec);
}

BedtimeSettings _bedtimeSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BedtimeSettings(
    distractionApps: reader.readStringList(offsets[0]) ?? const [],
    endTimeInSec: reader.readLongOrNull(offsets[1]) ?? 0,
    scheduleDays: reader.readBoolList(offsets[2]) ??
        const [false, true, true, true, true, true, false],
    scheduleStatus: reader.readBoolOrNull(offsets[3]) ?? false,
    startDnd: reader.readBoolOrNull(offsets[4]) ?? false,
    startInternetLockdown: reader.readBoolOrNull(offsets[5]) ?? false,
    startScreenLockdown: reader.readBoolOrNull(offsets[6]) ?? false,
    startTimeInSec: reader.readLongOrNull(offsets[7]) ?? 0,
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
      return (reader.readBoolList(offset) ??
          const [false, true, true, true, true, true, false]) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
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
      distractionAppsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distractionApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distractionApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distractionApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distractionApps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'distractionApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'distractionApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'distractionApps',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'distractionApps',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distractionApps',
        value: '',
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'distractionApps',
        value: '',
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractionApps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractionApps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractionApps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractionApps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractionApps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      distractionAppsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'distractionApps',
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
      scheduleStatusEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      startDndEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDnd',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      startInternetLockdownEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startInternetLockdown',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterFilterCondition>
      startScreenLockdownEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startScreenLockdown',
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
      sortByScheduleStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByScheduleStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartInternetLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartInternetLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartScreenLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      sortByStartScreenLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.desc);
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
      thenByScheduleStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByScheduleStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartInternetLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartInternetLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.desc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartScreenLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QAfterSortBy>
      thenByStartScreenLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.desc);
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
      distinctByDistractionApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distractionApps');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByEndTimeInSec() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTimeInSec');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByScheduleDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleDays');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByScheduleStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleStatus');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDnd');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByStartInternetLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startInternetLockdown');
    });
  }

  QueryBuilder<BedtimeSettings, BedtimeSettings, QDistinct>
      distinctByStartScreenLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startScreenLockdown');
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
      distractionAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distractionApps');
    });
  }

  QueryBuilder<BedtimeSettings, int, QQueryOperations> endTimeInSecProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTimeInSec');
    });
  }

  QueryBuilder<BedtimeSettings, List<bool>, QQueryOperations>
      scheduleDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleDays');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations>
      scheduleStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleStatus');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations> startDndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDnd');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations>
      startInternetLockdownProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startInternetLockdown');
    });
  }

  QueryBuilder<BedtimeSettings, bool, QQueryOperations>
      startScreenLockdownProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startScreenLockdown');
    });
  }

  QueryBuilder<BedtimeSettings, int, QQueryOperations>
      startTimeInSecProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimeInSec');
    });
  }
}
