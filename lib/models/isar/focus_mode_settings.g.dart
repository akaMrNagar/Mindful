// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_mode_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusModeSettingsCollection on Isar {
  IsarCollection<FocusModeSettings> get focusModeSettings => this.collection();
}

const FocusModeSettingsSchema = CollectionSchema(
  name: r'FocusModeSettings',
  id: -6889118312166646239,
  properties: {
    r'currentStreak': PropertySchema(
      id: 0,
      name: r'currentStreak',
      type: IsarType.long,
    ),
    r'distractingApps': PropertySchema(
      id: 1,
      name: r'distractingApps',
      type: IsarType.stringList,
    ),
    r'lastStreakUpdatedDayMsEpoch': PropertySchema(
      id: 2,
      name: r'lastStreakUpdatedDayMsEpoch',
      type: IsarType.long,
    ),
    r'longestStreak': PropertySchema(
      id: 3,
      name: r'longestStreak',
      type: IsarType.long,
    ),
    r'sessionType': PropertySchema(
      id: 4,
      name: r'sessionType',
      type: IsarType.byte,
      enumMap: _FocusModeSettingssessionTypeEnumValueMap,
    ),
    r'shouldStartDnd': PropertySchema(
      id: 5,
      name: r'shouldStartDnd',
      type: IsarType.bool,
    )
  },
  estimateSize: _focusModeSettingsEstimateSize,
  serialize: _focusModeSettingsSerialize,
  deserialize: _focusModeSettingsDeserialize,
  deserializeProp: _focusModeSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _focusModeSettingsGetId,
  getLinks: _focusModeSettingsGetLinks,
  attach: _focusModeSettingsAttach,
  version: '3.1.0+1',
);

int _focusModeSettingsEstimateSize(
  FocusModeSettings object,
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
  return bytesCount;
}

void _focusModeSettingsSerialize(
  FocusModeSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentStreak);
  writer.writeStringList(offsets[1], object.distractingApps);
  writer.writeLong(offsets[2], object.lastStreakUpdatedDayMsEpoch);
  writer.writeLong(offsets[3], object.longestStreak);
  writer.writeByte(offsets[4], object.sessionType.index);
  writer.writeBool(offsets[5], object.shouldStartDnd);
}

FocusModeSettings _focusModeSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusModeSettings(
    currentStreak: reader.readLongOrNull(offsets[0]) ?? 0,
    distractingApps: reader.readStringList(offsets[1]) ?? const [],
    lastStreakUpdatedDayMsEpoch: reader.readLongOrNull(offsets[2]) ?? 0,
    longestStreak: reader.readLongOrNull(offsets[3]) ?? 0,
    sessionType: _FocusModeSettingssessionTypeValueEnumMap[
            reader.readByteOrNull(offsets[4])] ??
        SessionType.study,
    shouldStartDnd: reader.readBoolOrNull(offsets[5]) ?? false,
  );
  return object;
}

P _focusModeSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readStringList(offset) ?? const []) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (_FocusModeSettingssessionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SessionType.study) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FocusModeSettingssessionTypeEnumValueMap = {
  'study': 0,
  'work': 1,
  'exercise': 2,
  'meditation': 3,
  'creativeWriting': 4,
  'reading': 5,
  'programming': 6,
  'chores': 7,
  'projectPlanning': 8,
  'artAndDesign': 9,
  'languageLearning': 10,
  'musicPractice': 11,
  'selfCare': 12,
  'brainstorming': 13,
  'skillDevelopment': 14,
  'research': 15,
  'networking': 16,
  'cooking': 17,
  'sportsTraining': 18,
  'restAndRelaxation': 19,
  'other': 20,
};
const _FocusModeSettingssessionTypeValueEnumMap = {
  0: SessionType.study,
  1: SessionType.work,
  2: SessionType.exercise,
  3: SessionType.meditation,
  4: SessionType.creativeWriting,
  5: SessionType.reading,
  6: SessionType.programming,
  7: SessionType.chores,
  8: SessionType.projectPlanning,
  9: SessionType.artAndDesign,
  10: SessionType.languageLearning,
  11: SessionType.musicPractice,
  12: SessionType.selfCare,
  13: SessionType.brainstorming,
  14: SessionType.skillDevelopment,
  15: SessionType.research,
  16: SessionType.networking,
  17: SessionType.cooking,
  18: SessionType.sportsTraining,
  19: SessionType.restAndRelaxation,
  20: SessionType.other,
};

