// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFocusSessionCollection on Isar {
  IsarCollection<FocusSession> get focusSessions => this.collection();
}

const FocusSessionSchema = CollectionSchema(
  name: r'FocusSession',
  id: 7529488139707530527,
  properties: {
    r'durationSecs': PropertySchema(
      id: 0,
      name: r'durationSecs',
      type: IsarType.long,
    ),
    r'startTimeMsEpoch': PropertySchema(
      id: 1,
      name: r'startTimeMsEpoch',
      type: IsarType.long,
    ),
    r'state': PropertySchema(
      id: 2,
      name: r'state',
      type: IsarType.byte,
      enumMap: _FocusSessionstateEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 3,
      name: r'type',
      type: IsarType.byte,
      enumMap: _FocusSessiontypeEnumValueMap,
    )
  },
  estimateSize: _focusSessionEstimateSize,
  serialize: _focusSessionSerialize,
  deserialize: _focusSessionDeserialize,
  deserializeProp: _focusSessionDeserializeProp,
  idName: r'id',
  indexes: {
    r'startTimeMsEpoch': IndexSchema(
      id: 6705969030143502100,
      name: r'startTimeMsEpoch',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'startTimeMsEpoch',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _focusSessionGetId,
  getLinks: _focusSessionGetLinks,
  attach: _focusSessionAttach,
  version: '3.1.0+1',
);

int _focusSessionEstimateSize(
  FocusSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _focusSessionSerialize(
  FocusSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.durationSecs);
  writer.writeLong(offsets[1], object.startTimeMsEpoch);
  writer.writeByte(offsets[2], object.state.index);
  writer.writeByte(offsets[3], object.type.index);
}

FocusSession _focusSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FocusSession(
    durationSecs: reader.readLong(offsets[0]),
    id: id,
    startTimeMsEpoch: reader.readLong(offsets[1]),
    state: _FocusSessionstateValueEnumMap[reader.readByteOrNull(offsets[2])] ??
        SessionState.active,
    type: _FocusSessiontypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
        SessionType.study,
  );
  return object;
}

P _focusSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (_FocusSessionstateValueEnumMap[reader.readByteOrNull(offset)] ??
          SessionState.active) as P;
    case 3:
      return (_FocusSessiontypeValueEnumMap[reader.readByteOrNull(offset)] ??
          SessionType.study) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FocusSessionstateEnumValueMap = {
  'active': 0,
  'successful': 1,
  'failed': 2,
};
const _FocusSessionstateValueEnumMap = {
  0: SessionState.active,
  1: SessionState.successful,
  2: SessionState.failed,
};
const _FocusSessiontypeEnumValueMap = {
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
const _FocusSessiontypeValueEnumMap = {
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

Id _focusSessionGetId(FocusSession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _focusSessionGetLinks(FocusSession object) {
  return [];
}

void _focusSessionAttach(
    IsarCollection<dynamic> col, Id id, FocusSession object) {}

extension FocusSessionByIndex on IsarCollection<FocusSession> {
  Future<FocusSession?> getByStartTimeMsEpoch(int startTimeMsEpoch) {
    return getByIndex(r'startTimeMsEpoch', [startTimeMsEpoch]);
  }

  FocusSession? getByStartTimeMsEpochSync(int startTimeMsEpoch) {
    return getByIndexSync(r'startTimeMsEpoch', [startTimeMsEpoch]);
  }

  Future<bool> deleteByStartTimeMsEpoch(int startTimeMsEpoch) {
    return deleteByIndex(r'startTimeMsEpoch', [startTimeMsEpoch]);
  }

  bool deleteByStartTimeMsEpochSync(int startTimeMsEpoch) {
    return deleteByIndexSync(r'startTimeMsEpoch', [startTimeMsEpoch]);
  }

  Future<List<FocusSession?>> getAllByStartTimeMsEpoch(
      List<int> startTimeMsEpochValues) {
    final values = startTimeMsEpochValues.map((e) => [e]).toList();
    return getAllByIndex(r'startTimeMsEpoch', values);
  }

  List<FocusSession?> getAllByStartTimeMsEpochSync(
      List<int> startTimeMsEpochValues) {
    final values = startTimeMsEpochValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'startTimeMsEpoch', values);
  }

  Future<int> deleteAllByStartTimeMsEpoch(List<int> startTimeMsEpochValues) {
    final values = startTimeMsEpochValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'startTimeMsEpoch', values);
  }

  int deleteAllByStartTimeMsEpochSync(List<int> startTimeMsEpochValues) {
    final values = startTimeMsEpochValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'startTimeMsEpoch', values);
  }

  Future<Id> putByStartTimeMsEpoch(FocusSession object) {
    return putByIndex(r'startTimeMsEpoch', object);
  }

  Id putByStartTimeMsEpochSync(FocusSession object, {bool saveLinks = true}) {
    return putByIndexSync(r'startTimeMsEpoch', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByStartTimeMsEpoch(List<FocusSession> objects) {
    return putAllByIndex(r'startTimeMsEpoch', objects);
  }

  List<Id> putAllByStartTimeMsEpochSync(List<FocusSession> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'startTimeMsEpoch', objects,
        saveLinks: saveLinks);
  }
}

extension FocusSessionQueryWhereSort
    on QueryBuilder<FocusSession, FocusSession, QWhere> {
  QueryBuilder<FocusSession, FocusSession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhere> anyStartTimeMsEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'startTimeMsEpoch'),
      );
    });
  }
}

