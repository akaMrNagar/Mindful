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
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _launchLimitMeta =
      const VerificationMeta('launchLimit');
  @override
  late final GeneratedColumn<int> launchLimit = GeneratedColumn<int>(
      'launch_limit', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      activePeriodStart = GeneratedColumn<int>(
              'active_period_start', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $AppRestrictionTableTable.$converteractivePeriodStart);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      activePeriodEnd = GeneratedColumn<int>(
              'active_period_end', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $AppRestrictionTableTable.$converteractivePeriodEnd);
  static const VerificationMeta _periodDurationInMinsMeta =
      const VerificationMeta('periodDurationInMins');
  @override
  late final GeneratedColumn<int> periodDurationInMins = GeneratedColumn<int>(
      'period_duration_in_mins', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _associatedGroupIdMeta =
      const VerificationMeta('associatedGroupId');
  @override
  late final GeneratedColumn<int> associatedGroupId = GeneratedColumn<int>(
      'associated_group_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(null));
  static const VerificationMeta _canAccessInternetMeta =
      const VerificationMeta('canAccessInternet');
  @override
  late final GeneratedColumn<bool> canAccessInternet = GeneratedColumn<bool>(
      'can_access_internet', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_access_internet" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        appPackage,
        timerSec,
        launchLimit,
        activePeriodStart,
        activePeriodEnd,
        periodDurationInMins,
        associatedGroupId,
        canAccessInternet
      ];
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
    }
    if (data.containsKey('launch_limit')) {
      context.handle(
          _launchLimitMeta,
          launchLimit.isAcceptableOrUnknown(
              data['launch_limit']!, _launchLimitMeta));
    }
    if (data.containsKey('period_duration_in_mins')) {
      context.handle(
          _periodDurationInMinsMeta,
          periodDurationInMins.isAcceptableOrUnknown(
              data['period_duration_in_mins']!, _periodDurationInMinsMeta));
    }
    if (data.containsKey('associated_group_id')) {
      context.handle(
          _associatedGroupIdMeta,
          associatedGroupId.isAcceptableOrUnknown(
              data['associated_group_id']!, _associatedGroupIdMeta));
    }
    if (data.containsKey('can_access_internet')) {
      context.handle(
          _canAccessInternetMeta,
          canAccessInternet.isAcceptableOrUnknown(
              data['can_access_internet']!, _canAccessInternetMeta));
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
      launchLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}launch_limit'])!,
      activePeriodStart: $AppRestrictionTableTable.$converteractivePeriodStart
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}active_period_start'])!),
      activePeriodEnd: $AppRestrictionTableTable.$converteractivePeriodEnd
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}active_period_end'])!),
      periodDurationInMins: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}period_duration_in_mins'])!,
      associatedGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}associated_group_id']),
      canAccessInternet: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}can_access_internet'])!,
    );
  }

  @override
  $AppRestrictionTableTable createAlias(String alias) {
    return $AppRestrictionTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converteractivePeriodStart = const TimeOfDayAdapterConverter();
  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converteractivePeriodEnd = const TimeOfDayAdapterConverter();
}

class AppRestriction extends DataClass implements Insertable<AppRestriction> {
  /// Package name of the related app
  final String appPackage;

  /// The timer set for the app in SECONDS
  final int timerSec;

  /// The number of times user can launch this app
  final int launchLimit;

  /// [TimeOfDay] in minutes from where the active period will start.
  /// It is stored as total minutes.
  final TimeOfDayAdapter activePeriodStart;

  /// [TimeOfDay] in minutes when the active period will end
  /// It is stored as total minutes.
  final TimeOfDayAdapter activePeriodEnd;

  /// Total duration of active period from start to end in MINUTES
  final int periodDurationInMins;

  /// ID of the [RestrictionGroup] this app is associated with or NULL
  final int? associatedGroupId;

  /// Flag denoting if this app can access internet or not
  final bool canAccessInternet;
  const AppRestriction(
      {required this.appPackage,
      required this.timerSec,
      required this.launchLimit,
      required this.activePeriodStart,
      required this.activePeriodEnd,
      required this.periodDurationInMins,
      this.associatedGroupId,
      required this.canAccessInternet});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['app_package'] = Variable<String>(appPackage);
    map['timer_sec'] = Variable<int>(timerSec);
    map['launch_limit'] = Variable<int>(launchLimit);
    {
      map['active_period_start'] = Variable<int>($AppRestrictionTableTable
          .$converteractivePeriodStart
          .toSql(activePeriodStart));
    }
    {
      map['active_period_end'] = Variable<int>($AppRestrictionTableTable
          .$converteractivePeriodEnd
          .toSql(activePeriodEnd));
    }
    map['period_duration_in_mins'] = Variable<int>(periodDurationInMins);
    if (!nullToAbsent || associatedGroupId != null) {
      map['associated_group_id'] = Variable<int>(associatedGroupId);
    }
    map['can_access_internet'] = Variable<bool>(canAccessInternet);
    return map;
  }

  AppRestrictionTableCompanion toCompanion(bool nullToAbsent) {
    return AppRestrictionTableCompanion(
      appPackage: Value(appPackage),
      timerSec: Value(timerSec),
      launchLimit: Value(launchLimit),
      activePeriodStart: Value(activePeriodStart),
      activePeriodEnd: Value(activePeriodEnd),
      periodDurationInMins: Value(periodDurationInMins),
      associatedGroupId: associatedGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(associatedGroupId),
      canAccessInternet: Value(canAccessInternet),
    );
  }

  factory AppRestriction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppRestriction(
      appPackage: serializer.fromJson<String>(json['appPackage']),
      timerSec: serializer.fromJson<int>(json['timerSec']),
      launchLimit: serializer.fromJson<int>(json['launchLimit']),
      activePeriodStart: $AppRestrictionTableTable.$converteractivePeriodStart
          .fromJson(serializer.fromJson<dynamic>(json['activePeriodStart'])),
      activePeriodEnd: $AppRestrictionTableTable.$converteractivePeriodEnd
          .fromJson(serializer.fromJson<dynamic>(json['activePeriodEnd'])),
      periodDurationInMins:
          serializer.fromJson<int>(json['periodDurationInMins']),
      associatedGroupId: serializer.fromJson<int?>(json['associatedGroupId']),
      canAccessInternet: serializer.fromJson<bool>(json['canAccessInternet']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'appPackage': serializer.toJson<String>(appPackage),
      'timerSec': serializer.toJson<int>(timerSec),
      'launchLimit': serializer.toJson<int>(launchLimit),
      'activePeriodStart': serializer.toJson<dynamic>($AppRestrictionTableTable
          .$converteractivePeriodStart
          .toJson(activePeriodStart)),
      'activePeriodEnd': serializer.toJson<dynamic>($AppRestrictionTableTable
          .$converteractivePeriodEnd
          .toJson(activePeriodEnd)),
      'periodDurationInMins': serializer.toJson<int>(periodDurationInMins),
      'associatedGroupId': serializer.toJson<int?>(associatedGroupId),
      'canAccessInternet': serializer.toJson<bool>(canAccessInternet),
    };
  }

  AppRestriction copyWith(
          {String? appPackage,
          int? timerSec,
          int? launchLimit,
          TimeOfDayAdapter? activePeriodStart,
          TimeOfDayAdapter? activePeriodEnd,
          int? periodDurationInMins,
          Value<int?> associatedGroupId = const Value.absent(),
          bool? canAccessInternet}) =>
      AppRestriction(
        appPackage: appPackage ?? this.appPackage,
        timerSec: timerSec ?? this.timerSec,
        launchLimit: launchLimit ?? this.launchLimit,
        activePeriodStart: activePeriodStart ?? this.activePeriodStart,
        activePeriodEnd: activePeriodEnd ?? this.activePeriodEnd,
        periodDurationInMins: periodDurationInMins ?? this.periodDurationInMins,
        associatedGroupId: associatedGroupId.present
            ? associatedGroupId.value
            : this.associatedGroupId,
        canAccessInternet: canAccessInternet ?? this.canAccessInternet,
      );
  AppRestriction copyWithCompanion(AppRestrictionTableCompanion data) {
    return AppRestriction(
      appPackage:
          data.appPackage.present ? data.appPackage.value : this.appPackage,
      timerSec: data.timerSec.present ? data.timerSec.value : this.timerSec,
      launchLimit:
          data.launchLimit.present ? data.launchLimit.value : this.launchLimit,
      activePeriodStart: data.activePeriodStart.present
          ? data.activePeriodStart.value
          : this.activePeriodStart,
      activePeriodEnd: data.activePeriodEnd.present
          ? data.activePeriodEnd.value
          : this.activePeriodEnd,
      periodDurationInMins: data.periodDurationInMins.present
          ? data.periodDurationInMins.value
          : this.periodDurationInMins,
      associatedGroupId: data.associatedGroupId.present
          ? data.associatedGroupId.value
          : this.associatedGroupId,
      canAccessInternet: data.canAccessInternet.present
          ? data.canAccessInternet.value
          : this.canAccessInternet,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppRestriction(')
          ..write('appPackage: $appPackage, ')
          ..write('timerSec: $timerSec, ')
          ..write('launchLimit: $launchLimit, ')
          ..write('activePeriodStart: $activePeriodStart, ')
          ..write('activePeriodEnd: $activePeriodEnd, ')
          ..write('periodDurationInMins: $periodDurationInMins, ')
          ..write('associatedGroupId: $associatedGroupId, ')
          ..write('canAccessInternet: $canAccessInternet')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      appPackage,
      timerSec,
      launchLimit,
      activePeriodStart,
      activePeriodEnd,
      periodDurationInMins,
      associatedGroupId,
      canAccessInternet);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppRestriction &&
          other.appPackage == this.appPackage &&
          other.timerSec == this.timerSec &&
          other.launchLimit == this.launchLimit &&
          other.activePeriodStart == this.activePeriodStart &&
          other.activePeriodEnd == this.activePeriodEnd &&
          other.periodDurationInMins == this.periodDurationInMins &&
          other.associatedGroupId == this.associatedGroupId &&
          other.canAccessInternet == this.canAccessInternet);
}

