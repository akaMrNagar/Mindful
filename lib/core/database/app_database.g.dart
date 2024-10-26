// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppRestrictionTableTable extends AppRestrictionTable
    with TableInfo<$AppRestrictionTableTable, AppRestriction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppRestrictionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _appPackageMeta =
      const VerificationMeta('appPackage');
  @override
  late final GeneratedColumn<String> appPackage = GeneratedColumn<String>(
      'app_package', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timerSecMeta =
      const VerificationMeta('timerSec');
  @override
  late final GeneratedColumn<int> timerSec = GeneratedColumn<int>(
      'timer_sec', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _canAccessInternetMeta =
      const VerificationMeta('canAccessInternet');
  @override
  late final GeneratedColumn<bool> canAccessInternet = GeneratedColumn<bool>(
      'can_access_internet', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_access_internet" IN (0, 1))'));
  static const VerificationMeta _associatedGroupIdMeta =
      const VerificationMeta('associatedGroupId');
  @override
  late final GeneratedColumn<int> associatedGroupId = GeneratedColumn<int>(
      'associated_group_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [appPackage, timerSec, canAccessInternet, associatedGroupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_restriction_table';
  @override
  VerificationContext validateIntegrity(Insertable<AppRestriction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('app_package')) {
      context.handle(
          _appPackageMeta,
          appPackage.isAcceptableOrUnknown(
              data['app_package']!, _appPackageMeta));
    } else if (isInserting) {
      context.missing(_appPackageMeta);
    }
    if (data.containsKey('timer_sec')) {
      context.handle(_timerSecMeta,
          timerSec.isAcceptableOrUnknown(data['timer_sec']!, _timerSecMeta));
    } else if (isInserting) {
      context.missing(_timerSecMeta);
    }
    if (data.containsKey('can_access_internet')) {
      context.handle(
          _canAccessInternetMeta,
          canAccessInternet.isAcceptableOrUnknown(
              data['can_access_internet']!, _canAccessInternetMeta));
    } else if (isInserting) {
      context.missing(_canAccessInternetMeta);
    }
    if (data.containsKey('associated_group_id')) {
      context.handle(
          _associatedGroupIdMeta,
          associatedGroupId.isAcceptableOrUnknown(
              data['associated_group_id']!, _associatedGroupIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {appPackage};
  @override
  AppRestriction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppRestriction(
      appPackage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_package'])!,
      timerSec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timer_sec'])!,
      canAccessInternet: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_access_internet'])!,
      associatedGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}associated_group_id']),
    );
  }

  @override
  $AppRestrictionTableTable createAlias(String alias) {
    return $AppRestrictionTableTable(attachedDatabase, alias);
  }
}

class AppRestriction extends DataClass implements Insertable<AppRestriction> {
  /// Package name of the related app
  final String appPackage;

  /// The timer set for the app in SECONDS
  final int timerSec;

  /// Flag denoting if this app can access internet or not
  final bool canAccessInternet;

  /// ID of the [RestrictionGroup] this app is associated with
  final int? associatedGroupId;
  const AppRestriction(
      {required this.appPackage,
      required this.timerSec,
      required this.canAccessInternet,
      this.associatedGroupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['app_package'] = Variable<String>(appPackage);
    map['timer_sec'] = Variable<int>(timerSec);
    map['can_access_internet'] = Variable<bool>(canAccessInternet);
    if (!nullToAbsent || associatedGroupId != null) {
      map['associated_group_id'] = Variable<int>(associatedGroupId);
    }
    return map;
  }

  AppRestrictionTableCompanion toCompanion(bool nullToAbsent) {
    return AppRestrictionTableCompanion(
      appPackage: Value(appPackage),
      timerSec: Value(timerSec),
      canAccessInternet: Value(canAccessInternet),
      associatedGroupId: associatedGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(associatedGroupId),
    );
  }

  factory AppRestriction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppRestriction(
      appPackage: serializer.fromJson<String>(json['appPackage']),
      timerSec: serializer.fromJson<int>(json['timerSec']),
      canAccessInternet: serializer.fromJson<bool>(json['canAccessInternet']),
      associatedGroupId: serializer.fromJson<int?>(json['associatedGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appPackage': serializer.toJson<String>(appPackage),
      'timerSec': serializer.toJson<int>(timerSec),
      'canAccessInternet': serializer.toJson<bool>(canAccessInternet),
      'associatedGroupId': serializer.toJson<int?>(associatedGroupId),
    };
  }

  AppRestriction copyWith(
          {String? appPackage,
          int? timerSec,
          bool? canAccessInternet,
          Value<int?> associatedGroupId = const Value.absent()}) =>
      AppRestriction(
        appPackage: appPackage ?? this.appPackage,
        timerSec: timerSec ?? this.timerSec,
        canAccessInternet: canAccessInternet ?? this.canAccessInternet,
        associatedGroupId: associatedGroupId.present
            ? associatedGroupId.value
            : this.associatedGroupId,
      );
  @override
  String toString() {
    return (StringBuffer('AppRestriction(')
          ..write('appPackage: $appPackage, ')
          ..write('timerSec: $timerSec, ')
          ..write('canAccessInternet: $canAccessInternet, ')
          ..write('associatedGroupId: $associatedGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(appPackage, timerSec, canAccessInternet, associatedGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppRestriction &&
          other.appPackage == this.appPackage &&
          other.timerSec == this.timerSec &&
          other.canAccessInternet == this.canAccessInternet &&
          other.associatedGroupId == this.associatedGroupId);
}

class AppRestrictionTableCompanion extends UpdateCompanion<AppRestriction> {
  final Value<String> appPackage;
  final Value<int> timerSec;
  final Value<bool> canAccessInternet;
  final Value<int?> associatedGroupId;
  final Value<int> rowid;
  const AppRestrictionTableCompanion({
    this.appPackage = const Value.absent(),
    this.timerSec = const Value.absent(),
    this.canAccessInternet = const Value.absent(),
    this.associatedGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppRestrictionTableCompanion.insert({
    required String appPackage,
    required int timerSec,
    required bool canAccessInternet,
    this.associatedGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : appPackage = Value(appPackage),
        timerSec = Value(timerSec),
        canAccessInternet = Value(canAccessInternet);
  static Insertable<AppRestriction> custom({
    Expression<String>? appPackage,
    Expression<int>? timerSec,
    Expression<bool>? canAccessInternet,
    Expression<int>? associatedGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appPackage != null) 'app_package': appPackage,
      if (timerSec != null) 'timer_sec': timerSec,
      if (canAccessInternet != null) 'can_access_internet': canAccessInternet,
      if (associatedGroupId != null) 'associated_group_id': associatedGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppRestrictionTableCompanion copyWith(
      {Value<String>? appPackage,
      Value<int>? timerSec,
      Value<bool>? canAccessInternet,
      Value<int?>? associatedGroupId,
      Value<int>? rowid}) {
    return AppRestrictionTableCompanion(
      appPackage: appPackage ?? this.appPackage,
      timerSec: timerSec ?? this.timerSec,
      canAccessInternet: canAccessInternet ?? this.canAccessInternet,
      associatedGroupId: associatedGroupId ?? this.associatedGroupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (appPackage.present) {
      map['app_package'] = Variable<String>(appPackage.value);
    }
    if (timerSec.present) {
      map['timer_sec'] = Variable<int>(timerSec.value);
    }
    if (canAccessInternet.present) {
      map['can_access_internet'] = Variable<bool>(canAccessInternet.value);
    }
    if (associatedGroupId.present) {
      map['associated_group_id'] = Variable<int>(associatedGroupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppRestrictionTableCompanion(')
          ..write('appPackage: $appPackage, ')
          ..write('timerSec: $timerSec, ')
          ..write('canAccessInternet: $canAccessInternet, ')
          ..write('associatedGroupId: $associatedGroupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BedtimeScheduleTableTable extends BedtimeScheduleTable
    with TableInfo<$BedtimeScheduleTableTable, BedtimeSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BedtimeScheduleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _startTimeInMinsMeta =
      const VerificationMeta('startTimeInMins');
  @override
  late final GeneratedColumn<int> startTimeInMins = GeneratedColumn<int>(
      'start_time_in_mins', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endTimeInMinsMeta =
      const VerificationMeta('endTimeInMins');
  @override
  late final GeneratedColumn<int> endTimeInMins = GeneratedColumn<int>(
      'end_time_in_mins', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scheduleDaysMeta =
      const VerificationMeta('scheduleDays');
  @override
  late final GeneratedColumnWithTypeConverter<List<bool>, String> scheduleDays =
      GeneratedColumn<String>('schedule_days', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<bool>>(
              $BedtimeScheduleTableTable.$converterscheduleDays);
  static const VerificationMeta _isScheduleOnMeta =
      const VerificationMeta('isScheduleOn');
  @override
  late final GeneratedColumn<bool> isScheduleOn = GeneratedColumn<bool>(
      'is_schedule_on', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_schedule_on" IN (0, 1))'));
  static const VerificationMeta _shouldStartDndMeta =
      const VerificationMeta('shouldStartDnd');
  @override
  late final GeneratedColumn<bool> shouldStartDnd = GeneratedColumn<bool>(
      'should_start_dnd', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("should_start_dnd" IN (0, 1))'));
  static const VerificationMeta _distractingAppsMeta =
      const VerificationMeta('distractingApps');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      distractingApps = GeneratedColumn<String>(
              'distracting_apps', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $BedtimeScheduleTableTable.$converterdistractingApps);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        startTimeInMins,
        endTimeInMins,
        scheduleDays,
        isScheduleOn,
        shouldStartDnd,
        distractingApps
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bedtime_schedule_table';
  @override
  VerificationContext validateIntegrity(Insertable<BedtimeSchedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_time_in_mins')) {
      context.handle(
          _startTimeInMinsMeta,
          startTimeInMins.isAcceptableOrUnknown(
              data['start_time_in_mins']!, _startTimeInMinsMeta));
    } else if (isInserting) {
      context.missing(_startTimeInMinsMeta);
    }
    if (data.containsKey('end_time_in_mins')) {
      context.handle(
          _endTimeInMinsMeta,
          endTimeInMins.isAcceptableOrUnknown(
              data['end_time_in_mins']!, _endTimeInMinsMeta));
    } else if (isInserting) {
      context.missing(_endTimeInMinsMeta);
    }
    context.handle(_scheduleDaysMeta, const VerificationResult.success());
    if (data.containsKey('is_schedule_on')) {
      context.handle(
          _isScheduleOnMeta,
          isScheduleOn.isAcceptableOrUnknown(
              data['is_schedule_on']!, _isScheduleOnMeta));
    } else if (isInserting) {
      context.missing(_isScheduleOnMeta);
    }
    if (data.containsKey('should_start_dnd')) {
      context.handle(
          _shouldStartDndMeta,
          shouldStartDnd.isAcceptableOrUnknown(
              data['should_start_dnd']!, _shouldStartDndMeta));
    } else if (isInserting) {
      context.missing(_shouldStartDndMeta);
    }
    context.handle(_distractingAppsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BedtimeSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BedtimeSchedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startTimeInMins: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}start_time_in_mins'])!,
      endTimeInMins: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time_in_mins'])!,
      scheduleDays: $BedtimeScheduleTableTable.$converterscheduleDays.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}schedule_days'])!),
      isScheduleOn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_schedule_on'])!,
      shouldStartDnd: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}should_start_dnd'])!,
      distractingApps: $BedtimeScheduleTableTable.$converterdistractingApps
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}distracting_apps'])!),
    );
  }

  @override
  $BedtimeScheduleTableTable createAlias(String alias) {
    return $BedtimeScheduleTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<bool>, String> $converterscheduleDays =
      const ListBoolConverter();
  static TypeConverter<List<String>, String> $converterdistractingApps =
      const ListStringConverter();
}

class BedtimeSchedule extends DataClass implements Insertable<BedtimeSchedule> {
  /// Unique ID for bedtime schedule
  final int id;

  /// [TimeOfDay] in minutes from where the bedtime schedule task will start.
  /// It is stored as total minutes.
  final int startTimeInMins;

  /// [TimeOfDay] in minutes when the bedtime schedule task will end
  /// It is stored as total minutes.
  final int endTimeInMins;

  /// Days on which the task will execute.
  /// The list contains 7 booleans for each day of week.
  /// [TRUE] indicates that schedule task will run that day.
  /// [FALSE] indicates that schedule task will skip that day.
  final List<bool> scheduleDays;

  /// Boolean denoting the status of the bedtime schedule means
  /// [For User] if the schedule is running or not.
  /// [For Developer]  if the task alarm is scheduled or cancelled.
  final bool isScheduleOn;

  /// Boolean denoting if to start DO NOT DISTURB mode or not when bedtime starts.
  final bool shouldStartDnd;

  /// List of app's packages which are selected as distracting apps.
  final List<String> distractingApps;
  const BedtimeSchedule(
      {required this.id,
      required this.startTimeInMins,
      required this.endTimeInMins,
      required this.scheduleDays,
      required this.isScheduleOn,
      required this.shouldStartDnd,
      required this.distractingApps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_time_in_mins'] = Variable<int>(startTimeInMins);
    map['end_time_in_mins'] = Variable<int>(endTimeInMins);
    {
      map['schedule_days'] = Variable<String>($BedtimeScheduleTableTable
          .$converterscheduleDays
          .toSql(scheduleDays));
    }
    map['is_schedule_on'] = Variable<bool>(isScheduleOn);
    map['should_start_dnd'] = Variable<bool>(shouldStartDnd);
    {
      map['distracting_apps'] = Variable<String>($BedtimeScheduleTableTable
          .$converterdistractingApps
          .toSql(distractingApps));
    }
    return map;
  }

  BedtimeScheduleTableCompanion toCompanion(bool nullToAbsent) {
    return BedtimeScheduleTableCompanion(
      id: Value(id),
      startTimeInMins: Value(startTimeInMins),
      endTimeInMins: Value(endTimeInMins),
      scheduleDays: Value(scheduleDays),
      isScheduleOn: Value(isScheduleOn),
      shouldStartDnd: Value(shouldStartDnd),
      distractingApps: Value(distractingApps),
    );
  }

  factory BedtimeSchedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BedtimeSchedule(
      id: serializer.fromJson<int>(json['id']),
      startTimeInMins: serializer.fromJson<int>(json['startTimeInMins']),
      endTimeInMins: serializer.fromJson<int>(json['endTimeInMins']),
      scheduleDays: serializer.fromJson<List<bool>>(json['scheduleDays']),
      isScheduleOn: serializer.fromJson<bool>(json['isScheduleOn']),
      shouldStartDnd: serializer.fromJson<bool>(json['shouldStartDnd']),
      distractingApps:
          serializer.fromJson<List<String>>(json['distractingApps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startTimeInMins': serializer.toJson<int>(startTimeInMins),
      'endTimeInMins': serializer.toJson<int>(endTimeInMins),
      'scheduleDays': serializer.toJson<List<bool>>(scheduleDays),
      'isScheduleOn': serializer.toJson<bool>(isScheduleOn),
      'shouldStartDnd': serializer.toJson<bool>(shouldStartDnd),
      'distractingApps': serializer.toJson<List<String>>(distractingApps),
    };
  }

  BedtimeSchedule copyWith(
          {int? id,
          int? startTimeInMins,
          int? endTimeInMins,
          List<bool>? scheduleDays,
          bool? isScheduleOn,
          bool? shouldStartDnd,
          List<String>? distractingApps}) =>
      BedtimeSchedule(
        id: id ?? this.id,
        startTimeInMins: startTimeInMins ?? this.startTimeInMins,
        endTimeInMins: endTimeInMins ?? this.endTimeInMins,
        scheduleDays: scheduleDays ?? this.scheduleDays,
        isScheduleOn: isScheduleOn ?? this.isScheduleOn,
        shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
        distractingApps: distractingApps ?? this.distractingApps,
      );
  @override
  String toString() {
    return (StringBuffer('BedtimeSchedule(')
          ..write('id: $id, ')
          ..write('startTimeInMins: $startTimeInMins, ')
          ..write('endTimeInMins: $endTimeInMins, ')
          ..write('scheduleDays: $scheduleDays, ')
          ..write('isScheduleOn: $isScheduleOn, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startTimeInMins, endTimeInMins,
      scheduleDays, isScheduleOn, shouldStartDnd, distractingApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BedtimeSchedule &&
          other.id == this.id &&
          other.startTimeInMins == this.startTimeInMins &&
          other.endTimeInMins == this.endTimeInMins &&
          other.scheduleDays == this.scheduleDays &&
          other.isScheduleOn == this.isScheduleOn &&
          other.shouldStartDnd == this.shouldStartDnd &&
          other.distractingApps == this.distractingApps);
}

class BedtimeScheduleTableCompanion extends UpdateCompanion<BedtimeSchedule> {
  final Value<int> id;
  final Value<int> startTimeInMins;
  final Value<int> endTimeInMins;
  final Value<List<bool>> scheduleDays;
  final Value<bool> isScheduleOn;
  final Value<bool> shouldStartDnd;
  final Value<List<String>> distractingApps;
  const BedtimeScheduleTableCompanion({
    this.id = const Value.absent(),
    this.startTimeInMins = const Value.absent(),
    this.endTimeInMins = const Value.absent(),
    this.scheduleDays = const Value.absent(),
    this.isScheduleOn = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  BedtimeScheduleTableCompanion.insert({
    this.id = const Value.absent(),
    required int startTimeInMins,
    required int endTimeInMins,
    required List<bool> scheduleDays,
    required bool isScheduleOn,
    required bool shouldStartDnd,
    required List<String> distractingApps,
  })  : startTimeInMins = Value(startTimeInMins),
        endTimeInMins = Value(endTimeInMins),
        scheduleDays = Value(scheduleDays),
        isScheduleOn = Value(isScheduleOn),
        shouldStartDnd = Value(shouldStartDnd),
        distractingApps = Value(distractingApps);
  static Insertable<BedtimeSchedule> custom({
    Expression<int>? id,
    Expression<int>? startTimeInMins,
    Expression<int>? endTimeInMins,
    Expression<String>? scheduleDays,
    Expression<bool>? isScheduleOn,
    Expression<bool>? shouldStartDnd,
    Expression<String>? distractingApps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTimeInMins != null) 'start_time_in_mins': startTimeInMins,
      if (endTimeInMins != null) 'end_time_in_mins': endTimeInMins,
      if (scheduleDays != null) 'schedule_days': scheduleDays,
      if (isScheduleOn != null) 'is_schedule_on': isScheduleOn,
      if (shouldStartDnd != null) 'should_start_dnd': shouldStartDnd,
      if (distractingApps != null) 'distracting_apps': distractingApps,
    });
  }

  BedtimeScheduleTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? startTimeInMins,
      Value<int>? endTimeInMins,
      Value<List<bool>>? scheduleDays,
      Value<bool>? isScheduleOn,
      Value<bool>? shouldStartDnd,
      Value<List<String>>? distractingApps}) {
    return BedtimeScheduleTableCompanion(
      id: id ?? this.id,
      startTimeInMins: startTimeInMins ?? this.startTimeInMins,
      endTimeInMins: endTimeInMins ?? this.endTimeInMins,
      scheduleDays: scheduleDays ?? this.scheduleDays,
      isScheduleOn: isScheduleOn ?? this.isScheduleOn,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTimeInMins.present) {
      map['start_time_in_mins'] = Variable<int>(startTimeInMins.value);
    }
    if (endTimeInMins.present) {
      map['end_time_in_mins'] = Variable<int>(endTimeInMins.value);
    }
    if (scheduleDays.present) {
      map['schedule_days'] = Variable<String>($BedtimeScheduleTableTable
          .$converterscheduleDays
          .toSql(scheduleDays.value));
    }
    if (isScheduleOn.present) {
      map['is_schedule_on'] = Variable<bool>(isScheduleOn.value);
    }
    if (shouldStartDnd.present) {
      map['should_start_dnd'] = Variable<bool>(shouldStartDnd.value);
    }
    if (distractingApps.present) {
      map['distracting_apps'] = Variable<String>($BedtimeScheduleTableTable
          .$converterdistractingApps
          .toSql(distractingApps.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BedtimeScheduleTableCompanion(')
          ..write('id: $id, ')
          ..write('startTimeInMins: $startTimeInMins, ')
          ..write('endTimeInMins: $endTimeInMins, ')
          ..write('scheduleDays: $scheduleDays, ')
          ..write('isScheduleOn: $isScheduleOn, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }
}

class $CrashLogsTableTable extends CrashLogsTable
    with TableInfo<$CrashLogsTableTable, CrashLogs> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrashLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _appVersionMeta =
      const VerificationMeta('appVersion');
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
      'app_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeStampMeta =
      const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<DateTime> timeStamp = GeneratedColumn<DateTime>(
      'time_stamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stackTraceMeta =
      const VerificationMeta('stackTrace');
  @override
  late final GeneratedColumn<String> stackTrace = GeneratedColumn<String>(
      'stack_trace', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, appVersion, timeStamp, error, stackTrace];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crash_logs_table';
  @override
  VerificationContext validateIntegrity(Insertable<CrashLogs> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('app_version')) {
      context.handle(
          _appVersionMeta,
          appVersion.isAcceptableOrUnknown(
              data['app_version']!, _appVersionMeta));
    } else if (isInserting) {
      context.missing(_appVersionMeta);
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    } else if (isInserting) {
      context.missing(_timeStampMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    } else if (isInserting) {
      context.missing(_errorMeta);
    }
    if (data.containsKey('stack_trace')) {
      context.handle(
          _stackTraceMeta,
          stackTrace.isAcceptableOrUnknown(
              data['stack_trace']!, _stackTraceMeta));
    } else if (isInserting) {
      context.missing(_stackTraceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrashLogs map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrashLogs(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      appVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_version'])!,
      timeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_stamp'])!,
      error: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error'])!,
      stackTrace: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stack_trace'])!,
    );
  }

  @override
  $CrashLogsTableTable createAlias(String alias) {
    return $CrashLogsTableTable(attachedDatabase, alias);
  }
}

class CrashLogs extends DataClass implements Insertable<CrashLogs> {
  /// Unique ID for crash logs
  final int id;

  /// Current version of Mindful app
  final String appVersion;

  /// [DateTime] when the error was thrown
  final DateTime timeStamp;

  /// The error string
  final String error;

  /// Stack trace when the error or exception was thrown
  final String stackTrace;
  const CrashLogs(
      {required this.id,
      required this.appVersion,
      required this.timeStamp,
      required this.error,
      required this.stackTrace});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['app_version'] = Variable<String>(appVersion);
    map['time_stamp'] = Variable<DateTime>(timeStamp);
    map['error'] = Variable<String>(error);
    map['stack_trace'] = Variable<String>(stackTrace);
    return map;
  }

  CrashLogsTableCompanion toCompanion(bool nullToAbsent) {
    return CrashLogsTableCompanion(
      id: Value(id),
      appVersion: Value(appVersion),
      timeStamp: Value(timeStamp),
      error: Value(error),
      stackTrace: Value(stackTrace),
    );
  }

  factory CrashLogs.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrashLogs(
      id: serializer.fromJson<int>(json['id']),
      appVersion: serializer.fromJson<String>(json['appVersion']),
      timeStamp: serializer.fromJson<DateTime>(json['timeStamp']),
      error: serializer.fromJson<String>(json['error']),
      stackTrace: serializer.fromJson<String>(json['stackTrace']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'appVersion': serializer.toJson<String>(appVersion),
      'timeStamp': serializer.toJson<DateTime>(timeStamp),
      'error': serializer.toJson<String>(error),
      'stackTrace': serializer.toJson<String>(stackTrace),
    };
  }

  CrashLogs copyWith(
          {int? id,
          String? appVersion,
          DateTime? timeStamp,
          String? error,
          String? stackTrace}) =>
      CrashLogs(
        id: id ?? this.id,
        appVersion: appVersion ?? this.appVersion,
        timeStamp: timeStamp ?? this.timeStamp,
        error: error ?? this.error,
        stackTrace: stackTrace ?? this.stackTrace,
      );
  @override
  String toString() {
    return (StringBuffer('CrashLogs(')
          ..write('id: $id, ')
          ..write('appVersion: $appVersion, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('error: $error, ')
          ..write('stackTrace: $stackTrace')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, appVersion, timeStamp, error, stackTrace);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrashLogs &&
          other.id == this.id &&
          other.appVersion == this.appVersion &&
          other.timeStamp == this.timeStamp &&
          other.error == this.error &&
          other.stackTrace == this.stackTrace);
}

class CrashLogsTableCompanion extends UpdateCompanion<CrashLogs> {
  final Value<int> id;
  final Value<String> appVersion;
  final Value<DateTime> timeStamp;
  final Value<String> error;
  final Value<String> stackTrace;
  const CrashLogsTableCompanion({
    this.id = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.timeStamp = const Value.absent(),
    this.error = const Value.absent(),
    this.stackTrace = const Value.absent(),
  });
  CrashLogsTableCompanion.insert({
    this.id = const Value.absent(),
    required String appVersion,
    required DateTime timeStamp,
    required String error,
    required String stackTrace,
  })  : appVersion = Value(appVersion),
        timeStamp = Value(timeStamp),
        error = Value(error),
        stackTrace = Value(stackTrace);
  static Insertable<CrashLogs> custom({
    Expression<int>? id,
    Expression<String>? appVersion,
    Expression<DateTime>? timeStamp,
    Expression<String>? error,
    Expression<String>? stackTrace,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (appVersion != null) 'app_version': appVersion,
      if (timeStamp != null) 'time_stamp': timeStamp,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stack_trace': stackTrace,
    });
  }

  CrashLogsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? appVersion,
      Value<DateTime>? timeStamp,
      Value<String>? error,
      Value<String>? stackTrace}) {
    return CrashLogsTableCompanion(
      id: id ?? this.id,
      appVersion: appVersion ?? this.appVersion,
      timeStamp: timeStamp ?? this.timeStamp,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<DateTime>(timeStamp.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (stackTrace.present) {
      map['stack_trace'] = Variable<String>(stackTrace.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrashLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('appVersion: $appVersion, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('error: $error, ')
          ..write('stackTrace: $stackTrace')
          ..write(')'))
        .toString();
  }
}

class $FocusModeTableTable extends FocusModeTable
    with TableInfo<$FocusModeTableTable, FocusMode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusModeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _sessionTypeMeta =
      const VerificationMeta('sessionType');
  @override
  late final GeneratedColumnWithTypeConverter<SessionType, int> sessionType =
      GeneratedColumn<int>('session_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<SessionType>(
              $FocusModeTableTable.$convertersessionType);
  static const VerificationMeta _shouldStartDndMeta =
      const VerificationMeta('shouldStartDnd');
  @override
  late final GeneratedColumn<bool> shouldStartDnd = GeneratedColumn<bool>(
      'should_start_dnd', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("should_start_dnd" IN (0, 1))'));
  static const VerificationMeta _distractingAppsMeta =
      const VerificationMeta('distractingApps');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      distractingApps = GeneratedColumn<String>(
              'distracting_apps', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $FocusModeTableTable.$converterdistractingApps);
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastTimeStreakUpdatedMeta =
      const VerificationMeta('lastTimeStreakUpdated');
  @override
  late final GeneratedColumn<DateTime> lastTimeStreakUpdated =
      GeneratedColumn<DateTime>('last_time_streak_updated', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _activeSessionIdMeta =
      const VerificationMeta('activeSessionId');
  @override
  late final GeneratedColumn<int> activeSessionId = GeneratedColumn<int>(
      'active_session_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionType,
        shouldStartDnd,
        distractingApps,
        longestStreak,
        currentStreak,
        lastTimeStreakUpdated,
        activeSessionId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_mode_table';
  @override
  VerificationContext validateIntegrity(Insertable<FocusMode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_sessionTypeMeta, const VerificationResult.success());
    if (data.containsKey('should_start_dnd')) {
      context.handle(
          _shouldStartDndMeta,
          shouldStartDnd.isAcceptableOrUnknown(
              data['should_start_dnd']!, _shouldStartDndMeta));
    } else if (isInserting) {
      context.missing(_shouldStartDndMeta);
    }
    context.handle(_distractingAppsMeta, const VerificationResult.success());
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    } else if (isInserting) {
      context.missing(_longestStreakMeta);
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    } else if (isInserting) {
      context.missing(_currentStreakMeta);
    }
    if (data.containsKey('last_time_streak_updated')) {
      context.handle(
          _lastTimeStreakUpdatedMeta,
          lastTimeStreakUpdated.isAcceptableOrUnknown(
              data['last_time_streak_updated']!, _lastTimeStreakUpdatedMeta));
    } else if (isInserting) {
      context.missing(_lastTimeStreakUpdatedMeta);
    }
    if (data.containsKey('active_session_id')) {
      context.handle(
          _activeSessionIdMeta,
          activeSessionId.isAcceptableOrUnknown(
              data['active_session_id']!, _activeSessionIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusMode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusMode(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionType: $FocusModeTableTable.$convertersessionType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}session_type'])!),
      shouldStartDnd: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}should_start_dnd'])!,
      distractingApps: $FocusModeTableTable.$converterdistractingApps.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}distracting_apps'])!),
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      lastTimeStreakUpdated: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_time_streak_updated'])!,
      activeSessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}active_session_id']),
    );
  }

  @override
  $FocusModeTableTable createAlias(String alias) {
    return $FocusModeTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SessionType, int, int> $convertersessionType =
      const EnumIndexConverter<SessionType>(SessionType.values);
  static TypeConverter<List<String>, String> $converterdistractingApps =
      const ListStringConverter();
}

class FocusMode extends DataClass implements Insertable<FocusMode> {
  /// Unique ID for focus mode
  final int id;

  /// Selected session type
  final SessionType sessionType;

  /// Flag indicating if to start DND during the focus session
  final bool shouldStartDnd;

  /// List of app's packages which are selected as distracting apps.
  final List<String> distractingApps;

  /// Longest streak (number of days) till now
  final int longestStreak;

  /// Current streak (number of days) till now
  final int currentStreak;

  /// The [DateTime] when the streak was updated last time
  final DateTime lastTimeStreakUpdated;

  /// Id of current active [FocusSession]
  final int? activeSessionId;
  const FocusMode(
      {required this.id,
      required this.sessionType,
      required this.shouldStartDnd,
      required this.distractingApps,
      required this.longestStreak,
      required this.currentStreak,
      required this.lastTimeStreakUpdated,
      this.activeSessionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['session_type'] = Variable<int>(
          $FocusModeTableTable.$convertersessionType.toSql(sessionType));
    }
    map['should_start_dnd'] = Variable<bool>(shouldStartDnd);
    {
      map['distracting_apps'] = Variable<String>($FocusModeTableTable
          .$converterdistractingApps
          .toSql(distractingApps));
    }
    map['longest_streak'] = Variable<int>(longestStreak);
    map['current_streak'] = Variable<int>(currentStreak);
    map['last_time_streak_updated'] = Variable<DateTime>(lastTimeStreakUpdated);
    if (!nullToAbsent || activeSessionId != null) {
      map['active_session_id'] = Variable<int>(activeSessionId);
    }
    return map;
  }

  FocusModeTableCompanion toCompanion(bool nullToAbsent) {
    return FocusModeTableCompanion(
      id: Value(id),
      sessionType: Value(sessionType),
      shouldStartDnd: Value(shouldStartDnd),
      distractingApps: Value(distractingApps),
      longestStreak: Value(longestStreak),
      currentStreak: Value(currentStreak),
      lastTimeStreakUpdated: Value(lastTimeStreakUpdated),
      activeSessionId: activeSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeSessionId),
    );
  }

  factory FocusMode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusMode(
      id: serializer.fromJson<int>(json['id']),
      sessionType: $FocusModeTableTable.$convertersessionType
          .fromJson(serializer.fromJson<int>(json['sessionType'])),
      shouldStartDnd: serializer.fromJson<bool>(json['shouldStartDnd']),
      distractingApps:
          serializer.fromJson<List<String>>(json['distractingApps']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      lastTimeStreakUpdated:
          serializer.fromJson<DateTime>(json['lastTimeStreakUpdated']),
      activeSessionId: serializer.fromJson<int?>(json['activeSessionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionType': serializer.toJson<int>(
          $FocusModeTableTable.$convertersessionType.toJson(sessionType)),
      'shouldStartDnd': serializer.toJson<bool>(shouldStartDnd),
      'distractingApps': serializer.toJson<List<String>>(distractingApps),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'lastTimeStreakUpdated':
          serializer.toJson<DateTime>(lastTimeStreakUpdated),
      'activeSessionId': serializer.toJson<int?>(activeSessionId),
    };
  }

  FocusMode copyWith(
          {int? id,
          SessionType? sessionType,
          bool? shouldStartDnd,
          List<String>? distractingApps,
          int? longestStreak,
          int? currentStreak,
          DateTime? lastTimeStreakUpdated,
          Value<int?> activeSessionId = const Value.absent()}) =>
      FocusMode(
        id: id ?? this.id,
        sessionType: sessionType ?? this.sessionType,
        shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
        distractingApps: distractingApps ?? this.distractingApps,
        longestStreak: longestStreak ?? this.longestStreak,
        currentStreak: currentStreak ?? this.currentStreak,
        lastTimeStreakUpdated:
            lastTimeStreakUpdated ?? this.lastTimeStreakUpdated,
        activeSessionId: activeSessionId.present
            ? activeSessionId.value
            : this.activeSessionId,
      );
  @override
  String toString() {
    return (StringBuffer('FocusMode(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('lastTimeStreakUpdated: $lastTimeStreakUpdated, ')
          ..write('activeSessionId: $activeSessionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sessionType,
      shouldStartDnd,
      distractingApps,
      longestStreak,
      currentStreak,
      lastTimeStreakUpdated,
      activeSessionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusMode &&
          other.id == this.id &&
          other.sessionType == this.sessionType &&
          other.shouldStartDnd == this.shouldStartDnd &&
          other.distractingApps == this.distractingApps &&
          other.longestStreak == this.longestStreak &&
          other.currentStreak == this.currentStreak &&
          other.lastTimeStreakUpdated == this.lastTimeStreakUpdated &&
          other.activeSessionId == this.activeSessionId);
}

class FocusModeTableCompanion extends UpdateCompanion<FocusMode> {
  final Value<int> id;
  final Value<SessionType> sessionType;
  final Value<bool> shouldStartDnd;
  final Value<List<String>> distractingApps;
  final Value<int> longestStreak;
  final Value<int> currentStreak;
  final Value<DateTime> lastTimeStreakUpdated;
  final Value<int?> activeSessionId;
  const FocusModeTableCompanion({
    this.id = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.lastTimeStreakUpdated = const Value.absent(),
    this.activeSessionId = const Value.absent(),
  });
  FocusModeTableCompanion.insert({
    this.id = const Value.absent(),
    required SessionType sessionType,
    required bool shouldStartDnd,
    required List<String> distractingApps,
    required int longestStreak,
    required int currentStreak,
    required DateTime lastTimeStreakUpdated,
    this.activeSessionId = const Value.absent(),
  })  : sessionType = Value(sessionType),
        shouldStartDnd = Value(shouldStartDnd),
        distractingApps = Value(distractingApps),
        longestStreak = Value(longestStreak),
        currentStreak = Value(currentStreak),
        lastTimeStreakUpdated = Value(lastTimeStreakUpdated);
  static Insertable<FocusMode> custom({
    Expression<int>? id,
    Expression<int>? sessionType,
    Expression<bool>? shouldStartDnd,
    Expression<String>? distractingApps,
    Expression<int>? longestStreak,
    Expression<int>? currentStreak,
    Expression<DateTime>? lastTimeStreakUpdated,
    Expression<int>? activeSessionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionType != null) 'session_type': sessionType,
      if (shouldStartDnd != null) 'should_start_dnd': shouldStartDnd,
      if (distractingApps != null) 'distracting_apps': distractingApps,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (lastTimeStreakUpdated != null)
        'last_time_streak_updated': lastTimeStreakUpdated,
      if (activeSessionId != null) 'active_session_id': activeSessionId,
    });
  }

  FocusModeTableCompanion copyWith(
      {Value<int>? id,
      Value<SessionType>? sessionType,
      Value<bool>? shouldStartDnd,
      Value<List<String>>? distractingApps,
      Value<int>? longestStreak,
      Value<int>? currentStreak,
      Value<DateTime>? lastTimeStreakUpdated,
      Value<int?>? activeSessionId}) {
    return FocusModeTableCompanion(
      id: id ?? this.id,
      sessionType: sessionType ?? this.sessionType,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
      longestStreak: longestStreak ?? this.longestStreak,
      currentStreak: currentStreak ?? this.currentStreak,
      lastTimeStreakUpdated:
          lastTimeStreakUpdated ?? this.lastTimeStreakUpdated,
      activeSessionId: activeSessionId ?? this.activeSessionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<int>(
          $FocusModeTableTable.$convertersessionType.toSql(sessionType.value));
    }
    if (shouldStartDnd.present) {
      map['should_start_dnd'] = Variable<bool>(shouldStartDnd.value);
    }
    if (distractingApps.present) {
      map['distracting_apps'] = Variable<String>($FocusModeTableTable
          .$converterdistractingApps
          .toSql(distractingApps.value));
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (lastTimeStreakUpdated.present) {
      map['last_time_streak_updated'] =
          Variable<DateTime>(lastTimeStreakUpdated.value);
    }
    if (activeSessionId.present) {
      map['active_session_id'] = Variable<int>(activeSessionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusModeTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('lastTimeStreakUpdated: $lastTimeStreakUpdated, ')
          ..write('activeSessionId: $activeSessionId')
          ..write(')'))
        .toString();
  }
}

class $FocusSessionsTableTable extends FocusSessionsTable
    with TableInfo<$FocusSessionsTableTable, FocusSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<SessionType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<SessionType>($FocusSessionsTableTable.$convertertype);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumnWithTypeConverter<SessionState, int> state =
      GeneratedColumn<int>('state', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<SessionState>(
              $FocusSessionsTableTable.$converterstate);
  static const VerificationMeta _startDateTimeMeta =
      const VerificationMeta('startDateTime');
  @override
  late final GeneratedColumn<DateTime> startDateTime =
      GeneratedColumn<DateTime>('start_date_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationSecsMeta =
      const VerificationMeta('durationSecs');
  @override
  late final GeneratedColumn<int> durationSecs = GeneratedColumn<int>(
      'duration_secs', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, state, startDateTime, durationSecs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_sessions_table';
  @override
  VerificationContext validateIntegrity(Insertable<FocusSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_stateMeta, const VerificationResult.success());
    if (data.containsKey('start_date_time')) {
      context.handle(
          _startDateTimeMeta,
          startDateTime.isAcceptableOrUnknown(
              data['start_date_time']!, _startDateTimeMeta));
    } else if (isInserting) {
      context.missing(_startDateTimeMeta);
    }
    if (data.containsKey('duration_secs')) {
      context.handle(
          _durationSecsMeta,
          durationSecs.isAcceptableOrUnknown(
              data['duration_secs']!, _durationSecsMeta));
    } else if (isInserting) {
      context.missing(_durationSecsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: $FocusSessionsTableTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      state: $FocusSessionsTableTable.$converterstate.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}state'])!),
      startDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}start_date_time'])!,
      durationSecs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_secs'])!,
    );
  }

  @override
  $FocusSessionsTableTable createAlias(String alias) {
    return $FocusSessionsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SessionType, int, int> $convertertype =
      const EnumIndexConverter<SessionType>(SessionType.values);
  static JsonTypeConverter2<SessionState, int, int> $converterstate =
      const EnumIndexConverter<SessionState>(SessionState.values);
}

class FocusSession extends DataClass implements Insertable<FocusSession> {
  /// Unique ID for each focus session
  final int id;

  /// Type of focus session [SessionType]
  final SessionType type;

  /// Current state of focus session [SessionState]
  final SessionState state;

  /// [DateTime] when the focus session is started
  final DateTime startDateTime;

  /// Total duration of the focus session in SECONDS
  /// If the session state is [SessionState.failed] then the duration
  /// is considered as the time spent before giveup
  final int durationSecs;
  const FocusSession(
      {required this.id,
      required this.type,
      required this.state,
      required this.startDateTime,
      required this.durationSecs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] =
          Variable<int>($FocusSessionsTableTable.$convertertype.toSql(type));
    }
    {
      map['state'] =
          Variable<int>($FocusSessionsTableTable.$converterstate.toSql(state));
    }
    map['start_date_time'] = Variable<DateTime>(startDateTime);
    map['duration_secs'] = Variable<int>(durationSecs);
    return map;
  }

  FocusSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return FocusSessionsTableCompanion(
      id: Value(id),
      type: Value(type),
      state: Value(state),
      startDateTime: Value(startDateTime),
      durationSecs: Value(durationSecs),
    );
  }

  factory FocusSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusSession(
      id: serializer.fromJson<int>(json['id']),
      type: $FocusSessionsTableTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      state: $FocusSessionsTableTable.$converterstate
          .fromJson(serializer.fromJson<int>(json['state'])),
      startDateTime: serializer.fromJson<DateTime>(json['startDateTime']),
      durationSecs: serializer.fromJson<int>(json['durationSecs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer
          .toJson<int>($FocusSessionsTableTable.$convertertype.toJson(type)),
      'state': serializer
          .toJson<int>($FocusSessionsTableTable.$converterstate.toJson(state)),
      'startDateTime': serializer.toJson<DateTime>(startDateTime),
      'durationSecs': serializer.toJson<int>(durationSecs),
    };
  }

  FocusSession copyWith(
          {int? id,
          SessionType? type,
          SessionState? state,
          DateTime? startDateTime,
          int? durationSecs}) =>
      FocusSession(
        id: id ?? this.id,
        type: type ?? this.type,
        state: state ?? this.state,
        startDateTime: startDateTime ?? this.startDateTime,
        durationSecs: durationSecs ?? this.durationSecs,
      );
  @override
  String toString() {
    return (StringBuffer('FocusSession(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('state: $state, ')
          ..write('startDateTime: $startDateTime, ')
          ..write('durationSecs: $durationSecs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, state, startDateTime, durationSecs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusSession &&
          other.id == this.id &&
          other.type == this.type &&
          other.state == this.state &&
          other.startDateTime == this.startDateTime &&
          other.durationSecs == this.durationSecs);
}

class FocusSessionsTableCompanion extends UpdateCompanion<FocusSession> {
  final Value<int> id;
  final Value<SessionType> type;
  final Value<SessionState> state;
  final Value<DateTime> startDateTime;
  final Value<int> durationSecs;
  const FocusSessionsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.state = const Value.absent(),
    this.startDateTime = const Value.absent(),
    this.durationSecs = const Value.absent(),
  });
  FocusSessionsTableCompanion.insert({
    this.id = const Value.absent(),
    required SessionType type,
    required SessionState state,
    required DateTime startDateTime,
    required int durationSecs,
  })  : type = Value(type),
        state = Value(state),
        startDateTime = Value(startDateTime),
        durationSecs = Value(durationSecs);
  static Insertable<FocusSession> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<int>? state,
    Expression<DateTime>? startDateTime,
    Expression<int>? durationSecs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (state != null) 'state': state,
      if (startDateTime != null) 'start_date_time': startDateTime,
      if (durationSecs != null) 'duration_secs': durationSecs,
    });
  }

  FocusSessionsTableCompanion copyWith(
      {Value<int>? id,
      Value<SessionType>? type,
      Value<SessionState>? state,
      Value<DateTime>? startDateTime,
      Value<int>? durationSecs}) {
    return FocusSessionsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      state: state ?? this.state,
      startDateTime: startDateTime ?? this.startDateTime,
      durationSecs: durationSecs ?? this.durationSecs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
          $FocusSessionsTableTable.$convertertype.toSql(type.value));
    }
    if (state.present) {
      map['state'] = Variable<int>(
          $FocusSessionsTableTable.$converterstate.toSql(state.value));
    }
    if (startDateTime.present) {
      map['start_date_time'] = Variable<DateTime>(startDateTime.value);
    }
    if (durationSecs.present) {
      map['duration_secs'] = Variable<int>(durationSecs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('state: $state, ')
          ..write('startDateTime: $startDateTime, ')
          ..write('durationSecs: $durationSecs')
          ..write(')'))
        .toString();
  }
}

class $MindfulSettingsTableTable extends MindfulSettingsTable
    with TableInfo<$MindfulSettingsTableTable, MindfulSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MindfulSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumnWithTypeConverter<AppThemeMode, int> themeMode =
      GeneratedColumn<int>('theme_mode', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<AppThemeMode>(
              $MindfulSettingsTableTable.$converterthemeMode);
  static const VerificationMeta _accentColorMeta =
      const VerificationMeta('accentColor');
  @override
  late final GeneratedColumn<String> accentColor = GeneratedColumn<String>(
      'accent_color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localeCodeMeta =
      const VerificationMeta('localeCode');
  @override
  late final GeneratedColumn<String> localeCode = GeneratedColumn<String>(
      'locale_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isInvincibleModeOnMeta =
      const VerificationMeta('isInvincibleModeOn');
  @override
  late final GeneratedColumn<bool> isInvincibleModeOn = GeneratedColumn<bool>(
      'is_invincible_mode_on', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_invincible_mode_on" IN (0, 1))'));
  static const VerificationMeta _dataResetTimeMinsMeta =
      const VerificationMeta('dataResetTimeMins');
  @override
  late final GeneratedColumn<int> dataResetTimeMins = GeneratedColumn<int>(
      'data_reset_time_mins', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _useBottomNavigationMeta =
      const VerificationMeta('useBottomNavigation');
  @override
  late final GeneratedColumn<bool> useBottomNavigation = GeneratedColumn<bool>(
      'use_bottom_navigation', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("use_bottom_navigation" IN (0, 1))'));
  static const VerificationMeta _useAmoledDarkMeta =
      const VerificationMeta('useAmoledDark');
  @override
  late final GeneratedColumn<bool> useAmoledDark = GeneratedColumn<bool>(
      'use_amoled_dark', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("use_amoled_dark" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        themeMode,
        accentColor,
        username,
        localeCode,
        isInvincibleModeOn,
        dataResetTimeMins,
        useBottomNavigation,
        useAmoledDark
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mindful_settings_table';
  @override
  VerificationContext validateIntegrity(Insertable<MindfulSettings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_themeModeMeta, const VerificationResult.success());
    if (data.containsKey('accent_color')) {
      context.handle(
          _accentColorMeta,
          accentColor.isAcceptableOrUnknown(
              data['accent_color']!, _accentColorMeta));
    } else if (isInserting) {
      context.missing(_accentColorMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('locale_code')) {
      context.handle(
          _localeCodeMeta,
          localeCode.isAcceptableOrUnknown(
              data['locale_code']!, _localeCodeMeta));
    } else if (isInserting) {
      context.missing(_localeCodeMeta);
    }
    if (data.containsKey('is_invincible_mode_on')) {
      context.handle(
          _isInvincibleModeOnMeta,
          isInvincibleModeOn.isAcceptableOrUnknown(
              data['is_invincible_mode_on']!, _isInvincibleModeOnMeta));
    } else if (isInserting) {
      context.missing(_isInvincibleModeOnMeta);
    }
    if (data.containsKey('data_reset_time_mins')) {
      context.handle(
          _dataResetTimeMinsMeta,
          dataResetTimeMins.isAcceptableOrUnknown(
              data['data_reset_time_mins']!, _dataResetTimeMinsMeta));
    } else if (isInserting) {
      context.missing(_dataResetTimeMinsMeta);
    }
    if (data.containsKey('use_bottom_navigation')) {
      context.handle(
          _useBottomNavigationMeta,
          useBottomNavigation.isAcceptableOrUnknown(
              data['use_bottom_navigation']!, _useBottomNavigationMeta));
    } else if (isInserting) {
      context.missing(_useBottomNavigationMeta);
    }
    if (data.containsKey('use_amoled_dark')) {
      context.handle(
          _useAmoledDarkMeta,
          useAmoledDark.isAcceptableOrUnknown(
              data['use_amoled_dark']!, _useAmoledDarkMeta));
    } else if (isInserting) {
      context.missing(_useAmoledDarkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MindfulSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MindfulSettings(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      themeMode: $MindfulSettingsTableTable.$converterthemeMode.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}theme_mode'])!),
      accentColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}accent_color'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      localeCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale_code'])!,
      isInvincibleModeOn: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_invincible_mode_on'])!,
      dataResetTimeMins: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}data_reset_time_mins'])!,
      useBottomNavigation: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}use_bottom_navigation'])!,
      useAmoledDark: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}use_amoled_dark'])!,
    );
  }

  @override
  $MindfulSettingsTableTable createAlias(String alias) {
    return $MindfulSettingsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppThemeMode, int, int> $converterthemeMode =
      const EnumIndexConverter<AppThemeMode>(AppThemeMode.values);
}

class MindfulSettings extends DataClass implements Insertable<MindfulSettings> {
  /// Unique ID for app settings
  final int id;

  /// Default theme mode for app
  final AppThemeMode themeMode;

  /// Default material color for app
  final String accentColor;

  /// Username shown on the dashboard
  final String username;

  /// App Locale (Language code)
  final String localeCode;

  /// Is invincible mode on if it is ON then user cannot change following :
  ///
  /// 1. App timer if it is purged
  /// 2. Short content time if it is exhausted
  final bool isInvincibleModeOn;

  /// Daily data usage renew or reset time [TimeOfDay] stored as minutes
  final int dataResetTimeMins;

  /// Flag indicating if to use bottom navigation or the default sidebar
  final bool useBottomNavigation;

  /// Flag indicating if to use pure amoled black color for dark theme
  final bool useAmoledDark;
  const MindfulSettings(
      {required this.id,
      required this.themeMode,
      required this.accentColor,
      required this.username,
      required this.localeCode,
      required this.isInvincibleModeOn,
      required this.dataResetTimeMins,
      required this.useBottomNavigation,
      required this.useAmoledDark});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['theme_mode'] = Variable<int>(
          $MindfulSettingsTableTable.$converterthemeMode.toSql(themeMode));
    }
    map['accent_color'] = Variable<String>(accentColor);
    map['username'] = Variable<String>(username);
    map['locale_code'] = Variable<String>(localeCode);
    map['is_invincible_mode_on'] = Variable<bool>(isInvincibleModeOn);
    map['data_reset_time_mins'] = Variable<int>(dataResetTimeMins);
    map['use_bottom_navigation'] = Variable<bool>(useBottomNavigation);
    map['use_amoled_dark'] = Variable<bool>(useAmoledDark);
    return map;
  }

  MindfulSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return MindfulSettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      accentColor: Value(accentColor),
      username: Value(username),
      localeCode: Value(localeCode),
      isInvincibleModeOn: Value(isInvincibleModeOn),
      dataResetTimeMins: Value(dataResetTimeMins),
      useBottomNavigation: Value(useBottomNavigation),
      useAmoledDark: Value(useAmoledDark),
    );
  }

  factory MindfulSettings.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MindfulSettings(
      id: serializer.fromJson<int>(json['id']),
      themeMode: $MindfulSettingsTableTable.$converterthemeMode
          .fromJson(serializer.fromJson<int>(json['themeMode'])),
      accentColor: serializer.fromJson<String>(json['accentColor']),
      username: serializer.fromJson<String>(json['username']),
      localeCode: serializer.fromJson<String>(json['localeCode']),
      isInvincibleModeOn: serializer.fromJson<bool>(json['isInvincibleModeOn']),
      dataResetTimeMins: serializer.fromJson<int>(json['dataResetTimeMins']),
      useBottomNavigation:
          serializer.fromJson<bool>(json['useBottomNavigation']),
      useAmoledDark: serializer.fromJson<bool>(json['useAmoledDark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<int>(
          $MindfulSettingsTableTable.$converterthemeMode.toJson(themeMode)),
      'accentColor': serializer.toJson<String>(accentColor),
      'username': serializer.toJson<String>(username),
      'localeCode': serializer.toJson<String>(localeCode),
      'isInvincibleModeOn': serializer.toJson<bool>(isInvincibleModeOn),
      'dataResetTimeMins': serializer.toJson<int>(dataResetTimeMins),
      'useBottomNavigation': serializer.toJson<bool>(useBottomNavigation),
      'useAmoledDark': serializer.toJson<bool>(useAmoledDark),
    };
  }

  MindfulSettings copyWith(
          {int? id,
          AppThemeMode? themeMode,
          String? accentColor,
          String? username,
          String? localeCode,
          bool? isInvincibleModeOn,
          int? dataResetTimeMins,
          bool? useBottomNavigation,
          bool? useAmoledDark}) =>
      MindfulSettings(
        id: id ?? this.id,
        themeMode: themeMode ?? this.themeMode,
        accentColor: accentColor ?? this.accentColor,
        username: username ?? this.username,
        localeCode: localeCode ?? this.localeCode,
        isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
        dataResetTimeMins: dataResetTimeMins ?? this.dataResetTimeMins,
        useBottomNavigation: useBottomNavigation ?? this.useBottomNavigation,
        useAmoledDark: useAmoledDark ?? this.useAmoledDark,
      );
  @override
  String toString() {
    return (StringBuffer('MindfulSettings(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentColor: $accentColor, ')
          ..write('username: $username, ')
          ..write('localeCode: $localeCode, ')
          ..write('isInvincibleModeOn: $isInvincibleModeOn, ')
          ..write('dataResetTimeMins: $dataResetTimeMins, ')
          ..write('useBottomNavigation: $useBottomNavigation, ')
          ..write('useAmoledDark: $useAmoledDark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      themeMode,
      accentColor,
      username,
      localeCode,
      isInvincibleModeOn,
      dataResetTimeMins,
      useBottomNavigation,
      useAmoledDark);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MindfulSettings &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.accentColor == this.accentColor &&
          other.username == this.username &&
          other.localeCode == this.localeCode &&
          other.isInvincibleModeOn == this.isInvincibleModeOn &&
          other.dataResetTimeMins == this.dataResetTimeMins &&
          other.useBottomNavigation == this.useBottomNavigation &&
          other.useAmoledDark == this.useAmoledDark);
}

class MindfulSettingsTableCompanion extends UpdateCompanion<MindfulSettings> {
  final Value<int> id;
  final Value<AppThemeMode> themeMode;
  final Value<String> accentColor;
  final Value<String> username;
  final Value<String> localeCode;
  final Value<bool> isInvincibleModeOn;
  final Value<int> dataResetTimeMins;
  final Value<bool> useBottomNavigation;
  final Value<bool> useAmoledDark;
  const MindfulSettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.username = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.isInvincibleModeOn = const Value.absent(),
    this.dataResetTimeMins = const Value.absent(),
    this.useBottomNavigation = const Value.absent(),
    this.useAmoledDark = const Value.absent(),
  });
  MindfulSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required AppThemeMode themeMode,
    required String accentColor,
    required String username,
    required String localeCode,
    required bool isInvincibleModeOn,
    required int dataResetTimeMins,
    required bool useBottomNavigation,
    required bool useAmoledDark,
  })  : themeMode = Value(themeMode),
        accentColor = Value(accentColor),
        username = Value(username),
        localeCode = Value(localeCode),
        isInvincibleModeOn = Value(isInvincibleModeOn),
        dataResetTimeMins = Value(dataResetTimeMins),
        useBottomNavigation = Value(useBottomNavigation),
        useAmoledDark = Value(useAmoledDark);
  static Insertable<MindfulSettings> custom({
    Expression<int>? id,
    Expression<int>? themeMode,
    Expression<String>? accentColor,
    Expression<String>? username,
    Expression<String>? localeCode,
    Expression<bool>? isInvincibleModeOn,
    Expression<int>? dataResetTimeMins,
    Expression<bool>? useBottomNavigation,
    Expression<bool>? useAmoledDark,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (accentColor != null) 'accent_color': accentColor,
      if (username != null) 'username': username,
      if (localeCode != null) 'locale_code': localeCode,
      if (isInvincibleModeOn != null)
        'is_invincible_mode_on': isInvincibleModeOn,
      if (dataResetTimeMins != null) 'data_reset_time_mins': dataResetTimeMins,
      if (useBottomNavigation != null)
        'use_bottom_navigation': useBottomNavigation,
      if (useAmoledDark != null) 'use_amoled_dark': useAmoledDark,
    });
  }

  MindfulSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<AppThemeMode>? themeMode,
      Value<String>? accentColor,
      Value<String>? username,
      Value<String>? localeCode,
      Value<bool>? isInvincibleModeOn,
      Value<int>? dataResetTimeMins,
      Value<bool>? useBottomNavigation,
      Value<bool>? useAmoledDark}) {
    return MindfulSettingsTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      username: username ?? this.username,
      localeCode: localeCode ?? this.localeCode,
      isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
      dataResetTimeMins: dataResetTimeMins ?? this.dataResetTimeMins,
      useBottomNavigation: useBottomNavigation ?? this.useBottomNavigation,
      useAmoledDark: useAmoledDark ?? this.useAmoledDark,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<int>($MindfulSettingsTableTable
          .$converterthemeMode
          .toSql(themeMode.value));
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<String>(accentColor.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (localeCode.present) {
      map['locale_code'] = Variable<String>(localeCode.value);
    }
    if (isInvincibleModeOn.present) {
      map['is_invincible_mode_on'] = Variable<bool>(isInvincibleModeOn.value);
    }
    if (dataResetTimeMins.present) {
      map['data_reset_time_mins'] = Variable<int>(dataResetTimeMins.value);
    }
    if (useBottomNavigation.present) {
      map['use_bottom_navigation'] = Variable<bool>(useBottomNavigation.value);
    }
    if (useAmoledDark.present) {
      map['use_amoled_dark'] = Variable<bool>(useAmoledDark.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MindfulSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentColor: $accentColor, ')
          ..write('username: $username, ')
          ..write('localeCode: $localeCode, ')
          ..write('isInvincibleModeOn: $isInvincibleModeOn, ')
          ..write('dataResetTimeMins: $dataResetTimeMins, ')
          ..write('useBottomNavigation: $useBottomNavigation, ')
          ..write('useAmoledDark: $useAmoledDark')
          ..write(')'))
        .toString();
  }
}

class $RestrictionGroupsTableTable extends RestrictionGroupsTable
    with TableInfo<$RestrictionGroupsTableTable, RestrictionGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestrictionGroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timerSecMeta =
      const VerificationMeta('timerSec');
  @override
  late final GeneratedColumn<int> timerSec = GeneratedColumn<int>(
      'timer_sec', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _distractingAppsMeta =
      const VerificationMeta('distractingApps');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      distractingApps = GeneratedColumn<String>(
              'distracting_apps', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $RestrictionGroupsTableTable.$converterdistractingApps);
  @override
  List<GeneratedColumn> get $columns =>
      [id, groupName, timerSec, distractingApps];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restriction_groups_table';
  @override
  VerificationContext validateIntegrity(Insertable<RestrictionGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('timer_sec')) {
      context.handle(_timerSecMeta,
          timerSec.isAcceptableOrUnknown(data['timer_sec']!, _timerSecMeta));
    } else if (isInserting) {
      context.missing(_timerSecMeta);
    }
    context.handle(_distractingAppsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestrictionGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestrictionGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      timerSec: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timer_sec'])!,
      distractingApps: $RestrictionGroupsTableTable.$converterdistractingApps
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}distracting_apps'])!),
    );
  }

  @override
  $RestrictionGroupsTableTable createAlias(String alias) {
    return $RestrictionGroupsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterdistractingApps =
      const ListStringConverter();
}

class RestrictionGroup extends DataClass
    implements Insertable<RestrictionGroup> {
  /// Unique ID for each restriction group
  final int id;

  /// Name of the group
  final String groupName;

  /// The timer set for the group in SECONDS
  final int timerSec;

  /// List of app's packages which are associated with the group.
  final List<String> distractingApps;
  const RestrictionGroup(
      {required this.id,
      required this.groupName,
      required this.timerSec,
      required this.distractingApps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_name'] = Variable<String>(groupName);
    map['timer_sec'] = Variable<int>(timerSec);
    {
      map['distracting_apps'] = Variable<String>($RestrictionGroupsTableTable
          .$converterdistractingApps
          .toSql(distractingApps));
    }
    return map;
  }

  RestrictionGroupsTableCompanion toCompanion(bool nullToAbsent) {
    return RestrictionGroupsTableCompanion(
      id: Value(id),
      groupName: Value(groupName),
      timerSec: Value(timerSec),
      distractingApps: Value(distractingApps),
    );
  }

  factory RestrictionGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestrictionGroup(
      id: serializer.fromJson<int>(json['id']),
      groupName: serializer.fromJson<String>(json['groupName']),
      timerSec: serializer.fromJson<int>(json['timerSec']),
      distractingApps:
          serializer.fromJson<List<String>>(json['distractingApps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupName': serializer.toJson<String>(groupName),
      'timerSec': serializer.toJson<int>(timerSec),
      'distractingApps': serializer.toJson<List<String>>(distractingApps),
    };
  }

  RestrictionGroup copyWith(
          {int? id,
          String? groupName,
          int? timerSec,
          List<String>? distractingApps}) =>
      RestrictionGroup(
        id: id ?? this.id,
        groupName: groupName ?? this.groupName,
        timerSec: timerSec ?? this.timerSec,
        distractingApps: distractingApps ?? this.distractingApps,
      );
  @override
  String toString() {
    return (StringBuffer('RestrictionGroup(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('timerSec: $timerSec, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupName, timerSec, distractingApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestrictionGroup &&
          other.id == this.id &&
          other.groupName == this.groupName &&
          other.timerSec == this.timerSec &&
          other.distractingApps == this.distractingApps);
}

class RestrictionGroupsTableCompanion
    extends UpdateCompanion<RestrictionGroup> {
  final Value<int> id;
  final Value<String> groupName;
  final Value<int> timerSec;
  final Value<List<String>> distractingApps;
  const RestrictionGroupsTableCompanion({
    this.id = const Value.absent(),
    this.groupName = const Value.absent(),
    this.timerSec = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  RestrictionGroupsTableCompanion.insert({
    this.id = const Value.absent(),
    required String groupName,
    required int timerSec,
    required List<String> distractingApps,
  })  : groupName = Value(groupName),
        timerSec = Value(timerSec),
        distractingApps = Value(distractingApps);
  static Insertable<RestrictionGroup> custom({
    Expression<int>? id,
    Expression<String>? groupName,
    Expression<int>? timerSec,
    Expression<String>? distractingApps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupName != null) 'group_name': groupName,
      if (timerSec != null) 'timer_sec': timerSec,
      if (distractingApps != null) 'distracting_apps': distractingApps,
    });
  }

  RestrictionGroupsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? groupName,
      Value<int>? timerSec,
      Value<List<String>>? distractingApps}) {
    return RestrictionGroupsTableCompanion(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      timerSec: timerSec ?? this.timerSec,
      distractingApps: distractingApps ?? this.distractingApps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (timerSec.present) {
      map['timer_sec'] = Variable<int>(timerSec.value);
    }
    if (distractingApps.present) {
      map['distracting_apps'] = Variable<String>($RestrictionGroupsTableTable
          .$converterdistractingApps
          .toSql(distractingApps.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestrictionGroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('timerSec: $timerSec, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }
}

class $WellbeingTableTable extends WellbeingTable
    with TableInfo<$WellbeingTableTable, Wellbeing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WellbeingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _allowedShortsTimeSecMeta =
      const VerificationMeta('allowedShortsTimeSec');
  @override
  late final GeneratedColumn<int> allowedShortsTimeSec = GeneratedColumn<int>(
      'allowed_shorts_time_sec', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _blockInstaReelsMeta =
      const VerificationMeta('blockInstaReels');
  @override
  late final GeneratedColumn<bool> blockInstaReels = GeneratedColumn<bool>(
      'block_insta_reels', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_insta_reels" IN (0, 1))'));
  static const VerificationMeta _blockYtShortsMeta =
      const VerificationMeta('blockYtShorts');
  @override
  late final GeneratedColumn<bool> blockYtShorts = GeneratedColumn<bool>(
      'block_yt_shorts', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_yt_shorts" IN (0, 1))'));
  static const VerificationMeta _blockSnapSpotlightMeta =
      const VerificationMeta('blockSnapSpotlight');
  @override
  late final GeneratedColumn<bool> blockSnapSpotlight = GeneratedColumn<bool>(
      'block_snap_spotlight', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_snap_spotlight" IN (0, 1))'));
  static const VerificationMeta _blockFbReelsMeta =
      const VerificationMeta('blockFbReels');
  @override
  late final GeneratedColumn<bool> blockFbReels = GeneratedColumn<bool>(
      'block_fb_reels', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_fb_reels" IN (0, 1))'));
  static const VerificationMeta _blockRedditShortsMeta =
      const VerificationMeta('blockRedditShorts');
  @override
  late final GeneratedColumn<bool> blockRedditShorts = GeneratedColumn<bool>(
      'block_reddit_shorts', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_reddit_shorts" IN (0, 1))'));
  static const VerificationMeta _blockNsfwSitesMeta =
      const VerificationMeta('blockNsfwSites');
  @override
  late final GeneratedColumn<bool> blockNsfwSites = GeneratedColumn<bool>(
      'block_nsfw_sites', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_nsfw_sites" IN (0, 1))'));
  static const VerificationMeta _distractingSitesMeta =
      const VerificationMeta('distractingSites');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      distractingSites = GeneratedColumn<String>(
              'distracting_sites', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $WellbeingTableTable.$converterdistractingSites);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        allowedShortsTimeSec,
        blockInstaReels,
        blockYtShorts,
        blockSnapSpotlight,
        blockFbReels,
        blockRedditShorts,
        blockNsfwSites,
        distractingSites
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wellbeing_table';
  @override
  VerificationContext validateIntegrity(Insertable<Wellbeing> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('allowed_shorts_time_sec')) {
      context.handle(
          _allowedShortsTimeSecMeta,
          allowedShortsTimeSec.isAcceptableOrUnknown(
              data['allowed_shorts_time_sec']!, _allowedShortsTimeSecMeta));
    } else if (isInserting) {
      context.missing(_allowedShortsTimeSecMeta);
    }
    if (data.containsKey('block_insta_reels')) {
      context.handle(
          _blockInstaReelsMeta,
          blockInstaReels.isAcceptableOrUnknown(
              data['block_insta_reels']!, _blockInstaReelsMeta));
    } else if (isInserting) {
      context.missing(_blockInstaReelsMeta);
    }
    if (data.containsKey('block_yt_shorts')) {
      context.handle(
          _blockYtShortsMeta,
          blockYtShorts.isAcceptableOrUnknown(
              data['block_yt_shorts']!, _blockYtShortsMeta));
    } else if (isInserting) {
      context.missing(_blockYtShortsMeta);
    }
    if (data.containsKey('block_snap_spotlight')) {
      context.handle(
          _blockSnapSpotlightMeta,
          blockSnapSpotlight.isAcceptableOrUnknown(
              data['block_snap_spotlight']!, _blockSnapSpotlightMeta));
    } else if (isInserting) {
      context.missing(_blockSnapSpotlightMeta);
    }
    if (data.containsKey('block_fb_reels')) {
      context.handle(
          _blockFbReelsMeta,
          blockFbReels.isAcceptableOrUnknown(
              data['block_fb_reels']!, _blockFbReelsMeta));
    } else if (isInserting) {
      context.missing(_blockFbReelsMeta);
    }
    if (data.containsKey('block_reddit_shorts')) {
      context.handle(
          _blockRedditShortsMeta,
          blockRedditShorts.isAcceptableOrUnknown(
              data['block_reddit_shorts']!, _blockRedditShortsMeta));
    } else if (isInserting) {
      context.missing(_blockRedditShortsMeta);
    }
    if (data.containsKey('block_nsfw_sites')) {
      context.handle(
          _blockNsfwSitesMeta,
          blockNsfwSites.isAcceptableOrUnknown(
              data['block_nsfw_sites']!, _blockNsfwSitesMeta));
    } else if (isInserting) {
      context.missing(_blockNsfwSitesMeta);
    }
    context.handle(_distractingSitesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wellbeing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wellbeing(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      allowedShortsTimeSec: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}allowed_shorts_time_sec'])!,
      blockInstaReels: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}block_insta_reels'])!,
      blockYtShorts: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}block_yt_shorts'])!,
      blockSnapSpotlight: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}block_snap_spotlight'])!,
      blockFbReels: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}block_fb_reels'])!,
      blockRedditShorts: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}block_reddit_shorts'])!,
      blockNsfwSites: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}block_nsfw_sites'])!,
      distractingSites: $WellbeingTableTable.$converterdistractingSites.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}distracting_sites'])!),
    );
  }

  @override
  $WellbeingTableTable createAlias(String alias) {
    return $WellbeingTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterdistractingSites =
      const ListStringConverter();
}

class Wellbeing extends DataClass implements Insertable<Wellbeing> {
  /// Unique ID for wellbeing
  final int id;

  /// Allowed time for short content in SECONDS
  final int allowedShortsTimeSec;

  /// Flag denoting if to block instagram reels or not
  final bool blockInstaReels;

  /// Flag denoting if to block youtube shorts or not
  final bool blockYtShorts;

  /// Flag denoting if to block snapchat spotlight or not
  final bool blockSnapSpotlight;

  /// Flag denoting if to block facebook reels or not
  final bool blockFbReels;

  /// Flag denoting if to block reddit shorts or not
  final bool blockRedditShorts;

  /// Flag denoting if the nsfw or adult  websites are blocked or not
  /// i.e if accessibility service is filtering websites or not
  final bool blockNsfwSites;

  /// List of website hosts which are blocked.
  final List<String> distractingSites;
  const Wellbeing(
      {required this.id,
      required this.allowedShortsTimeSec,
      required this.blockInstaReels,
      required this.blockYtShorts,
      required this.blockSnapSpotlight,
      required this.blockFbReels,
      required this.blockRedditShorts,
      required this.blockNsfwSites,
      required this.distractingSites});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['allowed_shorts_time_sec'] = Variable<int>(allowedShortsTimeSec);
    map['block_insta_reels'] = Variable<bool>(blockInstaReels);
    map['block_yt_shorts'] = Variable<bool>(blockYtShorts);
    map['block_snap_spotlight'] = Variable<bool>(blockSnapSpotlight);
    map['block_fb_reels'] = Variable<bool>(blockFbReels);
    map['block_reddit_shorts'] = Variable<bool>(blockRedditShorts);
    map['block_nsfw_sites'] = Variable<bool>(blockNsfwSites);
    {
      map['distracting_sites'] = Variable<String>($WellbeingTableTable
          .$converterdistractingSites
          .toSql(distractingSites));
    }
    return map;
  }

  WellbeingTableCompanion toCompanion(bool nullToAbsent) {
    return WellbeingTableCompanion(
      id: Value(id),
      allowedShortsTimeSec: Value(allowedShortsTimeSec),
      blockInstaReels: Value(blockInstaReels),
      blockYtShorts: Value(blockYtShorts),
      blockSnapSpotlight: Value(blockSnapSpotlight),
      blockFbReels: Value(blockFbReels),
      blockRedditShorts: Value(blockRedditShorts),
      blockNsfwSites: Value(blockNsfwSites),
      distractingSites: Value(distractingSites),
    );
  }

  factory Wellbeing.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wellbeing(
      id: serializer.fromJson<int>(json['id']),
      allowedShortsTimeSec:
          serializer.fromJson<int>(json['allowedShortsTimeSec']),
      blockInstaReels: serializer.fromJson<bool>(json['blockInstaReels']),
      blockYtShorts: serializer.fromJson<bool>(json['blockYtShorts']),
      blockSnapSpotlight: serializer.fromJson<bool>(json['blockSnapSpotlight']),
      blockFbReels: serializer.fromJson<bool>(json['blockFbReels']),
      blockRedditShorts: serializer.fromJson<bool>(json['blockRedditShorts']),
      blockNsfwSites: serializer.fromJson<bool>(json['blockNsfwSites']),
      distractingSites:
          serializer.fromJson<List<String>>(json['distractingSites']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'allowedShortsTimeSec': serializer.toJson<int>(allowedShortsTimeSec),
      'blockInstaReels': serializer.toJson<bool>(blockInstaReels),
      'blockYtShorts': serializer.toJson<bool>(blockYtShorts),
      'blockSnapSpotlight': serializer.toJson<bool>(blockSnapSpotlight),
      'blockFbReels': serializer.toJson<bool>(blockFbReels),
      'blockRedditShorts': serializer.toJson<bool>(blockRedditShorts),
      'blockNsfwSites': serializer.toJson<bool>(blockNsfwSites),
      'distractingSites': serializer.toJson<List<String>>(distractingSites),
    };
  }

  Wellbeing copyWith(
          {int? id,
          int? allowedShortsTimeSec,
          bool? blockInstaReels,
          bool? blockYtShorts,
          bool? blockSnapSpotlight,
          bool? blockFbReels,
          bool? blockRedditShorts,
          bool? blockNsfwSites,
          List<String>? distractingSites}) =>
      Wellbeing(
        id: id ?? this.id,
        allowedShortsTimeSec: allowedShortsTimeSec ?? this.allowedShortsTimeSec,
        blockInstaReels: blockInstaReels ?? this.blockInstaReels,
        blockYtShorts: blockYtShorts ?? this.blockYtShorts,
        blockSnapSpotlight: blockSnapSpotlight ?? this.blockSnapSpotlight,
        blockFbReels: blockFbReels ?? this.blockFbReels,
        blockRedditShorts: blockRedditShorts ?? this.blockRedditShorts,
        blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
        distractingSites: distractingSites ?? this.distractingSites,
      );
  @override
  String toString() {
    return (StringBuffer('Wellbeing(')
          ..write('id: $id, ')
          ..write('allowedShortsTimeSec: $allowedShortsTimeSec, ')
          ..write('blockInstaReels: $blockInstaReels, ')
          ..write('blockYtShorts: $blockYtShorts, ')
          ..write('blockSnapSpotlight: $blockSnapSpotlight, ')
          ..write('blockFbReels: $blockFbReels, ')
          ..write('blockRedditShorts: $blockRedditShorts, ')
          ..write('blockNsfwSites: $blockNsfwSites, ')
          ..write('distractingSites: $distractingSites')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      allowedShortsTimeSec,
      blockInstaReels,
      blockYtShorts,
      blockSnapSpotlight,
      blockFbReels,
      blockRedditShorts,
      blockNsfwSites,
      distractingSites);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wellbeing &&
          other.id == this.id &&
          other.allowedShortsTimeSec == this.allowedShortsTimeSec &&
          other.blockInstaReels == this.blockInstaReels &&
          other.blockYtShorts == this.blockYtShorts &&
          other.blockSnapSpotlight == this.blockSnapSpotlight &&
          other.blockFbReels == this.blockFbReels &&
          other.blockRedditShorts == this.blockRedditShorts &&
          other.blockNsfwSites == this.blockNsfwSites &&
          other.distractingSites == this.distractingSites);
}

class WellbeingTableCompanion extends UpdateCompanion<Wellbeing> {
  final Value<int> id;
  final Value<int> allowedShortsTimeSec;
  final Value<bool> blockInstaReels;
  final Value<bool> blockYtShorts;
  final Value<bool> blockSnapSpotlight;
  final Value<bool> blockFbReels;
  final Value<bool> blockRedditShorts;
  final Value<bool> blockNsfwSites;
  final Value<List<String>> distractingSites;
  const WellbeingTableCompanion({
    this.id = const Value.absent(),
    this.allowedShortsTimeSec = const Value.absent(),
    this.blockInstaReels = const Value.absent(),
    this.blockYtShorts = const Value.absent(),
    this.blockSnapSpotlight = const Value.absent(),
    this.blockFbReels = const Value.absent(),
    this.blockRedditShorts = const Value.absent(),
    this.blockNsfwSites = const Value.absent(),
    this.distractingSites = const Value.absent(),
  });
  WellbeingTableCompanion.insert({
    this.id = const Value.absent(),
    required int allowedShortsTimeSec,
    required bool blockInstaReels,
    required bool blockYtShorts,
    required bool blockSnapSpotlight,
    required bool blockFbReels,
    required bool blockRedditShorts,
    required bool blockNsfwSites,
    required List<String> distractingSites,
  })  : allowedShortsTimeSec = Value(allowedShortsTimeSec),
        blockInstaReels = Value(blockInstaReels),
        blockYtShorts = Value(blockYtShorts),
        blockSnapSpotlight = Value(blockSnapSpotlight),
        blockFbReels = Value(blockFbReels),
        blockRedditShorts = Value(blockRedditShorts),
        blockNsfwSites = Value(blockNsfwSites),
        distractingSites = Value(distractingSites);
  static Insertable<Wellbeing> custom({
    Expression<int>? id,
    Expression<int>? allowedShortsTimeSec,
    Expression<bool>? blockInstaReels,
    Expression<bool>? blockYtShorts,
    Expression<bool>? blockSnapSpotlight,
    Expression<bool>? blockFbReels,
    Expression<bool>? blockRedditShorts,
    Expression<bool>? blockNsfwSites,
    Expression<String>? distractingSites,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (allowedShortsTimeSec != null)
        'allowed_shorts_time_sec': allowedShortsTimeSec,
      if (blockInstaReels != null) 'block_insta_reels': blockInstaReels,
      if (blockYtShorts != null) 'block_yt_shorts': blockYtShorts,
      if (blockSnapSpotlight != null)
        'block_snap_spotlight': blockSnapSpotlight,
      if (blockFbReels != null) 'block_fb_reels': blockFbReels,
      if (blockRedditShorts != null) 'block_reddit_shorts': blockRedditShorts,
      if (blockNsfwSites != null) 'block_nsfw_sites': blockNsfwSites,
      if (distractingSites != null) 'distracting_sites': distractingSites,
    });
  }

  WellbeingTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? allowedShortsTimeSec,
      Value<bool>? blockInstaReels,
      Value<bool>? blockYtShorts,
      Value<bool>? blockSnapSpotlight,
      Value<bool>? blockFbReels,
      Value<bool>? blockRedditShorts,
      Value<bool>? blockNsfwSites,
      Value<List<String>>? distractingSites}) {
    return WellbeingTableCompanion(
      id: id ?? this.id,
      allowedShortsTimeSec: allowedShortsTimeSec ?? this.allowedShortsTimeSec,
      blockInstaReels: blockInstaReels ?? this.blockInstaReels,
      blockYtShorts: blockYtShorts ?? this.blockYtShorts,
      blockSnapSpotlight: blockSnapSpotlight ?? this.blockSnapSpotlight,
      blockFbReels: blockFbReels ?? this.blockFbReels,
      blockRedditShorts: blockRedditShorts ?? this.blockRedditShorts,
      blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
      distractingSites: distractingSites ?? this.distractingSites,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (allowedShortsTimeSec.present) {
      map['allowed_shorts_time_sec'] =
          Variable<int>(allowedShortsTimeSec.value);
    }
    if (blockInstaReels.present) {
      map['block_insta_reels'] = Variable<bool>(blockInstaReels.value);
    }
    if (blockYtShorts.present) {
      map['block_yt_shorts'] = Variable<bool>(blockYtShorts.value);
    }
    if (blockSnapSpotlight.present) {
      map['block_snap_spotlight'] = Variable<bool>(blockSnapSpotlight.value);
    }
    if (blockFbReels.present) {
      map['block_fb_reels'] = Variable<bool>(blockFbReels.value);
    }
    if (blockRedditShorts.present) {
      map['block_reddit_shorts'] = Variable<bool>(blockRedditShorts.value);
    }
    if (blockNsfwSites.present) {
      map['block_nsfw_sites'] = Variable<bool>(blockNsfwSites.value);
    }
    if (distractingSites.present) {
      map['distracting_sites'] = Variable<String>($WellbeingTableTable
          .$converterdistractingSites
          .toSql(distractingSites.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WellbeingTableCompanion(')
          ..write('id: $id, ')
          ..write('allowedShortsTimeSec: $allowedShortsTimeSec, ')
          ..write('blockInstaReels: $blockInstaReels, ')
          ..write('blockYtShorts: $blockYtShorts, ')
          ..write('blockSnapSpotlight: $blockSnapSpotlight, ')
          ..write('blockFbReels: $blockFbReels, ')
          ..write('blockRedditShorts: $blockRedditShorts, ')
          ..write('blockNsfwSites: $blockNsfwSites, ')
          ..write('distractingSites: $distractingSites')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $AppRestrictionTableTable appRestrictionTable =
      $AppRestrictionTableTable(this);
  late final $BedtimeScheduleTableTable bedtimeScheduleTable =
      $BedtimeScheduleTableTable(this);
  late final $CrashLogsTableTable crashLogsTable = $CrashLogsTableTable(this);
  late final $FocusModeTableTable focusModeTable = $FocusModeTableTable(this);
  late final $FocusSessionsTableTable focusSessionsTable =
      $FocusSessionsTableTable(this);
  late final $MindfulSettingsTableTable mindfulSettingsTable =
      $MindfulSettingsTableTable(this);
  late final $RestrictionGroupsTableTable restrictionGroupsTable =
      $RestrictionGroupsTableTable(this);
  late final $WellbeingTableTable wellbeingTable = $WellbeingTableTable(this);
  late final UniqueRecordsDao uniqueRecordsDao =
      UniqueRecordsDao(this as AppDatabase);
  late final DynamicRecordsDao dynamicRecordsDao =
      DynamicRecordsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        appRestrictionTable,
        bedtimeScheduleTable,
        crashLogsTable,
        focusModeTable,
        focusSessionsTable,
        mindfulSettingsTable,
        restrictionGroupsTable,
        wellbeingTable
      ];
}

typedef $$AppRestrictionTableTableInsertCompanionBuilder
    = AppRestrictionTableCompanion Function({
  required String appPackage,
  required int timerSec,
  required bool canAccessInternet,
  Value<int?> associatedGroupId,
  Value<int> rowid,
});
typedef $$AppRestrictionTableTableUpdateCompanionBuilder
    = AppRestrictionTableCompanion Function({
  Value<String> appPackage,
  Value<int> timerSec,
  Value<bool> canAccessInternet,
  Value<int?> associatedGroupId,
  Value<int> rowid,
});

class $$AppRestrictionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppRestrictionTableTable,
    AppRestriction,
    $$AppRestrictionTableTableFilterComposer,
    $$AppRestrictionTableTableOrderingComposer,
    $$AppRestrictionTableTableProcessedTableManager,
    $$AppRestrictionTableTableInsertCompanionBuilder,
    $$AppRestrictionTableTableUpdateCompanionBuilder> {
  $$AppRestrictionTableTableTableManager(
      _$AppDatabase db, $AppRestrictionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$AppRestrictionTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$AppRestrictionTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AppRestrictionTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> appPackage = const Value.absent(),
            Value<int> timerSec = const Value.absent(),
            Value<bool> canAccessInternet = const Value.absent(),
            Value<int?> associatedGroupId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppRestrictionTableCompanion(
            appPackage: appPackage,
            timerSec: timerSec,
            canAccessInternet: canAccessInternet,
            associatedGroupId: associatedGroupId,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String appPackage,
            required int timerSec,
            required bool canAccessInternet,
            Value<int?> associatedGroupId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppRestrictionTableCompanion.insert(
            appPackage: appPackage,
            timerSec: timerSec,
            canAccessInternet: canAccessInternet,
            associatedGroupId: associatedGroupId,
            rowid: rowid,
          ),
        ));
}

class $$AppRestrictionTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $AppRestrictionTableTable,
        AppRestriction,
        $$AppRestrictionTableTableFilterComposer,
        $$AppRestrictionTableTableOrderingComposer,
        $$AppRestrictionTableTableProcessedTableManager,
        $$AppRestrictionTableTableInsertCompanionBuilder,
        $$AppRestrictionTableTableUpdateCompanionBuilder> {
  $$AppRestrictionTableTableProcessedTableManager(super.$state);
}

class $$AppRestrictionTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AppRestrictionTableTable> {
  $$AppRestrictionTableTableFilterComposer(super.$state);
  ColumnFilters<String> get appPackage => $state.composableBuilder(
      column: $state.table.appPackage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get timerSec => $state.composableBuilder(
      column: $state.table.timerSec,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get canAccessInternet => $state.composableBuilder(
      column: $state.table.canAccessInternet,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get associatedGroupId => $state.composableBuilder(
      column: $state.table.associatedGroupId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AppRestrictionTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AppRestrictionTableTable> {
  $$AppRestrictionTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get appPackage => $state.composableBuilder(
      column: $state.table.appPackage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get timerSec => $state.composableBuilder(
      column: $state.table.timerSec,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get canAccessInternet => $state.composableBuilder(
      column: $state.table.canAccessInternet,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get associatedGroupId => $state.composableBuilder(
      column: $state.table.associatedGroupId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BedtimeScheduleTableTableInsertCompanionBuilder
    = BedtimeScheduleTableCompanion Function({
  Value<int> id,
  required int startTimeInMins,
  required int endTimeInMins,
  required List<bool> scheduleDays,
  required bool isScheduleOn,
  required bool shouldStartDnd,
  required List<String> distractingApps,
});
typedef $$BedtimeScheduleTableTableUpdateCompanionBuilder
    = BedtimeScheduleTableCompanion Function({
  Value<int> id,
  Value<int> startTimeInMins,
  Value<int> endTimeInMins,
  Value<List<bool>> scheduleDays,
  Value<bool> isScheduleOn,
  Value<bool> shouldStartDnd,
  Value<List<String>> distractingApps,
});

class $$BedtimeScheduleTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BedtimeScheduleTableTable,
    BedtimeSchedule,
    $$BedtimeScheduleTableTableFilterComposer,
    $$BedtimeScheduleTableTableOrderingComposer,
    $$BedtimeScheduleTableTableProcessedTableManager,
    $$BedtimeScheduleTableTableInsertCompanionBuilder,
    $$BedtimeScheduleTableTableUpdateCompanionBuilder> {
  $$BedtimeScheduleTableTableTableManager(
      _$AppDatabase db, $BedtimeScheduleTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$BedtimeScheduleTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$BedtimeScheduleTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$BedtimeScheduleTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> startTimeInMins = const Value.absent(),
            Value<int> endTimeInMins = const Value.absent(),
            Value<List<bool>> scheduleDays = const Value.absent(),
            Value<bool> isScheduleOn = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              BedtimeScheduleTableCompanion(
            id: id,
            startTimeInMins: startTimeInMins,
            endTimeInMins: endTimeInMins,
            scheduleDays: scheduleDays,
            isScheduleOn: isScheduleOn,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int startTimeInMins,
            required int endTimeInMins,
            required List<bool> scheduleDays,
            required bool isScheduleOn,
            required bool shouldStartDnd,
            required List<String> distractingApps,
          }) =>
              BedtimeScheduleTableCompanion.insert(
            id: id,
            startTimeInMins: startTimeInMins,
            endTimeInMins: endTimeInMins,
            scheduleDays: scheduleDays,
            isScheduleOn: isScheduleOn,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
        ));
}

class $$BedtimeScheduleTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $BedtimeScheduleTableTable,
        BedtimeSchedule,
        $$BedtimeScheduleTableTableFilterComposer,
        $$BedtimeScheduleTableTableOrderingComposer,
        $$BedtimeScheduleTableTableProcessedTableManager,
        $$BedtimeScheduleTableTableInsertCompanionBuilder,
        $$BedtimeScheduleTableTableUpdateCompanionBuilder> {
  $$BedtimeScheduleTableTableProcessedTableManager(super.$state);
}

class $$BedtimeScheduleTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BedtimeScheduleTableTable> {
  $$BedtimeScheduleTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get startTimeInMins => $state.composableBuilder(
      column: $state.table.startTimeInMins,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get endTimeInMins => $state.composableBuilder(
      column: $state.table.endTimeInMins,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<bool>, List<bool>, String>
      get scheduleDays => $state.composableBuilder(
          column: $state.table.scheduleDays,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<bool> get isScheduleOn => $state.composableBuilder(
      column: $state.table.isScheduleOn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get shouldStartDnd => $state.composableBuilder(
      column: $state.table.shouldStartDnd,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get distractingApps => $state.composableBuilder(
          column: $state.table.distractingApps,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$BedtimeScheduleTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BedtimeScheduleTableTable> {
  $$BedtimeScheduleTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get startTimeInMins => $state.composableBuilder(
      column: $state.table.startTimeInMins,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get endTimeInMins => $state.composableBuilder(
      column: $state.table.endTimeInMins,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get scheduleDays => $state.composableBuilder(
      column: $state.table.scheduleDays,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isScheduleOn => $state.composableBuilder(
      column: $state.table.isScheduleOn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get shouldStartDnd => $state.composableBuilder(
      column: $state.table.shouldStartDnd,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get distractingApps => $state.composableBuilder(
      column: $state.table.distractingApps,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CrashLogsTableTableInsertCompanionBuilder = CrashLogsTableCompanion
    Function({
  Value<int> id,
  required String appVersion,
  required DateTime timeStamp,
  required String error,
  required String stackTrace,
});
typedef $$CrashLogsTableTableUpdateCompanionBuilder = CrashLogsTableCompanion
    Function({
  Value<int> id,
  Value<String> appVersion,
  Value<DateTime> timeStamp,
  Value<String> error,
  Value<String> stackTrace,
});

class $$CrashLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CrashLogsTableTable,
    CrashLogs,
    $$CrashLogsTableTableFilterComposer,
    $$CrashLogsTableTableOrderingComposer,
    $$CrashLogsTableTableProcessedTableManager,
    $$CrashLogsTableTableInsertCompanionBuilder,
    $$CrashLogsTableTableUpdateCompanionBuilder> {
  $$CrashLogsTableTableTableManager(
      _$AppDatabase db, $CrashLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CrashLogsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CrashLogsTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$CrashLogsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> appVersion = const Value.absent(),
            Value<DateTime> timeStamp = const Value.absent(),
            Value<String> error = const Value.absent(),
            Value<String> stackTrace = const Value.absent(),
          }) =>
              CrashLogsTableCompanion(
            id: id,
            appVersion: appVersion,
            timeStamp: timeStamp,
            error: error,
            stackTrace: stackTrace,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String appVersion,
            required DateTime timeStamp,
            required String error,
            required String stackTrace,
          }) =>
              CrashLogsTableCompanion.insert(
            id: id,
            appVersion: appVersion,
            timeStamp: timeStamp,
            error: error,
            stackTrace: stackTrace,
          ),
        ));
}

class $$CrashLogsTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $CrashLogsTableTable,
    CrashLogs,
    $$CrashLogsTableTableFilterComposer,
    $$CrashLogsTableTableOrderingComposer,
    $$CrashLogsTableTableProcessedTableManager,
    $$CrashLogsTableTableInsertCompanionBuilder,
    $$CrashLogsTableTableUpdateCompanionBuilder> {
  $$CrashLogsTableTableProcessedTableManager(super.$state);
}

class $$CrashLogsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CrashLogsTableTable> {
  $$CrashLogsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get appVersion => $state.composableBuilder(
      column: $state.table.appVersion,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get timeStamp => $state.composableBuilder(
      column: $state.table.timeStamp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get stackTrace => $state.composableBuilder(
      column: $state.table.stackTrace,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CrashLogsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CrashLogsTableTable> {
  $$CrashLogsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get appVersion => $state.composableBuilder(
      column: $state.table.appVersion,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get timeStamp => $state.composableBuilder(
      column: $state.table.timeStamp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get error => $state.composableBuilder(
      column: $state.table.error,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get stackTrace => $state.composableBuilder(
      column: $state.table.stackTrace,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$FocusModeTableTableInsertCompanionBuilder = FocusModeTableCompanion
    Function({
  Value<int> id,
  required SessionType sessionType,
  required bool shouldStartDnd,
  required List<String> distractingApps,
  required int longestStreak,
  required int currentStreak,
  required DateTime lastTimeStreakUpdated,
  Value<int?> activeSessionId,
});
typedef $$FocusModeTableTableUpdateCompanionBuilder = FocusModeTableCompanion
    Function({
  Value<int> id,
  Value<SessionType> sessionType,
  Value<bool> shouldStartDnd,
  Value<List<String>> distractingApps,
  Value<int> longestStreak,
  Value<int> currentStreak,
  Value<DateTime> lastTimeStreakUpdated,
  Value<int?> activeSessionId,
});

class $$FocusModeTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusModeTableTable,
    FocusMode,
    $$FocusModeTableTableFilterComposer,
    $$FocusModeTableTableOrderingComposer,
    $$FocusModeTableTableProcessedTableManager,
    $$FocusModeTableTableInsertCompanionBuilder,
    $$FocusModeTableTableUpdateCompanionBuilder> {
  $$FocusModeTableTableTableManager(
      _$AppDatabase db, $FocusModeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FocusModeTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$FocusModeTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$FocusModeTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<SessionType> sessionType = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<DateTime> lastTimeStreakUpdated = const Value.absent(),
            Value<int?> activeSessionId = const Value.absent(),
          }) =>
              FocusModeTableCompanion(
            id: id,
            sessionType: sessionType,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
            longestStreak: longestStreak,
            currentStreak: currentStreak,
            lastTimeStreakUpdated: lastTimeStreakUpdated,
            activeSessionId: activeSessionId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required SessionType sessionType,
            required bool shouldStartDnd,
            required List<String> distractingApps,
            required int longestStreak,
            required int currentStreak,
            required DateTime lastTimeStreakUpdated,
            Value<int?> activeSessionId = const Value.absent(),
          }) =>
              FocusModeTableCompanion.insert(
            id: id,
            sessionType: sessionType,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
            longestStreak: longestStreak,
            currentStreak: currentStreak,
            lastTimeStreakUpdated: lastTimeStreakUpdated,
            activeSessionId: activeSessionId,
          ),
        ));
}

class $$FocusModeTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $FocusModeTableTable,
    FocusMode,
    $$FocusModeTableTableFilterComposer,
    $$FocusModeTableTableOrderingComposer,
    $$FocusModeTableTableProcessedTableManager,
    $$FocusModeTableTableInsertCompanionBuilder,
    $$FocusModeTableTableUpdateCompanionBuilder> {
  $$FocusModeTableTableProcessedTableManager(super.$state);
}

class $$FocusModeTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FocusModeTableTable> {
  $$FocusModeTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<SessionType, SessionType, int>
      get sessionType => $state.composableBuilder(
          column: $state.table.sessionType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<bool> get shouldStartDnd => $state.composableBuilder(
      column: $state.table.shouldStartDnd,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get distractingApps => $state.composableBuilder(
          column: $state.table.distractingApps,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<int> get longestStreak => $state.composableBuilder(
      column: $state.table.longestStreak,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentStreak => $state.composableBuilder(
      column: $state.table.currentStreak,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastTimeStreakUpdated => $state.composableBuilder(
      column: $state.table.lastTimeStreakUpdated,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get activeSessionId => $state.composableBuilder(
      column: $state.table.activeSessionId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FocusModeTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FocusModeTableTable> {
  $$FocusModeTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sessionType => $state.composableBuilder(
      column: $state.table.sessionType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get shouldStartDnd => $state.composableBuilder(
      column: $state.table.shouldStartDnd,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get distractingApps => $state.composableBuilder(
      column: $state.table.distractingApps,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get longestStreak => $state.composableBuilder(
      column: $state.table.longestStreak,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentStreak => $state.composableBuilder(
      column: $state.table.currentStreak,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastTimeStreakUpdated =>
      $state.composableBuilder(
          column: $state.table.lastTimeStreakUpdated,
          builder: (column, joinBuilders) =>
              ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get activeSessionId => $state.composableBuilder(
      column: $state.table.activeSessionId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$FocusSessionsTableTableInsertCompanionBuilder
    = FocusSessionsTableCompanion Function({
  Value<int> id,
  required SessionType type,
  required SessionState state,
  required DateTime startDateTime,
  required int durationSecs,
});
typedef $$FocusSessionsTableTableUpdateCompanionBuilder
    = FocusSessionsTableCompanion Function({
  Value<int> id,
  Value<SessionType> type,
  Value<SessionState> state,
  Value<DateTime> startDateTime,
  Value<int> durationSecs,
});

class $$FocusSessionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusSessionsTableTable,
    FocusSession,
    $$FocusSessionsTableTableFilterComposer,
    $$FocusSessionsTableTableOrderingComposer,
    $$FocusSessionsTableTableProcessedTableManager,
    $$FocusSessionsTableTableInsertCompanionBuilder,
    $$FocusSessionsTableTableUpdateCompanionBuilder> {
  $$FocusSessionsTableTableTableManager(
      _$AppDatabase db, $FocusSessionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FocusSessionsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$FocusSessionsTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$FocusSessionsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<SessionType> type = const Value.absent(),
            Value<SessionState> state = const Value.absent(),
            Value<DateTime> startDateTime = const Value.absent(),
            Value<int> durationSecs = const Value.absent(),
          }) =>
              FocusSessionsTableCompanion(
            id: id,
            type: type,
            state: state,
            startDateTime: startDateTime,
            durationSecs: durationSecs,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required SessionType type,
            required SessionState state,
            required DateTime startDateTime,
            required int durationSecs,
          }) =>
              FocusSessionsTableCompanion.insert(
            id: id,
            type: type,
            state: state,
            startDateTime: startDateTime,
            durationSecs: durationSecs,
          ),
        ));
}

class $$FocusSessionsTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $FocusSessionsTableTable,
        FocusSession,
        $$FocusSessionsTableTableFilterComposer,
        $$FocusSessionsTableTableOrderingComposer,
        $$FocusSessionsTableTableProcessedTableManager,
        $$FocusSessionsTableTableInsertCompanionBuilder,
        $$FocusSessionsTableTableUpdateCompanionBuilder> {
  $$FocusSessionsTableTableProcessedTableManager(super.$state);
}

class $$FocusSessionsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<SessionType, SessionType, int> get type =>
      $state.composableBuilder(
          column: $state.table.type,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<SessionState, SessionState, int> get state =>
      $state.composableBuilder(
          column: $state.table.state,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startDateTime => $state.composableBuilder(
      column: $state.table.startDateTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get durationSecs => $state.composableBuilder(
      column: $state.table.durationSecs,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FocusSessionsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get state => $state.composableBuilder(
      column: $state.table.state,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startDateTime => $state.composableBuilder(
      column: $state.table.startDateTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get durationSecs => $state.composableBuilder(
      column: $state.table.durationSecs,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MindfulSettingsTableTableInsertCompanionBuilder
    = MindfulSettingsTableCompanion Function({
  Value<int> id,
  required AppThemeMode themeMode,
  required String accentColor,
  required String username,
  required String localeCode,
  required bool isInvincibleModeOn,
  required int dataResetTimeMins,
  required bool useBottomNavigation,
  required bool useAmoledDark,
});
typedef $$MindfulSettingsTableTableUpdateCompanionBuilder
    = MindfulSettingsTableCompanion Function({
  Value<int> id,
  Value<AppThemeMode> themeMode,
  Value<String> accentColor,
  Value<String> username,
  Value<String> localeCode,
  Value<bool> isInvincibleModeOn,
  Value<int> dataResetTimeMins,
  Value<bool> useBottomNavigation,
  Value<bool> useAmoledDark,
});

class $$MindfulSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MindfulSettingsTableTable,
    MindfulSettings,
    $$MindfulSettingsTableTableFilterComposer,
    $$MindfulSettingsTableTableOrderingComposer,
    $$MindfulSettingsTableTableProcessedTableManager,
    $$MindfulSettingsTableTableInsertCompanionBuilder,
    $$MindfulSettingsTableTableUpdateCompanionBuilder> {
  $$MindfulSettingsTableTableTableManager(
      _$AppDatabase db, $MindfulSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$MindfulSettingsTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$MindfulSettingsTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$MindfulSettingsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<AppThemeMode> themeMode = const Value.absent(),
            Value<String> accentColor = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> localeCode = const Value.absent(),
            Value<bool> isInvincibleModeOn = const Value.absent(),
            Value<int> dataResetTimeMins = const Value.absent(),
            Value<bool> useBottomNavigation = const Value.absent(),
            Value<bool> useAmoledDark = const Value.absent(),
          }) =>
              MindfulSettingsTableCompanion(
            id: id,
            themeMode: themeMode,
            accentColor: accentColor,
            username: username,
            localeCode: localeCode,
            isInvincibleModeOn: isInvincibleModeOn,
            dataResetTimeMins: dataResetTimeMins,
            useBottomNavigation: useBottomNavigation,
            useAmoledDark: useAmoledDark,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required AppThemeMode themeMode,
            required String accentColor,
            required String username,
            required String localeCode,
            required bool isInvincibleModeOn,
            required int dataResetTimeMins,
            required bool useBottomNavigation,
            required bool useAmoledDark,
          }) =>
              MindfulSettingsTableCompanion.insert(
            id: id,
            themeMode: themeMode,
            accentColor: accentColor,
            username: username,
            localeCode: localeCode,
            isInvincibleModeOn: isInvincibleModeOn,
            dataResetTimeMins: dataResetTimeMins,
            useBottomNavigation: useBottomNavigation,
            useAmoledDark: useAmoledDark,
          ),
        ));
}

class $$MindfulSettingsTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $MindfulSettingsTableTable,
        MindfulSettings,
        $$MindfulSettingsTableTableFilterComposer,
        $$MindfulSettingsTableTableOrderingComposer,
        $$MindfulSettingsTableTableProcessedTableManager,
        $$MindfulSettingsTableTableInsertCompanionBuilder,
        $$MindfulSettingsTableTableUpdateCompanionBuilder> {
  $$MindfulSettingsTableTableProcessedTableManager(super.$state);
}

class $$MindfulSettingsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MindfulSettingsTableTable> {
  $$MindfulSettingsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<AppThemeMode, AppThemeMode, int>
      get themeMode => $state.composableBuilder(
          column: $state.table.themeMode,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<String> get accentColor => $state.composableBuilder(
      column: $state.table.accentColor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get localeCode => $state.composableBuilder(
      column: $state.table.localeCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isInvincibleModeOn => $state.composableBuilder(
      column: $state.table.isInvincibleModeOn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get dataResetTimeMins => $state.composableBuilder(
      column: $state.table.dataResetTimeMins,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get useBottomNavigation => $state.composableBuilder(
      column: $state.table.useBottomNavigation,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get useAmoledDark => $state.composableBuilder(
      column: $state.table.useAmoledDark,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MindfulSettingsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MindfulSettingsTableTable> {
  $$MindfulSettingsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get themeMode => $state.composableBuilder(
      column: $state.table.themeMode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get accentColor => $state.composableBuilder(
      column: $state.table.accentColor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get localeCode => $state.composableBuilder(
      column: $state.table.localeCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isInvincibleModeOn => $state.composableBuilder(
      column: $state.table.isInvincibleModeOn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get dataResetTimeMins => $state.composableBuilder(
      column: $state.table.dataResetTimeMins,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get useBottomNavigation => $state.composableBuilder(
      column: $state.table.useBottomNavigation,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get useAmoledDark => $state.composableBuilder(
      column: $state.table.useAmoledDark,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$RestrictionGroupsTableTableInsertCompanionBuilder
    = RestrictionGroupsTableCompanion Function({
  Value<int> id,
  required String groupName,
  required int timerSec,
  required List<String> distractingApps,
});
typedef $$RestrictionGroupsTableTableUpdateCompanionBuilder
    = RestrictionGroupsTableCompanion Function({
  Value<int> id,
  Value<String> groupName,
  Value<int> timerSec,
  Value<List<String>> distractingApps,
});

class $$RestrictionGroupsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RestrictionGroupsTableTable,
    RestrictionGroup,
    $$RestrictionGroupsTableTableFilterComposer,
    $$RestrictionGroupsTableTableOrderingComposer,
    $$RestrictionGroupsTableTableProcessedTableManager,
    $$RestrictionGroupsTableTableInsertCompanionBuilder,
    $$RestrictionGroupsTableTableUpdateCompanionBuilder> {
  $$RestrictionGroupsTableTableTableManager(
      _$AppDatabase db, $RestrictionGroupsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$RestrictionGroupsTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$RestrictionGroupsTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$RestrictionGroupsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<int> timerSec = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              RestrictionGroupsTableCompanion(
            id: id,
            groupName: groupName,
            timerSec: timerSec,
            distractingApps: distractingApps,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String groupName,
            required int timerSec,
            required List<String> distractingApps,
          }) =>
              RestrictionGroupsTableCompanion.insert(
            id: id,
            groupName: groupName,
            timerSec: timerSec,
            distractingApps: distractingApps,
          ),
        ));
}

class $$RestrictionGroupsTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $RestrictionGroupsTableTable,
        RestrictionGroup,
        $$RestrictionGroupsTableTableFilterComposer,
        $$RestrictionGroupsTableTableOrderingComposer,
        $$RestrictionGroupsTableTableProcessedTableManager,
        $$RestrictionGroupsTableTableInsertCompanionBuilder,
        $$RestrictionGroupsTableTableUpdateCompanionBuilder> {
  $$RestrictionGroupsTableTableProcessedTableManager(super.$state);
}

class $$RestrictionGroupsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RestrictionGroupsTableTable> {
  $$RestrictionGroupsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get groupName => $state.composableBuilder(
      column: $state.table.groupName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get timerSec => $state.composableBuilder(
      column: $state.table.timerSec,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get distractingApps => $state.composableBuilder(
          column: $state.table.distractingApps,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$RestrictionGroupsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RestrictionGroupsTableTable> {
  $$RestrictionGroupsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get groupName => $state.composableBuilder(
      column: $state.table.groupName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get timerSec => $state.composableBuilder(
      column: $state.table.timerSec,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get distractingApps => $state.composableBuilder(
      column: $state.table.distractingApps,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WellbeingTableTableInsertCompanionBuilder = WellbeingTableCompanion
    Function({
  Value<int> id,
  required int allowedShortsTimeSec,
  required bool blockInstaReels,
  required bool blockYtShorts,
  required bool blockSnapSpotlight,
  required bool blockFbReels,
  required bool blockRedditShorts,
  required bool blockNsfwSites,
  required List<String> distractingSites,
});
typedef $$WellbeingTableTableUpdateCompanionBuilder = WellbeingTableCompanion
    Function({
  Value<int> id,
  Value<int> allowedShortsTimeSec,
  Value<bool> blockInstaReels,
  Value<bool> blockYtShorts,
  Value<bool> blockSnapSpotlight,
  Value<bool> blockFbReels,
  Value<bool> blockRedditShorts,
  Value<bool> blockNsfwSites,
  Value<List<String>> distractingSites,
});

class $$WellbeingTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WellbeingTableTable,
    Wellbeing,
    $$WellbeingTableTableFilterComposer,
    $$WellbeingTableTableOrderingComposer,
    $$WellbeingTableTableProcessedTableManager,
    $$WellbeingTableTableInsertCompanionBuilder,
    $$WellbeingTableTableUpdateCompanionBuilder> {
  $$WellbeingTableTableTableManager(
      _$AppDatabase db, $WellbeingTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WellbeingTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WellbeingTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WellbeingTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> allowedShortsTimeSec = const Value.absent(),
            Value<bool> blockInstaReels = const Value.absent(),
            Value<bool> blockYtShorts = const Value.absent(),
            Value<bool> blockSnapSpotlight = const Value.absent(),
            Value<bool> blockFbReels = const Value.absent(),
            Value<bool> blockRedditShorts = const Value.absent(),
            Value<bool> blockNsfwSites = const Value.absent(),
            Value<List<String>> distractingSites = const Value.absent(),
          }) =>
              WellbeingTableCompanion(
            id: id,
            allowedShortsTimeSec: allowedShortsTimeSec,
            blockInstaReels: blockInstaReels,
            blockYtShorts: blockYtShorts,
            blockSnapSpotlight: blockSnapSpotlight,
            blockFbReels: blockFbReels,
            blockRedditShorts: blockRedditShorts,
            blockNsfwSites: blockNsfwSites,
            distractingSites: distractingSites,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int allowedShortsTimeSec,
            required bool blockInstaReels,
            required bool blockYtShorts,
            required bool blockSnapSpotlight,
            required bool blockFbReels,
            required bool blockRedditShorts,
            required bool blockNsfwSites,
            required List<String> distractingSites,
          }) =>
              WellbeingTableCompanion.insert(
            id: id,
            allowedShortsTimeSec: allowedShortsTimeSec,
            blockInstaReels: blockInstaReels,
            blockYtShorts: blockYtShorts,
            blockSnapSpotlight: blockSnapSpotlight,
            blockFbReels: blockFbReels,
            blockRedditShorts: blockRedditShorts,
            blockNsfwSites: blockNsfwSites,
            distractingSites: distractingSites,
          ),
        ));
}

class $$WellbeingTableTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WellbeingTableTable,
    Wellbeing,
    $$WellbeingTableTableFilterComposer,
    $$WellbeingTableTableOrderingComposer,
    $$WellbeingTableTableProcessedTableManager,
    $$WellbeingTableTableInsertCompanionBuilder,
    $$WellbeingTableTableUpdateCompanionBuilder> {
  $$WellbeingTableTableProcessedTableManager(super.$state);
}

class $$WellbeingTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WellbeingTableTable> {
  $$WellbeingTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get allowedShortsTimeSec => $state.composableBuilder(
      column: $state.table.allowedShortsTimeSec,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get blockInstaReels => $state.composableBuilder(
      column: $state.table.blockInstaReels,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get blockYtShorts => $state.composableBuilder(
      column: $state.table.blockYtShorts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get blockSnapSpotlight => $state.composableBuilder(
      column: $state.table.blockSnapSpotlight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get blockFbReels => $state.composableBuilder(
      column: $state.table.blockFbReels,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get blockRedditShorts => $state.composableBuilder(
      column: $state.table.blockRedditShorts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get blockNsfwSites => $state.composableBuilder(
      column: $state.table.blockNsfwSites,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get distractingSites => $state.composableBuilder(
          column: $state.table.distractingSites,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$WellbeingTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WellbeingTableTable> {
  $$WellbeingTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get allowedShortsTimeSec => $state.composableBuilder(
      column: $state.table.allowedShortsTimeSec,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get blockInstaReels => $state.composableBuilder(
      column: $state.table.blockInstaReels,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get blockYtShorts => $state.composableBuilder(
      column: $state.table.blockYtShorts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get blockSnapSpotlight => $state.composableBuilder(
      column: $state.table.blockSnapSpotlight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get blockFbReels => $state.composableBuilder(
      column: $state.table.blockFbReels,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get blockRedditShorts => $state.composableBuilder(
      column: $state.table.blockRedditShorts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get blockNsfwSites => $state.composableBuilder(
      column: $state.table.blockNsfwSites,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get distractingSites => $state.composableBuilder(
      column: $state.table.distractingSites,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$AppRestrictionTableTableTableManager get appRestrictionTable =>
      $$AppRestrictionTableTableTableManager(_db, _db.appRestrictionTable);
  $$BedtimeScheduleTableTableTableManager get bedtimeScheduleTable =>
      $$BedtimeScheduleTableTableTableManager(_db, _db.bedtimeScheduleTable);
  $$CrashLogsTableTableTableManager get crashLogsTable =>
      $$CrashLogsTableTableTableManager(_db, _db.crashLogsTable);
  $$FocusModeTableTableTableManager get focusModeTable =>
      $$FocusModeTableTableTableManager(_db, _db.focusModeTable);
  $$FocusSessionsTableTableTableManager get focusSessionsTable =>
      $$FocusSessionsTableTableTableManager(_db, _db.focusSessionsTable);
  $$MindfulSettingsTableTableTableManager get mindfulSettingsTable =>
      $$MindfulSettingsTableTableTableManager(_db, _db.mindfulSettingsTable);
  $$RestrictionGroupsTableTableTableManager get restrictionGroupsTable =>
      $$RestrictionGroupsTableTableTableManager(
          _db, _db.restrictionGroupsTable);
  $$WellbeingTableTableTableManager get wellbeingTable =>
      $$WellbeingTableTableTableManager(_db, _db.wellbeingTable);
}