Id _focusModeSettingsGetId(FocusModeSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusModeSettingsGetLinks(
    FocusModeSettings object) {
  return [];
}

void _focusModeSettingsAttach(
    IsarCollection<dynamic> col, Id id, FocusModeSettings object) {}

extension FocusModeSettingsQueryWhereSort
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QWhere> {
  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FocusModeSettingsQueryWhere
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QWhereClause> {
  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterWhereClause>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterWhereClause>
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

extension FocusModeSettingsQueryFilter
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QFilterCondition> {
  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      currentStreakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      currentStreakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      currentStreakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      currentStreakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStreak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      distractingAppsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distractingApps',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      distractingAppsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'distractingApps',
        value: '',
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
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

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      lastStreakUpdatedDayMsEpochEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastStreakUpdatedDayMsEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      lastStreakUpdatedDayMsEpochGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastStreakUpdatedDayMsEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      lastStreakUpdatedDayMsEpochLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastStreakUpdatedDayMsEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      lastStreakUpdatedDayMsEpochBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastStreakUpdatedDayMsEpoch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      longestStreakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longestStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      longestStreakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longestStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      longestStreakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longestStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      longestStreakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longestStreak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      sessionTypeEqualTo(SessionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionType',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      sessionTypeGreaterThan(
    SessionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionType',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      sessionTypeLessThan(
    SessionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionType',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      sessionTypeBetween(
    SessionType lower,
    SessionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterFilterCondition>
      shouldStartDndEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shouldStartDnd',
        value: value,
      ));
    });
  }
}

extension FocusModeSettingsQueryObject
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QFilterCondition> {}

extension FocusModeSettingsQueryLinks
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QFilterCondition> {}

extension FocusModeSettingsQuerySortBy
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QSortBy> {
  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByLastStreakUpdatedDayMsEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStreakUpdatedDayMsEpoch', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByLastStreakUpdatedDayMsEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStreakUpdatedDayMsEpoch', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByLongestStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByLongestStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortBySessionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortBySessionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByShouldStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      sortByShouldStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.desc);
    });
  }
}

extension FocusModeSettingsQuerySortThenBy
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QSortThenBy> {
  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByLastStreakUpdatedDayMsEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStreakUpdatedDayMsEpoch', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByLastStreakUpdatedDayMsEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStreakUpdatedDayMsEpoch', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByLongestStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByLongestStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreak', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenBySessionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenBySessionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionType', Sort.desc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByShouldStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.asc);
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QAfterSortBy>
      thenByShouldStartDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shouldStartDnd', Sort.desc);
    });
  }
}

extension FocusModeSettingsQueryWhereDistinct
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QDistinct> {
  QueryBuilder<FocusModeSettings, FocusModeSettings, QDistinct>
      distinctByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStreak');
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QDistinct>
      distinctByDistractingApps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distractingApps');
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QDistinct>
      distinctByLastStreakUpdatedDayMsEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastStreakUpdatedDayMsEpoch');
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QDistinct>
      distinctByLongestStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longestStreak');
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QDistinct>
      distinctBySessionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionType');
    });
  }

  QueryBuilder<FocusModeSettings, FocusModeSettings, QDistinct>
      distinctByShouldStartDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shouldStartDnd');
    });
  }
}

extension FocusModeSettingsQueryProperty
    on QueryBuilder<FocusModeSettings, FocusModeSettings, QQueryProperty> {
  QueryBuilder<FocusModeSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusModeSettings, int, QQueryOperations>
      currentStreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStreak');
    });
  }

  QueryBuilder<FocusModeSettings, List<String>, QQueryOperations>
      distractingAppsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distractingApps');
    });
  }

  QueryBuilder<FocusModeSettings, int, QQueryOperations>
      lastStreakUpdatedDayMsEpochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastStreakUpdatedDayMsEpoch');
    });
  }

  QueryBuilder<FocusModeSettings, int, QQueryOperations>
      longestStreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longestStreak');
    });
  }

  QueryBuilder<FocusModeSettings, SessionType, QQueryOperations>
      sessionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionType');
    });
  }

  QueryBuilder<FocusModeSettings, bool, QQueryOperations>
      shouldStartDndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shouldStartDnd');
    });
  }
}
