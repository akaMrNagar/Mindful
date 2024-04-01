// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bedtime_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBedtimeModelCollection on Isar {
  IsarCollection<BedtimeModel> get bedtimeModels => this.collection();
}

const BedtimeModelSchema = CollectionSchema(
  name: r'BedtimeModel',
  id: 5777578954152592439,
  properties: {
    r'distractionApps': PropertySchema(
      id: 0,
      name: r'distractionApps',
      type: IsarType.stringList,
    ),
    r'endTimeInMinutes': PropertySchema(
      id: 1,
      name: r'endTimeInMinutes',
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
    r'startTimeInMinutes': PropertySchema(
      id: 7,
      name: r'startTimeInMinutes',
      type: IsarType.long,
    )
  },
  estimateSize: _bedtimeModelEstimateSize,
  serialize: _bedtimeModelSerialize,
  deserialize: _bedtimeModelDeserialize,
  deserializeProp: _bedtimeModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bedtimeModelGetId,
  getLinks: _bedtimeModelGetLinks,
  attach: _bedtimeModelAttach,
  version: '3.1.0+1',
);

int _bedtimeModelEstimateSize(
  BedtimeModel object,
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

void _bedtimeModelSerialize(
  BedtimeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.distractionApps);
  writer.writeLong(offsets[1], object.endTimeInMinutes);
  writer.writeBoolList(offsets[2], object.scheduleDays);
  writer.writeBool(offsets[3], object.scheduleStatus);
  writer.writeBool(offsets[4], object.startDnd);
  writer.writeBool(offsets[5], object.startInternetLockdown);
  writer.writeBool(offsets[6], object.startScreenLockdown);
  writer.writeLong(offsets[7], object.startTimeInMinutes);
}

BedtimeModel _bedtimeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BedtimeModel(
    distractionApps: reader.readStringList(offsets[0]) ?? const [],
    endTimeInMinutes: reader.readLongOrNull(offsets[1]) ?? 0,
    scheduleDays: reader.readBoolList(offsets[2]) ??
        const [false, true, true, true, true, true, false],
    scheduleStatus: reader.readBoolOrNull(offsets[3]) ?? false,
    startDnd: reader.readBoolOrNull(offsets[4]) ?? false,
    startInternetLockdown: reader.readBoolOrNull(offsets[5]) ?? false,
    startScreenLockdown: reader.readBoolOrNull(offsets[6]) ?? false,
    startTimeInMinutes: reader.readLongOrNull(offsets[7]) ?? 0,
  );
  return object;
}

P _bedtimeModelDeserializeProp<P>(
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

Id _bedtimeModelGetId(BedtimeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bedtimeModelGetLinks(BedtimeModel object) {
  return [];
}

void _bedtimeModelAttach(
    IsarCollection<dynamic> col, Id id, BedtimeModel object) {}

extension BedtimeModelQueryWhereSort
    on QueryBuilder<BedtimeModel, BedtimeModel, QWhere> {
  QueryBuilder<BedtimeModel, BedtimeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BedtimeModelQueryWhere
    on QueryBuilder<BedtimeModel, BedtimeModel, QWhereClause> {
  QueryBuilder<BedtimeModel, BedtimeModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterWhereClause> idBetween(
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

extension BedtimeModelQueryFilter
    on QueryBuilder<BedtimeModel, BedtimeModel, QFilterCondition> {
  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      distractionAppsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distractionApps',
        value: '',
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      distractionAppsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'distractionApps',
        value: '',
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      endTimeInMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTimeInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      endTimeInMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTimeInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      endTimeInMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTimeInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      endTimeInMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTimeInMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      scheduleDaysElementEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleDays',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
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

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      scheduleStatusEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      startDndEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDnd',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      startInternetLockdownEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startInternetLockdown',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      startScreenLockdownEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startScreenLockdown',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      startTimeInMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTimeInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      startTimeInMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTimeInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      startTimeInMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTimeInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterFilterCondition>
      startTimeInMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTimeInMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BedtimeModelQueryObject
    on QueryBuilder<BedtimeModel, BedtimeModel, QFilterCondition> {}

extension BedtimeModelQueryLinks
    on QueryBuilder<BedtimeModel, BedtimeModel, QFilterCondition> {}

extension BedtimeModelQuerySortBy
    on QueryBuilder<BedtimeModel, BedtimeModel, QSortBy> {
  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByEndTimeInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInMinutes', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByEndTimeInMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInMinutes', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByScheduleStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByScheduleStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy> sortByStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy> sortByStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByStartInternetLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByStartInternetLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByStartScreenLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByStartScreenLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByStartTimeInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMinutes', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      sortByStartTimeInMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMinutes', Sort.desc);
    });
  }
}

extension BedtimeModelQuerySortThenBy
    on QueryBuilder<BedtimeModel, BedtimeModel, QSortThenBy> {
  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByEndTimeInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInMinutes', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByEndTimeInMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimeInMinutes', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByScheduleStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByScheduleStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleStatus', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy> thenByStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy> thenByStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDnd', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByStartInternetLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByStartInternetLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startInternetLockdown', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByStartScreenLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByStartScreenLockdownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startScreenLockdown', Sort.desc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByStartTimeInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMinutes', Sort.asc);
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QAfterSortBy>
      thenByStartTimeInMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeInMinutes', Sort.desc);
    });
  }
}

extension BedtimeModelQueryWhereDistinct
    on QueryBuilder<BedtimeModel, BedtimeModel, QDistinct> {
  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct>
      distinctByDistractionApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distractionApps');
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct>
      distinctByEndTimeInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTimeInMinutes');
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct> distinctByScheduleDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleDays');
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct>
      distinctByScheduleStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleStatus');
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct> distinctByStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDnd');
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct>
      distinctByStartInternetLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startInternetLockdown');
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct>
      distinctByStartScreenLockdown() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startScreenLockdown');
    });
  }

  QueryBuilder<BedtimeModel, BedtimeModel, QDistinct>
      distinctByStartTimeInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTimeInMinutes');
    });
  }
}

extension BedtimeModelQueryProperty
    on QueryBuilder<BedtimeModel, BedtimeModel, QQueryProperty> {
  QueryBuilder<BedtimeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BedtimeModel, List<String>, QQueryOperations>
      distractionAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distractionApps');
    });
  }

  QueryBuilder<BedtimeModel, int, QQueryOperations> endTimeInMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTimeInMinutes');
    });
  }

  QueryBuilder<BedtimeModel, List<bool>, QQueryOperations>
      scheduleDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleDays');
    });
  }

  QueryBuilder<BedtimeModel, bool, QQueryOperations> scheduleStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleStatus');
    });
  }

  QueryBuilder<BedtimeModel, bool, QQueryOperations> startDndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDnd');
    });
  }

  QueryBuilder<BedtimeModel, bool, QQueryOperations>
      startInternetLockdownProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startInternetLockdown');
    });
  }

  QueryBuilder<BedtimeModel, bool, QQueryOperations>
      startScreenLockdownProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startScreenLockdown');
    });
  }

  QueryBuilder<BedtimeModel, int, QQueryOperations>
      startTimeInMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimeInMinutes');
    });
  }
}