class AppRestrictionTableCompanion extends UpdateCompanion<AppRestriction> {
  final Value<String> appPackage;
  final Value<int> timerSec;
  final Value<int> launchLimit;
  final Value<TimeOfDayAdapter> activePeriodStart;
  final Value<TimeOfDayAdapter> activePeriodEnd;
  final Value<int> periodDurationInMins;
  final Value<int?> associatedGroupId;
  final Value<bool> canAccessInternet;
  final Value<int> rowid;
  const AppRestrictionTableCompanion({
    this.appPackage = const Value.absent(),
    this.timerSec = const Value.absent(),
    this.launchLimit = const Value.absent(),
    this.activePeriodStart = const Value.absent(),
    this.activePeriodEnd = const Value.absent(),
    this.periodDurationInMins = const Value.absent(),
    this.associatedGroupId = const Value.absent(),
    this.canAccessInternet = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppRestrictionTableCompanion.insert({
    required String appPackage,
    this.timerSec = const Value.absent(),
    this.launchLimit = const Value.absent(),
    this.activePeriodStart = const Value.absent(),
    this.activePeriodEnd = const Value.absent(),
    this.periodDurationInMins = const Value.absent(),
    this.associatedGroupId = const Value.absent(),
    this.canAccessInternet = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : appPackage = Value(appPackage);
  static Insertable<AppRestriction> custom({
    Expression<String>? appPackage,
    Expression<int>? timerSec,
    Expression<int>? launchLimit,
    Expression<int>? activePeriodStart,
    Expression<int>? activePeriodEnd,
    Expression<int>? periodDurationInMins,
    Expression<int>? associatedGroupId,
    Expression<bool>? canAccessInternet,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appPackage != null) 'app_package': appPackage,
      if (timerSec != null) 'timer_sec': timerSec,
      if (launchLimit != null) 'launch_limit': launchLimit,
      if (activePeriodStart != null) 'active_period_start': activePeriodStart,
      if (activePeriodEnd != null) 'active_period_end': activePeriodEnd,
      if (periodDurationInMins != null)
        'period_duration_in_mins': periodDurationInMins,
      if (associatedGroupId != null) 'associated_group_id': associatedGroupId,
      if (canAccessInternet != null) 'can_access_internet': canAccessInternet,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppRestrictionTableCompanion copyWith(
      {Value<String>? appPackage,
      Value<int>? timerSec,
      Value<int>? launchLimit,
      Value<TimeOfDayAdapter>? activePeriodStart,
      Value<TimeOfDayAdapter>? activePeriodEnd,
      Value<int>? periodDurationInMins,
      Value<int?>? associatedGroupId,
      Value<bool>? canAccessInternet,
      Value<int>? rowid}) {
    return AppRestrictionTableCompanion(
      appPackage: appPackage ?? this.appPackage,
      timerSec: timerSec ?? this.timerSec,
      launchLimit: launchLimit ?? this.launchLimit,
      activePeriodStart: activePeriodStart ?? this.activePeriodStart,
      activePeriodEnd: activePeriodEnd ?? this.activePeriodEnd,
      periodDurationInMins: periodDurationInMins ?? this.periodDurationInMins,
      associatedGroupId: associatedGroupId ?? this.associatedGroupId,
      canAccessInternet: canAccessInternet ?? this.canAccessInternet,
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
    if (launchLimit.present) {
      map['launch_limit'] = Variable<int>(launchLimit.value);
    }
    if (activePeriodStart.present) {
      map['active_period_start'] = Variable<int>($AppRestrictionTableTable
          .$converteractivePeriodStart
          .toSql(activePeriodStart.value));
    }
    if (activePeriodEnd.present) {
      map['active_period_end'] = Variable<int>($AppRestrictionTableTable
          .$converteractivePeriodEnd
          .toSql(activePeriodEnd.value));
    }
    if (periodDurationInMins.present) {
      map['period_duration_in_mins'] =
          Variable<int>(periodDurationInMins.value);
    }
    if (associatedGroupId.present) {
      map['associated_group_id'] = Variable<int>(associatedGroupId.value);
    }
    if (canAccessInternet.present) {
      map['can_access_internet'] = Variable<bool>(canAccessInternet.value);
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
          ..write('launchLimit: $launchLimit, ')
          ..write('activePeriodStart: $activePeriodStart, ')
          ..write('activePeriodEnd: $activePeriodEnd, ')
          ..write('periodDurationInMins: $periodDurationInMins, ')
          ..write('associatedGroupId: $associatedGroupId, ')
          ..write('canAccessInternet: $canAccessInternet, ')
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
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      scheduleStartTime = GeneratedColumn<int>(
              'schedule_start_time', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $BedtimeScheduleTableTable.$converterscheduleStartTime);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      scheduleEndTime = GeneratedColumn<int>(
              'schedule_end_time', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $BedtimeScheduleTableTable.$converterscheduleEndTime);
  static const VerificationMeta _scheduleDurationInMinsMeta =
      const VerificationMeta('scheduleDurationInMins');
  @override
  late final GeneratedColumn<int> scheduleDurationInMins = GeneratedColumn<int>(
      'schedule_duration_in_mins', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<List<bool>, String> scheduleDays =
      GeneratedColumn<String>('schedule_days', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(
                  jsonEncode([true, true, true, true, true, false, false])))
          .withConverter<List<bool>>(
              $BedtimeScheduleTableTable.$converterscheduleDays);
  static const VerificationMeta _isScheduleOnMeta =
      const VerificationMeta('isScheduleOn');
  @override
  late final GeneratedColumn<bool> isScheduleOn = GeneratedColumn<bool>(
      'is_schedule_on', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_schedule_on" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _shouldStartDndMeta =
      const VerificationMeta('shouldStartDnd');
  @override
  late final GeneratedColumn<bool> shouldStartDnd = GeneratedColumn<bool>(
      'should_start_dnd', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("should_start_dnd" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      distractingApps = GeneratedColumn<String>(
              'distracting_apps', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<String>>(
              $BedtimeScheduleTableTable.$converterdistractingApps);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        scheduleStartTime,
        scheduleEndTime,
        scheduleDurationInMins,
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
    if (data.containsKey('schedule_duration_in_mins')) {
      context.handle(
          _scheduleDurationInMinsMeta,
          scheduleDurationInMins.isAcceptableOrUnknown(
              data['schedule_duration_in_mins']!, _scheduleDurationInMinsMeta));
    }
    if (data.containsKey('is_schedule_on')) {
      context.handle(
          _isScheduleOnMeta,
          isScheduleOn.isAcceptableOrUnknown(
              data['is_schedule_on']!, _isScheduleOnMeta));
    }
    if (data.containsKey('should_start_dnd')) {
      context.handle(
          _shouldStartDndMeta,
          shouldStartDnd.isAcceptableOrUnknown(
              data['should_start_dnd']!, _shouldStartDndMeta));
    }
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
      scheduleStartTime: $BedtimeScheduleTableTable.$converterscheduleStartTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}schedule_start_time'])!),
      scheduleEndTime: $BedtimeScheduleTableTable.$converterscheduleEndTime
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}schedule_end_time'])!),
      scheduleDurationInMins: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}schedule_duration_in_mins'])!,
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

  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converterscheduleStartTime = const TimeOfDayAdapterConverter();
  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converterscheduleEndTime = const TimeOfDayAdapterConverter();
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
  final TimeOfDayAdapter scheduleStartTime;

  /// [TimeOfDay] in minutes when the bedtime schedule task will end
  /// It is stored as total minutes.
  final TimeOfDayAdapter scheduleEndTime;

  /// Total duration of bedtime schedule from start to end in MINUTES
  final int scheduleDurationInMins;

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
      required this.scheduleStartTime,
      required this.scheduleEndTime,
      required this.scheduleDurationInMins,
      required this.scheduleDays,
      required this.isScheduleOn,
      required this.shouldStartDnd,
      required this.distractingApps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['schedule_start_time'] = Variable<int>($BedtimeScheduleTableTable
          .$converterscheduleStartTime
          .toSql(scheduleStartTime));
    }
    {
      map['schedule_end_time'] = Variable<int>($BedtimeScheduleTableTable
          .$converterscheduleEndTime
          .toSql(scheduleEndTime));
    }
    map['schedule_duration_in_mins'] = Variable<int>(scheduleDurationInMins);
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
      scheduleStartTime: Value(scheduleStartTime),
      scheduleEndTime: Value(scheduleEndTime),
      scheduleDurationInMins: Value(scheduleDurationInMins),
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
      scheduleStartTime: $BedtimeScheduleTableTable.$converterscheduleStartTime
          .fromJson(serializer.fromJson<dynamic>(json['scheduleStartTime'])),
      scheduleEndTime: $BedtimeScheduleTableTable.$converterscheduleEndTime
          .fromJson(serializer.fromJson<dynamic>(json['scheduleEndTime'])),
      scheduleDurationInMins:
          serializer.fromJson<int>(json['scheduleDurationInMins']),
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
      'scheduleStartTime': serializer.toJson<dynamic>($BedtimeScheduleTableTable
          .$converterscheduleStartTime
          .toJson(scheduleStartTime)),
      'scheduleEndTime': serializer.toJson<dynamic>($BedtimeScheduleTableTable
          .$converterscheduleEndTime
          .toJson(scheduleEndTime)),
      'scheduleDurationInMins': serializer.toJson<int>(scheduleDurationInMins),
      'scheduleDays': serializer.toJson<List<bool>>(scheduleDays),
      'isScheduleOn': serializer.toJson<bool>(isScheduleOn),
      'shouldStartDnd': serializer.toJson<bool>(shouldStartDnd),
      'distractingApps': serializer.toJson<List<String>>(distractingApps),
    };
  }

  BedtimeSchedule copyWith(
          {int? id,
          TimeOfDayAdapter? scheduleStartTime,
          TimeOfDayAdapter? scheduleEndTime,
          int? scheduleDurationInMins,
          List<bool>? scheduleDays,
          bool? isScheduleOn,
          bool? shouldStartDnd,
          List<String>? distractingApps}) =>
      BedtimeSchedule(
        id: id ?? this.id,
        scheduleStartTime: scheduleStartTime ?? this.scheduleStartTime,
        scheduleEndTime: scheduleEndTime ?? this.scheduleEndTime,
        scheduleDurationInMins:
            scheduleDurationInMins ?? this.scheduleDurationInMins,
        scheduleDays: scheduleDays ?? this.scheduleDays,
        isScheduleOn: isScheduleOn ?? this.isScheduleOn,
        shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
        distractingApps: distractingApps ?? this.distractingApps,
      );
  BedtimeSchedule copyWithCompanion(BedtimeScheduleTableCompanion data) {
    return BedtimeSchedule(
      id: data.id.present ? data.id.value : this.id,
      scheduleStartTime: data.scheduleStartTime.present
          ? data.scheduleStartTime.value
          : this.scheduleStartTime,
      scheduleEndTime: data.scheduleEndTime.present
          ? data.scheduleEndTime.value
          : this.scheduleEndTime,
      scheduleDurationInMins: data.scheduleDurationInMins.present
          ? data.scheduleDurationInMins.value
          : this.scheduleDurationInMins,
      scheduleDays: data.scheduleDays.present
          ? data.scheduleDays.value
          : this.scheduleDays,
      isScheduleOn: data.isScheduleOn.present
          ? data.isScheduleOn.value
          : this.isScheduleOn,
      shouldStartDnd: data.shouldStartDnd.present
          ? data.shouldStartDnd.value
          : this.shouldStartDnd,
      distractingApps: data.distractingApps.present
          ? data.distractingApps.value
          : this.distractingApps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BedtimeSchedule(')
          ..write('id: $id, ')
          ..write('scheduleStartTime: $scheduleStartTime, ')
          ..write('scheduleEndTime: $scheduleEndTime, ')
          ..write('scheduleDurationInMins: $scheduleDurationInMins, ')
          ..write('scheduleDays: $scheduleDays, ')
          ..write('isScheduleOn: $isScheduleOn, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      scheduleStartTime,
      scheduleEndTime,
      scheduleDurationInMins,
      scheduleDays,
      isScheduleOn,
      shouldStartDnd,
      distractingApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BedtimeSchedule &&
          other.id == this.id &&
          other.scheduleStartTime == this.scheduleStartTime &&
          other.scheduleEndTime == this.scheduleEndTime &&
          other.scheduleDurationInMins == this.scheduleDurationInMins &&
          other.scheduleDays == this.scheduleDays &&
          other.isScheduleOn == this.isScheduleOn &&
          other.shouldStartDnd == this.shouldStartDnd &&
          other.distractingApps == this.distractingApps);
}

class BedtimeScheduleTableCompanion extends UpdateCompanion<BedtimeSchedule> {
  final Value<int> id;
  final Value<TimeOfDayAdapter> scheduleStartTime;
  final Value<TimeOfDayAdapter> scheduleEndTime;
  final Value<int> scheduleDurationInMins;
  final Value<List<bool>> scheduleDays;
  final Value<bool> isScheduleOn;
  final Value<bool> shouldStartDnd;
  final Value<List<String>> distractingApps;
  const BedtimeScheduleTableCompanion({
    this.id = const Value.absent(),
    this.scheduleStartTime = const Value.absent(),
    this.scheduleEndTime = const Value.absent(),
    this.scheduleDurationInMins = const Value.absent(),
    this.scheduleDays = const Value.absent(),
    this.isScheduleOn = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  BedtimeScheduleTableCompanion.insert({
    this.id = const Value.absent(),
    this.scheduleStartTime = const Value.absent(),
    this.scheduleEndTime = const Value.absent(),
    this.scheduleDurationInMins = const Value.absent(),
    this.scheduleDays = const Value.absent(),
    this.isScheduleOn = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  static Insertable<BedtimeSchedule> custom({
    Expression<int>? id,
    Expression<int>? scheduleStartTime,
    Expression<int>? scheduleEndTime,
    Expression<int>? scheduleDurationInMins,
    Expression<String>? scheduleDays,
    Expression<bool>? isScheduleOn,
    Expression<bool>? shouldStartDnd,
    Expression<String>? distractingApps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scheduleStartTime != null) 'schedule_start_time': scheduleStartTime,
      if (scheduleEndTime != null) 'schedule_end_time': scheduleEndTime,
      if (scheduleDurationInMins != null)
        'schedule_duration_in_mins': scheduleDurationInMins,
      if (scheduleDays != null) 'schedule_days': scheduleDays,
      if (isScheduleOn != null) 'is_schedule_on': isScheduleOn,
      if (shouldStartDnd != null) 'should_start_dnd': shouldStartDnd,
      if (distractingApps != null) 'distracting_apps': distractingApps,
    });
  }

  BedtimeScheduleTableCompanion copyWith(
      {Value<int>? id,
      Value<TimeOfDayAdapter>? scheduleStartTime,
      Value<TimeOfDayAdapter>? scheduleEndTime,
      Value<int>? scheduleDurationInMins,
      Value<List<bool>>? scheduleDays,
      Value<bool>? isScheduleOn,
      Value<bool>? shouldStartDnd,
      Value<List<String>>? distractingApps}) {
    return BedtimeScheduleTableCompanion(
      id: id ?? this.id,
      scheduleStartTime: scheduleStartTime ?? this.scheduleStartTime,
      scheduleEndTime: scheduleEndTime ?? this.scheduleEndTime,
      scheduleDurationInMins:
          scheduleDurationInMins ?? this.scheduleDurationInMins,
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
    if (scheduleStartTime.present) {
      map['schedule_start_time'] = Variable<int>($BedtimeScheduleTableTable
          .$converterscheduleStartTime
          .toSql(scheduleStartTime.value));
    }
    if (scheduleEndTime.present) {
      map['schedule_end_time'] = Variable<int>($BedtimeScheduleTableTable
          .$converterscheduleEndTime
          .toSql(scheduleEndTime.value));
    }
    if (scheduleDurationInMins.present) {
      map['schedule_duration_in_mins'] =
          Variable<int>(scheduleDurationInMins.value);
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
          ..write('scheduleStartTime: $scheduleStartTime, ')
          ..write('scheduleEndTime: $scheduleEndTime, ')
          ..write('scheduleDurationInMins: $scheduleDurationInMins, ')
          ..write('scheduleDays: $scheduleDays, ')
          ..write('isScheduleOn: $isScheduleOn, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }
}

class $CrashLogsTableTable extends CrashLogsTable
    with TableInfo<$CrashLogsTableTable, CrashLog> {
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
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _timeStampMeta =
      const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<DateTime> timeStamp = GeneratedColumn<DateTime>(
      'time_stamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime(0)));
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
      'error', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _stackTraceMeta =
      const VerificationMeta('stackTrace');
  @override
  late final GeneratedColumn<String> stackTrace = GeneratedColumn<String>(
      'stack_trace', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns =>
      [id, appVersion, timeStamp, error, stackTrace];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crash_logs_table';
  @override
  VerificationContext validateIntegrity(Insertable<CrashLog> instance,
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
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('stack_trace')) {
      context.handle(
          _stackTraceMeta,
          stackTrace.isAcceptableOrUnknown(
              data['stack_trace']!, _stackTraceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrashLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrashLog(
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

class CrashLog extends DataClass implements Insertable<CrashLog> {
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
  const CrashLog(
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

  factory CrashLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrashLog(
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

  CrashLog copyWith(
          {int? id,
          String? appVersion,
          DateTime? timeStamp,
          String? error,
          String? stackTrace}) =>
      CrashLog(
        id: id ?? this.id,
        appVersion: appVersion ?? this.appVersion,
        timeStamp: timeStamp ?? this.timeStamp,
        error: error ?? this.error,
        stackTrace: stackTrace ?? this.stackTrace,
      );
  CrashLog copyWithCompanion(CrashLogsTableCompanion data) {
    return CrashLog(
      id: data.id.present ? data.id.value : this.id,
      appVersion:
          data.appVersion.present ? data.appVersion.value : this.appVersion,
      timeStamp: data.timeStamp.present ? data.timeStamp.value : this.timeStamp,
      error: data.error.present ? data.error.value : this.error,
      stackTrace:
          data.stackTrace.present ? data.stackTrace.value : this.stackTrace,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrashLog(')
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
      (other is CrashLog &&
          other.id == this.id &&
          other.appVersion == this.appVersion &&
          other.timeStamp == this.timeStamp &&
          other.error == this.error &&
          other.stackTrace == this.stackTrace);
}

class CrashLogsTableCompanion extends UpdateCompanion<CrashLog> {
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
    this.appVersion = const Value.absent(),
    this.timeStamp = const Value.absent(),
    this.error = const Value.absent(),
    this.stackTrace = const Value.absent(),
  });
  static Insertable<CrashLog> custom({
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
  @override
  late final GeneratedColumnWithTypeConverter<SessionType, int> sessionType =
      GeneratedColumn<int>('session_type', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<SessionType>(
              $FocusModeTableTable.$convertersessionType);
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastTimeStreakUpdatedMeta =
      const VerificationMeta('lastTimeStreakUpdated');
  @override
  late final GeneratedColumn<DateTime> lastTimeStreakUpdated =
      GeneratedColumn<DateTime>('last_time_streak_updated', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime(0)));
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionType, longestStreak, currentStreak, lastTimeStreakUpdated];
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
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('last_time_streak_updated')) {
      context.handle(
          _lastTimeStreakUpdatedMeta,
          lastTimeStreakUpdated.isAcceptableOrUnknown(
              data['last_time_streak_updated']!, _lastTimeStreakUpdatedMeta));
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
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      lastTimeStreakUpdated: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_time_streak_updated'])!,
    );
  }

  @override
  $FocusModeTableTable createAlias(String alias) {
    return $FocusModeTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SessionType, int, int> $convertersessionType =
      const EnumIndexConverter<SessionType>(SessionType.values);
}

class FocusMode extends DataClass implements Insertable<FocusMode> {
  /// Unique ID for focus mode
  final int id;

  /// Selected session type
  final SessionType sessionType;

  /// Longest streak (number of days) till now
  final int longestStreak;

  /// Current streak (number of days) till now
  final int currentStreak;

  /// The [DateTime] when the streak was updated last time
  final DateTime lastTimeStreakUpdated;
  const FocusMode(
      {required this.id,
      required this.sessionType,
      required this.longestStreak,
      required this.currentStreak,
      required this.lastTimeStreakUpdated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['session_type'] = Variable<int>(
          $FocusModeTableTable.$convertersessionType.toSql(sessionType));
    }
    map['longest_streak'] = Variable<int>(longestStreak);
    map['current_streak'] = Variable<int>(currentStreak);
    map['last_time_streak_updated'] = Variable<DateTime>(lastTimeStreakUpdated);
    return map;
  }

  FocusModeTableCompanion toCompanion(bool nullToAbsent) {
    return FocusModeTableCompanion(
      id: Value(id),
      sessionType: Value(sessionType),
      longestStreak: Value(longestStreak),
      currentStreak: Value(currentStreak),
      lastTimeStreakUpdated: Value(lastTimeStreakUpdated),
    );
  }

  factory FocusMode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusMode(
      id: serializer.fromJson<int>(json['id']),
      sessionType: $FocusModeTableTable.$convertersessionType
          .fromJson(serializer.fromJson<int>(json['sessionType'])),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      lastTimeStreakUpdated:
          serializer.fromJson<DateTime>(json['lastTimeStreakUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionType': serializer.toJson<int>(
          $FocusModeTableTable.$convertersessionType.toJson(sessionType)),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'lastTimeStreakUpdated':
          serializer.toJson<DateTime>(lastTimeStreakUpdated),
    };
  }

  FocusMode copyWith(
          {int? id,
          SessionType? sessionType,
          int? longestStreak,
          int? currentStreak,
          DateTime? lastTimeStreakUpdated}) =>
      FocusMode(
        id: id ?? this.id,
        sessionType: sessionType ?? this.sessionType,
        longestStreak: longestStreak ?? this.longestStreak,
        currentStreak: currentStreak ?? this.currentStreak,
        lastTimeStreakUpdated:
            lastTimeStreakUpdated ?? this.lastTimeStreakUpdated,
      );
  FocusMode copyWithCompanion(FocusModeTableCompanion data) {
    return FocusMode(
      id: data.id.present ? data.id.value : this.id,
      sessionType:
          data.sessionType.present ? data.sessionType.value : this.sessionType,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      lastTimeStreakUpdated: data.lastTimeStreakUpdated.present
          ? data.lastTimeStreakUpdated.value
          : this.lastTimeStreakUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusMode(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('lastTimeStreakUpdated: $lastTimeStreakUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, sessionType, longestStreak, currentStreak, lastTimeStreakUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusMode &&
          other.id == this.id &&
          other.sessionType == this.sessionType &&
          other.longestStreak == this.longestStreak &&
          other.currentStreak == this.currentStreak &&
          other.lastTimeStreakUpdated == this.lastTimeStreakUpdated);
}

class FocusModeTableCompanion extends UpdateCompanion<FocusMode> {
  final Value<int> id;
  final Value<SessionType> sessionType;
  final Value<int> longestStreak;
  final Value<int> currentStreak;
  final Value<DateTime> lastTimeStreakUpdated;
  const FocusModeTableCompanion({
    this.id = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.lastTimeStreakUpdated = const Value.absent(),
  });
  FocusModeTableCompanion.insert({
    this.id = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.lastTimeStreakUpdated = const Value.absent(),
  });
  static Insertable<FocusMode> custom({
    Expression<int>? id,
    Expression<int>? sessionType,
    Expression<int>? longestStreak,
    Expression<int>? currentStreak,
    Expression<DateTime>? lastTimeStreakUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionType != null) 'session_type': sessionType,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (lastTimeStreakUpdated != null)
        'last_time_streak_updated': lastTimeStreakUpdated,
    });
  }

  FocusModeTableCompanion copyWith(
      {Value<int>? id,
      Value<SessionType>? sessionType,
      Value<int>? longestStreak,
      Value<int>? currentStreak,
      Value<DateTime>? lastTimeStreakUpdated}) {
    return FocusModeTableCompanion(
      id: id ?? this.id,
      sessionType: sessionType ?? this.sessionType,
      longestStreak: longestStreak ?? this.longestStreak,
      currentStreak: currentStreak ?? this.currentStreak,
      lastTimeStreakUpdated:
          lastTimeStreakUpdated ?? this.lastTimeStreakUpdated,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusModeTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('lastTimeStreakUpdated: $lastTimeStreakUpdated')
          ..write(')'))
        .toString();
  }
}

class $FocusProfileTableTable extends FocusProfileTable
    with TableInfo<$FocusProfileTableTable, FocusProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusProfileTableTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<SessionType, int> sessionType =
      GeneratedColumn<int>('session_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<SessionType>(
              $FocusProfileTableTable.$convertersessionType);
  static const VerificationMeta _sessionDurationMeta =
      const VerificationMeta('sessionDuration');
  @override
  late final GeneratedColumn<int> sessionDuration = GeneratedColumn<int>(
      'session_duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _enforceSessionMeta =
      const VerificationMeta('enforceSession');
  @override
  late final GeneratedColumn<bool> enforceSession = GeneratedColumn<bool>(
      'enforce_session', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enforce_session" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _shouldStartDndMeta =
      const VerificationMeta('shouldStartDnd');
  @override
  late final GeneratedColumn<bool> shouldStartDnd = GeneratedColumn<bool>(
      'should_start_dnd', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("should_start_dnd" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      distractingApps = GeneratedColumn<String>(
              'distracting_apps', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<String>>(
              $FocusProfileTableTable.$converterdistractingApps);
  @override
  List<GeneratedColumn> get $columns => [
        sessionType,
        sessionDuration,
        enforceSession,
        shouldStartDnd,
        distractingApps
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_profile_table';
  @override
  VerificationContext validateIntegrity(Insertable<FocusProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_duration')) {
      context.handle(
          _sessionDurationMeta,
          sessionDuration.isAcceptableOrUnknown(
              data['session_duration']!, _sessionDurationMeta));
    }
    if (data.containsKey('enforce_session')) {
      context.handle(
          _enforceSessionMeta,
          enforceSession.isAcceptableOrUnknown(
              data['enforce_session']!, _enforceSessionMeta));
    }
    if (data.containsKey('should_start_dnd')) {
      context.handle(
          _shouldStartDndMeta,
          shouldStartDnd.isAcceptableOrUnknown(
              data['should_start_dnd']!, _shouldStartDndMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionType};
  @override
  FocusProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusProfile(
      sessionType: $FocusProfileTableTable.$convertersessionType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}session_type'])!),
      sessionDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_duration'])!,
      enforceSession: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enforce_session'])!,
      shouldStartDnd: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}should_start_dnd'])!,
      distractingApps: $FocusProfileTableTable.$converterdistractingApps
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}distracting_apps'])!),
    );
  }

  @override
  $FocusProfileTableTable createAlias(String alias) {
    return $FocusProfileTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SessionType, int, int> $convertersessionType =
      const EnumIndexConverter<SessionType>(SessionType.values);
  static TypeConverter<List<String>, String> $converterdistractingApps =
      const ListStringConverter();
}

class FocusProfile extends DataClass implements Insertable<FocusProfile> {
  /// Selected session type
  final SessionType sessionType;

  /// Duration in SECONDS for the focus session
  final int sessionDuration;

  /// Flag indicating if to enforce the session or not.
  /// If 'True' user cannot end session until the time ends.
  final bool enforceSession;

  /// Flag indicating if to start DND during the focus session
  final bool shouldStartDnd;

  /// List of app's packages which are selected as distracting apps.
  final List<String> distractingApps;
  const FocusProfile(
      {required this.sessionType,
      required this.sessionDuration,
      required this.enforceSession,
      required this.shouldStartDnd,
      required this.distractingApps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['session_type'] = Variable<int>(
          $FocusProfileTableTable.$convertersessionType.toSql(sessionType));
    }
    map['session_duration'] = Variable<int>(sessionDuration);
    map['enforce_session'] = Variable<bool>(enforceSession);
    map['should_start_dnd'] = Variable<bool>(shouldStartDnd);
    {
      map['distracting_apps'] = Variable<String>($FocusProfileTableTable
          .$converterdistractingApps
          .toSql(distractingApps));
    }
    return map;
  }

  FocusProfileTableCompanion toCompanion(bool nullToAbsent) {
    return FocusProfileTableCompanion(
      sessionType: Value(sessionType),
      sessionDuration: Value(sessionDuration),
      enforceSession: Value(enforceSession),
      shouldStartDnd: Value(shouldStartDnd),
      distractingApps: Value(distractingApps),
    );
  }

  factory FocusProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusProfile(
      sessionType: $FocusProfileTableTable.$convertersessionType
          .fromJson(serializer.fromJson<int>(json['sessionType'])),
      sessionDuration: serializer.fromJson<int>(json['sessionDuration']),
      enforceSession: serializer.fromJson<bool>(json['enforceSession']),
      shouldStartDnd: serializer.fromJson<bool>(json['shouldStartDnd']),
      distractingApps:
          serializer.fromJson<List<String>>(json['distractingApps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionType': serializer.toJson<int>(
          $FocusProfileTableTable.$convertersessionType.toJson(sessionType)),
      'sessionDuration': serializer.toJson<int>(sessionDuration),
      'enforceSession': serializer.toJson<bool>(enforceSession),
      'shouldStartDnd': serializer.toJson<bool>(shouldStartDnd),
      'distractingApps': serializer.toJson<List<String>>(distractingApps),
    };
  }

  FocusProfile copyWith(
          {SessionType? sessionType,
          int? sessionDuration,
          bool? enforceSession,
          bool? shouldStartDnd,
          List<String>? distractingApps}) =>
      FocusProfile(
        sessionType: sessionType ?? this.sessionType,
        sessionDuration: sessionDuration ?? this.sessionDuration,
        enforceSession: enforceSession ?? this.enforceSession,
        shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
        distractingApps: distractingApps ?? this.distractingApps,
      );
  FocusProfile copyWithCompanion(FocusProfileTableCompanion data) {
    return FocusProfile(
      sessionType:
          data.sessionType.present ? data.sessionType.value : this.sessionType,
      sessionDuration: data.sessionDuration.present
          ? data.sessionDuration.value
          : this.sessionDuration,
      enforceSession: data.enforceSession.present
          ? data.enforceSession.value
          : this.enforceSession,
      shouldStartDnd: data.shouldStartDnd.present
          ? data.shouldStartDnd.value
          : this.shouldStartDnd,
      distractingApps: data.distractingApps.present
          ? data.distractingApps.value
          : this.distractingApps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusProfile(')
          ..write('sessionType: $sessionType, ')
          ..write('sessionDuration: $sessionDuration, ')
          ..write('enforceSession: $enforceSession, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionType, sessionDuration, enforceSession,
      shouldStartDnd, distractingApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusProfile &&
          other.sessionType == this.sessionType &&
          other.sessionDuration == this.sessionDuration &&
          other.enforceSession == this.enforceSession &&
          other.shouldStartDnd == this.shouldStartDnd &&
          other.distractingApps == this.distractingApps);
}

class FocusProfileTableCompanion extends UpdateCompanion<FocusProfile> {
  final Value<SessionType> sessionType;
  final Value<int> sessionDuration;
  final Value<bool> enforceSession;
  final Value<bool> shouldStartDnd;
  final Value<List<String>> distractingApps;
  const FocusProfileTableCompanion({
    this.sessionType = const Value.absent(),
    this.sessionDuration = const Value.absent(),
    this.enforceSession = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  FocusProfileTableCompanion.insert({
    this.sessionType = const Value.absent(),
    this.sessionDuration = const Value.absent(),
    this.enforceSession = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  static Insertable<FocusProfile> custom({
    Expression<int>? sessionType,
    Expression<int>? sessionDuration,
    Expression<bool>? enforceSession,
    Expression<bool>? shouldStartDnd,
    Expression<String>? distractingApps,
  }) {
    return RawValuesInsertable({
      if (sessionType != null) 'session_type': sessionType,
      if (sessionDuration != null) 'session_duration': sessionDuration,
      if (enforceSession != null) 'enforce_session': enforceSession,
      if (shouldStartDnd != null) 'should_start_dnd': shouldStartDnd,
      if (distractingApps != null) 'distracting_apps': distractingApps,
    });
  }

  FocusProfileTableCompanion copyWith(
      {Value<SessionType>? sessionType,
      Value<int>? sessionDuration,
      Value<bool>? enforceSession,
      Value<bool>? shouldStartDnd,
      Value<List<String>>? distractingApps}) {
    return FocusProfileTableCompanion(
      sessionType: sessionType ?? this.sessionType,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      enforceSession: enforceSession ?? this.enforceSession,
      shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
      distractingApps: distractingApps ?? this.distractingApps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionType.present) {
      map['session_type'] = Variable<int>($FocusProfileTableTable
          .$convertersessionType
          .toSql(sessionType.value));
    }
    if (sessionDuration.present) {
      map['session_duration'] = Variable<int>(sessionDuration.value);
    }
    if (enforceSession.present) {
      map['enforce_session'] = Variable<bool>(enforceSession.value);
    }
    if (shouldStartDnd.present) {
      map['should_start_dnd'] = Variable<bool>(shouldStartDnd.value);
    }
    if (distractingApps.present) {
      map['distracting_apps'] = Variable<String>($FocusProfileTableTable
          .$converterdistractingApps
          .toSql(distractingApps.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusProfileTableCompanion(')
          ..write('sessionType: $sessionType, ')
          ..write('sessionDuration: $sessionDuration, ')
          ..write('enforceSession: $enforceSession, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps')
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
  @override
  late final GeneratedColumnWithTypeConverter<SessionType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<SessionType>($FocusSessionsTableTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<SessionState, int> state =
      GeneratedColumn<int>('state', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<SessionState>(
              $FocusSessionsTableTable.$converterstate);
  static const VerificationMeta _startDateTimeMeta =
      const VerificationMeta('startDateTime');
  @override
  late final GeneratedColumn<DateTime> startDateTime =
      GeneratedColumn<DateTime>('start_date_time', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime(0)));
  static const VerificationMeta _durationSecsMeta =
      const VerificationMeta('durationSecs');
  @override
  late final GeneratedColumn<int> durationSecs = GeneratedColumn<int>(
      'duration_secs', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _reflectionMeta =
      const VerificationMeta('reflection');
  @override
  late final GeneratedColumn<String> reflection = GeneratedColumn<String>(
      'reflection', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, state, startDateTime, durationSecs, reflection];
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
    if (data.containsKey('start_date_time')) {
      context.handle(
          _startDateTimeMeta,
          startDateTime.isAcceptableOrUnknown(
              data['start_date_time']!, _startDateTimeMeta));
    }
    if (data.containsKey('duration_secs')) {
      context.handle(
          _durationSecsMeta,
          durationSecs.isAcceptableOrUnknown(
              data['duration_secs']!, _durationSecsMeta));
    }
    if (data.containsKey('reflection')) {
      context.handle(
          _reflectionMeta,
          reflection.isAcceptableOrUnknown(
              data['reflection']!, _reflectionMeta));
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
      reflection: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reflection'])!,
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

  /// Reflection about the focus session. Means what did the user achieved with the session.
  /// By default empty string.
  final String reflection;
  const FocusSession(
      {required this.id,
      required this.type,
      required this.state,
      required this.startDateTime,
      required this.durationSecs,
      required this.reflection});
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
    map['reflection'] = Variable<String>(reflection);
    return map;
  }

  FocusSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return FocusSessionsTableCompanion(
      id: Value(id),
      type: Value(type),
      state: Value(state),
      startDateTime: Value(startDateTime),
      durationSecs: Value(durationSecs),
      reflection: Value(reflection),
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
      reflection: serializer.fromJson<String>(json['reflection']),
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
      'reflection': serializer.toJson<String>(reflection),
    };
  }

  FocusSession copyWith(
          {int? id,
          SessionType? type,
          SessionState? state,
          DateTime? startDateTime,
          int? durationSecs,
          String? reflection}) =>
      FocusSession(
        id: id ?? this.id,
        type: type ?? this.type,
        state: state ?? this.state,
        startDateTime: startDateTime ?? this.startDateTime,
        durationSecs: durationSecs ?? this.durationSecs,
        reflection: reflection ?? this.reflection,
      );
  FocusSession copyWithCompanion(FocusSessionsTableCompanion data) {
    return FocusSession(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      state: data.state.present ? data.state.value : this.state,
      startDateTime: data.startDateTime.present
          ? data.startDateTime.value
          : this.startDateTime,
      durationSecs: data.durationSecs.present
          ? data.durationSecs.value
          : this.durationSecs,
      reflection:
          data.reflection.present ? data.reflection.value : this.reflection,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusSession(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('state: $state, ')
          ..write('startDateTime: $startDateTime, ')
          ..write('durationSecs: $durationSecs, ')
          ..write('reflection: $reflection')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, state, startDateTime, durationSecs, reflection);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusSession &&
          other.id == this.id &&
          other.type == this.type &&
          other.state == this.state &&
          other.startDateTime == this.startDateTime &&
          other.durationSecs == this.durationSecs &&
          other.reflection == this.reflection);
}

class FocusSessionsTableCompanion extends UpdateCompanion<FocusSession> {
  final Value<int> id;
  final Value<SessionType> type;
  final Value<SessionState> state;
  final Value<DateTime> startDateTime;
  final Value<int> durationSecs;
  final Value<String> reflection;
  const FocusSessionsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.state = const Value.absent(),
    this.startDateTime = const Value.absent(),
    this.durationSecs = const Value.absent(),
    this.reflection = const Value.absent(),
  });
  FocusSessionsTableCompanion.insert({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.state = const Value.absent(),
    this.startDateTime = const Value.absent(),
    this.durationSecs = const Value.absent(),
    this.reflection = const Value.absent(),
  });
  static Insertable<FocusSession> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<int>? state,
    Expression<DateTime>? startDateTime,
    Expression<int>? durationSecs,
    Expression<String>? reflection,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (state != null) 'state': state,
      if (startDateTime != null) 'start_date_time': startDateTime,
      if (durationSecs != null) 'duration_secs': durationSecs,
      if (reflection != null) 'reflection': reflection,
    });
  }

  FocusSessionsTableCompanion copyWith(
      {Value<int>? id,
      Value<SessionType>? type,
      Value<SessionState>? state,
      Value<DateTime>? startDateTime,
      Value<int>? durationSecs,
      Value<String>? reflection}) {
    return FocusSessionsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      state: state ?? this.state,
      startDateTime: startDateTime ?? this.startDateTime,
      durationSecs: durationSecs ?? this.durationSecs,
      reflection: reflection ?? this.reflection,
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
    if (reflection.present) {
      map['reflection'] = Variable<String>(reflection.value);
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
          ..write('durationSecs: $durationSecs, ')
          ..write('reflection: $reflection')
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
  @override
  late final GeneratedColumnWithTypeConverter<AppThemeMode, int> themeMode =
      GeneratedColumn<int>('theme_mode', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: Constant(AppConstants.defaultThemeMode.index))
          .withConverter<AppThemeMode>(
              $MindfulSettingsTableTable.$converterthemeMode);
  static const VerificationMeta _accentColorMeta =
      const VerificationMeta('accentColor');
  @override
  late final GeneratedColumn<String> accentColor = GeneratedColumn<String>(
      'accent_color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(AppConstants.defaultMaterialColor));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(AppConstants.defaultUsername));
  static const VerificationMeta _localeCodeMeta =
      const VerificationMeta('localeCode');
  @override
  late final GeneratedColumn<String> localeCode = GeneratedColumn<String>(
      'locale_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(AppConstants.defaultLocale));
  static const VerificationMeta _useAmoledDarkMeta =
      const VerificationMeta('useAmoledDark');
  @override
  late final GeneratedColumn<bool> useAmoledDark = GeneratedColumn<bool>(
      'use_amoled_dark', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("use_amoled_dark" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _useDynamicColorsMeta =
      const VerificationMeta('useDynamicColors');
  @override
  late final GeneratedColumn<bool> useDynamicColors = GeneratedColumn<bool>(
      'use_dynamic_colors', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("use_dynamic_colors" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<DefaultHomeTab, int>
      defaultHomeTab = GeneratedColumn<int>(
              'default_home_tab', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: Constant(DefaultHomeTab.dashboard.index))
          .withConverter<DefaultHomeTab>(
              $MindfulSettingsTableTable.$converterdefaultHomeTab);
  static const VerificationMeta _usageHistoryWeeksMeta =
      const VerificationMeta('usageHistoryWeeks');
  @override
  late final GeneratedColumn<int> usageHistoryWeeks = GeneratedColumn<int>(
      'usage_history_weeks', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(4));
  static const VerificationMeta _leftEmergencyPassesMeta =
      const VerificationMeta('leftEmergencyPasses');
  @override
  late final GeneratedColumn<int> leftEmergencyPasses = GeneratedColumn<int>(
      'left_emergency_passes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _lastEmergencyUsedMeta =
      const VerificationMeta('lastEmergencyUsed');
  @override
  late final GeneratedColumn<DateTime> lastEmergencyUsed =
      GeneratedColumn<DateTime>('last_emergency_used', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime(0)));
  static const VerificationMeta _isOnboardingDoneMeta =
      const VerificationMeta('isOnboardingDone');
  @override
  late final GeneratedColumn<bool> isOnboardingDone = GeneratedColumn<bool>(
      'is_onboarding_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_onboarding_done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _appVersionMeta =
      const VerificationMeta('appVersion');
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
      'app_version', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        themeMode,
        accentColor,
        username,
        localeCode,
        useAmoledDark,
        useDynamicColors,
        defaultHomeTab,
        usageHistoryWeeks,
        leftEmergencyPasses,
        lastEmergencyUsed,
        isOnboardingDone,
        appVersion
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
    if (data.containsKey('accent_color')) {
      context.handle(
          _accentColorMeta,
          accentColor.isAcceptableOrUnknown(
              data['accent_color']!, _accentColorMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('locale_code')) {
      context.handle(
          _localeCodeMeta,
          localeCode.isAcceptableOrUnknown(
              data['locale_code']!, _localeCodeMeta));
    }
    if (data.containsKey('use_amoled_dark')) {
      context.handle(
          _useAmoledDarkMeta,
          useAmoledDark.isAcceptableOrUnknown(
              data['use_amoled_dark']!, _useAmoledDarkMeta));
    }
    if (data.containsKey('use_dynamic_colors')) {
      context.handle(
          _useDynamicColorsMeta,
          useDynamicColors.isAcceptableOrUnknown(
              data['use_dynamic_colors']!, _useDynamicColorsMeta));
    }
    if (data.containsKey('usage_history_weeks')) {
      context.handle(
          _usageHistoryWeeksMeta,
          usageHistoryWeeks.isAcceptableOrUnknown(
              data['usage_history_weeks']!, _usageHistoryWeeksMeta));
    }
    if (data.containsKey('left_emergency_passes')) {
      context.handle(
          _leftEmergencyPassesMeta,
          leftEmergencyPasses.isAcceptableOrUnknown(
              data['left_emergency_passes']!, _leftEmergencyPassesMeta));
    }
    if (data.containsKey('last_emergency_used')) {
      context.handle(
          _lastEmergencyUsedMeta,
          lastEmergencyUsed.isAcceptableOrUnknown(
              data['last_emergency_used']!, _lastEmergencyUsedMeta));
    }
    if (data.containsKey('is_onboarding_done')) {
      context.handle(
          _isOnboardingDoneMeta,
          isOnboardingDone.isAcceptableOrUnknown(
              data['is_onboarding_done']!, _isOnboardingDoneMeta));
    }
    if (data.containsKey('app_version')) {
      context.handle(
          _appVersionMeta,
          appVersion.isAcceptableOrUnknown(
              data['app_version']!, _appVersionMeta));
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
      useAmoledDark: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}use_amoled_dark'])!,
      useDynamicColors: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}use_dynamic_colors'])!,
      defaultHomeTab: $MindfulSettingsTableTable.$converterdefaultHomeTab
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}default_home_tab'])!),
      usageHistoryWeeks: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}usage_history_weeks'])!,
      leftEmergencyPasses: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}left_emergency_passes'])!,
      lastEmergencyUsed: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_emergency_used'])!,
      isOnboardingDone: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_onboarding_done'])!,
      appVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_version'])!,
    );
  }

  @override
  $MindfulSettingsTableTable createAlias(String alias) {
    return $MindfulSettingsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AppThemeMode, int, int> $converterthemeMode =
      const EnumIndexConverter<AppThemeMode>(AppThemeMode.values);
  static JsonTypeConverter2<DefaultHomeTab, int, int> $converterdefaultHomeTab =
      const EnumIndexConverter<DefaultHomeTab>(DefaultHomeTab.values);
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

  /// Flag indicating if to use pure amoled black color for dark theme
  final bool useAmoledDark;

  /// Flag indicating if to use wallpaper colors for themes
  final bool useDynamicColors;

  /// Default initial home tab
  final DefaultHomeTab defaultHomeTab;

  /// Maximum number of weeks till the app's usage history will be kept
  final int usageHistoryWeeks;

  /// Number of emergency break passes left for today
  final int leftEmergencyPasses;

  /// Timestamp of the last used emergency break
  final DateTime lastEmergencyUsed;

  /// Flag indicating if onboarding is completed or not
  final bool isOnboardingDone;

  /// The currently installed version of Mindful.
  /// Mainly used to show changelogs screen.
  final String appVersion;
  const MindfulSettings(
      {required this.id,
      required this.themeMode,
      required this.accentColor,
      required this.username,
      required this.localeCode,
      required this.useAmoledDark,
      required this.useDynamicColors,
      required this.defaultHomeTab,
      required this.usageHistoryWeeks,
      required this.leftEmergencyPasses,
      required this.lastEmergencyUsed,
      required this.isOnboardingDone,
      required this.appVersion});
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
    map['use_amoled_dark'] = Variable<bool>(useAmoledDark);
    map['use_dynamic_colors'] = Variable<bool>(useDynamicColors);
    {
      map['default_home_tab'] = Variable<int>($MindfulSettingsTableTable
          .$converterdefaultHomeTab
          .toSql(defaultHomeTab));
    }
    map['usage_history_weeks'] = Variable<int>(usageHistoryWeeks);
    map['left_emergency_passes'] = Variable<int>(leftEmergencyPasses);
    map['last_emergency_used'] = Variable<DateTime>(lastEmergencyUsed);
    map['is_onboarding_done'] = Variable<bool>(isOnboardingDone);
    map['app_version'] = Variable<String>(appVersion);
    return map;
  }

  MindfulSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return MindfulSettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      accentColor: Value(accentColor),
      username: Value(username),
      localeCode: Value(localeCode),
      useAmoledDark: Value(useAmoledDark),
      useDynamicColors: Value(useDynamicColors),
      defaultHomeTab: Value(defaultHomeTab),
      usageHistoryWeeks: Value(usageHistoryWeeks),
      leftEmergencyPasses: Value(leftEmergencyPasses),
      lastEmergencyUsed: Value(lastEmergencyUsed),
      isOnboardingDone: Value(isOnboardingDone),
      appVersion: Value(appVersion),
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
      useAmoledDark: serializer.fromJson<bool>(json['useAmoledDark']),
      useDynamicColors: serializer.fromJson<bool>(json['useDynamicColors']),
      defaultHomeTab: $MindfulSettingsTableTable.$converterdefaultHomeTab
          .fromJson(serializer.fromJson<int>(json['defaultHomeTab'])),
      usageHistoryWeeks: serializer.fromJson<int>(json['usageHistoryWeeks']),
      leftEmergencyPasses:
          serializer.fromJson<int>(json['leftEmergencyPasses']),
      lastEmergencyUsed:
          serializer.fromJson<DateTime>(json['lastEmergencyUsed']),
      isOnboardingDone: serializer.fromJson<bool>(json['isOnboardingDone']),
      appVersion: serializer.fromJson<String>(json['appVersion']),
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
      'useAmoledDark': serializer.toJson<bool>(useAmoledDark),
      'useDynamicColors': serializer.toJson<bool>(useDynamicColors),
      'defaultHomeTab': serializer.toJson<int>($MindfulSettingsTableTable
          .$converterdefaultHomeTab
          .toJson(defaultHomeTab)),
      'usageHistoryWeeks': serializer.toJson<int>(usageHistoryWeeks),
      'leftEmergencyPasses': serializer.toJson<int>(leftEmergencyPasses),
      'lastEmergencyUsed': serializer.toJson<DateTime>(lastEmergencyUsed),
      'isOnboardingDone': serializer.toJson<bool>(isOnboardingDone),
      'appVersion': serializer.toJson<String>(appVersion),
    };
  }

  MindfulSettings copyWith(
          {int? id,
          AppThemeMode? themeMode,
          String? accentColor,
          String? username,
          String? localeCode,
          bool? useAmoledDark,
          bool? useDynamicColors,
          DefaultHomeTab? defaultHomeTab,
          int? usageHistoryWeeks,
          int? leftEmergencyPasses,
          DateTime? lastEmergencyUsed,
          bool? isOnboardingDone,
          String? appVersion}) =>
      MindfulSettings(
        id: id ?? this.id,
        themeMode: themeMode ?? this.themeMode,
        accentColor: accentColor ?? this.accentColor,
        username: username ?? this.username,
        localeCode: localeCode ?? this.localeCode,
        useAmoledDark: useAmoledDark ?? this.useAmoledDark,
        useDynamicColors: useDynamicColors ?? this.useDynamicColors,
        defaultHomeTab: defaultHomeTab ?? this.defaultHomeTab,
        usageHistoryWeeks: usageHistoryWeeks ?? this.usageHistoryWeeks,
        leftEmergencyPasses: leftEmergencyPasses ?? this.leftEmergencyPasses,
        lastEmergencyUsed: lastEmergencyUsed ?? this.lastEmergencyUsed,
        isOnboardingDone: isOnboardingDone ?? this.isOnboardingDone,
        appVersion: appVersion ?? this.appVersion,
      );
  MindfulSettings copyWithCompanion(MindfulSettingsTableCompanion data) {
    return MindfulSettings(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      accentColor:
          data.accentColor.present ? data.accentColor.value : this.accentColor,
      username: data.username.present ? data.username.value : this.username,
      localeCode:
          data.localeCode.present ? data.localeCode.value : this.localeCode,
      useAmoledDark: data.useAmoledDark.present
          ? data.useAmoledDark.value
          : this.useAmoledDark,
      useDynamicColors: data.useDynamicColors.present
          ? data.useDynamicColors.value
          : this.useDynamicColors,
      defaultHomeTab: data.defaultHomeTab.present
          ? data.defaultHomeTab.value
          : this.defaultHomeTab,
      usageHistoryWeeks: data.usageHistoryWeeks.present
          ? data.usageHistoryWeeks.value
          : this.usageHistoryWeeks,
      leftEmergencyPasses: data.leftEmergencyPasses.present
          ? data.leftEmergencyPasses.value
          : this.leftEmergencyPasses,
      lastEmergencyUsed: data.lastEmergencyUsed.present
          ? data.lastEmergencyUsed.value
          : this.lastEmergencyUsed,
      isOnboardingDone: data.isOnboardingDone.present
          ? data.isOnboardingDone.value
          : this.isOnboardingDone,
      appVersion:
          data.appVersion.present ? data.appVersion.value : this.appVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MindfulSettings(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentColor: $accentColor, ')
          ..write('username: $username, ')
          ..write('localeCode: $localeCode, ')
          ..write('useAmoledDark: $useAmoledDark, ')
          ..write('useDynamicColors: $useDynamicColors, ')
          ..write('defaultHomeTab: $defaultHomeTab, ')
          ..write('usageHistoryWeeks: $usageHistoryWeeks, ')
          ..write('leftEmergencyPasses: $leftEmergencyPasses, ')
          ..write('lastEmergencyUsed: $lastEmergencyUsed, ')
          ..write('isOnboardingDone: $isOnboardingDone, ')
          ..write('appVersion: $appVersion')
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
      useAmoledDark,
      useDynamicColors,
      defaultHomeTab,
      usageHistoryWeeks,
      leftEmergencyPasses,
      lastEmergencyUsed,
      isOnboardingDone,
      appVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MindfulSettings &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.accentColor == this.accentColor &&
          other.username == this.username &&
          other.localeCode == this.localeCode &&
          other.useAmoledDark == this.useAmoledDark &&
          other.useDynamicColors == this.useDynamicColors &&
          other.defaultHomeTab == this.defaultHomeTab &&
          other.usageHistoryWeeks == this.usageHistoryWeeks &&
          other.leftEmergencyPasses == this.leftEmergencyPasses &&
          other.lastEmergencyUsed == this.lastEmergencyUsed &&
          other.isOnboardingDone == this.isOnboardingDone &&
          other.appVersion == this.appVersion);
}

class MindfulSettingsTableCompanion extends UpdateCompanion<MindfulSettings> {
  final Value<int> id;
  final Value<AppThemeMode> themeMode;
  final Value<String> accentColor;
  final Value<String> username;
  final Value<String> localeCode;
  final Value<bool> useAmoledDark;
  final Value<bool> useDynamicColors;
  final Value<DefaultHomeTab> defaultHomeTab;
  final Value<int> usageHistoryWeeks;
  final Value<int> leftEmergencyPasses;
  final Value<DateTime> lastEmergencyUsed;
  final Value<bool> isOnboardingDone;
  final Value<String> appVersion;
  const MindfulSettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.username = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.useAmoledDark = const Value.absent(),
    this.useDynamicColors = const Value.absent(),
    this.defaultHomeTab = const Value.absent(),
    this.usageHistoryWeeks = const Value.absent(),
    this.leftEmergencyPasses = const Value.absent(),
    this.lastEmergencyUsed = const Value.absent(),
    this.isOnboardingDone = const Value.absent(),
    this.appVersion = const Value.absent(),
  });
  MindfulSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.username = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.useAmoledDark = const Value.absent(),
    this.useDynamicColors = const Value.absent(),
    this.defaultHomeTab = const Value.absent(),
    this.usageHistoryWeeks = const Value.absent(),
    this.leftEmergencyPasses = const Value.absent(),
    this.lastEmergencyUsed = const Value.absent(),
    this.isOnboardingDone = const Value.absent(),
    this.appVersion = const Value.absent(),
  });
  static Insertable<MindfulSettings> custom({
    Expression<int>? id,
    Expression<int>? themeMode,
    Expression<String>? accentColor,
    Expression<String>? username,
    Expression<String>? localeCode,
    Expression<bool>? useAmoledDark,
    Expression<bool>? useDynamicColors,
    Expression<int>? defaultHomeTab,
    Expression<int>? usageHistoryWeeks,
    Expression<int>? leftEmergencyPasses,
    Expression<DateTime>? lastEmergencyUsed,
    Expression<bool>? isOnboardingDone,
    Expression<String>? appVersion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (accentColor != null) 'accent_color': accentColor,
      if (username != null) 'username': username,
      if (localeCode != null) 'locale_code': localeCode,
      if (useAmoledDark != null) 'use_amoled_dark': useAmoledDark,
      if (useDynamicColors != null) 'use_dynamic_colors': useDynamicColors,
      if (defaultHomeTab != null) 'default_home_tab': defaultHomeTab,
      if (usageHistoryWeeks != null) 'usage_history_weeks': usageHistoryWeeks,
      if (leftEmergencyPasses != null)
        'left_emergency_passes': leftEmergencyPasses,
      if (lastEmergencyUsed != null) 'last_emergency_used': lastEmergencyUsed,
      if (isOnboardingDone != null) 'is_onboarding_done': isOnboardingDone,
      if (appVersion != null) 'app_version': appVersion,
    });
  }

  MindfulSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<AppThemeMode>? themeMode,
      Value<String>? accentColor,
      Value<String>? username,
      Value<String>? localeCode,
      Value<bool>? useAmoledDark,
      Value<bool>? useDynamicColors,
      Value<DefaultHomeTab>? defaultHomeTab,
      Value<int>? usageHistoryWeeks,
      Value<int>? leftEmergencyPasses,
      Value<DateTime>? lastEmergencyUsed,
      Value<bool>? isOnboardingDone,
      Value<String>? appVersion}) {
    return MindfulSettingsTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      username: username ?? this.username,
      localeCode: localeCode ?? this.localeCode,
      useAmoledDark: useAmoledDark ?? this.useAmoledDark,
      useDynamicColors: useDynamicColors ?? this.useDynamicColors,
      defaultHomeTab: defaultHomeTab ?? this.defaultHomeTab,
      usageHistoryWeeks: usageHistoryWeeks ?? this.usageHistoryWeeks,
      leftEmergencyPasses: leftEmergencyPasses ?? this.leftEmergencyPasses,
      lastEmergencyUsed: lastEmergencyUsed ?? this.lastEmergencyUsed,
      isOnboardingDone: isOnboardingDone ?? this.isOnboardingDone,
      appVersion: appVersion ?? this.appVersion,
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
    if (useAmoledDark.present) {
      map['use_amoled_dark'] = Variable<bool>(useAmoledDark.value);
    }
    if (useDynamicColors.present) {
      map['use_dynamic_colors'] = Variable<bool>(useDynamicColors.value);
    }
    if (defaultHomeTab.present) {
      map['default_home_tab'] = Variable<int>($MindfulSettingsTableTable
          .$converterdefaultHomeTab
          .toSql(defaultHomeTab.value));
    }
    if (usageHistoryWeeks.present) {
      map['usage_history_weeks'] = Variable<int>(usageHistoryWeeks.value);
    }
    if (leftEmergencyPasses.present) {
      map['left_emergency_passes'] = Variable<int>(leftEmergencyPasses.value);
    }
    if (lastEmergencyUsed.present) {
      map['last_emergency_used'] = Variable<DateTime>(lastEmergencyUsed.value);
    }
    if (isOnboardingDone.present) {
      map['is_onboarding_done'] = Variable<bool>(isOnboardingDone.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
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
          ..write('useAmoledDark: $useAmoledDark, ')
          ..write('useDynamicColors: $useDynamicColors, ')
          ..write('defaultHomeTab: $defaultHomeTab, ')
          ..write('usageHistoryWeeks: $usageHistoryWeeks, ')
          ..write('leftEmergencyPasses: $leftEmergencyPasses, ')
          ..write('lastEmergencyUsed: $lastEmergencyUsed, ')
          ..write('isOnboardingDone: $isOnboardingDone, ')
          ..write('appVersion: $appVersion')
          ..write(')'))
        .toString();
  }
}

class $ParentalControlsTableTable extends ParentalControlsTable
    with TableInfo<$ParentalControlsTableTable, ParentalControls> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParentalControlsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _protectedAccessMeta =
      const VerificationMeta('protectedAccess');
  @override
  late final GeneratedColumn<bool> protectedAccess = GeneratedColumn<bool>(
      'protected_access', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("protected_access" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      uninstallWindowTime = GeneratedColumn<int>(
              'uninstall_window_time', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $ParentalControlsTableTable.$converteruninstallWindowTime);
  static const VerificationMeta _isInvincibleModeOnMeta =
      const VerificationMeta('isInvincibleModeOn');
  @override
  late final GeneratedColumn<bool> isInvincibleModeOn = GeneratedColumn<bool>(
      'is_invincible_mode_on', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_invincible_mode_on" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      invincibleWindowTime = GeneratedColumn<int>(
              'invincible_window_time', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $ParentalControlsTableTable.$converterinvincibleWindowTime);
  static const VerificationMeta _includeAppsTimerMeta =
      const VerificationMeta('includeAppsTimer');
  @override
  late final GeneratedColumn<bool> includeAppsTimer = GeneratedColumn<bool>(
      'include_apps_timer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("include_apps_timer" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _includeAppsLaunchLimitMeta =
      const VerificationMeta('includeAppsLaunchLimit');
  @override
  late final GeneratedColumn<bool> includeAppsLaunchLimit =
      GeneratedColumn<bool>('include_apps_launch_limit', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("include_apps_launch_limit" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _includeAppsActivePeriodMeta =
      const VerificationMeta('includeAppsActivePeriod');
  @override
  late final GeneratedColumn<bool> includeAppsActivePeriod =
      GeneratedColumn<bool>('include_apps_active_period', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("include_apps_active_period" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _includeGroupsTimerMeta =
      const VerificationMeta('includeGroupsTimer');
  @override
  late final GeneratedColumn<bool> includeGroupsTimer = GeneratedColumn<bool>(
      'include_groups_timer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("include_groups_timer" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _includeGroupsActivePeriodMeta =
      const VerificationMeta('includeGroupsActivePeriod');
  @override
  late final GeneratedColumn<bool> includeGroupsActivePeriod =
      GeneratedColumn<bool>('include_groups_active_period', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("include_groups_active_period" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _includeShortsTimerMeta =
      const VerificationMeta('includeShortsTimer');
  @override
  late final GeneratedColumn<bool> includeShortsTimer = GeneratedColumn<bool>(
      'include_shorts_timer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("include_shorts_timer" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _includeBedtimeScheduleMeta =
      const VerificationMeta('includeBedtimeSchedule');
  @override
  late final GeneratedColumn<bool> includeBedtimeSchedule =
      GeneratedColumn<bool>('include_bedtime_schedule', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("include_bedtime_schedule" IN (0, 1))'),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        protectedAccess,
        uninstallWindowTime,
        isInvincibleModeOn,
        invincibleWindowTime,
        includeAppsTimer,
        includeAppsLaunchLimit,
        includeAppsActivePeriod,
        includeGroupsTimer,
        includeGroupsActivePeriod,
        includeShortsTimer,
        includeBedtimeSchedule
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parental_controls_table';
  @override
  VerificationContext validateIntegrity(Insertable<ParentalControls> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('protected_access')) {
      context.handle(
          _protectedAccessMeta,
          protectedAccess.isAcceptableOrUnknown(
              data['protected_access']!, _protectedAccessMeta));
    }
    if (data.containsKey('is_invincible_mode_on')) {
      context.handle(
          _isInvincibleModeOnMeta,
          isInvincibleModeOn.isAcceptableOrUnknown(
              data['is_invincible_mode_on']!, _isInvincibleModeOnMeta));
    }
    if (data.containsKey('include_apps_timer')) {
      context.handle(
          _includeAppsTimerMeta,
          includeAppsTimer.isAcceptableOrUnknown(
              data['include_apps_timer']!, _includeAppsTimerMeta));
    }
    if (data.containsKey('include_apps_launch_limit')) {
      context.handle(
          _includeAppsLaunchLimitMeta,
          includeAppsLaunchLimit.isAcceptableOrUnknown(
              data['include_apps_launch_limit']!, _includeAppsLaunchLimitMeta));
    }
    if (data.containsKey('include_apps_active_period')) {
      context.handle(
          _includeAppsActivePeriodMeta,
          includeAppsActivePeriod.isAcceptableOrUnknown(
              data['include_apps_active_period']!,
              _includeAppsActivePeriodMeta));
    }
    if (data.containsKey('include_groups_timer')) {
      context.handle(
          _includeGroupsTimerMeta,
          includeGroupsTimer.isAcceptableOrUnknown(
              data['include_groups_timer']!, _includeGroupsTimerMeta));
    }
    if (data.containsKey('include_groups_active_period')) {
      context.handle(
          _includeGroupsActivePeriodMeta,
          includeGroupsActivePeriod.isAcceptableOrUnknown(
              data['include_groups_active_period']!,
              _includeGroupsActivePeriodMeta));
    }
    if (data.containsKey('include_shorts_timer')) {
      context.handle(
          _includeShortsTimerMeta,
          includeShortsTimer.isAcceptableOrUnknown(
              data['include_shorts_timer']!, _includeShortsTimerMeta));
    }
    if (data.containsKey('include_bedtime_schedule')) {
      context.handle(
          _includeBedtimeScheduleMeta,
          includeBedtimeSchedule.isAcceptableOrUnknown(
              data['include_bedtime_schedule']!, _includeBedtimeScheduleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ParentalControls map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParentalControls(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      protectedAccess: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}protected_access'])!,
      uninstallWindowTime: $ParentalControlsTableTable
          .$converteruninstallWindowTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}uninstall_window_time'])!),
      isInvincibleModeOn: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_invincible_mode_on'])!,
      invincibleWindowTime: $ParentalControlsTableTable
          .$converterinvincibleWindowTime
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}invincible_window_time'])!),
      includeAppsTimer: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}include_apps_timer'])!,
      includeAppsLaunchLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}include_apps_launch_limit'])!,
      includeAppsActivePeriod: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}include_apps_active_period'])!,
      includeGroupsTimer: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}include_groups_timer'])!,
      includeGroupsActivePeriod: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}include_groups_active_period'])!,
      includeShortsTimer: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}include_shorts_timer'])!,
      includeBedtimeSchedule: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}include_bedtime_schedule'])!,
    );
  }

  @override
  $ParentalControlsTableTable createAlias(String alias) {
    return $ParentalControlsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converteruninstallWindowTime = const TimeOfDayAdapterConverter();
  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converterinvincibleWindowTime = const TimeOfDayAdapterConverter();
}

class ParentalControls extends DataClass
    implements Insertable<ParentalControls> {
  /// Unique ID for Invincible Mode settings
  final int id;

  /// Flag indicating whether to authenticate before opening Mindful or not
  final bool protectedAccess;

  /// Daily uninstall window start time [TimeOfDay] stored as minutes
  final TimeOfDayAdapter uninstallWindowTime;

  /// Flag indicating if invincible mode is ON
  final bool isInvincibleModeOn;

  /// Daily invincible window start time [TimeOfDay] stored as minutes
  final TimeOfDayAdapter invincibleWindowTime;

  /// Flag indicating if apps timer are included in the invincible mode
  ///
  /// If included user cannot modify app timer if it is already ran out
  final bool includeAppsTimer;

  /// Flag indicating if apps launch count limit is included in the invincible mode
  ///
  /// If included user cannot modify app launch count limit if it is already ran out
  final bool includeAppsLaunchLimit;

  /// Flag indicating if apps active period is included in the invincible mode
  ///
  /// If included user cannot modify app launch count limit if it is already ran out
  final bool includeAppsActivePeriod;

  /// Flag indicating if groups timer are included in the invincible mode
  ///
  /// If included user cannot modify group timer if it is already ran out
  final bool includeGroupsTimer;

  /// Flag indicating if groups active period is included in the invincible mode
  ///
  /// If included user cannot modify group timer if it is already ran out
  final bool includeGroupsActivePeriod;

  /// Flag indicating if short content's timer is included in the invincible mode
  ///
  /// If included user cannot modify short content timer if it is already ran out
  final bool includeShortsTimer;

  /// Flag indicating if bedtime schedule is included in the invincible mode
  ///
  /// If included user cannot modify bedtime schedule during the active period
  final bool includeBedtimeSchedule;
  const ParentalControls(
      {required this.id,
      required this.protectedAccess,
      required this.uninstallWindowTime,
      required this.isInvincibleModeOn,
      required this.invincibleWindowTime,
      required this.includeAppsTimer,
      required this.includeAppsLaunchLimit,
      required this.includeAppsActivePeriod,
      required this.includeGroupsTimer,
      required this.includeGroupsActivePeriod,
      required this.includeShortsTimer,
      required this.includeBedtimeSchedule});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['protected_access'] = Variable<bool>(protectedAccess);
    {
      map['uninstall_window_time'] = Variable<int>($ParentalControlsTableTable
          .$converteruninstallWindowTime
          .toSql(uninstallWindowTime));
    }
    map['is_invincible_mode_on'] = Variable<bool>(isInvincibleModeOn);
    {
      map['invincible_window_time'] = Variable<int>($ParentalControlsTableTable
          .$converterinvincibleWindowTime
          .toSql(invincibleWindowTime));
    }
    map['include_apps_timer'] = Variable<bool>(includeAppsTimer);
    map['include_apps_launch_limit'] = Variable<bool>(includeAppsLaunchLimit);
    map['include_apps_active_period'] = Variable<bool>(includeAppsActivePeriod);
    map['include_groups_timer'] = Variable<bool>(includeGroupsTimer);
    map['include_groups_active_period'] =
        Variable<bool>(includeGroupsActivePeriod);
    map['include_shorts_timer'] = Variable<bool>(includeShortsTimer);
    map['include_bedtime_schedule'] = Variable<bool>(includeBedtimeSchedule);
    return map;
  }

  ParentalControlsTableCompanion toCompanion(bool nullToAbsent) {
    return ParentalControlsTableCompanion(
      id: Value(id),
      protectedAccess: Value(protectedAccess),
      uninstallWindowTime: Value(uninstallWindowTime),
      isInvincibleModeOn: Value(isInvincibleModeOn),
      invincibleWindowTime: Value(invincibleWindowTime),
      includeAppsTimer: Value(includeAppsTimer),
      includeAppsLaunchLimit: Value(includeAppsLaunchLimit),
      includeAppsActivePeriod: Value(includeAppsActivePeriod),
      includeGroupsTimer: Value(includeGroupsTimer),
      includeGroupsActivePeriod: Value(includeGroupsActivePeriod),
      includeShortsTimer: Value(includeShortsTimer),
      includeBedtimeSchedule: Value(includeBedtimeSchedule),
    );
  }

  factory ParentalControls.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParentalControls(
      id: serializer.fromJson<int>(json['id']),
      protectedAccess: serializer.fromJson<bool>(json['protectedAccess']),
      uninstallWindowTime: $ParentalControlsTableTable
          .$converteruninstallWindowTime
          .fromJson(serializer.fromJson<dynamic>(json['uninstallWindowTime'])),
      isInvincibleModeOn: serializer.fromJson<bool>(json['isInvincibleModeOn']),
      invincibleWindowTime: $ParentalControlsTableTable
          .$converterinvincibleWindowTime
          .fromJson(serializer.fromJson<dynamic>(json['invincibleWindowTime'])),
      includeAppsTimer: serializer.fromJson<bool>(json['includeAppsTimer']),
      includeAppsLaunchLimit:
          serializer.fromJson<bool>(json['includeAppsLaunchLimit']),
      includeAppsActivePeriod:
          serializer.fromJson<bool>(json['includeAppsActivePeriod']),
      includeGroupsTimer: serializer.fromJson<bool>(json['includeGroupsTimer']),
      includeGroupsActivePeriod:
          serializer.fromJson<bool>(json['includeGroupsActivePeriod']),
      includeShortsTimer: serializer.fromJson<bool>(json['includeShortsTimer']),
      includeBedtimeSchedule:
          serializer.fromJson<bool>(json['includeBedtimeSchedule']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'protectedAccess': serializer.toJson<bool>(protectedAccess),
      'uninstallWindowTime': serializer.toJson<dynamic>(
          $ParentalControlsTableTable.$converteruninstallWindowTime
              .toJson(uninstallWindowTime)),
      'isInvincibleModeOn': serializer.toJson<bool>(isInvincibleModeOn),
      'invincibleWindowTime': serializer.toJson<dynamic>(
          $ParentalControlsTableTable.$converterinvincibleWindowTime
              .toJson(invincibleWindowTime)),
      'includeAppsTimer': serializer.toJson<bool>(includeAppsTimer),
      'includeAppsLaunchLimit': serializer.toJson<bool>(includeAppsLaunchLimit),
      'includeAppsActivePeriod':
          serializer.toJson<bool>(includeAppsActivePeriod),
      'includeGroupsTimer': serializer.toJson<bool>(includeGroupsTimer),
      'includeGroupsActivePeriod':
          serializer.toJson<bool>(includeGroupsActivePeriod),
      'includeShortsTimer': serializer.toJson<bool>(includeShortsTimer),
      'includeBedtimeSchedule': serializer.toJson<bool>(includeBedtimeSchedule),
    };
  }

  ParentalControls copyWith(
          {int? id,
          bool? protectedAccess,
          TimeOfDayAdapter? uninstallWindowTime,
          bool? isInvincibleModeOn,
          TimeOfDayAdapter? invincibleWindowTime,
          bool? includeAppsTimer,
          bool? includeAppsLaunchLimit,
          bool? includeAppsActivePeriod,
          bool? includeGroupsTimer,
          bool? includeGroupsActivePeriod,
          bool? includeShortsTimer,
          bool? includeBedtimeSchedule}) =>
      ParentalControls(
        id: id ?? this.id,
        protectedAccess: protectedAccess ?? this.protectedAccess,
        uninstallWindowTime: uninstallWindowTime ?? this.uninstallWindowTime,
        isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
        invincibleWindowTime: invincibleWindowTime ?? this.invincibleWindowTime,
        includeAppsTimer: includeAppsTimer ?? this.includeAppsTimer,
        includeAppsLaunchLimit:
            includeAppsLaunchLimit ?? this.includeAppsLaunchLimit,
        includeAppsActivePeriod:
            includeAppsActivePeriod ?? this.includeAppsActivePeriod,
        includeGroupsTimer: includeGroupsTimer ?? this.includeGroupsTimer,
        includeGroupsActivePeriod:
            includeGroupsActivePeriod ?? this.includeGroupsActivePeriod,
        includeShortsTimer: includeShortsTimer ?? this.includeShortsTimer,
        includeBedtimeSchedule:
            includeBedtimeSchedule ?? this.includeBedtimeSchedule,
      );
  ParentalControls copyWithCompanion(ParentalControlsTableCompanion data) {
    return ParentalControls(
      id: data.id.present ? data.id.value : this.id,
      protectedAccess: data.protectedAccess.present
          ? data.protectedAccess.value
          : this.protectedAccess,
      uninstallWindowTime: data.uninstallWindowTime.present
          ? data.uninstallWindowTime.value
          : this.uninstallWindowTime,
      isInvincibleModeOn: data.isInvincibleModeOn.present
          ? data.isInvincibleModeOn.value
          : this.isInvincibleModeOn,
      invincibleWindowTime: data.invincibleWindowTime.present
          ? data.invincibleWindowTime.value
          : this.invincibleWindowTime,
      includeAppsTimer: data.includeAppsTimer.present
          ? data.includeAppsTimer.value
          : this.includeAppsTimer,
      includeAppsLaunchLimit: data.includeAppsLaunchLimit.present
          ? data.includeAppsLaunchLimit.value
          : this.includeAppsLaunchLimit,
      includeAppsActivePeriod: data.includeAppsActivePeriod.present
          ? data.includeAppsActivePeriod.value
          : this.includeAppsActivePeriod,
      includeGroupsTimer: data.includeGroupsTimer.present
          ? data.includeGroupsTimer.value
          : this.includeGroupsTimer,
      includeGroupsActivePeriod: data.includeGroupsActivePeriod.present
          ? data.includeGroupsActivePeriod.value
          : this.includeGroupsActivePeriod,
      includeShortsTimer: data.includeShortsTimer.present
          ? data.includeShortsTimer.value
          : this.includeShortsTimer,
      includeBedtimeSchedule: data.includeBedtimeSchedule.present
          ? data.includeBedtimeSchedule.value
          : this.includeBedtimeSchedule,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParentalControls(')
          ..write('id: $id, ')
          ..write('protectedAccess: $protectedAccess, ')
          ..write('uninstallWindowTime: $uninstallWindowTime, ')
          ..write('isInvincibleModeOn: $isInvincibleModeOn, ')
          ..write('invincibleWindowTime: $invincibleWindowTime, ')
          ..write('includeAppsTimer: $includeAppsTimer, ')
          ..write('includeAppsLaunchLimit: $includeAppsLaunchLimit, ')
          ..write('includeAppsActivePeriod: $includeAppsActivePeriod, ')
          ..write('includeGroupsTimer: $includeGroupsTimer, ')
          ..write('includeGroupsActivePeriod: $includeGroupsActivePeriod, ')
          ..write('includeShortsTimer: $includeShortsTimer, ')
          ..write('includeBedtimeSchedule: $includeBedtimeSchedule')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      protectedAccess,
      uninstallWindowTime,
      isInvincibleModeOn,
      invincibleWindowTime,
      includeAppsTimer,
      includeAppsLaunchLimit,
      includeAppsActivePeriod,
      includeGroupsTimer,
      includeGroupsActivePeriod,
      includeShortsTimer,
      includeBedtimeSchedule);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParentalControls &&
          other.id == this.id &&
          other.protectedAccess == this.protectedAccess &&
          other.uninstallWindowTime == this.uninstallWindowTime &&
          other.isInvincibleModeOn == this.isInvincibleModeOn &&
          other.invincibleWindowTime == this.invincibleWindowTime &&
          other.includeAppsTimer == this.includeAppsTimer &&
          other.includeAppsLaunchLimit == this.includeAppsLaunchLimit &&
          other.includeAppsActivePeriod == this.includeAppsActivePeriod &&
          other.includeGroupsTimer == this.includeGroupsTimer &&
          other.includeGroupsActivePeriod == this.includeGroupsActivePeriod &&
          other.includeShortsTimer == this.includeShortsTimer &&
          other.includeBedtimeSchedule == this.includeBedtimeSchedule);
}

class ParentalControlsTableCompanion extends UpdateCompanion<ParentalControls> {
  final Value<int> id;
  final Value<bool> protectedAccess;
  final Value<TimeOfDayAdapter> uninstallWindowTime;
  final Value<bool> isInvincibleModeOn;
  final Value<TimeOfDayAdapter> invincibleWindowTime;
  final Value<bool> includeAppsTimer;
  final Value<bool> includeAppsLaunchLimit;
  final Value<bool> includeAppsActivePeriod;
  final Value<bool> includeGroupsTimer;
  final Value<bool> includeGroupsActivePeriod;
  final Value<bool> includeShortsTimer;
  final Value<bool> includeBedtimeSchedule;
  const ParentalControlsTableCompanion({
    this.id = const Value.absent(),
    this.protectedAccess = const Value.absent(),
    this.uninstallWindowTime = const Value.absent(),
    this.isInvincibleModeOn = const Value.absent(),
    this.invincibleWindowTime = const Value.absent(),
    this.includeAppsTimer = const Value.absent(),
    this.includeAppsLaunchLimit = const Value.absent(),
    this.includeAppsActivePeriod = const Value.absent(),
    this.includeGroupsTimer = const Value.absent(),
    this.includeGroupsActivePeriod = const Value.absent(),
    this.includeShortsTimer = const Value.absent(),
    this.includeBedtimeSchedule = const Value.absent(),
  });
  ParentalControlsTableCompanion.insert({
    this.id = const Value.absent(),
    this.protectedAccess = const Value.absent(),
    this.uninstallWindowTime = const Value.absent(),
    this.isInvincibleModeOn = const Value.absent(),
    this.invincibleWindowTime = const Value.absent(),
    this.includeAppsTimer = const Value.absent(),
    this.includeAppsLaunchLimit = const Value.absent(),
    this.includeAppsActivePeriod = const Value.absent(),
    this.includeGroupsTimer = const Value.absent(),
    this.includeGroupsActivePeriod = const Value.absent(),
    this.includeShortsTimer = const Value.absent(),
    this.includeBedtimeSchedule = const Value.absent(),
  });
  static Insertable<ParentalControls> custom({
    Expression<int>? id,
    Expression<bool>? protectedAccess,
    Expression<int>? uninstallWindowTime,
    Expression<bool>? isInvincibleModeOn,
    Expression<int>? invincibleWindowTime,
    Expression<bool>? includeAppsTimer,
    Expression<bool>? includeAppsLaunchLimit,
    Expression<bool>? includeAppsActivePeriod,
    Expression<bool>? includeGroupsTimer,
    Expression<bool>? includeGroupsActivePeriod,
    Expression<bool>? includeShortsTimer,
    Expression<bool>? includeBedtimeSchedule,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (protectedAccess != null) 'protected_access': protectedAccess,
      if (uninstallWindowTime != null)
        'uninstall_window_time': uninstallWindowTime,
      if (isInvincibleModeOn != null)
        'is_invincible_mode_on': isInvincibleModeOn,
      if (invincibleWindowTime != null)
        'invincible_window_time': invincibleWindowTime,
      if (includeAppsTimer != null) 'include_apps_timer': includeAppsTimer,
      if (includeAppsLaunchLimit != null)
        'include_apps_launch_limit': includeAppsLaunchLimit,
      if (includeAppsActivePeriod != null)
        'include_apps_active_period': includeAppsActivePeriod,
      if (includeGroupsTimer != null)
        'include_groups_timer': includeGroupsTimer,
      if (includeGroupsActivePeriod != null)
        'include_groups_active_period': includeGroupsActivePeriod,
      if (includeShortsTimer != null)
        'include_shorts_timer': includeShortsTimer,
      if (includeBedtimeSchedule != null)
        'include_bedtime_schedule': includeBedtimeSchedule,
    });
  }

  ParentalControlsTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? protectedAccess,
      Value<TimeOfDayAdapter>? uninstallWindowTime,
      Value<bool>? isInvincibleModeOn,
      Value<TimeOfDayAdapter>? invincibleWindowTime,
      Value<bool>? includeAppsTimer,
      Value<bool>? includeAppsLaunchLimit,
      Value<bool>? includeAppsActivePeriod,
      Value<bool>? includeGroupsTimer,
      Value<bool>? includeGroupsActivePeriod,
      Value<bool>? includeShortsTimer,
      Value<bool>? includeBedtimeSchedule}) {
    return ParentalControlsTableCompanion(
      id: id ?? this.id,
      protectedAccess: protectedAccess ?? this.protectedAccess,
      uninstallWindowTime: uninstallWindowTime ?? this.uninstallWindowTime,
      isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
      invincibleWindowTime: invincibleWindowTime ?? this.invincibleWindowTime,
      includeAppsTimer: includeAppsTimer ?? this.includeAppsTimer,
      includeAppsLaunchLimit:
          includeAppsLaunchLimit ?? this.includeAppsLaunchLimit,
      includeAppsActivePeriod:
          includeAppsActivePeriod ?? this.includeAppsActivePeriod,
      includeGroupsTimer: includeGroupsTimer ?? this.includeGroupsTimer,
      includeGroupsActivePeriod:
          includeGroupsActivePeriod ?? this.includeGroupsActivePeriod,
      includeShortsTimer: includeShortsTimer ?? this.includeShortsTimer,
      includeBedtimeSchedule:
          includeBedtimeSchedule ?? this.includeBedtimeSchedule,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (protectedAccess.present) {
      map['protected_access'] = Variable<bool>(protectedAccess.value);
    }
    if (uninstallWindowTime.present) {
      map['uninstall_window_time'] = Variable<int>($ParentalControlsTableTable
          .$converteruninstallWindowTime
          .toSql(uninstallWindowTime.value));
    }
    if (isInvincibleModeOn.present) {
      map['is_invincible_mode_on'] = Variable<bool>(isInvincibleModeOn.value);
    }
    if (invincibleWindowTime.present) {
      map['invincible_window_time'] = Variable<int>($ParentalControlsTableTable
          .$converterinvincibleWindowTime
          .toSql(invincibleWindowTime.value));
    }
    if (includeAppsTimer.present) {
      map['include_apps_timer'] = Variable<bool>(includeAppsTimer.value);
    }
    if (includeAppsLaunchLimit.present) {
      map['include_apps_launch_limit'] =
          Variable<bool>(includeAppsLaunchLimit.value);
    }
    if (includeAppsActivePeriod.present) {
      map['include_apps_active_period'] =
          Variable<bool>(includeAppsActivePeriod.value);
    }
    if (includeGroupsTimer.present) {
      map['include_groups_timer'] = Variable<bool>(includeGroupsTimer.value);
    }
    if (includeGroupsActivePeriod.present) {
      map['include_groups_active_period'] =
          Variable<bool>(includeGroupsActivePeriod.value);
    }
    if (includeShortsTimer.present) {
      map['include_shorts_timer'] = Variable<bool>(includeShortsTimer.value);
    }
    if (includeBedtimeSchedule.present) {
      map['include_bedtime_schedule'] =
          Variable<bool>(includeBedtimeSchedule.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParentalControlsTableCompanion(')
          ..write('id: $id, ')
          ..write('protectedAccess: $protectedAccess, ')
          ..write('uninstallWindowTime: $uninstallWindowTime, ')
          ..write('isInvincibleModeOn: $isInvincibleModeOn, ')
          ..write('invincibleWindowTime: $invincibleWindowTime, ')
          ..write('includeAppsTimer: $includeAppsTimer, ')
          ..write('includeAppsLaunchLimit: $includeAppsLaunchLimit, ')
          ..write('includeAppsActivePeriod: $includeAppsActivePeriod, ')
          ..write('includeGroupsTimer: $includeGroupsTimer, ')
          ..write('includeGroupsActivePeriod: $includeGroupsActivePeriod, ')
          ..write('includeShortsTimer: $includeShortsTimer, ')
          ..write('includeBedtimeSchedule: $includeBedtimeSchedule')
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
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("Social"));
  static const VerificationMeta _timerSecMeta =
      const VerificationMeta('timerSec');
  @override
  late final GeneratedColumn<int> timerSec = GeneratedColumn<int>(
      'timer_sec', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      activePeriodStart = GeneratedColumn<int>(
              'active_period_start', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $RestrictionGroupsTableTable.$converteractivePeriodStart);
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      activePeriodEnd = GeneratedColumn<int>(
              'active_period_end', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $RestrictionGroupsTableTable.$converteractivePeriodEnd);
  static const VerificationMeta _periodDurationInMinsMeta =
      const VerificationMeta('periodDurationInMins');
  @override
  late final GeneratedColumn<int> periodDurationInMins = GeneratedColumn<int>(
      'period_duration_in_mins', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      distractingApps = GeneratedColumn<String>(
              'distracting_apps', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<String>>(
              $RestrictionGroupsTableTable.$converterdistractingApps);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupName,
        timerSec,
        activePeriodStart,
        activePeriodEnd,
        periodDurationInMins,
        distractingApps
      ];
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
    }
    if (data.containsKey('timer_sec')) {
      context.handle(_timerSecMeta,
          timerSec.isAcceptableOrUnknown(data['timer_sec']!, _timerSecMeta));
    }
    if (data.containsKey('period_duration_in_mins')) {
      context.handle(
          _periodDurationInMinsMeta,
          periodDurationInMins.isAcceptableOrUnknown(
              data['period_duration_in_mins']!, _periodDurationInMinsMeta));
    }
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
      activePeriodStart: $RestrictionGroupsTableTable
          .$converteractivePeriodStart
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.int,
              data['${effectivePrefix}active_period_start'])!),
      activePeriodEnd: $RestrictionGroupsTableTable.$converteractivePeriodEnd
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}active_period_end'])!),
      periodDurationInMins: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}period_duration_in_mins'])!,
      distractingApps: $RestrictionGroupsTableTable.$converterdistractingApps
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}distracting_apps'])!),
    );
  }

  @override
  $RestrictionGroupsTableTable createAlias(String alias) {
    return $RestrictionGroupsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converteractivePeriodStart = const TimeOfDayAdapterConverter();
  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic>
      $converteractivePeriodEnd = const TimeOfDayAdapterConverter();
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

  /// [TimeOfDay] in minutes from where the active period will start.
  /// It is stored as total minutes.
  final TimeOfDayAdapter activePeriodStart;

  /// [TimeOfDay] in minutes when the active period will end
  /// It is stored as total minutes.
  final TimeOfDayAdapter activePeriodEnd;

  /// Total duration of active period from start to end in MINUTES
  final int periodDurationInMins;

  /// List of app's packages which are associated with the group.
  final List<String> distractingApps;
  const RestrictionGroup(
      {required this.id,
      required this.groupName,
      required this.timerSec,
      required this.activePeriodStart,
      required this.activePeriodEnd,
      required this.periodDurationInMins,
      required this.distractingApps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_name'] = Variable<String>(groupName);
    map['timer_sec'] = Variable<int>(timerSec);
    {
      map['active_period_start'] = Variable<int>($RestrictionGroupsTableTable
          .$converteractivePeriodStart
          .toSql(activePeriodStart));
    }
    {
      map['active_period_end'] = Variable<int>($RestrictionGroupsTableTable
          .$converteractivePeriodEnd
          .toSql(activePeriodEnd));
    }
    map['period_duration_in_mins'] = Variable<int>(periodDurationInMins);
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
      activePeriodStart: Value(activePeriodStart),
      activePeriodEnd: Value(activePeriodEnd),
      periodDurationInMins: Value(periodDurationInMins),
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
      activePeriodStart: $RestrictionGroupsTableTable
          .$converteractivePeriodStart
          .fromJson(serializer.fromJson<dynamic>(json['activePeriodStart'])),
      activePeriodEnd: $RestrictionGroupsTableTable.$converteractivePeriodEnd
          .fromJson(serializer.fromJson<dynamic>(json['activePeriodEnd'])),
      periodDurationInMins:
          serializer.fromJson<int>(json['periodDurationInMins']),
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
      'activePeriodStart': serializer.toJson<dynamic>(
          $RestrictionGroupsTableTable.$converteractivePeriodStart
              .toJson(activePeriodStart)),
      'activePeriodEnd': serializer.toJson<dynamic>($RestrictionGroupsTableTable
          .$converteractivePeriodEnd
          .toJson(activePeriodEnd)),
      'periodDurationInMins': serializer.toJson<int>(periodDurationInMins),
      'distractingApps': serializer.toJson<List<String>>(distractingApps),
    };
  }

  RestrictionGroup copyWith(
          {int? id,
          String? groupName,
          int? timerSec,
          TimeOfDayAdapter? activePeriodStart,
          TimeOfDayAdapter? activePeriodEnd,
          int? periodDurationInMins,
          List<String>? distractingApps}) =>
      RestrictionGroup(
        id: id ?? this.id,
        groupName: groupName ?? this.groupName,
        timerSec: timerSec ?? this.timerSec,
        activePeriodStart: activePeriodStart ?? this.activePeriodStart,
        activePeriodEnd: activePeriodEnd ?? this.activePeriodEnd,
        periodDurationInMins: periodDurationInMins ?? this.periodDurationInMins,
        distractingApps: distractingApps ?? this.distractingApps,
      );
  RestrictionGroup copyWithCompanion(RestrictionGroupsTableCompanion data) {
    return RestrictionGroup(
      id: data.id.present ? data.id.value : this.id,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      timerSec: data.timerSec.present ? data.timerSec.value : this.timerSec,
      activePeriodStart: data.activePeriodStart.present
          ? data.activePeriodStart.value
          : this.activePeriodStart,
      activePeriodEnd: data.activePeriodEnd.present
          ? data.activePeriodEnd.value
          : this.activePeriodEnd,
      periodDurationInMins: data.periodDurationInMins.present
          ? data.periodDurationInMins.value
          : this.periodDurationInMins,
      distractingApps: data.distractingApps.present
          ? data.distractingApps.value
          : this.distractingApps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestrictionGroup(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('timerSec: $timerSec, ')
          ..write('activePeriodStart: $activePeriodStart, ')
          ..write('activePeriodEnd: $activePeriodEnd, ')
          ..write('periodDurationInMins: $periodDurationInMins, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupName, timerSec, activePeriodStart,
      activePeriodEnd, periodDurationInMins, distractingApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestrictionGroup &&
          other.id == this.id &&
          other.groupName == this.groupName &&
          other.timerSec == this.timerSec &&
          other.activePeriodStart == this.activePeriodStart &&
          other.activePeriodEnd == this.activePeriodEnd &&
          other.periodDurationInMins == this.periodDurationInMins &&
          other.distractingApps == this.distractingApps);
}

class RestrictionGroupsTableCompanion
    extends UpdateCompanion<RestrictionGroup> {
  final Value<int> id;
  final Value<String> groupName;
  final Value<int> timerSec;
  final Value<TimeOfDayAdapter> activePeriodStart;
  final Value<TimeOfDayAdapter> activePeriodEnd;
  final Value<int> periodDurationInMins;
  final Value<List<String>> distractingApps;
  const RestrictionGroupsTableCompanion({
    this.id = const Value.absent(),
    this.groupName = const Value.absent(),
    this.timerSec = const Value.absent(),
    this.activePeriodStart = const Value.absent(),
    this.activePeriodEnd = const Value.absent(),
    this.periodDurationInMins = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  RestrictionGroupsTableCompanion.insert({
    this.id = const Value.absent(),
    this.groupName = const Value.absent(),
    this.timerSec = const Value.absent(),
    this.activePeriodStart = const Value.absent(),
    this.activePeriodEnd = const Value.absent(),
    this.periodDurationInMins = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  static Insertable<RestrictionGroup> custom({
    Expression<int>? id,
    Expression<String>? groupName,
    Expression<int>? timerSec,
    Expression<int>? activePeriodStart,
    Expression<int>? activePeriodEnd,
    Expression<int>? periodDurationInMins,
    Expression<String>? distractingApps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupName != null) 'group_name': groupName,
      if (timerSec != null) 'timer_sec': timerSec,
      if (activePeriodStart != null) 'active_period_start': activePeriodStart,
      if (activePeriodEnd != null) 'active_period_end': activePeriodEnd,
      if (periodDurationInMins != null)
        'period_duration_in_mins': periodDurationInMins,
      if (distractingApps != null) 'distracting_apps': distractingApps,
    });
  }

  RestrictionGroupsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? groupName,
      Value<int>? timerSec,
      Value<TimeOfDayAdapter>? activePeriodStart,
      Value<TimeOfDayAdapter>? activePeriodEnd,
      Value<int>? periodDurationInMins,
      Value<List<String>>? distractingApps}) {
    return RestrictionGroupsTableCompanion(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      timerSec: timerSec ?? this.timerSec,
      activePeriodStart: activePeriodStart ?? this.activePeriodStart,
      activePeriodEnd: activePeriodEnd ?? this.activePeriodEnd,
      periodDurationInMins: periodDurationInMins ?? this.periodDurationInMins,
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
    if (activePeriodStart.present) {
      map['active_period_start'] = Variable<int>($RestrictionGroupsTableTable
          .$converteractivePeriodStart
          .toSql(activePeriodStart.value));
    }
    if (activePeriodEnd.present) {
      map['active_period_end'] = Variable<int>($RestrictionGroupsTableTable
          .$converteractivePeriodEnd
          .toSql(activePeriodEnd.value));
    }
    if (periodDurationInMins.present) {
      map['period_duration_in_mins'] =
          Variable<int>(periodDurationInMins.value);
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
          ..write('activePeriodStart: $activePeriodStart, ')
          ..write('activePeriodEnd: $activePeriodEnd, ')
          ..write('periodDurationInMins: $periodDurationInMins, ')
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
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(30 * 60));
  @override
  late final GeneratedColumnWithTypeConverter<List<PlatformFeatures>, String>
      blockedFeatures = GeneratedColumn<String>(
              'blocked_features', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<PlatformFeatures>>(
              $WellbeingTableTable.$converterblockedFeatures);
  static const VerificationMeta _blockNsfwSitesMeta =
      const VerificationMeta('blockNsfwSites');
  @override
  late final GeneratedColumn<bool> blockNsfwSites = GeneratedColumn<bool>(
      'block_nsfw_sites', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("block_nsfw_sites" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      blockedWebsites = GeneratedColumn<String>(
              'blocked_websites', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<String>>(
              $WellbeingTableTable.$converterblockedWebsites);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      nsfwWebsites = GeneratedColumn<String>(
              'nsfw_websites', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<String>>(
              $WellbeingTableTable.$converternsfwWebsites);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        allowedShortsTimeSec,
        blockedFeatures,
        blockNsfwSites,
        blockedWebsites,
        nsfwWebsites
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
    }
    if (data.containsKey('block_nsfw_sites')) {
      context.handle(
          _blockNsfwSitesMeta,
          blockNsfwSites.isAcceptableOrUnknown(
              data['block_nsfw_sites']!, _blockNsfwSitesMeta));
    }
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
      blockedFeatures: $WellbeingTableTable.$converterblockedFeatures.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}blocked_features'])!),
      blockNsfwSites: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}block_nsfw_sites'])!,
      blockedWebsites: $WellbeingTableTable.$converterblockedWebsites.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}blocked_websites'])!),
      nsfwWebsites: $WellbeingTableTable.$converternsfwWebsites.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}nsfw_websites'])!),
    );
  }

  @override
  $WellbeingTableTable createAlias(String alias) {
    return $WellbeingTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<PlatformFeatures>, String>
      $converterblockedFeatures =
      const ListEnumNamesConverter<PlatformFeatures>(PlatformFeatures.values);
  static TypeConverter<List<String>, String> $converterblockedWebsites =
      const ListStringConverter();
  static TypeConverter<List<String>, String> $converternsfwWebsites =
      const ListStringConverter();
}

class Wellbeing extends DataClass implements Insertable<Wellbeing> {
  /// Unique ID for wellbeing
  final int id;

  /// Allowed time for short content in SECONDS
  final int allowedShortsTimeSec;

  /// List of feature which are blocked
  final List<PlatformFeatures> blockedFeatures;

  /// Flag denoting if the nsfw or adult  websites are blocked or not
  /// i.e if accessibility service is filtering websites or not
  final bool blockNsfwSites;

  /// List of website hosts which are blocked.
  final List<String> blockedWebsites;

  /// List of website hosts which are nsfw.
  final List<String> nsfwWebsites;
  const Wellbeing(
      {required this.id,
      required this.allowedShortsTimeSec,
      required this.blockedFeatures,
      required this.blockNsfwSites,
      required this.blockedWebsites,
      required this.nsfwWebsites});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['allowed_shorts_time_sec'] = Variable<int>(allowedShortsTimeSec);
    {
      map['blocked_features'] = Variable<String>($WellbeingTableTable
          .$converterblockedFeatures
          .toSql(blockedFeatures));
    }
    map['block_nsfw_sites'] = Variable<bool>(blockNsfwSites);
    {
      map['blocked_websites'] = Variable<String>($WellbeingTableTable
          .$converterblockedWebsites
          .toSql(blockedWebsites));
    }
    {
      map['nsfw_websites'] = Variable<String>(
          $WellbeingTableTable.$converternsfwWebsites.toSql(nsfwWebsites));
    }
    return map;
  }

  WellbeingTableCompanion toCompanion(bool nullToAbsent) {
    return WellbeingTableCompanion(
      id: Value(id),
      allowedShortsTimeSec: Value(allowedShortsTimeSec),
      blockedFeatures: Value(blockedFeatures),
      blockNsfwSites: Value(blockNsfwSites),
      blockedWebsites: Value(blockedWebsites),
      nsfwWebsites: Value(nsfwWebsites),
    );
  }

  factory Wellbeing.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wellbeing(
      id: serializer.fromJson<int>(json['id']),
      allowedShortsTimeSec:
          serializer.fromJson<int>(json['allowedShortsTimeSec']),
      blockedFeatures:
          serializer.fromJson<List<PlatformFeatures>>(json['blockedFeatures']),
      blockNsfwSites: serializer.fromJson<bool>(json['blockNsfwSites']),
      blockedWebsites:
          serializer.fromJson<List<String>>(json['blockedWebsites']),
      nsfwWebsites: serializer.fromJson<List<String>>(json['nsfwWebsites']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'allowedShortsTimeSec': serializer.toJson<int>(allowedShortsTimeSec),
      'blockedFeatures':
          serializer.toJson<List<PlatformFeatures>>(blockedFeatures),
      'blockNsfwSites': serializer.toJson<bool>(blockNsfwSites),
      'blockedWebsites': serializer.toJson<List<String>>(blockedWebsites),
      'nsfwWebsites': serializer.toJson<List<String>>(nsfwWebsites),
    };
  }

  Wellbeing copyWith(
          {int? id,
          int? allowedShortsTimeSec,
          List<PlatformFeatures>? blockedFeatures,
          bool? blockNsfwSites,
          List<String>? blockedWebsites,
          List<String>? nsfwWebsites}) =>
      Wellbeing(
        id: id ?? this.id,
        allowedShortsTimeSec: allowedShortsTimeSec ?? this.allowedShortsTimeSec,
        blockedFeatures: blockedFeatures ?? this.blockedFeatures,
        blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
        blockedWebsites: blockedWebsites ?? this.blockedWebsites,
        nsfwWebsites: nsfwWebsites ?? this.nsfwWebsites,
      );
  Wellbeing copyWithCompanion(WellbeingTableCompanion data) {
    return Wellbeing(
      id: data.id.present ? data.id.value : this.id,
      allowedShortsTimeSec: data.allowedShortsTimeSec.present
          ? data.allowedShortsTimeSec.value
          : this.allowedShortsTimeSec,
      blockedFeatures: data.blockedFeatures.present
          ? data.blockedFeatures.value
          : this.blockedFeatures,
      blockNsfwSites: data.blockNsfwSites.present
          ? data.blockNsfwSites.value
          : this.blockNsfwSites,
      blockedWebsites: data.blockedWebsites.present
          ? data.blockedWebsites.value
          : this.blockedWebsites,
      nsfwWebsites: data.nsfwWebsites.present
          ? data.nsfwWebsites.value
          : this.nsfwWebsites,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Wellbeing(')
          ..write('id: $id, ')
          ..write('allowedShortsTimeSec: $allowedShortsTimeSec, ')
          ..write('blockedFeatures: $blockedFeatures, ')
          ..write('blockNsfwSites: $blockNsfwSites, ')
          ..write('blockedWebsites: $blockedWebsites, ')
          ..write('nsfwWebsites: $nsfwWebsites')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, allowedShortsTimeSec, blockedFeatures,
      blockNsfwSites, blockedWebsites, nsfwWebsites);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wellbeing &&
          other.id == this.id &&
          other.allowedShortsTimeSec == this.allowedShortsTimeSec &&
          other.blockedFeatures == this.blockedFeatures &&
          other.blockNsfwSites == this.blockNsfwSites &&
          other.blockedWebsites == this.blockedWebsites &&
          other.nsfwWebsites == this.nsfwWebsites);
}

class WellbeingTableCompanion extends UpdateCompanion<Wellbeing> {
  final Value<int> id;
  final Value<int> allowedShortsTimeSec;
  final Value<List<PlatformFeatures>> blockedFeatures;
  final Value<bool> blockNsfwSites;
  final Value<List<String>> blockedWebsites;
  final Value<List<String>> nsfwWebsites;
  const WellbeingTableCompanion({
    this.id = const Value.absent(),
    this.allowedShortsTimeSec = const Value.absent(),
    this.blockedFeatures = const Value.absent(),
    this.blockNsfwSites = const Value.absent(),
    this.blockedWebsites = const Value.absent(),
    this.nsfwWebsites = const Value.absent(),
  });
  WellbeingTableCompanion.insert({
    this.id = const Value.absent(),
    this.allowedShortsTimeSec = const Value.absent(),
    this.blockedFeatures = const Value.absent(),
    this.blockNsfwSites = const Value.absent(),
    this.blockedWebsites = const Value.absent(),
    this.nsfwWebsites = const Value.absent(),
  });
  static Insertable<Wellbeing> custom({
    Expression<int>? id,
    Expression<int>? allowedShortsTimeSec,
    Expression<String>? blockedFeatures,
    Expression<bool>? blockNsfwSites,
    Expression<String>? blockedWebsites,
    Expression<String>? nsfwWebsites,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (allowedShortsTimeSec != null)
        'allowed_shorts_time_sec': allowedShortsTimeSec,
      if (blockedFeatures != null) 'blocked_features': blockedFeatures,
      if (blockNsfwSites != null) 'block_nsfw_sites': blockNsfwSites,
      if (blockedWebsites != null) 'blocked_websites': blockedWebsites,
      if (nsfwWebsites != null) 'nsfw_websites': nsfwWebsites,
    });
  }

  WellbeingTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? allowedShortsTimeSec,
      Value<List<PlatformFeatures>>? blockedFeatures,
      Value<bool>? blockNsfwSites,
      Value<List<String>>? blockedWebsites,
      Value<List<String>>? nsfwWebsites}) {
    return WellbeingTableCompanion(
      id: id ?? this.id,
      allowedShortsTimeSec: allowedShortsTimeSec ?? this.allowedShortsTimeSec,
      blockedFeatures: blockedFeatures ?? this.blockedFeatures,
      blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
      blockedWebsites: blockedWebsites ?? this.blockedWebsites,
      nsfwWebsites: nsfwWebsites ?? this.nsfwWebsites,
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
    if (blockedFeatures.present) {
      map['blocked_features'] = Variable<String>($WellbeingTableTable
          .$converterblockedFeatures
          .toSql(blockedFeatures.value));
    }
    if (blockNsfwSites.present) {
      map['block_nsfw_sites'] = Variable<bool>(blockNsfwSites.value);
    }
    if (blockedWebsites.present) {
      map['blocked_websites'] = Variable<String>($WellbeingTableTable
          .$converterblockedWebsites
          .toSql(blockedWebsites.value));
    }
    if (nsfwWebsites.present) {
      map['nsfw_websites'] = Variable<String>($WellbeingTableTable
          .$converternsfwWebsites
          .toSql(nsfwWebsites.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WellbeingTableCompanion(')
          ..write('id: $id, ')
          ..write('allowedShortsTimeSec: $allowedShortsTimeSec, ')
          ..write('blockedFeatures: $blockedFeatures, ')
          ..write('blockNsfwSites: $blockNsfwSites, ')
          ..write('blockedWebsites: $blockedWebsites, ')
          ..write('nsfwWebsites: $nsfwWebsites')
          ..write(')'))
        .toString();
  }
}

class $SharedUniqueDataTableTable extends SharedUniqueDataTable
    with TableInfo<$SharedUniqueDataTableTable, SharedUniqueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SharedUniqueDataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      excludedApps = GeneratedColumn<String>(
              'excluded_apps', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<String>>(
              $SharedUniqueDataTableTable.$converterexcludedApps);
  @override
  List<GeneratedColumn> get $columns => [id, excludedApps];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shared_unique_data_table';
  @override
  VerificationContext validateIntegrity(Insertable<SharedUniqueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SharedUniqueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SharedUniqueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      excludedApps: $SharedUniqueDataTableTable.$converterexcludedApps.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}excluded_apps'])!),
    );
  }

  @override
  $SharedUniqueDataTableTable createAlias(String alias) {
    return $SharedUniqueDataTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterexcludedApps =
      const ListStringConverter();
}

class SharedUniqueData extends DataClass
    implements Insertable<SharedUniqueData> {
  /// Unique ID for Shared Data
  final int id;

  /// List of app's packages which are excluded from the aggregated usage statistics.
  final List<String> excludedApps;
  const SharedUniqueData({required this.id, required this.excludedApps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['excluded_apps'] = Variable<String>($SharedUniqueDataTableTable
          .$converterexcludedApps
          .toSql(excludedApps));
    }
    return map;
  }

  SharedUniqueDataTableCompanion toCompanion(bool nullToAbsent) {
    return SharedUniqueDataTableCompanion(
      id: Value(id),
      excludedApps: Value(excludedApps),
    );
  }

  factory SharedUniqueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SharedUniqueData(
      id: serializer.fromJson<int>(json['id']),
      excludedApps: serializer.fromJson<List<String>>(json['excludedApps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'excludedApps': serializer.toJson<List<String>>(excludedApps),
    };
  }

  SharedUniqueData copyWith({int? id, List<String>? excludedApps}) =>
      SharedUniqueData(
        id: id ?? this.id,
        excludedApps: excludedApps ?? this.excludedApps,
      );
  SharedUniqueData copyWithCompanion(SharedUniqueDataTableCompanion data) {
    return SharedUniqueData(
      id: data.id.present ? data.id.value : this.id,
      excludedApps: data.excludedApps.present
          ? data.excludedApps.value
          : this.excludedApps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SharedUniqueData(')
          ..write('id: $id, ')
          ..write('excludedApps: $excludedApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, excludedApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SharedUniqueData &&
          other.id == this.id &&
          other.excludedApps == this.excludedApps);
}

class SharedUniqueDataTableCompanion extends UpdateCompanion<SharedUniqueData> {
  final Value<int> id;
  final Value<List<String>> excludedApps;
  const SharedUniqueDataTableCompanion({
    this.id = const Value.absent(),
    this.excludedApps = const Value.absent(),
  });
  SharedUniqueDataTableCompanion.insert({
    this.id = const Value.absent(),
    this.excludedApps = const Value.absent(),
  });
  static Insertable<SharedUniqueData> custom({
    Expression<int>? id,
    Expression<String>? excludedApps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (excludedApps != null) 'excluded_apps': excludedApps,
    });
  }

  SharedUniqueDataTableCompanion copyWith(
      {Value<int>? id, Value<List<String>>? excludedApps}) {
    return SharedUniqueDataTableCompanion(
      id: id ?? this.id,
      excludedApps: excludedApps ?? this.excludedApps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (excludedApps.present) {
      map['excluded_apps'] = Variable<String>($SharedUniqueDataTableTable
          .$converterexcludedApps
          .toSql(excludedApps.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SharedUniqueDataTableCompanion(')
          ..write('id: $id, ')
          ..write('excludedApps: $excludedApps')
          ..write(')'))
        .toString();
  }
}

class $NotificationScheduleTableTable extends NotificationScheduleTable
    with TableInfo<$NotificationScheduleTableTable, NotificationSchedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationScheduleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int> time =
      GeneratedColumn<int>('time', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<TimeOfDayAdapter>(
              $NotificationScheduleTableTable.$convertertime);
  @override
  List<GeneratedColumn> get $columns => [id, isActive, label, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_schedule_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificationSchedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationSchedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationSchedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      time: $NotificationScheduleTableTable.$convertertime.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}time'])!),
    );
  }

  @override
  $NotificationScheduleTableTable createAlias(String alias) {
    return $NotificationScheduleTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TimeOfDayAdapter, int, dynamic> $convertertime =
      const TimeOfDayAdapterConverter();
}

class NotificationSchedule extends DataClass
    implements Insertable<NotificationSchedule> {
  /// Unique ID for schedule
  final int id;

  /// Boolean denoting the status of this notification schedule
  final bool isActive;

  /// Name or Label for the schedule
  final String label;

  /// [TimeOfDay] in minutes of the schedule.
  /// It is stored as total minutes.
  final TimeOfDayAdapter time;
  const NotificationSchedule(
      {required this.id,
      required this.isActive,
      required this.label,
      required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_active'] = Variable<bool>(isActive);
    map['label'] = Variable<String>(label);
    {
      map['time'] = Variable<int>(
          $NotificationScheduleTableTable.$convertertime.toSql(time));
    }
    return map;
  }

  NotificationScheduleTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationScheduleTableCompanion(
      id: Value(id),
      isActive: Value(isActive),
      label: Value(label),
      time: Value(time),
    );
  }

  factory NotificationSchedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationSchedule(
      id: serializer.fromJson<int>(json['id']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      label: serializer.fromJson<String>(json['label']),
      time: $NotificationScheduleTableTable.$convertertime
          .fromJson(serializer.fromJson<dynamic>(json['time'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isActive': serializer.toJson<bool>(isActive),
      'label': serializer.toJson<String>(label),
      'time': serializer.toJson<dynamic>(
          $NotificationScheduleTableTable.$convertertime.toJson(time)),
    };
  }

  NotificationSchedule copyWith(
          {int? id, bool? isActive, String? label, TimeOfDayAdapter? time}) =>
      NotificationSchedule(
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        label: label ?? this.label,
        time: time ?? this.time,
      );
  NotificationSchedule copyWithCompanion(
      NotificationScheduleTableCompanion data) {
    return NotificationSchedule(
      id: data.id.present ? data.id.value : this.id,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      label: data.label.present ? data.label.value : this.label,
      time: data.time.present ? data.time.value : this.time,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSchedule(')
          ..write('id: $id, ')
          ..write('isActive: $isActive, ')
          ..write('label: $label, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, isActive, label, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationSchedule &&
          other.id == this.id &&
          other.isActive == this.isActive &&
          other.label == this.label &&
          other.time == this.time);
}

class NotificationScheduleTableCompanion
    extends UpdateCompanion<NotificationSchedule> {
  final Value<int> id;
  final Value<bool> isActive;
  final Value<String> label;
  final Value<TimeOfDayAdapter> time;
  const NotificationScheduleTableCompanion({
    this.id = const Value.absent(),
    this.isActive = const Value.absent(),
    this.label = const Value.absent(),
    this.time = const Value.absent(),
  });
  NotificationScheduleTableCompanion.insert({
    this.id = const Value.absent(),
    this.isActive = const Value.absent(),
    this.label = const Value.absent(),
    this.time = const Value.absent(),
  });
  static Insertable<NotificationSchedule> custom({
    Expression<int>? id,
    Expression<bool>? isActive,
    Expression<String>? label,
    Expression<int>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isActive != null) 'is_active': isActive,
      if (label != null) 'label': label,
      if (time != null) 'time': time,
    });
  }

  NotificationScheduleTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isActive,
      Value<String>? label,
      Value<TimeOfDayAdapter>? time}) {
    return NotificationScheduleTableCompanion(
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      label: label ?? this.label,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(
          $NotificationScheduleTableTable.$convertertime.toSql(time.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationScheduleTableCompanion(')
          ..write('id: $id, ')
          ..write('isActive: $isActive, ')
          ..write('label: $label, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $AppUsageTableTable extends AppUsageTable
    with TableInfo<$AppUsageTableTable, AppUsage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packageNameMeta =
      const VerificationMeta('packageName');
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
      'package_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime(0)));
  static const VerificationMeta _screenTimeMeta =
      const VerificationMeta('screenTime');
  @override
  late final GeneratedColumn<int> screenTime = GeneratedColumn<int>(
      'screen_time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _mobileDataMeta =
      const VerificationMeta('mobileData');
  @override
  late final GeneratedColumn<int> mobileData = GeneratedColumn<int>(
      'mobile_data', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _wifiDataMeta =
      const VerificationMeta('wifiData');
  @override
  late final GeneratedColumn<int> wifiData = GeneratedColumn<int>(
      'wifi_data', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [packageName, date, screenTime, mobileData, wifiData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_usage_table';
  @override
  VerificationContext validateIntegrity(Insertable<AppUsage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('package_name')) {
      context.handle(
          _packageNameMeta,
          packageName.isAcceptableOrUnknown(
              data['package_name']!, _packageNameMeta));
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('screen_time')) {
      context.handle(
          _screenTimeMeta,
          screenTime.isAcceptableOrUnknown(
              data['screen_time']!, _screenTimeMeta));
    }
    if (data.containsKey('mobile_data')) {
      context.handle(
          _mobileDataMeta,
          mobileData.isAcceptableOrUnknown(
              data['mobile_data']!, _mobileDataMeta));
    }
    if (data.containsKey('wifi_data')) {
      context.handle(_wifiDataMeta,
          wifiData.isAcceptableOrUnknown(data['wifi_data']!, _wifiDataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packageName, date};
  @override
  AppUsage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUsage(
      packageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}package_name'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      screenTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}screen_time'])!,
      mobileData: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mobile_data'])!,
      wifiData: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wifi_data'])!,
    );
  }

  @override
  $AppUsageTableTable createAlias(String alias) {
    return $AppUsageTableTable(attachedDatabase, alias);
  }
}

class AppUsage extends DataClass implements Insertable<AppUsage> {
  /// Package name of the related app
  final String packageName;

  /// The day [DateTime] but date only of the record
  final DateTime date;

  /// Package screen time of the related app
  final int screenTime;

  /// Package mobile data usage of the related app
  final int mobileData;

  /// Package wifi data usage of the related app
  final int wifiData;
  const AppUsage(
      {required this.packageName,
      required this.date,
      required this.screenTime,
      required this.mobileData,
      required this.wifiData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['package_name'] = Variable<String>(packageName);
    map['date'] = Variable<DateTime>(date);
    map['screen_time'] = Variable<int>(screenTime);
    map['mobile_data'] = Variable<int>(mobileData);
    map['wifi_data'] = Variable<int>(wifiData);
    return map;
  }

  AppUsageTableCompanion toCompanion(bool nullToAbsent) {
    return AppUsageTableCompanion(
      packageName: Value(packageName),
      date: Value(date),
      screenTime: Value(screenTime),
      mobileData: Value(mobileData),
      wifiData: Value(wifiData),
    );
  }

  factory AppUsage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUsage(
      packageName: serializer.fromJson<String>(json['packageName']),
      date: serializer.fromJson<DateTime>(json['date']),
      screenTime: serializer.fromJson<int>(json['screenTime']),
      mobileData: serializer.fromJson<int>(json['mobileData']),
      wifiData: serializer.fromJson<int>(json['wifiData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'packageName': serializer.toJson<String>(packageName),
      'date': serializer.toJson<DateTime>(date),
      'screenTime': serializer.toJson<int>(screenTime),
      'mobileData': serializer.toJson<int>(mobileData),
      'wifiData': serializer.toJson<int>(wifiData),
    };
  }

  AppUsage copyWith(
          {String? packageName,
          DateTime? date,
          int? screenTime,
          int? mobileData,
          int? wifiData}) =>
      AppUsage(
        packageName: packageName ?? this.packageName,
        date: date ?? this.date,
        screenTime: screenTime ?? this.screenTime,
        mobileData: mobileData ?? this.mobileData,
        wifiData: wifiData ?? this.wifiData,
      );
  AppUsage copyWithCompanion(AppUsageTableCompanion data) {
    return AppUsage(
      packageName:
          data.packageName.present ? data.packageName.value : this.packageName,
      date: data.date.present ? data.date.value : this.date,
      screenTime:
          data.screenTime.present ? data.screenTime.value : this.screenTime,
      mobileData:
          data.mobileData.present ? data.mobileData.value : this.mobileData,
      wifiData: data.wifiData.present ? data.wifiData.value : this.wifiData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUsage(')
          ..write('packageName: $packageName, ')
          ..write('date: $date, ')
          ..write('screenTime: $screenTime, ')
          ..write('mobileData: $mobileData, ')
          ..write('wifiData: $wifiData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(packageName, date, screenTime, mobileData, wifiData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUsage &&
          other.packageName == this.packageName &&
          other.date == this.date &&
          other.screenTime == this.screenTime &&
          other.mobileData == this.mobileData &&
          other.wifiData == this.wifiData);
}

class AppUsageTableCompanion extends UpdateCompanion<AppUsage> {
  final Value<String> packageName;
  final Value<DateTime> date;
  final Value<int> screenTime;
  final Value<int> mobileData;
  final Value<int> wifiData;
  final Value<int> rowid;
  const AppUsageTableCompanion({
    this.packageName = const Value.absent(),
    this.date = const Value.absent(),
    this.screenTime = const Value.absent(),
    this.mobileData = const Value.absent(),
    this.wifiData = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUsageTableCompanion.insert({
    required String packageName,
    this.date = const Value.absent(),
    this.screenTime = const Value.absent(),
    this.mobileData = const Value.absent(),
    this.wifiData = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : packageName = Value(packageName);
  static Insertable<AppUsage> custom({
    Expression<String>? packageName,
    Expression<DateTime>? date,
    Expression<int>? screenTime,
    Expression<int>? mobileData,
    Expression<int>? wifiData,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packageName != null) 'package_name': packageName,
      if (date != null) 'date': date,
      if (screenTime != null) 'screen_time': screenTime,
      if (mobileData != null) 'mobile_data': mobileData,
      if (wifiData != null) 'wifi_data': wifiData,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUsageTableCompanion copyWith(
      {Value<String>? packageName,
      Value<DateTime>? date,
      Value<int>? screenTime,
      Value<int>? mobileData,
      Value<int>? wifiData,
      Value<int>? rowid}) {
    return AppUsageTableCompanion(
      packageName: packageName ?? this.packageName,
      date: date ?? this.date,
      screenTime: screenTime ?? this.screenTime,
      mobileData: mobileData ?? this.mobileData,
      wifiData: wifiData ?? this.wifiData,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (screenTime.present) {
      map['screen_time'] = Variable<int>(screenTime.value);
    }
    if (mobileData.present) {
      map['mobile_data'] = Variable<int>(mobileData.value);
    }
    if (wifiData.present) {
      map['wifi_data'] = Variable<int>(wifiData.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsageTableCompanion(')
          ..write('packageName: $packageName, ')
          ..write('date: $date, ')
          ..write('screenTime: $screenTime, ')
          ..write('mobileData: $mobileData, ')
          ..write('wifiData: $wifiData, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationSettingsTableTable extends NotificationSettingsTable
    with TableInfo<$NotificationSettingsTableTable, NotificationSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _storeNonBatchedTooMeta =
      const VerificationMeta('storeNonBatchedToo');
  @override
  late final GeneratedColumn<bool> storeNonBatchedToo = GeneratedColumn<bool>(
      'store_non_batched_too', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("store_non_batched_too" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      batchedApps = GeneratedColumn<String>('batched_apps', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(jsonEncode([])))
          .withConverter<List<String>>(
              $NotificationSettingsTableTable.$converterbatchedApps);
  @override
  List<GeneratedColumn> get $columns => [id, storeNonBatchedToo, batchedApps];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<NotificationSettings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('store_non_batched_too')) {
      context.handle(
          _storeNonBatchedTooMeta,
          storeNonBatchedToo.isAcceptableOrUnknown(
              data['store_non_batched_too']!, _storeNonBatchedTooMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationSettings(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      storeNonBatchedToo: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}store_non_batched_too'])!,
      batchedApps: $NotificationSettingsTableTable.$converterbatchedApps
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}batched_apps'])!),
    );
  }

  @override
  $NotificationSettingsTableTable createAlias(String alias) {
    return $NotificationSettingsTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterbatchedApps =
      const ListStringConverter();
}

class NotificationSettings extends DataClass
    implements Insertable<NotificationSettings> {
  /// Unique ID for notification config
  final int id;

  /// Boolean denoting if to store notifications of non-batched apps too.
  final bool storeNonBatchedToo;

  /// List of app's packages whose notifications are batched.
  final List<String> batchedApps;
  const NotificationSettings(
      {required this.id,
      required this.storeNonBatchedToo,
      required this.batchedApps});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['store_non_batched_too'] = Variable<bool>(storeNonBatchedToo);
    {
      map['batched_apps'] = Variable<String>($NotificationSettingsTableTable
          .$converterbatchedApps
          .toSql(batchedApps));
    }
    return map;
  }

  NotificationSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationSettingsTableCompanion(
      id: Value(id),
      storeNonBatchedToo: Value(storeNonBatchedToo),
      batchedApps: Value(batchedApps),
    );
  }

  factory NotificationSettings.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationSettings(
      id: serializer.fromJson<int>(json['id']),
      storeNonBatchedToo: serializer.fromJson<bool>(json['storeNonBatchedToo']),
      batchedApps: serializer.fromJson<List<String>>(json['batchedApps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'storeNonBatchedToo': serializer.toJson<bool>(storeNonBatchedToo),
      'batchedApps': serializer.toJson<List<String>>(batchedApps),
    };
  }

  NotificationSettings copyWith(
          {int? id, bool? storeNonBatchedToo, List<String>? batchedApps}) =>
      NotificationSettings(
        id: id ?? this.id,
        storeNonBatchedToo: storeNonBatchedToo ?? this.storeNonBatchedToo,
        batchedApps: batchedApps ?? this.batchedApps,
      );
  NotificationSettings copyWithCompanion(
      NotificationSettingsTableCompanion data) {
    return NotificationSettings(
      id: data.id.present ? data.id.value : this.id,
      storeNonBatchedToo: data.storeNonBatchedToo.present
          ? data.storeNonBatchedToo.value
          : this.storeNonBatchedToo,
      batchedApps:
          data.batchedApps.present ? data.batchedApps.value : this.batchedApps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSettings(')
          ..write('id: $id, ')
          ..write('storeNonBatchedToo: $storeNonBatchedToo, ')
          ..write('batchedApps: $batchedApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, storeNonBatchedToo, batchedApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationSettings &&
          other.id == this.id &&
          other.storeNonBatchedToo == this.storeNonBatchedToo &&
          other.batchedApps == this.batchedApps);
}

class NotificationSettingsTableCompanion
    extends UpdateCompanion<NotificationSettings> {
  final Value<int> id;
  final Value<bool> storeNonBatchedToo;
  final Value<List<String>> batchedApps;
  const NotificationSettingsTableCompanion({
    this.id = const Value.absent(),
    this.storeNonBatchedToo = const Value.absent(),
    this.batchedApps = const Value.absent(),
  });
  NotificationSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.storeNonBatchedToo = const Value.absent(),
    this.batchedApps = const Value.absent(),
  });
  static Insertable<NotificationSettings> custom({
    Expression<int>? id,
    Expression<bool>? storeNonBatchedToo,
    Expression<String>? batchedApps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (storeNonBatchedToo != null)
        'store_non_batched_too': storeNonBatchedToo,
      if (batchedApps != null) 'batched_apps': batchedApps,
    });
  }

  NotificationSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? storeNonBatchedToo,
      Value<List<String>>? batchedApps}) {
    return NotificationSettingsTableCompanion(
      id: id ?? this.id,
      storeNonBatchedToo: storeNonBatchedToo ?? this.storeNonBatchedToo,
      batchedApps: batchedApps ?? this.batchedApps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (storeNonBatchedToo.present) {
      map['store_non_batched_too'] = Variable<bool>(storeNonBatchedToo.value);
    }
    if (batchedApps.present) {
      map['batched_apps'] = Variable<String>($NotificationSettingsTableTable
          .$converterbatchedApps
          .toSql(batchedApps.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('storeNonBatchedToo: $storeNonBatchedToo, ')
          ..write('batchedApps: $batchedApps')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTableTable extends NotificationsTable
    with TableInfo<$NotificationsTableTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _packageNameMeta =
      const VerificationMeta('packageName');
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
      'package_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeStampMeta =
      const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<DateTime> timeStamp = GeneratedColumn<DateTime>(
      'time_stamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime(0)));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
      'is_read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, key, packageName, timeStamp, title, content, category, isRead];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications_table';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('package_name')) {
      context.handle(
          _packageNameMeta,
          packageName.isAcceptableOrUnknown(
              data['package_name']!, _packageNameMeta));
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      packageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}package_name'])!,
      timeStamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_stamp'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      isRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
    );
  }

  @override
  $NotificationsTableTable createAlias(String alias) {
    return $NotificationsTableTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  /// Unique ID for notification
  final int id;

  /// Unique key of this notification created by system for live link
  final String key;

  /// Package name of the related app
  final String packageName;

  /// [DateTime] when the notification is pushed
  final DateTime timeStamp;

  /// The title of the notification
  final String title;

  /// The content of the notification
  final String content;

  /// The category of the notification
  final String category;

  /// Boolean denoting the status of this notification (Read/Unread)
  final bool isRead;
  const Notification(
      {required this.id,
      required this.key,
      required this.packageName,
      required this.timeStamp,
      required this.title,
      required this.content,
      required this.category,
      required this.isRead});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['package_name'] = Variable<String>(packageName);
    map['time_stamp'] = Variable<DateTime>(timeStamp);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['category'] = Variable<String>(category);
    map['is_read'] = Variable<bool>(isRead);
    return map;
  }

  NotificationsTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationsTableCompanion(
      id: Value(id),
      key: Value(key),
      packageName: Value(packageName),
      timeStamp: Value(timeStamp),
      title: Value(title),
      content: Value(content),
      category: Value(category),
      isRead: Value(isRead),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      packageName: serializer.fromJson<String>(json['packageName']),
      timeStamp: serializer.fromJson<DateTime>(json['timeStamp']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      category: serializer.fromJson<String>(json['category']),
      isRead: serializer.fromJson<bool>(json['isRead']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'packageName': serializer.toJson<String>(packageName),
      'timeStamp': serializer.toJson<DateTime>(timeStamp),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'category': serializer.toJson<String>(category),
      'isRead': serializer.toJson<bool>(isRead),
    };
  }

  Notification copyWith(
          {int? id,
          String? key,
          String? packageName,
          DateTime? timeStamp,
          String? title,
          String? content,
          String? category,
          bool? isRead}) =>
      Notification(
        id: id ?? this.id,
        key: key ?? this.key,
        packageName: packageName ?? this.packageName,
        timeStamp: timeStamp ?? this.timeStamp,
        title: title ?? this.title,
        content: content ?? this.content,
        category: category ?? this.category,
        isRead: isRead ?? this.isRead,
      );
  Notification copyWithCompanion(NotificationsTableCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      packageName:
          data.packageName.present ? data.packageName.value : this.packageName,
      timeStamp: data.timeStamp.present ? data.timeStamp.value : this.timeStamp,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      category: data.category.present ? data.category.value : this.category,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('packageName: $packageName, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('isRead: $isRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, key, packageName, timeStamp, title, content, category, isRead);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.key == this.key &&
          other.packageName == this.packageName &&
          other.timeStamp == this.timeStamp &&
          other.title == this.title &&
          other.content == this.content &&
          other.category == this.category &&
          other.isRead == this.isRead);
}

class NotificationsTableCompanion extends UpdateCompanion<Notification> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> packageName;
  final Value<DateTime> timeStamp;
  final Value<String> title;
  final Value<String> content;
  final Value<String> category;
  final Value<bool> isRead;
  const NotificationsTableCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.packageName = const Value.absent(),
    this.timeStamp = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
    this.isRead = const Value.absent(),
  });
  NotificationsTableCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String packageName,
    this.timeStamp = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
    this.isRead = const Value.absent(),
  })  : key = Value(key),
        packageName = Value(packageName);
  static Insertable<Notification> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? packageName,
    Expression<DateTime>? timeStamp,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? category,
    Expression<bool>? isRead,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (packageName != null) 'package_name': packageName,
      if (timeStamp != null) 'time_stamp': timeStamp,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (category != null) 'category': category,
      if (isRead != null) 'is_read': isRead,
    });
  }

  NotificationsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? key,
      Value<String>? packageName,
      Value<DateTime>? timeStamp,
      Value<String>? title,
      Value<String>? content,
      Value<String>? category,
      Value<bool>? isRead}) {
    return NotificationsTableCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      packageName: packageName ?? this.packageName,
      timeStamp: timeStamp ?? this.timeStamp,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<DateTime>(timeStamp.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsTableCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('packageName: $packageName, ')
          ..write('timeStamp: $timeStamp, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('isRead: $isRead')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppRestrictionTableTable appRestrictionTable =
      $AppRestrictionTableTable(this);
  late final $BedtimeScheduleTableTable bedtimeScheduleTable =
      $BedtimeScheduleTableTable(this);
  late final $CrashLogsTableTable crashLogsTable = $CrashLogsTableTable(this);
  late final $FocusModeTableTable focusModeTable = $FocusModeTableTable(this);
  late final $FocusProfileTableTable focusProfileTable =
      $FocusProfileTableTable(this);
  late final $FocusSessionsTableTable focusSessionsTable =
      $FocusSessionsTableTable(this);
  late final $MindfulSettingsTableTable mindfulSettingsTable =
      $MindfulSettingsTableTable(this);
  late final $ParentalControlsTableTable parentalControlsTable =
      $ParentalControlsTableTable(this);
  late final $RestrictionGroupsTableTable restrictionGroupsTable =
      $RestrictionGroupsTableTable(this);
  late final $WellbeingTableTable wellbeingTable = $WellbeingTableTable(this);
  late final $SharedUniqueDataTableTable sharedUniqueDataTable =
      $SharedUniqueDataTableTable(this);
  late final $NotificationScheduleTableTable notificationScheduleTable =
      $NotificationScheduleTableTable(this);
  late final $AppUsageTableTable appUsageTable = $AppUsageTableTable(this);
  late final $NotificationSettingsTableTable notificationSettingsTable =
      $NotificationSettingsTableTable(this);
  late final $NotificationsTableTable notificationsTable =
      $NotificationsTableTable(this);
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
        focusProfileTable,
        focusSessionsTable,
        mindfulSettingsTable,
        parentalControlsTable,
        restrictionGroupsTable,
        wellbeingTable,
        sharedUniqueDataTable,
        notificationScheduleTable,
        appUsageTable,
        notificationSettingsTable,
        notificationsTable
      ];
}

typedef $$AppRestrictionTableTableCreateCompanionBuilder
    = AppRestrictionTableCompanion Function({
  required String appPackage,
  Value<int> timerSec,
  Value<int> launchLimit,
  Value<TimeOfDayAdapter> activePeriodStart,
  Value<TimeOfDayAdapter> activePeriodEnd,
  Value<int> periodDurationInMins,
  Value<int?> associatedGroupId,
  Value<bool> canAccessInternet,
  Value<int> rowid,
});
typedef $$AppRestrictionTableTableUpdateCompanionBuilder
    = AppRestrictionTableCompanion Function({
  Value<String> appPackage,
  Value<int> timerSec,
  Value<int> launchLimit,
  Value<TimeOfDayAdapter> activePeriodStart,
  Value<TimeOfDayAdapter> activePeriodEnd,
  Value<int> periodDurationInMins,
  Value<int?> associatedGroupId,
  Value<bool> canAccessInternet,
  Value<int> rowid,
});

class $$AppRestrictionTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppRestrictionTableTable> {
  $$AppRestrictionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get appPackage => $composableBuilder(
      column: $table.appPackage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timerSec => $composableBuilder(
      column: $table.timerSec, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get launchLimit => $composableBuilder(
      column: $table.launchLimit, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get activePeriodStart => $composableBuilder(
          column: $table.activePeriodStart,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get activePeriodEnd => $composableBuilder(
          column: $table.activePeriodEnd,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get periodDurationInMins => $composableBuilder(
      column: $table.periodDurationInMins,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get associatedGroupId => $composableBuilder(
      column: $table.associatedGroupId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get canAccessInternet => $composableBuilder(
      column: $table.canAccessInternet,
      builder: (column) => ColumnFilters(column));
}

class $$AppRestrictionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppRestrictionTableTable> {
  $$AppRestrictionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get appPackage => $composableBuilder(
      column: $table.appPackage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timerSec => $composableBuilder(
      column: $table.timerSec, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get launchLimit => $composableBuilder(
      column: $table.launchLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activePeriodStart => $composableBuilder(
      column: $table.activePeriodStart,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activePeriodEnd => $composableBuilder(
      column: $table.activePeriodEnd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get periodDurationInMins => $composableBuilder(
      column: $table.periodDurationInMins,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get associatedGroupId => $composableBuilder(
      column: $table.associatedGroupId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get canAccessInternet => $composableBuilder(
      column: $table.canAccessInternet,
      builder: (column) => ColumnOrderings(column));
}

class $$AppRestrictionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppRestrictionTableTable> {
  $$AppRestrictionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get appPackage => $composableBuilder(
      column: $table.appPackage, builder: (column) => column);

  GeneratedColumn<int> get timerSec =>
      $composableBuilder(column: $table.timerSec, builder: (column) => column);

  GeneratedColumn<int> get launchLimit => $composableBuilder(
      column: $table.launchLimit, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      get activePeriodStart => $composableBuilder(
          column: $table.activePeriodStart, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int> get activePeriodEnd =>
      $composableBuilder(
          column: $table.activePeriodEnd, builder: (column) => column);

  GeneratedColumn<int> get periodDurationInMins => $composableBuilder(
      column: $table.periodDurationInMins, builder: (column) => column);

  GeneratedColumn<int> get associatedGroupId => $composableBuilder(
      column: $table.associatedGroupId, builder: (column) => column);

  GeneratedColumn<bool> get canAccessInternet => $composableBuilder(
      column: $table.canAccessInternet, builder: (column) => column);
}

class $$AppRestrictionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppRestrictionTableTable,
    AppRestriction,
    $$AppRestrictionTableTableFilterComposer,
    $$AppRestrictionTableTableOrderingComposer,
    $$AppRestrictionTableTableAnnotationComposer,
    $$AppRestrictionTableTableCreateCompanionBuilder,
    $$AppRestrictionTableTableUpdateCompanionBuilder,
    (
      AppRestriction,
      BaseReferences<_$AppDatabase, $AppRestrictionTableTable, AppRestriction>
    ),
    AppRestriction,
    PrefetchHooks Function()> {
  $$AppRestrictionTableTableTableManager(
      _$AppDatabase db, $AppRestrictionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppRestrictionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppRestrictionTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppRestrictionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> appPackage = const Value.absent(),
            Value<int> timerSec = const Value.absent(),
            Value<int> launchLimit = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodStart = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodEnd = const Value.absent(),
            Value<int> periodDurationInMins = const Value.absent(),
            Value<int?> associatedGroupId = const Value.absent(),
            Value<bool> canAccessInternet = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppRestrictionTableCompanion(
            appPackage: appPackage,
            timerSec: timerSec,
            launchLimit: launchLimit,
            activePeriodStart: activePeriodStart,
            activePeriodEnd: activePeriodEnd,
            periodDurationInMins: periodDurationInMins,
            associatedGroupId: associatedGroupId,
            canAccessInternet: canAccessInternet,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String appPackage,
            Value<int> timerSec = const Value.absent(),
            Value<int> launchLimit = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodStart = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodEnd = const Value.absent(),
            Value<int> periodDurationInMins = const Value.absent(),
            Value<int?> associatedGroupId = const Value.absent(),
            Value<bool> canAccessInternet = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppRestrictionTableCompanion.insert(
            appPackage: appPackage,
            timerSec: timerSec,
            launchLimit: launchLimit,
            activePeriodStart: activePeriodStart,
            activePeriodEnd: activePeriodEnd,
            periodDurationInMins: periodDurationInMins,
            associatedGroupId: associatedGroupId,
            canAccessInternet: canAccessInternet,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppRestrictionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppRestrictionTableTable,
    AppRestriction,
    $$AppRestrictionTableTableFilterComposer,
    $$AppRestrictionTableTableOrderingComposer,
    $$AppRestrictionTableTableAnnotationComposer,
    $$AppRestrictionTableTableCreateCompanionBuilder,
    $$AppRestrictionTableTableUpdateCompanionBuilder,
    (
      AppRestriction,
      BaseReferences<_$AppDatabase, $AppRestrictionTableTable, AppRestriction>
    ),
    AppRestriction,
    PrefetchHooks Function()>;
typedef $$BedtimeScheduleTableTableCreateCompanionBuilder
    = BedtimeScheduleTableCompanion Function({
  Value<int> id,
  Value<TimeOfDayAdapter> scheduleStartTime,
  Value<TimeOfDayAdapter> scheduleEndTime,
  Value<int> scheduleDurationInMins,
  Value<List<bool>> scheduleDays,
  Value<bool> isScheduleOn,
  Value<bool> shouldStartDnd,
  Value<List<String>> distractingApps,
});
typedef $$BedtimeScheduleTableTableUpdateCompanionBuilder
    = BedtimeScheduleTableCompanion Function({
  Value<int> id,
  Value<TimeOfDayAdapter> scheduleStartTime,
  Value<TimeOfDayAdapter> scheduleEndTime,
  Value<int> scheduleDurationInMins,
  Value<List<bool>> scheduleDays,
  Value<bool> isScheduleOn,
  Value<bool> shouldStartDnd,
  Value<List<String>> distractingApps,
});

class $$BedtimeScheduleTableTableFilterComposer
    extends Composer<_$AppDatabase, $BedtimeScheduleTableTable> {
  $$BedtimeScheduleTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get scheduleStartTime => $composableBuilder(
          column: $table.scheduleStartTime,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get scheduleEndTime => $composableBuilder(
          column: $table.scheduleEndTime,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get scheduleDurationInMins => $composableBuilder(
      column: $table.scheduleDurationInMins,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<bool>, List<bool>, String>
      get scheduleDays => $composableBuilder(
          column: $table.scheduleDays,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isScheduleOn => $composableBuilder(
      column: $table.isScheduleOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get shouldStartDnd => $composableBuilder(
      column: $table.shouldStartDnd,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get distractingApps => $composableBuilder(
          column: $table.distractingApps,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$BedtimeScheduleTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BedtimeScheduleTableTable> {
  $$BedtimeScheduleTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scheduleStartTime => $composableBuilder(
      column: $table.scheduleStartTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scheduleEndTime => $composableBuilder(
      column: $table.scheduleEndTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scheduleDurationInMins => $composableBuilder(
      column: $table.scheduleDurationInMins,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduleDays => $composableBuilder(
      column: $table.scheduleDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isScheduleOn => $composableBuilder(
      column: $table.isScheduleOn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get shouldStartDnd => $composableBuilder(
      column: $table.shouldStartDnd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get distractingApps => $composableBuilder(
      column: $table.distractingApps,
      builder: (column) => ColumnOrderings(column));
}

class $$BedtimeScheduleTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BedtimeScheduleTableTable> {
  $$BedtimeScheduleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      get scheduleStartTime => $composableBuilder(
          column: $table.scheduleStartTime, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int> get scheduleEndTime =>
      $composableBuilder(
          column: $table.scheduleEndTime, builder: (column) => column);

  GeneratedColumn<int> get scheduleDurationInMins => $composableBuilder(
      column: $table.scheduleDurationInMins, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<bool>, String> get scheduleDays =>
      $composableBuilder(
          column: $table.scheduleDays, builder: (column) => column);

  GeneratedColumn<bool> get isScheduleOn => $composableBuilder(
      column: $table.isScheduleOn, builder: (column) => column);

  GeneratedColumn<bool> get shouldStartDnd => $composableBuilder(
      column: $table.shouldStartDnd, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get distractingApps =>
      $composableBuilder(
          column: $table.distractingApps, builder: (column) => column);
}

class $$BedtimeScheduleTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BedtimeScheduleTableTable,
    BedtimeSchedule,
    $$BedtimeScheduleTableTableFilterComposer,
    $$BedtimeScheduleTableTableOrderingComposer,
    $$BedtimeScheduleTableTableAnnotationComposer,
    $$BedtimeScheduleTableTableCreateCompanionBuilder,
    $$BedtimeScheduleTableTableUpdateCompanionBuilder,
    (
      BedtimeSchedule,
      BaseReferences<_$AppDatabase, $BedtimeScheduleTableTable, BedtimeSchedule>
    ),
    BedtimeSchedule,
    PrefetchHooks Function()> {
  $$BedtimeScheduleTableTableTableManager(
      _$AppDatabase db, $BedtimeScheduleTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BedtimeScheduleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BedtimeScheduleTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BedtimeScheduleTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<TimeOfDayAdapter> scheduleStartTime = const Value.absent(),
            Value<TimeOfDayAdapter> scheduleEndTime = const Value.absent(),
            Value<int> scheduleDurationInMins = const Value.absent(),
            Value<List<bool>> scheduleDays = const Value.absent(),
            Value<bool> isScheduleOn = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              BedtimeScheduleTableCompanion(
            id: id,
            scheduleStartTime: scheduleStartTime,
            scheduleEndTime: scheduleEndTime,
            scheduleDurationInMins: scheduleDurationInMins,
            scheduleDays: scheduleDays,
            isScheduleOn: isScheduleOn,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<TimeOfDayAdapter> scheduleStartTime = const Value.absent(),
            Value<TimeOfDayAdapter> scheduleEndTime = const Value.absent(),
            Value<int> scheduleDurationInMins = const Value.absent(),
            Value<List<bool>> scheduleDays = const Value.absent(),
            Value<bool> isScheduleOn = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              BedtimeScheduleTableCompanion.insert(
            id: id,
            scheduleStartTime: scheduleStartTime,
            scheduleEndTime: scheduleEndTime,
            scheduleDurationInMins: scheduleDurationInMins,
            scheduleDays: scheduleDays,
            isScheduleOn: isScheduleOn,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BedtimeScheduleTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $BedtimeScheduleTableTable,
        BedtimeSchedule,
        $$BedtimeScheduleTableTableFilterComposer,
        $$BedtimeScheduleTableTableOrderingComposer,
        $$BedtimeScheduleTableTableAnnotationComposer,
        $$BedtimeScheduleTableTableCreateCompanionBuilder,
        $$BedtimeScheduleTableTableUpdateCompanionBuilder,
        (
          BedtimeSchedule,
          BaseReferences<_$AppDatabase, $BedtimeScheduleTableTable,
              BedtimeSchedule>
        ),
        BedtimeSchedule,
        PrefetchHooks Function()>;
typedef $$CrashLogsTableTableCreateCompanionBuilder = CrashLogsTableCompanion
    Function({
  Value<int> id,
  Value<String> appVersion,
  Value<DateTime> timeStamp,
  Value<String> error,
  Value<String> stackTrace,
});
typedef $$CrashLogsTableTableUpdateCompanionBuilder = CrashLogsTableCompanion
    Function({
  Value<int> id,
  Value<String> appVersion,
  Value<DateTime> timeStamp,
  Value<String> error,
  Value<String> stackTrace,
});

class $$CrashLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CrashLogsTableTable> {
  $$CrashLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stackTrace => $composableBuilder(
      column: $table.stackTrace, builder: (column) => ColumnFilters(column));
}

class $$CrashLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CrashLogsTableTable> {
  $$CrashLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get error => $composableBuilder(
      column: $table.error, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stackTrace => $composableBuilder(
      column: $table.stackTrace, builder: (column) => ColumnOrderings(column));
}

class $$CrashLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrashLogsTableTable> {
  $$CrashLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => column);

  GeneratedColumn<DateTime> get timeStamp =>
      $composableBuilder(column: $table.timeStamp, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<String> get stackTrace => $composableBuilder(
      column: $table.stackTrace, builder: (column) => column);
}

class $$CrashLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CrashLogsTableTable,
    CrashLog,
    $$CrashLogsTableTableFilterComposer,
    $$CrashLogsTableTableOrderingComposer,
    $$CrashLogsTableTableAnnotationComposer,
    $$CrashLogsTableTableCreateCompanionBuilder,
    $$CrashLogsTableTableUpdateCompanionBuilder,
    (CrashLog, BaseReferences<_$AppDatabase, $CrashLogsTableTable, CrashLog>),
    CrashLog,
    PrefetchHooks Function()> {
  $$CrashLogsTableTableTableManager(
      _$AppDatabase db, $CrashLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrashLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrashLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrashLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
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
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> appVersion = const Value.absent(),
            Value<DateTime> timeStamp = const Value.absent(),
            Value<String> error = const Value.absent(),
            Value<String> stackTrace = const Value.absent(),
          }) =>
              CrashLogsTableCompanion.insert(
            id: id,
            appVersion: appVersion,
            timeStamp: timeStamp,
            error: error,
            stackTrace: stackTrace,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CrashLogsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CrashLogsTableTable,
    CrashLog,
    $$CrashLogsTableTableFilterComposer,
    $$CrashLogsTableTableOrderingComposer,
    $$CrashLogsTableTableAnnotationComposer,
    $$CrashLogsTableTableCreateCompanionBuilder,
    $$CrashLogsTableTableUpdateCompanionBuilder,
    (CrashLog, BaseReferences<_$AppDatabase, $CrashLogsTableTable, CrashLog>),
    CrashLog,
    PrefetchHooks Function()>;
typedef $$FocusModeTableTableCreateCompanionBuilder = FocusModeTableCompanion
    Function({
  Value<int> id,
  Value<SessionType> sessionType,
  Value<int> longestStreak,
  Value<int> currentStreak,
  Value<DateTime> lastTimeStreakUpdated,
});
typedef $$FocusModeTableTableUpdateCompanionBuilder = FocusModeTableCompanion
    Function({
  Value<int> id,
  Value<SessionType> sessionType,
  Value<int> longestStreak,
  Value<int> currentStreak,
  Value<DateTime> lastTimeStreakUpdated,
});

class $$FocusModeTableTableFilterComposer
    extends Composer<_$AppDatabase, $FocusModeTableTable> {
  $$FocusModeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SessionType, SessionType, int>
      get sessionType => $composableBuilder(
          column: $table.sessionType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastTimeStreakUpdated => $composableBuilder(
      column: $table.lastTimeStreakUpdated,
      builder: (column) => ColumnFilters(column));
}

class $$FocusModeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusModeTableTable> {
  $$FocusModeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionType => $composableBuilder(
      column: $table.sessionType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastTimeStreakUpdated => $composableBuilder(
      column: $table.lastTimeStreakUpdated,
      builder: (column) => ColumnOrderings(column));
}

class $$FocusModeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusModeTableTable> {
  $$FocusModeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SessionType, int> get sessionType =>
      $composableBuilder(
          column: $table.sessionType, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTimeStreakUpdated => $composableBuilder(
      column: $table.lastTimeStreakUpdated, builder: (column) => column);
}

class $$FocusModeTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusModeTableTable,
    FocusMode,
    $$FocusModeTableTableFilterComposer,
    $$FocusModeTableTableOrderingComposer,
    $$FocusModeTableTableAnnotationComposer,
    $$FocusModeTableTableCreateCompanionBuilder,
    $$FocusModeTableTableUpdateCompanionBuilder,
    (FocusMode, BaseReferences<_$AppDatabase, $FocusModeTableTable, FocusMode>),
    FocusMode,
    PrefetchHooks Function()> {
  $$FocusModeTableTableTableManager(
      _$AppDatabase db, $FocusModeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusModeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusModeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusModeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<SessionType> sessionType = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<DateTime> lastTimeStreakUpdated = const Value.absent(),
          }) =>
              FocusModeTableCompanion(
            id: id,
            sessionType: sessionType,
            longestStreak: longestStreak,
            currentStreak: currentStreak,
            lastTimeStreakUpdated: lastTimeStreakUpdated,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<SessionType> sessionType = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<DateTime> lastTimeStreakUpdated = const Value.absent(),
          }) =>
              FocusModeTableCompanion.insert(
            id: id,
            sessionType: sessionType,
            longestStreak: longestStreak,
            currentStreak: currentStreak,
            lastTimeStreakUpdated: lastTimeStreakUpdated,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FocusModeTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FocusModeTableTable,
    FocusMode,
    $$FocusModeTableTableFilterComposer,
    $$FocusModeTableTableOrderingComposer,
    $$FocusModeTableTableAnnotationComposer,
    $$FocusModeTableTableCreateCompanionBuilder,
    $$FocusModeTableTableUpdateCompanionBuilder,
    (FocusMode, BaseReferences<_$AppDatabase, $FocusModeTableTable, FocusMode>),
    FocusMode,
    PrefetchHooks Function()>;
typedef $$FocusProfileTableTableCreateCompanionBuilder
    = FocusProfileTableCompanion Function({
  Value<SessionType> sessionType,
  Value<int> sessionDuration,
  Value<bool> enforceSession,
  Value<bool> shouldStartDnd,
  Value<List<String>> distractingApps,
});
typedef $$FocusProfileTableTableUpdateCompanionBuilder
    = FocusProfileTableCompanion Function({
  Value<SessionType> sessionType,
  Value<int> sessionDuration,
  Value<bool> enforceSession,
  Value<bool> shouldStartDnd,
  Value<List<String>> distractingApps,
});

class $$FocusProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $FocusProfileTableTable> {
  $$FocusProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<SessionType, SessionType, int>
      get sessionType => $composableBuilder(
          column: $table.sessionType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get sessionDuration => $composableBuilder(
      column: $table.sessionDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enforceSession => $composableBuilder(
      column: $table.enforceSession,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get shouldStartDnd => $composableBuilder(
      column: $table.shouldStartDnd,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get distractingApps => $composableBuilder(
          column: $table.distractingApps,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$FocusProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusProfileTableTable> {
  $$FocusProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sessionType => $composableBuilder(
      column: $table.sessionType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionDuration => $composableBuilder(
      column: $table.sessionDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enforceSession => $composableBuilder(
      column: $table.enforceSession,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get shouldStartDnd => $composableBuilder(
      column: $table.shouldStartDnd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get distractingApps => $composableBuilder(
      column: $table.distractingApps,
      builder: (column) => ColumnOrderings(column));
}

class $$FocusProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusProfileTableTable> {
  $$FocusProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<SessionType, int> get sessionType =>
      $composableBuilder(
          column: $table.sessionType, builder: (column) => column);

  GeneratedColumn<int> get sessionDuration => $composableBuilder(
      column: $table.sessionDuration, builder: (column) => column);

  GeneratedColumn<bool> get enforceSession => $composableBuilder(
      column: $table.enforceSession, builder: (column) => column);

  GeneratedColumn<bool> get shouldStartDnd => $composableBuilder(
      column: $table.shouldStartDnd, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get distractingApps =>
      $composableBuilder(
          column: $table.distractingApps, builder: (column) => column);
}

class $$FocusProfileTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusProfileTableTable,
    FocusProfile,
    $$FocusProfileTableTableFilterComposer,
    $$FocusProfileTableTableOrderingComposer,
    $$FocusProfileTableTableAnnotationComposer,
    $$FocusProfileTableTableCreateCompanionBuilder,
    $$FocusProfileTableTableUpdateCompanionBuilder,
    (
      FocusProfile,
      BaseReferences<_$AppDatabase, $FocusProfileTableTable, FocusProfile>
    ),
    FocusProfile,
    PrefetchHooks Function()> {
  $$FocusProfileTableTableTableManager(
      _$AppDatabase db, $FocusProfileTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusProfileTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<SessionType> sessionType = const Value.absent(),
            Value<int> sessionDuration = const Value.absent(),
            Value<bool> enforceSession = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              FocusProfileTableCompanion(
            sessionType: sessionType,
            sessionDuration: sessionDuration,
            enforceSession: enforceSession,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
          createCompanionCallback: ({
            Value<SessionType> sessionType = const Value.absent(),
            Value<int> sessionDuration = const Value.absent(),
            Value<bool> enforceSession = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              FocusProfileTableCompanion.insert(
            sessionType: sessionType,
            sessionDuration: sessionDuration,
            enforceSession: enforceSession,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FocusProfileTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FocusProfileTableTable,
    FocusProfile,
    $$FocusProfileTableTableFilterComposer,
    $$FocusProfileTableTableOrderingComposer,
    $$FocusProfileTableTableAnnotationComposer,
    $$FocusProfileTableTableCreateCompanionBuilder,
    $$FocusProfileTableTableUpdateCompanionBuilder,
    (
      FocusProfile,
      BaseReferences<_$AppDatabase, $FocusProfileTableTable, FocusProfile>
    ),
    FocusProfile,
    PrefetchHooks Function()>;
typedef $$FocusSessionsTableTableCreateCompanionBuilder
    = FocusSessionsTableCompanion Function({
  Value<int> id,
  Value<SessionType> type,
  Value<SessionState> state,
  Value<DateTime> startDateTime,
  Value<int> durationSecs,
  Value<String> reflection,
});
typedef $$FocusSessionsTableTableUpdateCompanionBuilder
    = FocusSessionsTableCompanion Function({
  Value<int> id,
  Value<SessionType> type,
  Value<SessionState> state,
  Value<DateTime> startDateTime,
  Value<int> durationSecs,
  Value<String> reflection,
});

class $$FocusSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SessionType, SessionType, int> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<SessionState, SessionState, int> get state =>
      $composableBuilder(
          column: $table.state,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get startDateTime => $composableBuilder(
      column: $table.startDateTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSecs => $composableBuilder(
      column: $table.durationSecs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reflection => $composableBuilder(
      column: $table.reflection, builder: (column) => ColumnFilters(column));
}

class $$FocusSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDateTime => $composableBuilder(
      column: $table.startDateTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSecs => $composableBuilder(
      column: $table.durationSecs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reflection => $composableBuilder(
      column: $table.reflection, builder: (column) => ColumnOrderings(column));
}

class $$FocusSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SessionType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SessionState, int> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get startDateTime => $composableBuilder(
      column: $table.startDateTime, builder: (column) => column);

  GeneratedColumn<int> get durationSecs => $composableBuilder(
      column: $table.durationSecs, builder: (column) => column);

  GeneratedColumn<String> get reflection => $composableBuilder(
      column: $table.reflection, builder: (column) => column);
}

class $$FocusSessionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusSessionsTableTable,
    FocusSession,
    $$FocusSessionsTableTableFilterComposer,
    $$FocusSessionsTableTableOrderingComposer,
    $$FocusSessionsTableTableAnnotationComposer,
    $$FocusSessionsTableTableCreateCompanionBuilder,
    $$FocusSessionsTableTableUpdateCompanionBuilder,
    (
      FocusSession,
      BaseReferences<_$AppDatabase, $FocusSessionsTableTable, FocusSession>
    ),
    FocusSession,
    PrefetchHooks Function()> {
  $$FocusSessionsTableTableTableManager(
      _$AppDatabase db, $FocusSessionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusSessionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<SessionType> type = const Value.absent(),
            Value<SessionState> state = const Value.absent(),
            Value<DateTime> startDateTime = const Value.absent(),
            Value<int> durationSecs = const Value.absent(),
            Value<String> reflection = const Value.absent(),
          }) =>
              FocusSessionsTableCompanion(
            id: id,
            type: type,
            state: state,
            startDateTime: startDateTime,
            durationSecs: durationSecs,
            reflection: reflection,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<SessionType> type = const Value.absent(),
            Value<SessionState> state = const Value.absent(),
            Value<DateTime> startDateTime = const Value.absent(),
            Value<int> durationSecs = const Value.absent(),
            Value<String> reflection = const Value.absent(),
          }) =>
              FocusSessionsTableCompanion.insert(
            id: id,
            type: type,
            state: state,
            startDateTime: startDateTime,
            durationSecs: durationSecs,
            reflection: reflection,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FocusSessionsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FocusSessionsTableTable,
    FocusSession,
    $$FocusSessionsTableTableFilterComposer,
    $$FocusSessionsTableTableOrderingComposer,
    $$FocusSessionsTableTableAnnotationComposer,
    $$FocusSessionsTableTableCreateCompanionBuilder,
    $$FocusSessionsTableTableUpdateCompanionBuilder,
    (
      FocusSession,
      BaseReferences<_$AppDatabase, $FocusSessionsTableTable, FocusSession>
    ),
    FocusSession,
    PrefetchHooks Function()>;
typedef $$MindfulSettingsTableTableCreateCompanionBuilder
    = MindfulSettingsTableCompanion Function({
  Value<int> id,
  Value<AppThemeMode> themeMode,
  Value<String> accentColor,
  Value<String> username,
  Value<String> localeCode,
  Value<bool> useAmoledDark,
  Value<bool> useDynamicColors,
  Value<DefaultHomeTab> defaultHomeTab,
  Value<int> usageHistoryWeeks,
  Value<int> leftEmergencyPasses,
  Value<DateTime> lastEmergencyUsed,
  Value<bool> isOnboardingDone,
  Value<String> appVersion,
});
typedef $$MindfulSettingsTableTableUpdateCompanionBuilder
    = MindfulSettingsTableCompanion Function({
  Value<int> id,
  Value<AppThemeMode> themeMode,
  Value<String> accentColor,
  Value<String> username,
  Value<String> localeCode,
  Value<bool> useAmoledDark,
  Value<bool> useDynamicColors,
  Value<DefaultHomeTab> defaultHomeTab,
  Value<int> usageHistoryWeeks,
  Value<int> leftEmergencyPasses,
  Value<DateTime> lastEmergencyUsed,
  Value<bool> isOnboardingDone,
  Value<String> appVersion,
});

class $$MindfulSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MindfulSettingsTableTable> {
  $$MindfulSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<AppThemeMode, AppThemeMode, int>
      get themeMode => $composableBuilder(
          column: $table.themeMode,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get accentColor => $composableBuilder(
      column: $table.accentColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localeCode => $composableBuilder(
      column: $table.localeCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get useAmoledDark => $composableBuilder(
      column: $table.useAmoledDark, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get useDynamicColors => $composableBuilder(
      column: $table.useDynamicColors,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<DefaultHomeTab, DefaultHomeTab, int>
      get defaultHomeTab => $composableBuilder(
          column: $table.defaultHomeTab,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get usageHistoryWeeks => $composableBuilder(
      column: $table.usageHistoryWeeks,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get leftEmergencyPasses => $composableBuilder(
      column: $table.leftEmergencyPasses,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastEmergencyUsed => $composableBuilder(
      column: $table.lastEmergencyUsed,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isOnboardingDone => $composableBuilder(
      column: $table.isOnboardingDone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => ColumnFilters(column));
}

class $$MindfulSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MindfulSettingsTableTable> {
  $$MindfulSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accentColor => $composableBuilder(
      column: $table.accentColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localeCode => $composableBuilder(
      column: $table.localeCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get useAmoledDark => $composableBuilder(
      column: $table.useAmoledDark,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get useDynamicColors => $composableBuilder(
      column: $table.useDynamicColors,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultHomeTab => $composableBuilder(
      column: $table.defaultHomeTab,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usageHistoryWeeks => $composableBuilder(
      column: $table.usageHistoryWeeks,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get leftEmergencyPasses => $composableBuilder(
      column: $table.leftEmergencyPasses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastEmergencyUsed => $composableBuilder(
      column: $table.lastEmergencyUsed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isOnboardingDone => $composableBuilder(
      column: $table.isOnboardingDone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => ColumnOrderings(column));
}

class $$MindfulSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MindfulSettingsTableTable> {
  $$MindfulSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AppThemeMode, int> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get accentColor => $composableBuilder(
      column: $table.accentColor, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get localeCode => $composableBuilder(
      column: $table.localeCode, builder: (column) => column);

  GeneratedColumn<bool> get useAmoledDark => $composableBuilder(
      column: $table.useAmoledDark, builder: (column) => column);

  GeneratedColumn<bool> get useDynamicColors => $composableBuilder(
      column: $table.useDynamicColors, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DefaultHomeTab, int> get defaultHomeTab =>
      $composableBuilder(
          column: $table.defaultHomeTab, builder: (column) => column);

  GeneratedColumn<int> get usageHistoryWeeks => $composableBuilder(
      column: $table.usageHistoryWeeks, builder: (column) => column);

  GeneratedColumn<int> get leftEmergencyPasses => $composableBuilder(
      column: $table.leftEmergencyPasses, builder: (column) => column);

  GeneratedColumn<DateTime> get lastEmergencyUsed => $composableBuilder(
      column: $table.lastEmergencyUsed, builder: (column) => column);

  GeneratedColumn<bool> get isOnboardingDone => $composableBuilder(
      column: $table.isOnboardingDone, builder: (column) => column);

  GeneratedColumn<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => column);
}

class $$MindfulSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MindfulSettingsTableTable,
    MindfulSettings,
    $$MindfulSettingsTableTableFilterComposer,
    $$MindfulSettingsTableTableOrderingComposer,
    $$MindfulSettingsTableTableAnnotationComposer,
    $$MindfulSettingsTableTableCreateCompanionBuilder,
    $$MindfulSettingsTableTableUpdateCompanionBuilder,
    (
      MindfulSettings,
      BaseReferences<_$AppDatabase, $MindfulSettingsTableTable, MindfulSettings>
    ),
    MindfulSettings,
    PrefetchHooks Function()> {
  $$MindfulSettingsTableTableTableManager(
      _$AppDatabase db, $MindfulSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MindfulSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MindfulSettingsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MindfulSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<AppThemeMode> themeMode = const Value.absent(),
            Value<String> accentColor = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> localeCode = const Value.absent(),
            Value<bool> useAmoledDark = const Value.absent(),
            Value<bool> useDynamicColors = const Value.absent(),
            Value<DefaultHomeTab> defaultHomeTab = const Value.absent(),
            Value<int> usageHistoryWeeks = const Value.absent(),
            Value<int> leftEmergencyPasses = const Value.absent(),
            Value<DateTime> lastEmergencyUsed = const Value.absent(),
            Value<bool> isOnboardingDone = const Value.absent(),
            Value<String> appVersion = const Value.absent(),
          }) =>
              MindfulSettingsTableCompanion(
            id: id,
            themeMode: themeMode,
            accentColor: accentColor,
            username: username,
            localeCode: localeCode,
            useAmoledDark: useAmoledDark,
            useDynamicColors: useDynamicColors,
            defaultHomeTab: defaultHomeTab,
            usageHistoryWeeks: usageHistoryWeeks,
            leftEmergencyPasses: leftEmergencyPasses,
            lastEmergencyUsed: lastEmergencyUsed,
            isOnboardingDone: isOnboardingDone,
            appVersion: appVersion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<AppThemeMode> themeMode = const Value.absent(),
            Value<String> accentColor = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> localeCode = const Value.absent(),
            Value<bool> useAmoledDark = const Value.absent(),
            Value<bool> useDynamicColors = const Value.absent(),
            Value<DefaultHomeTab> defaultHomeTab = const Value.absent(),
            Value<int> usageHistoryWeeks = const Value.absent(),
            Value<int> leftEmergencyPasses = const Value.absent(),
            Value<DateTime> lastEmergencyUsed = const Value.absent(),
            Value<bool> isOnboardingDone = const Value.absent(),
            Value<String> appVersion = const Value.absent(),
          }) =>
              MindfulSettingsTableCompanion.insert(
            id: id,
            themeMode: themeMode,
            accentColor: accentColor,
            username: username,
            localeCode: localeCode,
            useAmoledDark: useAmoledDark,
            useDynamicColors: useDynamicColors,
            defaultHomeTab: defaultHomeTab,
            usageHistoryWeeks: usageHistoryWeeks,
            leftEmergencyPasses: leftEmergencyPasses,
            lastEmergencyUsed: lastEmergencyUsed,
            isOnboardingDone: isOnboardingDone,
            appVersion: appVersion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MindfulSettingsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $MindfulSettingsTableTable,
        MindfulSettings,
        $$MindfulSettingsTableTableFilterComposer,
        $$MindfulSettingsTableTableOrderingComposer,
        $$MindfulSettingsTableTableAnnotationComposer,
        $$MindfulSettingsTableTableCreateCompanionBuilder,
        $$MindfulSettingsTableTableUpdateCompanionBuilder,
        (
          MindfulSettings,
          BaseReferences<_$AppDatabase, $MindfulSettingsTableTable,
              MindfulSettings>
        ),
        MindfulSettings,
        PrefetchHooks Function()>;
typedef $$ParentalControlsTableTableCreateCompanionBuilder
    = ParentalControlsTableCompanion Function({
  Value<int> id,
  Value<bool> protectedAccess,
  Value<TimeOfDayAdapter> uninstallWindowTime,
  Value<bool> isInvincibleModeOn,
  Value<TimeOfDayAdapter> invincibleWindowTime,
  Value<bool> includeAppsTimer,
  Value<bool> includeAppsLaunchLimit,
  Value<bool> includeAppsActivePeriod,
  Value<bool> includeGroupsTimer,
  Value<bool> includeGroupsActivePeriod,
  Value<bool> includeShortsTimer,
  Value<bool> includeBedtimeSchedule,
});
typedef $$ParentalControlsTableTableUpdateCompanionBuilder
    = ParentalControlsTableCompanion Function({
  Value<int> id,
  Value<bool> protectedAccess,
  Value<TimeOfDayAdapter> uninstallWindowTime,
  Value<bool> isInvincibleModeOn,
  Value<TimeOfDayAdapter> invincibleWindowTime,
  Value<bool> includeAppsTimer,
  Value<bool> includeAppsLaunchLimit,
  Value<bool> includeAppsActivePeriod,
  Value<bool> includeGroupsTimer,
  Value<bool> includeGroupsActivePeriod,
  Value<bool> includeShortsTimer,
  Value<bool> includeBedtimeSchedule,
});

class $$ParentalControlsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ParentalControlsTableTable> {
  $$ParentalControlsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get protectedAccess => $composableBuilder(
      column: $table.protectedAccess,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get uninstallWindowTime => $composableBuilder(
          column: $table.uninstallWindowTime,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isInvincibleModeOn => $composableBuilder(
      column: $table.isInvincibleModeOn,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get invincibleWindowTime => $composableBuilder(
          column: $table.invincibleWindowTime,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get includeAppsTimer => $composableBuilder(
      column: $table.includeAppsTimer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get includeAppsLaunchLimit => $composableBuilder(
      column: $table.includeAppsLaunchLimit,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get includeAppsActivePeriod => $composableBuilder(
      column: $table.includeAppsActivePeriod,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get includeGroupsTimer => $composableBuilder(
      column: $table.includeGroupsTimer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get includeGroupsActivePeriod => $composableBuilder(
      column: $table.includeGroupsActivePeriod,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get includeShortsTimer => $composableBuilder(
      column: $table.includeShortsTimer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get includeBedtimeSchedule => $composableBuilder(
      column: $table.includeBedtimeSchedule,
      builder: (column) => ColumnFilters(column));
}

class $$ParentalControlsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ParentalControlsTableTable> {
  $$ParentalControlsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get protectedAccess => $composableBuilder(
      column: $table.protectedAccess,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get uninstallWindowTime => $composableBuilder(
      column: $table.uninstallWindowTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isInvincibleModeOn => $composableBuilder(
      column: $table.isInvincibleModeOn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get invincibleWindowTime => $composableBuilder(
      column: $table.invincibleWindowTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeAppsTimer => $composableBuilder(
      column: $table.includeAppsTimer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeAppsLaunchLimit => $composableBuilder(
      column: $table.includeAppsLaunchLimit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeAppsActivePeriod => $composableBuilder(
      column: $table.includeAppsActivePeriod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeGroupsTimer => $composableBuilder(
      column: $table.includeGroupsTimer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeGroupsActivePeriod => $composableBuilder(
      column: $table.includeGroupsActivePeriod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeShortsTimer => $composableBuilder(
      column: $table.includeShortsTimer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get includeBedtimeSchedule => $composableBuilder(
      column: $table.includeBedtimeSchedule,
      builder: (column) => ColumnOrderings(column));
}

class $$ParentalControlsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParentalControlsTableTable> {
  $$ParentalControlsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get protectedAccess => $composableBuilder(
      column: $table.protectedAccess, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      get uninstallWindowTime => $composableBuilder(
          column: $table.uninstallWindowTime, builder: (column) => column);

  GeneratedColumn<bool> get isInvincibleModeOn => $composableBuilder(
      column: $table.isInvincibleModeOn, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      get invincibleWindowTime => $composableBuilder(
          column: $table.invincibleWindowTime, builder: (column) => column);

  GeneratedColumn<bool> get includeAppsTimer => $composableBuilder(
      column: $table.includeAppsTimer, builder: (column) => column);

  GeneratedColumn<bool> get includeAppsLaunchLimit => $composableBuilder(
      column: $table.includeAppsLaunchLimit, builder: (column) => column);

  GeneratedColumn<bool> get includeAppsActivePeriod => $composableBuilder(
      column: $table.includeAppsActivePeriod, builder: (column) => column);

  GeneratedColumn<bool> get includeGroupsTimer => $composableBuilder(
      column: $table.includeGroupsTimer, builder: (column) => column);

  GeneratedColumn<bool> get includeGroupsActivePeriod => $composableBuilder(
      column: $table.includeGroupsActivePeriod, builder: (column) => column);

  GeneratedColumn<bool> get includeShortsTimer => $composableBuilder(
      column: $table.includeShortsTimer, builder: (column) => column);

  GeneratedColumn<bool> get includeBedtimeSchedule => $composableBuilder(
      column: $table.includeBedtimeSchedule, builder: (column) => column);
}

class $$ParentalControlsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ParentalControlsTableTable,
    ParentalControls,
    $$ParentalControlsTableTableFilterComposer,
    $$ParentalControlsTableTableOrderingComposer,
    $$ParentalControlsTableTableAnnotationComposer,
    $$ParentalControlsTableTableCreateCompanionBuilder,
    $$ParentalControlsTableTableUpdateCompanionBuilder,
    (
      ParentalControls,
      BaseReferences<_$AppDatabase, $ParentalControlsTableTable,
          ParentalControls>
    ),
    ParentalControls,
    PrefetchHooks Function()> {
  $$ParentalControlsTableTableTableManager(
      _$AppDatabase db, $ParentalControlsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParentalControlsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ParentalControlsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParentalControlsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> protectedAccess = const Value.absent(),
            Value<TimeOfDayAdapter> uninstallWindowTime = const Value.absent(),
            Value<bool> isInvincibleModeOn = const Value.absent(),
            Value<TimeOfDayAdapter> invincibleWindowTime = const Value.absent(),
            Value<bool> includeAppsTimer = const Value.absent(),
            Value<bool> includeAppsLaunchLimit = const Value.absent(),
            Value<bool> includeAppsActivePeriod = const Value.absent(),
            Value<bool> includeGroupsTimer = const Value.absent(),
            Value<bool> includeGroupsActivePeriod = const Value.absent(),
            Value<bool> includeShortsTimer = const Value.absent(),
            Value<bool> includeBedtimeSchedule = const Value.absent(),
          }) =>
              ParentalControlsTableCompanion(
            id: id,
            protectedAccess: protectedAccess,
            uninstallWindowTime: uninstallWindowTime,
            isInvincibleModeOn: isInvincibleModeOn,
            invincibleWindowTime: invincibleWindowTime,
            includeAppsTimer: includeAppsTimer,
            includeAppsLaunchLimit: includeAppsLaunchLimit,
            includeAppsActivePeriod: includeAppsActivePeriod,
            includeGroupsTimer: includeGroupsTimer,
            includeGroupsActivePeriod: includeGroupsActivePeriod,
            includeShortsTimer: includeShortsTimer,
            includeBedtimeSchedule: includeBedtimeSchedule,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> protectedAccess = const Value.absent(),
            Value<TimeOfDayAdapter> uninstallWindowTime = const Value.absent(),
            Value<bool> isInvincibleModeOn = const Value.absent(),
            Value<TimeOfDayAdapter> invincibleWindowTime = const Value.absent(),
            Value<bool> includeAppsTimer = const Value.absent(),
            Value<bool> includeAppsLaunchLimit = const Value.absent(),
            Value<bool> includeAppsActivePeriod = const Value.absent(),
            Value<bool> includeGroupsTimer = const Value.absent(),
            Value<bool> includeGroupsActivePeriod = const Value.absent(),
            Value<bool> includeShortsTimer = const Value.absent(),
            Value<bool> includeBedtimeSchedule = const Value.absent(),
          }) =>
              ParentalControlsTableCompanion.insert(
            id: id,
            protectedAccess: protectedAccess,
            uninstallWindowTime: uninstallWindowTime,
            isInvincibleModeOn: isInvincibleModeOn,
            invincibleWindowTime: invincibleWindowTime,
            includeAppsTimer: includeAppsTimer,
            includeAppsLaunchLimit: includeAppsLaunchLimit,
            includeAppsActivePeriod: includeAppsActivePeriod,
            includeGroupsTimer: includeGroupsTimer,
            includeGroupsActivePeriod: includeGroupsActivePeriod,
            includeShortsTimer: includeShortsTimer,
            includeBedtimeSchedule: includeBedtimeSchedule,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ParentalControlsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ParentalControlsTableTable,
        ParentalControls,
        $$ParentalControlsTableTableFilterComposer,
        $$ParentalControlsTableTableOrderingComposer,
        $$ParentalControlsTableTableAnnotationComposer,
        $$ParentalControlsTableTableCreateCompanionBuilder,
        $$ParentalControlsTableTableUpdateCompanionBuilder,
        (
          ParentalControls,
          BaseReferences<_$AppDatabase, $ParentalControlsTableTable,
              ParentalControls>
        ),
        ParentalControls,
        PrefetchHooks Function()>;
typedef $$RestrictionGroupsTableTableCreateCompanionBuilder
    = RestrictionGroupsTableCompanion Function({
  Value<int> id,
  Value<String> groupName,
  Value<int> timerSec,
  Value<TimeOfDayAdapter> activePeriodStart,
  Value<TimeOfDayAdapter> activePeriodEnd,
  Value<int> periodDurationInMins,
  Value<List<String>> distractingApps,
});
typedef $$RestrictionGroupsTableTableUpdateCompanionBuilder
    = RestrictionGroupsTableCompanion Function({
  Value<int> id,
  Value<String> groupName,
  Value<int> timerSec,
  Value<TimeOfDayAdapter> activePeriodStart,
  Value<TimeOfDayAdapter> activePeriodEnd,
  Value<int> periodDurationInMins,
  Value<List<String>> distractingApps,
});

class $$RestrictionGroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RestrictionGroupsTableTable> {
  $$RestrictionGroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timerSec => $composableBuilder(
      column: $table.timerSec, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get activePeriodStart => $composableBuilder(
          column: $table.activePeriodStart,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get activePeriodEnd => $composableBuilder(
          column: $table.activePeriodEnd,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get periodDurationInMins => $composableBuilder(
      column: $table.periodDurationInMins,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get distractingApps => $composableBuilder(
          column: $table.distractingApps,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$RestrictionGroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RestrictionGroupsTableTable> {
  $$RestrictionGroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupName => $composableBuilder(
      column: $table.groupName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timerSec => $composableBuilder(
      column: $table.timerSec, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activePeriodStart => $composableBuilder(
      column: $table.activePeriodStart,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activePeriodEnd => $composableBuilder(
      column: $table.activePeriodEnd,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get periodDurationInMins => $composableBuilder(
      column: $table.periodDurationInMins,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get distractingApps => $composableBuilder(
      column: $table.distractingApps,
      builder: (column) => ColumnOrderings(column));
}

class $$RestrictionGroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestrictionGroupsTableTable> {
  $$RestrictionGroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<int> get timerSec =>
      $composableBuilder(column: $table.timerSec, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int>
      get activePeriodStart => $composableBuilder(
          column: $table.activePeriodStart, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int> get activePeriodEnd =>
      $composableBuilder(
          column: $table.activePeriodEnd, builder: (column) => column);

  GeneratedColumn<int> get periodDurationInMins => $composableBuilder(
      column: $table.periodDurationInMins, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get distractingApps =>
      $composableBuilder(
          column: $table.distractingApps, builder: (column) => column);
}

class $$RestrictionGroupsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RestrictionGroupsTableTable,
    RestrictionGroup,
    $$RestrictionGroupsTableTableFilterComposer,
    $$RestrictionGroupsTableTableOrderingComposer,
    $$RestrictionGroupsTableTableAnnotationComposer,
    $$RestrictionGroupsTableTableCreateCompanionBuilder,
    $$RestrictionGroupsTableTableUpdateCompanionBuilder,
    (
      RestrictionGroup,
      BaseReferences<_$AppDatabase, $RestrictionGroupsTableTable,
          RestrictionGroup>
    ),
    RestrictionGroup,
    PrefetchHooks Function()> {
  $$RestrictionGroupsTableTableTableManager(
      _$AppDatabase db, $RestrictionGroupsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestrictionGroupsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$RestrictionGroupsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestrictionGroupsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<int> timerSec = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodStart = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodEnd = const Value.absent(),
            Value<int> periodDurationInMins = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              RestrictionGroupsTableCompanion(
            id: id,
            groupName: groupName,
            timerSec: timerSec,
            activePeriodStart: activePeriodStart,
            activePeriodEnd: activePeriodEnd,
            periodDurationInMins: periodDurationInMins,
            distractingApps: distractingApps,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> groupName = const Value.absent(),
            Value<int> timerSec = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodStart = const Value.absent(),
            Value<TimeOfDayAdapter> activePeriodEnd = const Value.absent(),
            Value<int> periodDurationInMins = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              RestrictionGroupsTableCompanion.insert(
            id: id,
            groupName: groupName,
            timerSec: timerSec,
            activePeriodStart: activePeriodStart,
            activePeriodEnd: activePeriodEnd,
            periodDurationInMins: periodDurationInMins,
            distractingApps: distractingApps,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RestrictionGroupsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RestrictionGroupsTableTable,
        RestrictionGroup,
        $$RestrictionGroupsTableTableFilterComposer,
        $$RestrictionGroupsTableTableOrderingComposer,
        $$RestrictionGroupsTableTableAnnotationComposer,
        $$RestrictionGroupsTableTableCreateCompanionBuilder,
        $$RestrictionGroupsTableTableUpdateCompanionBuilder,
        (
          RestrictionGroup,
          BaseReferences<_$AppDatabase, $RestrictionGroupsTableTable,
              RestrictionGroup>
        ),
        RestrictionGroup,
        PrefetchHooks Function()>;
typedef $$WellbeingTableTableCreateCompanionBuilder = WellbeingTableCompanion
    Function({
  Value<int> id,
  Value<int> allowedShortsTimeSec,
  Value<List<PlatformFeatures>> blockedFeatures,
  Value<bool> blockNsfwSites,
  Value<List<String>> blockedWebsites,
  Value<List<String>> nsfwWebsites,
});
typedef $$WellbeingTableTableUpdateCompanionBuilder = WellbeingTableCompanion
    Function({
  Value<int> id,
  Value<int> allowedShortsTimeSec,
  Value<List<PlatformFeatures>> blockedFeatures,
  Value<bool> blockNsfwSites,
  Value<List<String>> blockedWebsites,
  Value<List<String>> nsfwWebsites,
});

class $$WellbeingTableTableFilterComposer
    extends Composer<_$AppDatabase, $WellbeingTableTable> {
  $$WellbeingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get allowedShortsTimeSec => $composableBuilder(
      column: $table.allowedShortsTimeSec,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<PlatformFeatures>, List<PlatformFeatures>,
          String>
      get blockedFeatures => $composableBuilder(
          column: $table.blockedFeatures,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get blockNsfwSites => $composableBuilder(
      column: $table.blockNsfwSites,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get blockedWebsites => $composableBuilder(
          column: $table.blockedWebsites,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get nsfwWebsites => $composableBuilder(
          column: $table.nsfwWebsites,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$WellbeingTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WellbeingTableTable> {
  $$WellbeingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get allowedShortsTimeSec => $composableBuilder(
      column: $table.allowedShortsTimeSec,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blockedFeatures => $composableBuilder(
      column: $table.blockedFeatures,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get blockNsfwSites => $composableBuilder(
      column: $table.blockNsfwSites,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blockedWebsites => $composableBuilder(
      column: $table.blockedWebsites,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nsfwWebsites => $composableBuilder(
      column: $table.nsfwWebsites,
      builder: (column) => ColumnOrderings(column));
}

class $$WellbeingTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WellbeingTableTable> {
  $$WellbeingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get allowedShortsTimeSec => $composableBuilder(
      column: $table.allowedShortsTimeSec, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<PlatformFeatures>, String>
      get blockedFeatures => $composableBuilder(
          column: $table.blockedFeatures, builder: (column) => column);

  GeneratedColumn<bool> get blockNsfwSites => $composableBuilder(
      column: $table.blockNsfwSites, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get blockedWebsites =>
      $composableBuilder(
          column: $table.blockedWebsites, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get nsfwWebsites =>
      $composableBuilder(
          column: $table.nsfwWebsites, builder: (column) => column);
}

class $$WellbeingTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WellbeingTableTable,
    Wellbeing,
    $$WellbeingTableTableFilterComposer,
    $$WellbeingTableTableOrderingComposer,
    $$WellbeingTableTableAnnotationComposer,
    $$WellbeingTableTableCreateCompanionBuilder,
    $$WellbeingTableTableUpdateCompanionBuilder,
    (Wellbeing, BaseReferences<_$AppDatabase, $WellbeingTableTable, Wellbeing>),
    Wellbeing,
    PrefetchHooks Function()> {
  $$WellbeingTableTableTableManager(
      _$AppDatabase db, $WellbeingTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WellbeingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WellbeingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WellbeingTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> allowedShortsTimeSec = const Value.absent(),
            Value<List<PlatformFeatures>> blockedFeatures =
                const Value.absent(),
            Value<bool> blockNsfwSites = const Value.absent(),
            Value<List<String>> blockedWebsites = const Value.absent(),
            Value<List<String>> nsfwWebsites = const Value.absent(),
          }) =>
              WellbeingTableCompanion(
            id: id,
            allowedShortsTimeSec: allowedShortsTimeSec,
            blockedFeatures: blockedFeatures,
            blockNsfwSites: blockNsfwSites,
            blockedWebsites: blockedWebsites,
            nsfwWebsites: nsfwWebsites,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> allowedShortsTimeSec = const Value.absent(),
            Value<List<PlatformFeatures>> blockedFeatures =
                const Value.absent(),
            Value<bool> blockNsfwSites = const Value.absent(),
            Value<List<String>> blockedWebsites = const Value.absent(),
            Value<List<String>> nsfwWebsites = const Value.absent(),
          }) =>
              WellbeingTableCompanion.insert(
            id: id,
            allowedShortsTimeSec: allowedShortsTimeSec,
            blockedFeatures: blockedFeatures,
            blockNsfwSites: blockNsfwSites,
            blockedWebsites: blockedWebsites,
            nsfwWebsites: nsfwWebsites,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WellbeingTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WellbeingTableTable,
    Wellbeing,
    $$WellbeingTableTableFilterComposer,
    $$WellbeingTableTableOrderingComposer,
    $$WellbeingTableTableAnnotationComposer,
    $$WellbeingTableTableCreateCompanionBuilder,
    $$WellbeingTableTableUpdateCompanionBuilder,
    (Wellbeing, BaseReferences<_$AppDatabase, $WellbeingTableTable, Wellbeing>),
    Wellbeing,
    PrefetchHooks Function()>;
typedef $$SharedUniqueDataTableTableCreateCompanionBuilder
    = SharedUniqueDataTableCompanion Function({
  Value<int> id,
  Value<List<String>> excludedApps,
});
typedef $$SharedUniqueDataTableTableUpdateCompanionBuilder
    = SharedUniqueDataTableCompanion Function({
  Value<int> id,
  Value<List<String>> excludedApps,
});

class $$SharedUniqueDataTableTableFilterComposer
    extends Composer<_$AppDatabase, $SharedUniqueDataTableTable> {
  $$SharedUniqueDataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get excludedApps => $composableBuilder(
          column: $table.excludedApps,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$SharedUniqueDataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SharedUniqueDataTableTable> {
  $$SharedUniqueDataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get excludedApps => $composableBuilder(
      column: $table.excludedApps,
      builder: (column) => ColumnOrderings(column));
}

class $$SharedUniqueDataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SharedUniqueDataTableTable> {
  $$SharedUniqueDataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get excludedApps =>
      $composableBuilder(
          column: $table.excludedApps, builder: (column) => column);
}

class $$SharedUniqueDataTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SharedUniqueDataTableTable,
    SharedUniqueData,
    $$SharedUniqueDataTableTableFilterComposer,
    $$SharedUniqueDataTableTableOrderingComposer,
    $$SharedUniqueDataTableTableAnnotationComposer,
    $$SharedUniqueDataTableTableCreateCompanionBuilder,
    $$SharedUniqueDataTableTableUpdateCompanionBuilder,
    (
      SharedUniqueData,
      BaseReferences<_$AppDatabase, $SharedUniqueDataTableTable,
          SharedUniqueData>
    ),
    SharedUniqueData,
    PrefetchHooks Function()> {
  $$SharedUniqueDataTableTableTableManager(
      _$AppDatabase db, $SharedUniqueDataTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SharedUniqueDataTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SharedUniqueDataTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SharedUniqueDataTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<List<String>> excludedApps = const Value.absent(),
          }) =>
              SharedUniqueDataTableCompanion(
            id: id,
            excludedApps: excludedApps,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<List<String>> excludedApps = const Value.absent(),
          }) =>
              SharedUniqueDataTableCompanion.insert(
            id: id,
            excludedApps: excludedApps,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SharedUniqueDataTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SharedUniqueDataTableTable,
        SharedUniqueData,
        $$SharedUniqueDataTableTableFilterComposer,
        $$SharedUniqueDataTableTableOrderingComposer,
        $$SharedUniqueDataTableTableAnnotationComposer,
        $$SharedUniqueDataTableTableCreateCompanionBuilder,
        $$SharedUniqueDataTableTableUpdateCompanionBuilder,
        (
          SharedUniqueData,
          BaseReferences<_$AppDatabase, $SharedUniqueDataTableTable,
              SharedUniqueData>
        ),
        SharedUniqueData,
        PrefetchHooks Function()>;
typedef $$NotificationScheduleTableTableCreateCompanionBuilder
    = NotificationScheduleTableCompanion Function({
  Value<int> id,
  Value<bool> isActive,
  Value<String> label,
  Value<TimeOfDayAdapter> time,
});
typedef $$NotificationScheduleTableTableUpdateCompanionBuilder
    = NotificationScheduleTableCompanion Function({
  Value<int> id,
  Value<bool> isActive,
  Value<String> label,
  Value<TimeOfDayAdapter> time,
});

class $$NotificationScheduleTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationScheduleTableTable> {
  $$NotificationScheduleTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TimeOfDayAdapter, TimeOfDayAdapter, int>
      get time => $composableBuilder(
          column: $table.time,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$NotificationScheduleTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationScheduleTableTable> {
  $$NotificationScheduleTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));
}

class $$NotificationScheduleTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationScheduleTableTable> {
  $$NotificationScheduleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDayAdapter, int> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);
}

class $$NotificationScheduleTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationScheduleTableTable,
    NotificationSchedule,
    $$NotificationScheduleTableTableFilterComposer,
    $$NotificationScheduleTableTableOrderingComposer,
    $$NotificationScheduleTableTableAnnotationComposer,
    $$NotificationScheduleTableTableCreateCompanionBuilder,
    $$NotificationScheduleTableTableUpdateCompanionBuilder,
    (
      NotificationSchedule,
      BaseReferences<_$AppDatabase, $NotificationScheduleTableTable,
          NotificationSchedule>
    ),
    NotificationSchedule,
    PrefetchHooks Function()> {
  $$NotificationScheduleTableTableTableManager(
      _$AppDatabase db, $NotificationScheduleTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationScheduleTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationScheduleTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationScheduleTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<TimeOfDayAdapter> time = const Value.absent(),
          }) =>
              NotificationScheduleTableCompanion(
            id: id,
            isActive: isActive,
            label: label,
            time: time,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<TimeOfDayAdapter> time = const Value.absent(),
          }) =>
              NotificationScheduleTableCompanion.insert(
            id: id,
            isActive: isActive,
            label: label,
            time: time,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationScheduleTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $NotificationScheduleTableTable,
        NotificationSchedule,
        $$NotificationScheduleTableTableFilterComposer,
        $$NotificationScheduleTableTableOrderingComposer,
        $$NotificationScheduleTableTableAnnotationComposer,
        $$NotificationScheduleTableTableCreateCompanionBuilder,
        $$NotificationScheduleTableTableUpdateCompanionBuilder,
        (
          NotificationSchedule,
          BaseReferences<_$AppDatabase, $NotificationScheduleTableTable,
              NotificationSchedule>
        ),
        NotificationSchedule,
        PrefetchHooks Function()>;
typedef $$AppUsageTableTableCreateCompanionBuilder = AppUsageTableCompanion
    Function({
  required String packageName,
  Value<DateTime> date,
  Value<int> screenTime,
  Value<int> mobileData,
  Value<int> wifiData,
  Value<int> rowid,
});
typedef $$AppUsageTableTableUpdateCompanionBuilder = AppUsageTableCompanion
    Function({
  Value<String> packageName,
  Value<DateTime> date,
  Value<int> screenTime,
  Value<int> mobileData,
  Value<int> wifiData,
  Value<int> rowid,
});

class $$AppUsageTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsageTableTable> {
  $$AppUsageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get screenTime => $composableBuilder(
      column: $table.screenTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mobileData => $composableBuilder(
      column: $table.mobileData, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wifiData => $composableBuilder(
      column: $table.wifiData, builder: (column) => ColumnFilters(column));
}

class $$AppUsageTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsageTableTable> {
  $$AppUsageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get screenTime => $composableBuilder(
      column: $table.screenTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mobileData => $composableBuilder(
      column: $table.mobileData, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wifiData => $composableBuilder(
      column: $table.wifiData, builder: (column) => ColumnOrderings(column));
}

class $$AppUsageTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsageTableTable> {
  $$AppUsageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get screenTime => $composableBuilder(
      column: $table.screenTime, builder: (column) => column);

  GeneratedColumn<int> get mobileData => $composableBuilder(
      column: $table.mobileData, builder: (column) => column);

  GeneratedColumn<int> get wifiData =>
      $composableBuilder(column: $table.wifiData, builder: (column) => column);
}

class $$AppUsageTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppUsageTableTable,
    AppUsage,
    $$AppUsageTableTableFilterComposer,
    $$AppUsageTableTableOrderingComposer,
    $$AppUsageTableTableAnnotationComposer,
    $$AppUsageTableTableCreateCompanionBuilder,
    $$AppUsageTableTableUpdateCompanionBuilder,
    (AppUsage, BaseReferences<_$AppDatabase, $AppUsageTableTable, AppUsage>),
    AppUsage,
    PrefetchHooks Function()> {
  $$AppUsageTableTableTableManager(_$AppDatabase db, $AppUsageTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsageTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> packageName = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> screenTime = const Value.absent(),
            Value<int> mobileData = const Value.absent(),
            Value<int> wifiData = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUsageTableCompanion(
            packageName: packageName,
            date: date,
            screenTime: screenTime,
            mobileData: mobileData,
            wifiData: wifiData,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String packageName,
            Value<DateTime> date = const Value.absent(),
            Value<int> screenTime = const Value.absent(),
            Value<int> mobileData = const Value.absent(),
            Value<int> wifiData = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUsageTableCompanion.insert(
            packageName: packageName,
            date: date,
            screenTime: screenTime,
            mobileData: mobileData,
            wifiData: wifiData,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppUsageTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppUsageTableTable,
    AppUsage,
    $$AppUsageTableTableFilterComposer,
    $$AppUsageTableTableOrderingComposer,
    $$AppUsageTableTableAnnotationComposer,
    $$AppUsageTableTableCreateCompanionBuilder,
    $$AppUsageTableTableUpdateCompanionBuilder,
    (AppUsage, BaseReferences<_$AppDatabase, $AppUsageTableTable, AppUsage>),
    AppUsage,
    PrefetchHooks Function()>;
typedef $$NotificationSettingsTableTableCreateCompanionBuilder
    = NotificationSettingsTableCompanion Function({
  Value<int> id,
  Value<bool> storeNonBatchedToo,
  Value<List<String>> batchedApps,
});
typedef $$NotificationSettingsTableTableUpdateCompanionBuilder
    = NotificationSettingsTableCompanion Function({
  Value<int> id,
  Value<bool> storeNonBatchedToo,
  Value<List<String>> batchedApps,
});

class $$NotificationSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get storeNonBatchedToo => $composableBuilder(
      column: $table.storeNonBatchedToo,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get batchedApps => $composableBuilder(
          column: $table.batchedApps,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$NotificationSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get storeNonBatchedToo => $composableBuilder(
      column: $table.storeNonBatchedToo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get batchedApps => $composableBuilder(
      column: $table.batchedApps, builder: (column) => ColumnOrderings(column));
}

class $$NotificationSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get storeNonBatchedToo => $composableBuilder(
      column: $table.storeNonBatchedToo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get batchedApps =>
      $composableBuilder(
          column: $table.batchedApps, builder: (column) => column);
}

class $$NotificationSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationSettingsTableTable,
    NotificationSettings,
    $$NotificationSettingsTableTableFilterComposer,
    $$NotificationSettingsTableTableOrderingComposer,
    $$NotificationSettingsTableTableAnnotationComposer,
    $$NotificationSettingsTableTableCreateCompanionBuilder,
    $$NotificationSettingsTableTableUpdateCompanionBuilder,
    (
      NotificationSettings,
      BaseReferences<_$AppDatabase, $NotificationSettingsTableTable,
          NotificationSettings>
    ),
    NotificationSettings,
    PrefetchHooks Function()> {
  $$NotificationSettingsTableTableTableManager(
      _$AppDatabase db, $NotificationSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationSettingsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationSettingsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> storeNonBatchedToo = const Value.absent(),
            Value<List<String>> batchedApps = const Value.absent(),
          }) =>
              NotificationSettingsTableCompanion(
            id: id,
            storeNonBatchedToo: storeNonBatchedToo,
            batchedApps: batchedApps,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> storeNonBatchedToo = const Value.absent(),
            Value<List<String>> batchedApps = const Value.absent(),
          }) =>
              NotificationSettingsTableCompanion.insert(
            id: id,
            storeNonBatchedToo: storeNonBatchedToo,
            batchedApps: batchedApps,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationSettingsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $NotificationSettingsTableTable,
        NotificationSettings,
        $$NotificationSettingsTableTableFilterComposer,
        $$NotificationSettingsTableTableOrderingComposer,
        $$NotificationSettingsTableTableAnnotationComposer,
        $$NotificationSettingsTableTableCreateCompanionBuilder,
        $$NotificationSettingsTableTableUpdateCompanionBuilder,
        (
          NotificationSettings,
          BaseReferences<_$AppDatabase, $NotificationSettingsTableTable,
              NotificationSettings>
        ),
        NotificationSettings,
        PrefetchHooks Function()>;
typedef $$NotificationsTableTableCreateCompanionBuilder
    = NotificationsTableCompanion Function({
  Value<int> id,
  required String key,
  required String packageName,
  Value<DateTime> timeStamp,
  Value<String> title,
  Value<String> content,
  Value<String> category,
  Value<bool> isRead,
});
typedef $$NotificationsTableTableUpdateCompanionBuilder
    = NotificationsTableCompanion Function({
  Value<int> id,
  Value<String> key,
  Value<String> packageName,
  Value<DateTime> timeStamp,
  Value<String> title,
  Value<String> content,
  Value<String> category,
  Value<bool> isRead,
});

class $$NotificationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnFilters(column));
}

class $$NotificationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timeStamp => $composableBuilder(
      column: $table.timeStamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnOrderings(column));
}

class $$NotificationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => column);

  GeneratedColumn<DateTime> get timeStamp =>
      $composableBuilder(column: $table.timeStamp, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);
}

class $$NotificationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationsTableTable,
    Notification,
    $$NotificationsTableTableFilterComposer,
    $$NotificationsTableTableOrderingComposer,
    $$NotificationsTableTableAnnotationComposer,
    $$NotificationsTableTableCreateCompanionBuilder,
    $$NotificationsTableTableUpdateCompanionBuilder,
    (
      Notification,
      BaseReferences<_$AppDatabase, $NotificationsTableTable, Notification>
    ),
    Notification,
    PrefetchHooks Function()> {
  $$NotificationsTableTableTableManager(
      _$AppDatabase db, $NotificationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> packageName = const Value.absent(),
            Value<DateTime> timeStamp = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
          }) =>
              NotificationsTableCompanion(
            id: id,
            key: key,
            packageName: packageName,
            timeStamp: timeStamp,
            title: title,
            content: content,
            category: category,
            isRead: isRead,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String key,
            required String packageName,
            Value<DateTime> timeStamp = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
          }) =>
              NotificationsTableCompanion.insert(
            id: id,
            key: key,
            packageName: packageName,
            timeStamp: timeStamp,
            title: title,
            content: content,
            category: category,
            isRead: isRead,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationsTableTable,
    Notification,
    $$NotificationsTableTableFilterComposer,
    $$NotificationsTableTableOrderingComposer,
    $$NotificationsTableTableAnnotationComposer,
    $$NotificationsTableTableCreateCompanionBuilder,
    $$NotificationsTableTableUpdateCompanionBuilder,
    (
      Notification,
      BaseReferences<_$AppDatabase, $NotificationsTableTable, Notification>
    ),
    Notification,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppRestrictionTableTableTableManager get appRestrictionTable =>
      $$AppRestrictionTableTableTableManager(_db, _db.appRestrictionTable);
  $$BedtimeScheduleTableTableTableManager get bedtimeScheduleTable =>
      $$BedtimeScheduleTableTableTableManager(_db, _db.bedtimeScheduleTable);
  $$CrashLogsTableTableTableManager get crashLogsTable =>
      $$CrashLogsTableTableTableManager(_db, _db.crashLogsTable);
  $$FocusModeTableTableTableManager get focusModeTable =>
      $$FocusModeTableTableTableManager(_db, _db.focusModeTable);
  $$FocusProfileTableTableTableManager get focusProfileTable =>
      $$FocusProfileTableTableTableManager(_db, _db.focusProfileTable);
  $$FocusSessionsTableTableTableManager get focusSessionsTable =>
      $$FocusSessionsTableTableTableManager(_db, _db.focusSessionsTable);
  $$MindfulSettingsTableTableTableManager get mindfulSettingsTable =>
      $$MindfulSettingsTableTableTableManager(_db, _db.mindfulSettingsTable);
  $$ParentalControlsTableTableTableManager get parentalControlsTable =>
      $$ParentalControlsTableTableTableManager(_db, _db.parentalControlsTable);
  $$RestrictionGroupsTableTableTableManager get restrictionGroupsTable =>
      $$RestrictionGroupsTableTableTableManager(
          _db, _db.restrictionGroupsTable);
  $$WellbeingTableTableTableManager get wellbeingTable =>
      $$WellbeingTableTableTableManager(_db, _db.wellbeingTable);
  $$SharedUniqueDataTableTableTableManager get sharedUniqueDataTable =>
      $$SharedUniqueDataTableTableTableManager(_db, _db.sharedUniqueDataTable);
  $$NotificationScheduleTableTableTableManager get notificationScheduleTable =>
      $$NotificationScheduleTableTableTableManager(
          _db, _db.notificationScheduleTable);
  $$AppUsageTableTableTableManager get appUsageTable =>
      $$AppUsageTableTableTableManager(_db, _db.appUsageTable);
  $$NotificationSettingsTableTableTableManager get notificationSettingsTable =>
      $$NotificationSettingsTableTableTableManager(
          _db, _db.notificationSettingsTable);
  $$NotificationsTableTableTableManager get notificationsTable =>
      $$NotificationsTableTableTableManager(_db, _db.notificationsTable);
}