extension FocusSessionQueryWhere
    on QueryBuilder<FocusSession, FocusSession, QWhereClause> {
  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause> idBetween(
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

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause>
      startTimeMsEpochEqualTo(int startTimeMsEpoch) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'startTimeMsEpoch',
        value: [startTimeMsEpoch],
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause>
      startTimeMsEpochNotEqualTo(int startTimeMsEpoch) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startTimeMsEpoch',
              lower: [],
              upper: [startTimeMsEpoch],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startTimeMsEpoch',
              lower: [startTimeMsEpoch],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startTimeMsEpoch',
              lower: [startTimeMsEpoch],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startTimeMsEpoch',
              lower: [],
              upper: [startTimeMsEpoch],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause>
      startTimeMsEpochGreaterThan(
    int startTimeMsEpoch, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startTimeMsEpoch',
        lower: [startTimeMsEpoch],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause>
      startTimeMsEpochLessThan(
    int startTimeMsEpoch, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startTimeMsEpoch',
        lower: [],
        upper: [startTimeMsEpoch],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterWhereClause>
      startTimeMsEpochBetween(
    int lowerStartTimeMsEpoch,
    int upperStartTimeMsEpoch, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startTimeMsEpoch',
        lower: [lowerStartTimeMsEpoch],
        includeLower: includeLower,
        upper: [upperStartTimeMsEpoch],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FocusSessionQueryFilter
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {
  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      durationSecsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSecs',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      durationSecsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSecs',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      durationSecsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSecs',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      durationSecsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSecs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> idBetween(
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

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      startTimeMsEpochEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTimeMsEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      startTimeMsEpochGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTimeMsEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      startTimeMsEpochLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTimeMsEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      startTimeMsEpochBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTimeMsEpoch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> stateEqualTo(
      SessionState value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      stateGreaterThan(
    SessionState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> stateLessThan(
    SessionState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> stateBetween(
    SessionState lower,
    SessionState upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> typeEqualTo(
      SessionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition>
      typeGreaterThan(
    SessionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> typeLessThan(
    SessionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterFilterCondition> typeBetween(
    SessionType lower,
    SessionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FocusSessionQueryObject
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {}

extension FocusSessionQueryLinks
    on QueryBuilder<FocusSession, FocusSession, QFilterCondition> {}

extension FocusSessionQuerySortBy
    on QueryBuilder<FocusSession, FocusSession, QSortBy> {
  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByDurationSecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSecs', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByDurationSecsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSecs', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByStartTimeMsEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMsEpoch', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      sortByStartTimeMsEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMsEpoch', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension FocusSessionQuerySortThenBy
    on QueryBuilder<FocusSession, FocusSession, QSortThenBy> {
  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByDurationSecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSecs', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByDurationSecsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSecs', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByStartTimeMsEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMsEpoch', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy>
      thenByStartTimeMsEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimeMsEpoch', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<FocusSession, FocusSession, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension FocusSessionQueryWhereDistinct
    on QueryBuilder<FocusSession, FocusSession, QDistinct> {
  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByDurationSecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSecs');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct>
      distinctByStartTimeMsEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTimeMsEpoch');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state');
    });
  }

  QueryBuilder<FocusSession, FocusSession, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension FocusSessionQueryProperty
    on QueryBuilder<FocusSession, FocusSession, QQueryProperty> {
  QueryBuilder<FocusSession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FocusSession, int, QQueryOperations> durationSecsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSecs');
    });
  }

  QueryBuilder<FocusSession, int, QQueryOperations> startTimeMsEpochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimeMsEpoch');
    });
  }

  QueryBuilder<FocusSession, SessionState, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }

  QueryBuilder<FocusSession, SessionType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
