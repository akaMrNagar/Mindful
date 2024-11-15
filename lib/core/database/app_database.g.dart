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
  static const VerificationMeta _launchLimitMeta =
      const VerificationMeta('launchLimit');
  @override
  late final GeneratedColumn<int> launchLimit = GeneratedColumn<int>(
      'launch_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _alertIntervalMeta =
      const VerificationMeta('alertInterval');
  @override
  late final GeneratedColumn<int> alertInterval = GeneratedColumn<int>(
      'alert_interval', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _alertByDialogMeta =
      const VerificationMeta('alertByDialog');
  @override
  late final GeneratedColumn<bool> alertByDialog = GeneratedColumn<bool>(
      'alert_by_dialog', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("alert_by_dialog" IN (0, 1))'));
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
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(null));
  @override
  List<GeneratedColumn> get $columns => [
        appPackage,
        timerSec,
        launchLimit,
        alertInterval,
        alertByDialog,
        canAccessInternet,
        associatedGroupId
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
    } else if (isInserting) {
      context.missing(_timerSecMeta);
    }
    if (data.containsKey('launch_limit')) {
      context.handle(
          _launchLimitMeta,
          launchLimit.isAcceptableOrUnknown(
              data['launch_limit']!, _launchLimitMeta));
    } else if (isInserting) {
      context.missing(_launchLimitMeta);
    }
    if (data.containsKey('alert_interval')) {
      context.handle(
          _alertIntervalMeta,
          alertInterval.isAcceptableOrUnknown(
              data['alert_interval']!, _alertIntervalMeta));
    } else if (isInserting) {
      context.missing(_alertIntervalMeta);
    }
    if (data.containsKey('alert_by_dialog')) {
      context.handle(
          _alertByDialogMeta,
          alertByDialog.isAcceptableOrUnknown(
              data['alert_by_dialog']!, _alertByDialogMeta));
    } else if (isInserting) {
      context.missing(_alertByDialogMeta);
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
      launchLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}launch_limit'])!,
      alertInterval: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}alert_interval'])!,
      alertByDialog: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}alert_by_dialog'])!,
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

  /// The number of times user can launch this app
  final int launchLimit;

  /// The interval between each usage alert in SECONDS
  final int alertInterval;

  ///  Whether to alert user by dialog if false user will be alerted by notification
  final bool alertByDialog;

  /// Flag denoting if this app can access internet or not
  final bool canAccessInternet;

  /// ID of the [RestrictionGroup] this app is associated with or NULL
  final int? associatedGroupId;
  const AppRestriction(
      {required this.appPackage,
      required this.timerSec,
      required this.launchLimit,
      required this.alertInterval,
      required this.alertByDialog,
      required this.canAccessInternet,
      this.associatedGroupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['app_package'] = Variable<String>(appPackage);
    map['timer_sec'] = Variable<int>(timerSec);
    map['launch_limit'] = Variable<int>(launchLimit);
    map['alert_interval'] = Variable<int>(alertInterval);
    map['alert_by_dialog'] = Variable<bool>(alertByDialog);
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
      launchLimit: Value(launchLimit),
      alertInterval: Value(alertInterval),
      alertByDialog: Value(alertByDialog),
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
      launchLimit: serializer.fromJson<int>(json['launchLimit']),
      alertInterval: serializer.fromJson<int>(json['alertInterval']),
      alertByDialog: serializer.fromJson<bool>(json['alertByDialog']),
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
      'launchLimit': serializer.toJson<int>(launchLimit),
      'alertInterval': serializer.toJson<int>(alertInterval),
      'alertByDialog': serializer.toJson<bool>(alertByDialog),
      'canAccessInternet': serializer.toJson<bool>(canAccessInternet),
      'associatedGroupId': serializer.toJson<int?>(associatedGroupId),
    };
  }

  AppRestriction copyWith(
          {String? appPackage,
          int? timerSec,
          int? launchLimit,
          int? alertInterval,
          bool? alertByDialog,
          bool? canAccessInternet,
          Value<int?> associatedGroupId = const Value.absent()}) =>
      AppRestriction(
        appPackage: appPackage ?? this.appPackage,
        timerSec: timerSec ?? this.timerSec,
        launchLimit: launchLimit ?? this.launchLimit,
        alertInterval: alertInterval ?? this.alertInterval,
        alertByDialog: alertByDialog ?? this.alertByDialog,
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
          ..write('launchLimit: $launchLimit, ')
          ..write('alertInterval: $alertInterval, ')
          ..write('alertByDialog: $alertByDialog, ')
          ..write('canAccessInternet: $canAccessInternet, ')
          ..write('associatedGroupId: $associatedGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(appPackage, timerSec, launchLimit,
      alertInterval, alertByDialog, canAccessInternet, associatedGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppRestriction &&
          other.appPackage == this.appPackage &&
          other.timerSec == this.timerSec &&
          other.launchLimit == this.launchLimit &&
          other.alertInterval == this.alertInterval &&
          other.alertByDialog == this.alertByDialog &&
          other.canAccessInternet == this.canAccessInternet &&
          other.associatedGroupId == this.associatedGroupId);
}

class AppRestrictionTableCompanion extends UpdateCompanion<AppRestriction> {
  final Value<String> appPackage;
  final Value<int> timerSec;
  final Value<int> launchLimit;
  final Value<int> alertInterval;
  final Value<bool> alertByDialog;
  final Value<bool> canAccessInternet;
  final Value<int?> associatedGroupId;
  final Value<int> rowid;
  const AppRestrictionTableCompanion({
    this.appPackage = const Value.absent(),
    this.timerSec = const Value.absent(),
    this.launchLimit = const Value.absent(),
    this.alertInterval = const Value.absent(),
    this.alertByDialog = const Value.absent(),
    this.canAccessInternet = const Value.absent(),
    this.associatedGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppRestrictionTableCompanion.insert({
    required String appPackage,
    required int timerSec,
    required int launchLimit,
    required int alertInterval,
    required bool alertByDialog,
    required bool canAccessInternet,
    this.associatedGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : appPackage = Value(appPackage),
        timerSec = Value(timerSec),
        launchLimit = Value(launchLimit),
        alertInterval = Value(alertInterval),
        alertByDialog = Value(alertByDialog),
        canAccessInternet = Value(canAccessInternet);
  static Insertable<AppRestriction> custom({
    Expression<String>? appPackage,
    Expression<int>? timerSec,
    Expression<int>? launchLimit,
    Expression<int>? alertInterval,
    Expression<bool>? alertByDialog,
    Expression<bool>? canAccessInternet,
    Expression<int>? associatedGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (appPackage != null) 'app_package': appPackage,
      if (timerSec != null) 'timer_sec': timerSec,
      if (launchLimit != null) 'launch_limit': launchLimit,
      if (alertInterval != null) 'alert_interval': alertInterval,
      if (alertByDialog != null) 'alert_by_dialog': alertByDialog,
      if (canAccessInternet != null) 'can_access_internet': canAccessInternet,
      if (associatedGroupId != null) 'associated_group_id': associatedGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppRestrictionTableCompanion copyWith(
      {Value<String>? appPackage,
      Value<int>? timerSec,
      Value<int>? launchLimit,
      Value<int>? alertInterval,
      Value<bool>? alertByDialog,
      Value<bool>? canAccessInternet,
      Value<int?>? associatedGroupId,
      Value<int>? rowid}) {
    return AppRestrictionTableCompanion(
      appPackage: appPackage ?? this.appPackage,
      timerSec: timerSec ?? this.timerSec,
      launchLimit: launchLimit ?? this.launchLimit,
      alertInterval: alertInterval ?? this.alertInterval,
      alertByDialog: alertByDialog ?? this.alertByDialog,
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
    if (launchLimit.present) {
      map['launch_limit'] = Variable<int>(launchLimit.value);
    }
    if (alertInterval.present) {
      map['alert_interval'] = Variable<int>(alertInterval.value);
    }
    if (alertByDialog.present) {
      map['alert_by_dialog'] = Variable<bool>(alertByDialog.value);
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
          ..write('launchLimit: $launchLimit, ')
          ..write('alertInterval: $alertInterval, ')
          ..write('alertByDialog: $alertByDialog, ')
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
  static const VerificationMeta _totalDurationInMinsMeta =
      const VerificationMeta('totalDurationInMins');
  @override
  late final GeneratedColumn<int> totalDurationInMins = GeneratedColumn<int>(
      'total_duration_in_mins', aliasedName, false,
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
        totalDurationInMins,
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
    if (data.containsKey('total_duration_in_mins')) {
      context.handle(
          _totalDurationInMinsMeta,
          totalDurationInMins.isAcceptableOrUnknown(
              data['total_duration_in_mins']!, _totalDurationInMinsMeta));
    } else if (isInserting) {
      context.missing(_totalDurationInMinsMeta);
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
      totalDurationInMins: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_duration_in_mins'])!,
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

  /// Total duration of bedtime schedule from start to end in MINUTES
  final int totalDurationInMins;

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
      required this.totalDurationInMins,
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
    map['total_duration_in_mins'] = Variable<int>(totalDurationInMins);
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
      totalDurationInMins: Value(totalDurationInMins),
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
      totalDurationInMins:
          serializer.fromJson<int>(json['totalDurationInMins']),
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
      'totalDurationInMins': serializer.toJson<int>(totalDurationInMins),
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
          int? totalDurationInMins,
          List<bool>? scheduleDays,
          bool? isScheduleOn,
          bool? shouldStartDnd,
          List<String>? distractingApps}) =>
      BedtimeSchedule(
        id: id ?? this.id,
        startTimeInMins: startTimeInMins ?? this.startTimeInMins,
        endTimeInMins: endTimeInMins ?? this.endTimeInMins,
        totalDurationInMins: totalDurationInMins ?? this.totalDurationInMins,
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
          ..write('totalDurationInMins: $totalDurationInMins, ')
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
      startTimeInMins,
      endTimeInMins,
      totalDurationInMins,
      scheduleDays,
      isScheduleOn,
      shouldStartDnd,
      distractingApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BedtimeSchedule &&
          other.id == this.id &&
          other.startTimeInMins == this.startTimeInMins &&
          other.endTimeInMins == this.endTimeInMins &&
          other.totalDurationInMins == this.totalDurationInMins &&
          other.scheduleDays == this.scheduleDays &&
          other.isScheduleOn == this.isScheduleOn &&
          other.shouldStartDnd == this.shouldStartDnd &&
          other.distractingApps == this.distractingApps);
}

class BedtimeScheduleTableCompanion extends UpdateCompanion<BedtimeSchedule> {
  final Value<int> id;
  final Value<int> startTimeInMins;
  final Value<int> endTimeInMins;
  final Value<int> totalDurationInMins;
  final Value<List<bool>> scheduleDays;
  final Value<bool> isScheduleOn;
  final Value<bool> shouldStartDnd;
  final Value<List<String>> distractingApps;
  const BedtimeScheduleTableCompanion({
    this.id = const Value.absent(),
    this.startTimeInMins = const Value.absent(),
    this.endTimeInMins = const Value.absent(),
    this.totalDurationInMins = const Value.absent(),
    this.scheduleDays = const Value.absent(),
    this.isScheduleOn = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  BedtimeScheduleTableCompanion.insert({
    this.id = const Value.absent(),
    required int startTimeInMins,
    required int endTimeInMins,
    required int totalDurationInMins,
    required List<bool> scheduleDays,
    required bool isScheduleOn,
    required bool shouldStartDnd,
    required List<String> distractingApps,
  })  : startTimeInMins = Value(startTimeInMins),
        endTimeInMins = Value(endTimeInMins),
        totalDurationInMins = Value(totalDurationInMins),
        scheduleDays = Value(scheduleDays),
        isScheduleOn = Value(isScheduleOn),
        shouldStartDnd = Value(shouldStartDnd),
        distractingApps = Value(distractingApps);
  static Insertable<BedtimeSchedule> custom({
    Expression<int>? id,
    Expression<int>? startTimeInMins,
    Expression<int>? endTimeInMins,
    Expression<int>? totalDurationInMins,
    Expression<String>? scheduleDays,
    Expression<bool>? isScheduleOn,
    Expression<bool>? shouldStartDnd,
    Expression<String>? distractingApps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTimeInMins != null) 'start_time_in_mins': startTimeInMins,
      if (endTimeInMins != null) 'end_time_in_mins': endTimeInMins,
      if (totalDurationInMins != null)
        'total_duration_in_mins': totalDurationInMins,
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
      Value<int>? totalDurationInMins,
      Value<List<bool>>? scheduleDays,
      Value<bool>? isScheduleOn,
      Value<bool>? shouldStartDnd,
      Value<List<String>>? distractingApps}) {
    return BedtimeScheduleTableCompanion(
      id: id ?? this.id,
      startTimeInMins: startTimeInMins ?? this.startTimeInMins,
      endTimeInMins: endTimeInMins ?? this.endTimeInMins,
      totalDurationInMins: totalDurationInMins ?? this.totalDurationInMins,
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
    if (totalDurationInMins.present) {
      map['total_duration_in_mins'] = Variable<int>(totalDurationInMins.value);
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
          ..write('totalDurationInMins: $totalDurationInMins, ')
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
    context.handle(_sessionTypeMeta, const VerificationResult.success());
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
    required SessionType sessionType,
    required int longestStreak,
    required int currentStreak,
    required DateTime lastTimeStreakUpdated,
  })  : sessionType = Value(sessionType),
        longestStreak = Value(longestStreak),
        currentStreak = Value(currentStreak),
        lastTimeStreakUpdated = Value(lastTimeStreakUpdated);
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
  static const VerificationMeta _sessionTypeMeta =
      const VerificationMeta('sessionType');
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
      type: DriftSqlType.int, requiredDuringInsert: true);
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
              $FocusProfileTableTable.$converterdistractingApps);
  @override
  List<GeneratedColumn> get $columns =>
      [sessionType, sessionDuration, shouldStartDnd, distractingApps];
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
    context.handle(_sessionTypeMeta, const VerificationResult.success());
    if (data.containsKey('session_duration')) {
      context.handle(
          _sessionDurationMeta,
          sessionDuration.isAcceptableOrUnknown(
              data['session_duration']!, _sessionDurationMeta));
    } else if (isInserting) {
      context.missing(_sessionDurationMeta);
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

  /// Flag indicating if to start DND during the focus session
  final bool shouldStartDnd;

  /// List of app's packages which are selected as distracting apps.
  final List<String> distractingApps;
  const FocusProfile(
      {required this.sessionType,
      required this.sessionDuration,
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
      'shouldStartDnd': serializer.toJson<bool>(shouldStartDnd),
      'distractingApps': serializer.toJson<List<String>>(distractingApps),
    };
  }

  FocusProfile copyWith(
          {SessionType? sessionType,
          int? sessionDuration,
          bool? shouldStartDnd,
          List<String>? distractingApps}) =>
      FocusProfile(
        sessionType: sessionType ?? this.sessionType,
        sessionDuration: sessionDuration ?? this.sessionDuration,
        shouldStartDnd: shouldStartDnd ?? this.shouldStartDnd,
        distractingApps: distractingApps ?? this.distractingApps,
      );
  @override
  String toString() {
    return (StringBuffer('FocusProfile(')
          ..write('sessionType: $sessionType, ')
          ..write('sessionDuration: $sessionDuration, ')
          ..write('shouldStartDnd: $shouldStartDnd, ')
          ..write('distractingApps: $distractingApps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      sessionType, sessionDuration, shouldStartDnd, distractingApps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusProfile &&
          other.sessionType == this.sessionType &&
          other.sessionDuration == this.sessionDuration &&
          other.shouldStartDnd == this.shouldStartDnd &&
          other.distractingApps == this.distractingApps);
}

class FocusProfileTableCompanion extends UpdateCompanion<FocusProfile> {
  final Value<SessionType> sessionType;
  final Value<int> sessionDuration;
  final Value<bool> shouldStartDnd;
  final Value<List<String>> distractingApps;
  const FocusProfileTableCompanion({
    this.sessionType = const Value.absent(),
    this.sessionDuration = const Value.absent(),
    this.shouldStartDnd = const Value.absent(),
    this.distractingApps = const Value.absent(),
  });
  FocusProfileTableCompanion.insert({
    this.sessionType = const Value.absent(),
    required int sessionDuration,
    required bool shouldStartDnd,
    required List<String> distractingApps,
  })  : sessionDuration = Value(sessionDuration),
        shouldStartDnd = Value(shouldStartDnd),
        distractingApps = Value(distractingApps);
  static Insertable<FocusProfile> custom({
    Expression<int>? sessionType,
    Expression<int>? sessionDuration,
    Expression<bool>? shouldStartDnd,
    Expression<String>? distractingApps,
  }) {
    return RawValuesInsertable({
      if (sessionType != null) 'session_type': sessionType,
      if (sessionDuration != null) 'session_duration': sessionDuration,
      if (shouldStartDnd != null) 'should_start_dnd': shouldStartDnd,
      if (distractingApps != null) 'distracting_apps': distractingApps,
    });
  }

  FocusProfileTableCompanion copyWith(
      {Value<SessionType>? sessionType,
      Value<int>? sessionDuration,
      Value<bool>? shouldStartDnd,
      Value<List<String>>? distractingApps}) {
    return FocusProfileTableCompanion(
      sessionType: sessionType ?? this.sessionType,
      sessionDuration: sessionDuration ?? this.sessionDuration,
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
  static const VerificationMeta _useDynamicColorsMeta =
      const VerificationMeta('useDynamicColors');
  @override
  late final GeneratedColumn<bool> useDynamicColors = GeneratedColumn<bool>(
      'use_dynamic_colors', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("use_dynamic_colors" IN (0, 1))'));
  static const VerificationMeta _defaultHomeTabMeta =
      const VerificationMeta('defaultHomeTab');
  @override
  late final GeneratedColumnWithTypeConverter<DefaultHomeTab, int>
      defaultHomeTab = GeneratedColumn<int>(
              'default_home_tab', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<DefaultHomeTab>(
              $MindfulSettingsTableTable.$converterdefaultHomeTab);
  static const VerificationMeta _excludedAppsMeta =
      const VerificationMeta('excludedApps');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      excludedApps = GeneratedColumn<String>(
              'excluded_apps', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $MindfulSettingsTableTable.$converterexcludedApps);
  static const VerificationMeta _leftEmergencyPassesMeta =
      const VerificationMeta('leftEmergencyPasses');
  @override
  late final GeneratedColumn<int> leftEmergencyPasses = GeneratedColumn<int>(
      'left_emergency_passes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastEmergencyUsedMeta =
      const VerificationMeta('lastEmergencyUsed');
  @override
  late final GeneratedColumn<DateTime> lastEmergencyUsed =
      GeneratedColumn<DateTime>('last_emergency_used', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isOnboardingDoneMeta =
      const VerificationMeta('isOnboardingDone');
  @override
  late final GeneratedColumn<bool> isOnboardingDone = GeneratedColumn<bool>(
      'is_onboarding_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_onboarding_done" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        themeMode,
        accentColor,
        username,
        localeCode,
        dataResetTimeMins,
        useBottomNavigation,
        useAmoledDark,
        useDynamicColors,
        defaultHomeTab,
        excludedApps,
        leftEmergencyPasses,
        lastEmergencyUsed,
        isOnboardingDone
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
    if (data.containsKey('use_dynamic_colors')) {
      context.handle(
          _useDynamicColorsMeta,
          useDynamicColors.isAcceptableOrUnknown(
              data['use_dynamic_colors']!, _useDynamicColorsMeta));
    } else if (isInserting) {
      context.missing(_useDynamicColorsMeta);
    }
    context.handle(_defaultHomeTabMeta, const VerificationResult.success());
    context.handle(_excludedAppsMeta, const VerificationResult.success());
    if (data.containsKey('left_emergency_passes')) {
      context.handle(
          _leftEmergencyPassesMeta,
          leftEmergencyPasses.isAcceptableOrUnknown(
              data['left_emergency_passes']!, _leftEmergencyPassesMeta));
    } else if (isInserting) {
      context.missing(_leftEmergencyPassesMeta);
    }
    if (data.containsKey('last_emergency_used')) {
      context.handle(
          _lastEmergencyUsedMeta,
          lastEmergencyUsed.isAcceptableOrUnknown(
              data['last_emergency_used']!, _lastEmergencyUsedMeta));
    } else if (isInserting) {
      context.missing(_lastEmergencyUsedMeta);
    }
    if (data.containsKey('is_onboarding_done')) {
      context.handle(
          _isOnboardingDoneMeta,
          isOnboardingDone.isAcceptableOrUnknown(
              data['is_onboarding_done']!, _isOnboardingDoneMeta));
    } else if (isInserting) {
      context.missing(_isOnboardingDoneMeta);
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
      dataResetTimeMins: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}data_reset_time_mins'])!,
      useBottomNavigation: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}use_bottom_navigation'])!,
      useAmoledDark: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}use_amoled_dark'])!,
      useDynamicColors: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}use_dynamic_colors'])!,
      defaultHomeTab: $MindfulSettingsTableTable.$converterdefaultHomeTab
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}default_home_tab'])!),
      excludedApps: $MindfulSettingsTableTable.$converterexcludedApps.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}excluded_apps'])!),
      leftEmergencyPasses: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}left_emergency_passes'])!,
      lastEmergencyUsed: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_emergency_used'])!,
      isOnboardingDone: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_onboarding_done'])!,
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
  static TypeConverter<List<String>, String> $converterexcludedApps =
      const ListStringConverter();
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

  /// Daily data usage renew or reset time [TimeOfDay] stored as minutes
  final int dataResetTimeMins;

  /// Flag indicating if to use bottom navigation or the default sidebar
  final bool useBottomNavigation;

  /// Flag indicating if to use pure amoled black color for dark theme
  final bool useAmoledDark;

  /// Flag indicating if to use wallpaper colors for themes
  final bool useDynamicColors;

  /// Default initial home tab
  final DefaultHomeTab defaultHomeTab;

  /// List of app's packages which are excluded from the aggregated usage statistics.
  final List<String> excludedApps;

  /// Number of emergency break passes left for today
  final int leftEmergencyPasses;

  /// Timestamp of the last used emergency break
  final DateTime lastEmergencyUsed;

  /// Flag indicating if onboarding is completed or not
  final bool isOnboardingDone;
  const MindfulSettings(
      {required this.id,
      required this.themeMode,
      required this.accentColor,
      required this.username,
      required this.localeCode,
      required this.dataResetTimeMins,
      required this.useBottomNavigation,
      required this.useAmoledDark,
      required this.useDynamicColors,
      required this.defaultHomeTab,
      required this.excludedApps,
      required this.leftEmergencyPasses,
      required this.lastEmergencyUsed,
      required this.isOnboardingDone});
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
    map['data_reset_time_mins'] = Variable<int>(dataResetTimeMins);
    map['use_bottom_navigation'] = Variable<bool>(useBottomNavigation);
    map['use_amoled_dark'] = Variable<bool>(useAmoledDark);
    map['use_dynamic_colors'] = Variable<bool>(useDynamicColors);
    {
      map['default_home_tab'] = Variable<int>($MindfulSettingsTableTable
          .$converterdefaultHomeTab
          .toSql(defaultHomeTab));
    }
    {
      map['excluded_apps'] = Variable<String>($MindfulSettingsTableTable
          .$converterexcludedApps
          .toSql(excludedApps));
    }
    map['left_emergency_passes'] = Variable<int>(leftEmergencyPasses);
    map['last_emergency_used'] = Variable<DateTime>(lastEmergencyUsed);
    map['is_onboarding_done'] = Variable<bool>(isOnboardingDone);
    return map;
  }

  MindfulSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return MindfulSettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      accentColor: Value(accentColor),
      username: Value(username),
      localeCode: Value(localeCode),
      dataResetTimeMins: Value(dataResetTimeMins),
      useBottomNavigation: Value(useBottomNavigation),
      useAmoledDark: Value(useAmoledDark),
      useDynamicColors: Value(useDynamicColors),
      defaultHomeTab: Value(defaultHomeTab),
      excludedApps: Value(excludedApps),
      leftEmergencyPasses: Value(leftEmergencyPasses),
      lastEmergencyUsed: Value(lastEmergencyUsed),
      isOnboardingDone: Value(isOnboardingDone),
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
      dataResetTimeMins: serializer.fromJson<int>(json['dataResetTimeMins']),
      useBottomNavigation:
          serializer.fromJson<bool>(json['useBottomNavigation']),
      useAmoledDark: serializer.fromJson<bool>(json['useAmoledDark']),
      useDynamicColors: serializer.fromJson<bool>(json['useDynamicColors']),
      defaultHomeTab: $MindfulSettingsTableTable.$converterdefaultHomeTab
          .fromJson(serializer.fromJson<int>(json['defaultHomeTab'])),
      excludedApps: serializer.fromJson<List<String>>(json['excludedApps']),
      leftEmergencyPasses:
          serializer.fromJson<int>(json['leftEmergencyPasses']),
      lastEmergencyUsed:
          serializer.fromJson<DateTime>(json['lastEmergencyUsed']),
      isOnboardingDone: serializer.fromJson<bool>(json['isOnboardingDone']),
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
      'dataResetTimeMins': serializer.toJson<int>(dataResetTimeMins),
      'useBottomNavigation': serializer.toJson<bool>(useBottomNavigation),
      'useAmoledDark': serializer.toJson<bool>(useAmoledDark),
      'useDynamicColors': serializer.toJson<bool>(useDynamicColors),
      'defaultHomeTab': serializer.toJson<int>($MindfulSettingsTableTable
          .$converterdefaultHomeTab
          .toJson(defaultHomeTab)),
      'excludedApps': serializer.toJson<List<String>>(excludedApps),
      'leftEmergencyPasses': serializer.toJson<int>(leftEmergencyPasses),
      'lastEmergencyUsed': serializer.toJson<DateTime>(lastEmergencyUsed),
      'isOnboardingDone': serializer.toJson<bool>(isOnboardingDone),
    };
  }

  MindfulSettings copyWith(
          {int? id,
          AppThemeMode? themeMode,
          String? accentColor,
          String? username,
          String? localeCode,
          int? dataResetTimeMins,
          bool? useBottomNavigation,
          bool? useAmoledDark,
          bool? useDynamicColors,
          DefaultHomeTab? defaultHomeTab,
          List<String>? excludedApps,
          int? leftEmergencyPasses,
          DateTime? lastEmergencyUsed,
          bool? isOnboardingDone}) =>
      MindfulSettings(
        id: id ?? this.id,
        themeMode: themeMode ?? this.themeMode,
        accentColor: accentColor ?? this.accentColor,
        username: username ?? this.username,
        localeCode: localeCode ?? this.localeCode,
        dataResetTimeMins: dataResetTimeMins ?? this.dataResetTimeMins,
        useBottomNavigation: useBottomNavigation ?? this.useBottomNavigation,
        useAmoledDark: useAmoledDark ?? this.useAmoledDark,
        useDynamicColors: useDynamicColors ?? this.useDynamicColors,
        defaultHomeTab: defaultHomeTab ?? this.defaultHomeTab,
        excludedApps: excludedApps ?? this.excludedApps,
        leftEmergencyPasses: leftEmergencyPasses ?? this.leftEmergencyPasses,
        lastEmergencyUsed: lastEmergencyUsed ?? this.lastEmergencyUsed,
        isOnboardingDone: isOnboardingDone ?? this.isOnboardingDone,
      );
  @override
  String toString() {
    return (StringBuffer('MindfulSettings(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentColor: $accentColor, ')
          ..write('username: $username, ')
          ..write('localeCode: $localeCode, ')
          ..write('dataResetTimeMins: $dataResetTimeMins, ')
          ..write('useBottomNavigation: $useBottomNavigation, ')
          ..write('useAmoledDark: $useAmoledDark, ')
          ..write('useDynamicColors: $useDynamicColors, ')
          ..write('defaultHomeTab: $defaultHomeTab, ')
          ..write('excludedApps: $excludedApps, ')
          ..write('leftEmergencyPasses: $leftEmergencyPasses, ')
          ..write('lastEmergencyUsed: $lastEmergencyUsed, ')
          ..write('isOnboardingDone: $isOnboardingDone')
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
      dataResetTimeMins,
      useBottomNavigation,
      useAmoledDark,
      useDynamicColors,
      defaultHomeTab,
      excludedApps,
      leftEmergencyPasses,
      lastEmergencyUsed,
      isOnboardingDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MindfulSettings &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.accentColor == this.accentColor &&
          other.username == this.username &&
          other.localeCode == this.localeCode &&
          other.dataResetTimeMins == this.dataResetTimeMins &&
          other.useBottomNavigation == this.useBottomNavigation &&
          other.useAmoledDark == this.useAmoledDark &&
          other.useDynamicColors == this.useDynamicColors &&
          other.defaultHomeTab == this.defaultHomeTab &&
          other.excludedApps == this.excludedApps &&
          other.leftEmergencyPasses == this.leftEmergencyPasses &&
          other.lastEmergencyUsed == this.lastEmergencyUsed &&
          other.isOnboardingDone == this.isOnboardingDone);
}

class MindfulSettingsTableCompanion extends UpdateCompanion<MindfulSettings> {
  final Value<int> id;
  final Value<AppThemeMode> themeMode;
  final Value<String> accentColor;
  final Value<String> username;
  final Value<String> localeCode;
  final Value<int> dataResetTimeMins;
  final Value<bool> useBottomNavigation;
  final Value<bool> useAmoledDark;
  final Value<bool> useDynamicColors;
  final Value<DefaultHomeTab> defaultHomeTab;
  final Value<List<String>> excludedApps;
  final Value<int> leftEmergencyPasses;
  final Value<DateTime> lastEmergencyUsed;
  final Value<bool> isOnboardingDone;
  const MindfulSettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.username = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.dataResetTimeMins = const Value.absent(),
    this.useBottomNavigation = const Value.absent(),
    this.useAmoledDark = const Value.absent(),
    this.useDynamicColors = const Value.absent(),
    this.defaultHomeTab = const Value.absent(),
    this.excludedApps = const Value.absent(),
    this.leftEmergencyPasses = const Value.absent(),
    this.lastEmergencyUsed = const Value.absent(),
    this.isOnboardingDone = const Value.absent(),
  });
  MindfulSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required AppThemeMode themeMode,
    required String accentColor,
    required String username,
    required String localeCode,
    required int dataResetTimeMins,
    required bool useBottomNavigation,
    required bool useAmoledDark,
    required bool useDynamicColors,
    required DefaultHomeTab defaultHomeTab,
    required List<String> excludedApps,
    required int leftEmergencyPasses,
    required DateTime lastEmergencyUsed,
    required bool isOnboardingDone,
  })  : themeMode = Value(themeMode),
        accentColor = Value(accentColor),
        username = Value(username),
        localeCode = Value(localeCode),
        dataResetTimeMins = Value(dataResetTimeMins),
        useBottomNavigation = Value(useBottomNavigation),
        useAmoledDark = Value(useAmoledDark),
        useDynamicColors = Value(useDynamicColors),
        defaultHomeTab = Value(defaultHomeTab),
        excludedApps = Value(excludedApps),
        leftEmergencyPasses = Value(leftEmergencyPasses),
        lastEmergencyUsed = Value(lastEmergencyUsed),
        isOnboardingDone = Value(isOnboardingDone);
  static Insertable<MindfulSettings> custom({
    Expression<int>? id,
    Expression<int>? themeMode,
    Expression<String>? accentColor,
    Expression<String>? username,
    Expression<String>? localeCode,
    Expression<int>? dataResetTimeMins,
    Expression<bool>? useBottomNavigation,
    Expression<bool>? useAmoledDark,
    Expression<bool>? useDynamicColors,
    Expression<int>? defaultHomeTab,
    Expression<String>? excludedApps,
    Expression<int>? leftEmergencyPasses,
    Expression<DateTime>? lastEmergencyUsed,
    Expression<bool>? isOnboardingDone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (accentColor != null) 'accent_color': accentColor,
      if (username != null) 'username': username,
      if (localeCode != null) 'locale_code': localeCode,
      if (dataResetTimeMins != null) 'data_reset_time_mins': dataResetTimeMins,
      if (useBottomNavigation != null)
        'use_bottom_navigation': useBottomNavigation,
      if (useAmoledDark != null) 'use_amoled_dark': useAmoledDark,
      if (useDynamicColors != null) 'use_dynamic_colors': useDynamicColors,
      if (defaultHomeTab != null) 'default_home_tab': defaultHomeTab,
      if (excludedApps != null) 'excluded_apps': excludedApps,
      if (leftEmergencyPasses != null)
        'left_emergency_passes': leftEmergencyPasses,
      if (lastEmergencyUsed != null) 'last_emergency_used': lastEmergencyUsed,
      if (isOnboardingDone != null) 'is_onboarding_done': isOnboardingDone,
    });
  }

  MindfulSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<AppThemeMode>? themeMode,
      Value<String>? accentColor,
      Value<String>? username,
      Value<String>? localeCode,
      Value<int>? dataResetTimeMins,
      Value<bool>? useBottomNavigation,
      Value<bool>? useAmoledDark,
      Value<bool>? useDynamicColors,
      Value<DefaultHomeTab>? defaultHomeTab,
      Value<List<String>>? excludedApps,
      Value<int>? leftEmergencyPasses,
      Value<DateTime>? lastEmergencyUsed,
      Value<bool>? isOnboardingDone}) {
    return MindfulSettingsTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      username: username ?? this.username,
      localeCode: localeCode ?? this.localeCode,
      dataResetTimeMins: dataResetTimeMins ?? this.dataResetTimeMins,
      useBottomNavigation: useBottomNavigation ?? this.useBottomNavigation,
      useAmoledDark: useAmoledDark ?? this.useAmoledDark,
      useDynamicColors: useDynamicColors ?? this.useDynamicColors,
      defaultHomeTab: defaultHomeTab ?? this.defaultHomeTab,
      excludedApps: excludedApps ?? this.excludedApps,
      leftEmergencyPasses: leftEmergencyPasses ?? this.leftEmergencyPasses,
      lastEmergencyUsed: lastEmergencyUsed ?? this.lastEmergencyUsed,
      isOnboardingDone: isOnboardingDone ?? this.isOnboardingDone,
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
    if (dataResetTimeMins.present) {
      map['data_reset_time_mins'] = Variable<int>(dataResetTimeMins.value);
    }
    if (useBottomNavigation.present) {
      map['use_bottom_navigation'] = Variable<bool>(useBottomNavigation.value);
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
    if (excludedApps.present) {
      map['excluded_apps'] = Variable<String>($MindfulSettingsTableTable
          .$converterexcludedApps
          .toSql(excludedApps.value));
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
          ..write('dataResetTimeMins: $dataResetTimeMins, ')
          ..write('useBottomNavigation: $useBottomNavigation, ')
          ..write('useAmoledDark: $useAmoledDark, ')
          ..write('useDynamicColors: $useDynamicColors, ')
          ..write('defaultHomeTab: $defaultHomeTab, ')
          ..write('excludedApps: $excludedApps, ')
          ..write('leftEmergencyPasses: $leftEmergencyPasses, ')
          ..write('lastEmergencyUsed: $lastEmergencyUsed, ')
          ..write('isOnboardingDone: $isOnboardingDone')
          ..write(')'))
        .toString();
  }
}

class $InvincibleModeTableTable extends InvincibleModeTable
    with TableInfo<$InvincibleModeTableTable, InvincibleMode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvincibleModeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isInvincibleModeOnMeta =
      const VerificationMeta('isInvincibleModeOn');
  @override
  late final GeneratedColumn<bool> isInvincibleModeOn = GeneratedColumn<bool>(
      'is_invincible_mode_on', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_invincible_mode_on" IN (0, 1))'));
  static const VerificationMeta _includeAppsTimerMeta =
      const VerificationMeta('includeAppsTimer');
  @override
  late final GeneratedColumn<bool> includeAppsTimer = GeneratedColumn<bool>(
      'include_apps_timer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("include_apps_timer" IN (0, 1))'));
  static const VerificationMeta _includeAppsLaunchLimitMeta =
      const VerificationMeta('includeAppsLaunchLimit');
  @override
  late final GeneratedColumn<bool> includeAppsLaunchLimit =
      GeneratedColumn<bool>('include_apps_launch_limit', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("include_apps_launch_limit" IN (0, 1))'));
  static const VerificationMeta _includeGroupsTimerMeta =
      const VerificationMeta('includeGroupsTimer');
  @override
  late final GeneratedColumn<bool> includeGroupsTimer = GeneratedColumn<bool>(
      'include_groups_timer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("include_groups_timer" IN (0, 1))'));
  static const VerificationMeta _includeShortsTimerMeta =
      const VerificationMeta('includeShortsTimer');
  @override
  late final GeneratedColumn<bool> includeShortsTimer = GeneratedColumn<bool>(
      'include_shorts_timer', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("include_shorts_timer" IN (0, 1))'));
  static const VerificationMeta _includeBedtimeScheduleMeta =
      const VerificationMeta('includeBedtimeSchedule');
  @override
  late final GeneratedColumn<bool> includeBedtimeSchedule =
      GeneratedColumn<bool>('include_bedtime_schedule', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("include_bedtime_schedule" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        isInvincibleModeOn,
        includeAppsTimer,
        includeAppsLaunchLimit,
        includeGroupsTimer,
        includeShortsTimer,
        includeBedtimeSchedule
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invincible_mode_table';
  @override
  VerificationContext validateIntegrity(Insertable<InvincibleMode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_invincible_mode_on')) {
      context.handle(
          _isInvincibleModeOnMeta,
          isInvincibleModeOn.isAcceptableOrUnknown(
              data['is_invincible_mode_on']!, _isInvincibleModeOnMeta));
    } else if (isInserting) {
      context.missing(_isInvincibleModeOnMeta);
    }
    if (data.containsKey('include_apps_timer')) {
      context.handle(
          _includeAppsTimerMeta,
          includeAppsTimer.isAcceptableOrUnknown(
              data['include_apps_timer']!, _includeAppsTimerMeta));
    } else if (isInserting) {
      context.missing(_includeAppsTimerMeta);
    }
    if (data.containsKey('include_apps_launch_limit')) {
      context.handle(
          _includeAppsLaunchLimitMeta,
          includeAppsLaunchLimit.isAcceptableOrUnknown(
              data['include_apps_launch_limit']!, _includeAppsLaunchLimitMeta));
    } else if (isInserting) {
      context.missing(_includeAppsLaunchLimitMeta);
    }
    if (data.containsKey('include_groups_timer')) {
      context.handle(
          _includeGroupsTimerMeta,
          includeGroupsTimer.isAcceptableOrUnknown(
              data['include_groups_timer']!, _includeGroupsTimerMeta));
    } else if (isInserting) {
      context.missing(_includeGroupsTimerMeta);
    }
    if (data.containsKey('include_shorts_timer')) {
      context.handle(
          _includeShortsTimerMeta,
          includeShortsTimer.isAcceptableOrUnknown(
              data['include_shorts_timer']!, _includeShortsTimerMeta));
    } else if (isInserting) {
      context.missing(_includeShortsTimerMeta);
    }
    if (data.containsKey('include_bedtime_schedule')) {
      context.handle(
          _includeBedtimeScheduleMeta,
          includeBedtimeSchedule.isAcceptableOrUnknown(
              data['include_bedtime_schedule']!, _includeBedtimeScheduleMeta));
    } else if (isInserting) {
      context.missing(_includeBedtimeScheduleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvincibleMode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvincibleMode(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isInvincibleModeOn: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_invincible_mode_on'])!,
      includeAppsTimer: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}include_apps_timer'])!,
      includeAppsLaunchLimit: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}include_apps_launch_limit'])!,
      includeGroupsTimer: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}include_groups_timer'])!,
      includeShortsTimer: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}include_shorts_timer'])!,
      includeBedtimeSchedule: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}include_bedtime_schedule'])!,
    );
  }

  @override
  $InvincibleModeTableTable createAlias(String alias) {
    return $InvincibleModeTableTable(attachedDatabase, alias);
  }
}

class InvincibleMode extends DataClass implements Insertable<InvincibleMode> {
  /// Unique ID for Invincible Mode settings
  final int id;

  /// Flag indicating if invincible mode is ON
  final bool isInvincibleModeOn;

  /// Flag indicating if apps timer are included in the invincible mode
  ///
  /// If included user cannot modify app timer if it is already ran out
  final bool includeAppsTimer;

  /// Flag indicating if apps launch count limit is included in the invincible mode
  ///
  /// If included user cannot modify app launch count limit if it is already ran out
  final bool includeAppsLaunchLimit;

  /// Flag indicating if groups timer are included in the invincible mode
  ///
  /// If included user cannot modify group timer if it is already ran out
  final bool includeGroupsTimer;

  /// Flag indicating if short content's timer is included in the invincible mode
  ///
  /// If included user cannot modify short content timer if it is already ran out
  final bool includeShortsTimer;

  /// Flag indicating if bedtime schedule is included in the invincible mode
  ///
  /// If included user cannot modify bedtime schedule during the active period
  final bool includeBedtimeSchedule;
  const InvincibleMode(
      {required this.id,
      required this.isInvincibleModeOn,
      required this.includeAppsTimer,
      required this.includeAppsLaunchLimit,
      required this.includeGroupsTimer,
      required this.includeShortsTimer,
      required this.includeBedtimeSchedule});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_invincible_mode_on'] = Variable<bool>(isInvincibleModeOn);
    map['include_apps_timer'] = Variable<bool>(includeAppsTimer);
    map['include_apps_launch_limit'] = Variable<bool>(includeAppsLaunchLimit);
    map['include_groups_timer'] = Variable<bool>(includeGroupsTimer);
    map['include_shorts_timer'] = Variable<bool>(includeShortsTimer);
    map['include_bedtime_schedule'] = Variable<bool>(includeBedtimeSchedule);
    return map;
  }

  InvincibleModeTableCompanion toCompanion(bool nullToAbsent) {
    return InvincibleModeTableCompanion(
      id: Value(id),
      isInvincibleModeOn: Value(isInvincibleModeOn),
      includeAppsTimer: Value(includeAppsTimer),
      includeAppsLaunchLimit: Value(includeAppsLaunchLimit),
      includeGroupsTimer: Value(includeGroupsTimer),
      includeShortsTimer: Value(includeShortsTimer),
      includeBedtimeSchedule: Value(includeBedtimeSchedule),
    );
  }

  factory InvincibleMode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvincibleMode(
      id: serializer.fromJson<int>(json['id']),
      isInvincibleModeOn: serializer.fromJson<bool>(json['isInvincibleModeOn']),
      includeAppsTimer: serializer.fromJson<bool>(json['includeAppsTimer']),
      includeAppsLaunchLimit:
          serializer.fromJson<bool>(json['includeAppsLaunchLimit']),
      includeGroupsTimer: serializer.fromJson<bool>(json['includeGroupsTimer']),
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
      'isInvincibleModeOn': serializer.toJson<bool>(isInvincibleModeOn),
      'includeAppsTimer': serializer.toJson<bool>(includeAppsTimer),
      'includeAppsLaunchLimit': serializer.toJson<bool>(includeAppsLaunchLimit),
      'includeGroupsTimer': serializer.toJson<bool>(includeGroupsTimer),
      'includeShortsTimer': serializer.toJson<bool>(includeShortsTimer),
      'includeBedtimeSchedule': serializer.toJson<bool>(includeBedtimeSchedule),
    };
  }

  InvincibleMode copyWith(
          {int? id,
          bool? isInvincibleModeOn,
          bool? includeAppsTimer,
          bool? includeAppsLaunchLimit,
          bool? includeGroupsTimer,
          bool? includeShortsTimer,
          bool? includeBedtimeSchedule}) =>
      InvincibleMode(
        id: id ?? this.id,
        isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
        includeAppsTimer: includeAppsTimer ?? this.includeAppsTimer,
        includeAppsLaunchLimit:
            includeAppsLaunchLimit ?? this.includeAppsLaunchLimit,
        includeGroupsTimer: includeGroupsTimer ?? this.includeGroupsTimer,
        includeShortsTimer: includeShortsTimer ?? this.includeShortsTimer,
        includeBedtimeSchedule:
            includeBedtimeSchedule ?? this.includeBedtimeSchedule,
      );
  @override
  String toString() {
    return (StringBuffer('InvincibleMode(')
          ..write('id: $id, ')
          ..write('isInvincibleModeOn: $isInvincibleModeOn, ')
          ..write('includeAppsTimer: $includeAppsTimer, ')
          ..write('includeAppsLaunchLimit: $includeAppsLaunchLimit, ')
          ..write('includeGroupsTimer: $includeGroupsTimer, ')
          ..write('includeShortsTimer: $includeShortsTimer, ')
          ..write('includeBedtimeSchedule: $includeBedtimeSchedule')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      isInvincibleModeOn,
      includeAppsTimer,
      includeAppsLaunchLimit,
      includeGroupsTimer,
      includeShortsTimer,
      includeBedtimeSchedule);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvincibleMode &&
          other.id == this.id &&
          other.isInvincibleModeOn == this.isInvincibleModeOn &&
          other.includeAppsTimer == this.includeAppsTimer &&
          other.includeAppsLaunchLimit == this.includeAppsLaunchLimit &&
          other.includeGroupsTimer == this.includeGroupsTimer &&
          other.includeShortsTimer == this.includeShortsTimer &&
          other.includeBedtimeSchedule == this.includeBedtimeSchedule);
}

class InvincibleModeTableCompanion extends UpdateCompanion<InvincibleMode> {
  final Value<int> id;
  final Value<bool> isInvincibleModeOn;
  final Value<bool> includeAppsTimer;
  final Value<bool> includeAppsLaunchLimit;
  final Value<bool> includeGroupsTimer;
  final Value<bool> includeShortsTimer;
  final Value<bool> includeBedtimeSchedule;
  const InvincibleModeTableCompanion({
    this.id = const Value.absent(),
    this.isInvincibleModeOn = const Value.absent(),
    this.includeAppsTimer = const Value.absent(),
    this.includeAppsLaunchLimit = const Value.absent(),
    this.includeGroupsTimer = const Value.absent(),
    this.includeShortsTimer = const Value.absent(),
    this.includeBedtimeSchedule = const Value.absent(),
  });
  InvincibleModeTableCompanion.insert({
    this.id = const Value.absent(),
    required bool isInvincibleModeOn,
    required bool includeAppsTimer,
    required bool includeAppsLaunchLimit,
    required bool includeGroupsTimer,
    required bool includeShortsTimer,
    required bool includeBedtimeSchedule,
  })  : isInvincibleModeOn = Value(isInvincibleModeOn),
        includeAppsTimer = Value(includeAppsTimer),
        includeAppsLaunchLimit = Value(includeAppsLaunchLimit),
        includeGroupsTimer = Value(includeGroupsTimer),
        includeShortsTimer = Value(includeShortsTimer),
        includeBedtimeSchedule = Value(includeBedtimeSchedule);
  static Insertable<InvincibleMode> custom({
    Expression<int>? id,
    Expression<bool>? isInvincibleModeOn,
    Expression<bool>? includeAppsTimer,
    Expression<bool>? includeAppsLaunchLimit,
    Expression<bool>? includeGroupsTimer,
    Expression<bool>? includeShortsTimer,
    Expression<bool>? includeBedtimeSchedule,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isInvincibleModeOn != null)
        'is_invincible_mode_on': isInvincibleModeOn,
      if (includeAppsTimer != null) 'include_apps_timer': includeAppsTimer,
      if (includeAppsLaunchLimit != null)
        'include_apps_launch_limit': includeAppsLaunchLimit,
      if (includeGroupsTimer != null)
        'include_groups_timer': includeGroupsTimer,
      if (includeShortsTimer != null)
        'include_shorts_timer': includeShortsTimer,
      if (includeBedtimeSchedule != null)
        'include_bedtime_schedule': includeBedtimeSchedule,
    });
  }

  InvincibleModeTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isInvincibleModeOn,
      Value<bool>? includeAppsTimer,
      Value<bool>? includeAppsLaunchLimit,
      Value<bool>? includeGroupsTimer,
      Value<bool>? includeShortsTimer,
      Value<bool>? includeBedtimeSchedule}) {
    return InvincibleModeTableCompanion(
      id: id ?? this.id,
      isInvincibleModeOn: isInvincibleModeOn ?? this.isInvincibleModeOn,
      includeAppsTimer: includeAppsTimer ?? this.includeAppsTimer,
      includeAppsLaunchLimit:
          includeAppsLaunchLimit ?? this.includeAppsLaunchLimit,
      includeGroupsTimer: includeGroupsTimer ?? this.includeGroupsTimer,
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
    if (isInvincibleModeOn.present) {
      map['is_invincible_mode_on'] = Variable<bool>(isInvincibleModeOn.value);
    }
    if (includeAppsTimer.present) {
      map['include_apps_timer'] = Variable<bool>(includeAppsTimer.value);
    }
    if (includeAppsLaunchLimit.present) {
      map['include_apps_launch_limit'] =
          Variable<bool>(includeAppsLaunchLimit.value);
    }
    if (includeGroupsTimer.present) {
      map['include_groups_timer'] = Variable<bool>(includeGroupsTimer.value);
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
    return (StringBuffer('InvincibleModeTableCompanion(')
          ..write('id: $id, ')
          ..write('isInvincibleModeOn: $isInvincibleModeOn, ')
          ..write('includeAppsTimer: $includeAppsTimer, ')
          ..write('includeAppsLaunchLimit: $includeAppsLaunchLimit, ')
          ..write('includeGroupsTimer: $includeGroupsTimer, ')
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
  static const VerificationMeta _blockedWebsitesMeta =
      const VerificationMeta('blockedWebsites');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      blockedWebsites = GeneratedColumn<String>(
              'blocked_websites', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $WellbeingTableTable.$converterblockedWebsites);
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
        blockedWebsites
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
    context.handle(_blockedWebsitesMeta, const VerificationResult.success());
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
      blockedWebsites: $WellbeingTableTable.$converterblockedWebsites.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}blocked_websites'])!),
    );
  }

  @override
  $WellbeingTableTable createAlias(String alias) {
    return $WellbeingTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterblockedWebsites =
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
  final List<String> blockedWebsites;
  const Wellbeing(
      {required this.id,
      required this.allowedShortsTimeSec,
      required this.blockInstaReels,
      required this.blockYtShorts,
      required this.blockSnapSpotlight,
      required this.blockFbReels,
      required this.blockRedditShorts,
      required this.blockNsfwSites,
      required this.blockedWebsites});
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
      map['blocked_websites'] = Variable<String>($WellbeingTableTable
          .$converterblockedWebsites
          .toSql(blockedWebsites));
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
      blockedWebsites: Value(blockedWebsites),
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
      blockedWebsites:
          serializer.fromJson<List<String>>(json['blockedWebsites']),
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
      'blockedWebsites': serializer.toJson<List<String>>(blockedWebsites),
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
          List<String>? blockedWebsites}) =>
      Wellbeing(
        id: id ?? this.id,
        allowedShortsTimeSec: allowedShortsTimeSec ?? this.allowedShortsTimeSec,
        blockInstaReels: blockInstaReels ?? this.blockInstaReels,
        blockYtShorts: blockYtShorts ?? this.blockYtShorts,
        blockSnapSpotlight: blockSnapSpotlight ?? this.blockSnapSpotlight,
        blockFbReels: blockFbReels ?? this.blockFbReels,
        blockRedditShorts: blockRedditShorts ?? this.blockRedditShorts,
        blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
        blockedWebsites: blockedWebsites ?? this.blockedWebsites,
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
          ..write('blockedWebsites: $blockedWebsites')
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
      blockedWebsites);
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
          other.blockedWebsites == this.blockedWebsites);
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
  final Value<List<String>> blockedWebsites;
  const WellbeingTableCompanion({
    this.id = const Value.absent(),
    this.allowedShortsTimeSec = const Value.absent(),
    this.blockInstaReels = const Value.absent(),
    this.blockYtShorts = const Value.absent(),
    this.blockSnapSpotlight = const Value.absent(),
    this.blockFbReels = const Value.absent(),
    this.blockRedditShorts = const Value.absent(),
    this.blockNsfwSites = const Value.absent(),
    this.blockedWebsites = const Value.absent(),
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
    required List<String> blockedWebsites,
  })  : allowedShortsTimeSec = Value(allowedShortsTimeSec),
        blockInstaReels = Value(blockInstaReels),
        blockYtShorts = Value(blockYtShorts),
        blockSnapSpotlight = Value(blockSnapSpotlight),
        blockFbReels = Value(blockFbReels),
        blockRedditShorts = Value(blockRedditShorts),
        blockNsfwSites = Value(blockNsfwSites),
        blockedWebsites = Value(blockedWebsites);
  static Insertable<Wellbeing> custom({
    Expression<int>? id,
    Expression<int>? allowedShortsTimeSec,
    Expression<bool>? blockInstaReels,
    Expression<bool>? blockYtShorts,
    Expression<bool>? blockSnapSpotlight,
    Expression<bool>? blockFbReels,
    Expression<bool>? blockRedditShorts,
    Expression<bool>? blockNsfwSites,
    Expression<String>? blockedWebsites,
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
      if (blockedWebsites != null) 'blocked_websites': blockedWebsites,
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
      Value<List<String>>? blockedWebsites}) {
    return WellbeingTableCompanion(
      id: id ?? this.id,
      allowedShortsTimeSec: allowedShortsTimeSec ?? this.allowedShortsTimeSec,
      blockInstaReels: blockInstaReels ?? this.blockInstaReels,
      blockYtShorts: blockYtShorts ?? this.blockYtShorts,
      blockSnapSpotlight: blockSnapSpotlight ?? this.blockSnapSpotlight,
      blockFbReels: blockFbReels ?? this.blockFbReels,
      blockRedditShorts: blockRedditShorts ?? this.blockRedditShorts,
      blockNsfwSites: blockNsfwSites ?? this.blockNsfwSites,
      blockedWebsites: blockedWebsites ?? this.blockedWebsites,
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
    if (blockedWebsites.present) {
      map['blocked_websites'] = Variable<String>($WellbeingTableTable
          .$converterblockedWebsites
          .toSql(blockedWebsites.value));
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
          ..write('blockedWebsites: $blockedWebsites')
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
  late final $FocusProfileTableTable focusProfileTable =
      $FocusProfileTableTable(this);
  late final $FocusSessionsTableTable focusSessionsTable =
      $FocusSessionsTableTable(this);
  late final $MindfulSettingsTableTable mindfulSettingsTable =
      $MindfulSettingsTableTable(this);
  late final $InvincibleModeTableTable invincibleModeTable =
      $InvincibleModeTableTable(this);
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
        focusProfileTable,
        focusSessionsTable,
        mindfulSettingsTable,
        invincibleModeTable,
        restrictionGroupsTable,
        wellbeingTable
      ];
}

typedef $$AppRestrictionTableTableInsertCompanionBuilder
    = AppRestrictionTableCompanion Function({
  required String appPackage,
  required int timerSec,
  required int launchLimit,
  required int alertInterval,
  required bool alertByDialog,
  required bool canAccessInternet,
  Value<int?> associatedGroupId,
  Value<int> rowid,
});
typedef $$AppRestrictionTableTableUpdateCompanionBuilder
    = AppRestrictionTableCompanion Function({
  Value<String> appPackage,
  Value<int> timerSec,
  Value<int> launchLimit,
  Value<int> alertInterval,
  Value<bool> alertByDialog,
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
            Value<int> launchLimit = const Value.absent(),
            Value<int> alertInterval = const Value.absent(),
            Value<bool> alertByDialog = const Value.absent(),
            Value<bool> canAccessInternet = const Value.absent(),
            Value<int?> associatedGroupId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppRestrictionTableCompanion(
            appPackage: appPackage,
            timerSec: timerSec,
            launchLimit: launchLimit,
            alertInterval: alertInterval,
            alertByDialog: alertByDialog,
            canAccessInternet: canAccessInternet,
            associatedGroupId: associatedGroupId,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String appPackage,
            required int timerSec,
            required int launchLimit,
            required int alertInterval,
            required bool alertByDialog,
            required bool canAccessInternet,
            Value<int?> associatedGroupId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppRestrictionTableCompanion.insert(
            appPackage: appPackage,
            timerSec: timerSec,
            launchLimit: launchLimit,
            alertInterval: alertInterval,
            alertByDialog: alertByDialog,
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

  ColumnFilters<int> get launchLimit => $state.composableBuilder(
      column: $state.table.launchLimit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get alertInterval => $state.composableBuilder(
      column: $state.table.alertInterval,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get alertByDialog => $state.composableBuilder(
      column: $state.table.alertByDialog,
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

  ColumnOrderings<int> get launchLimit => $state.composableBuilder(
      column: $state.table.launchLimit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get alertInterval => $state.composableBuilder(
      column: $state.table.alertInterval,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get alertByDialog => $state.composableBuilder(
      column: $state.table.alertByDialog,
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
  required int totalDurationInMins,
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
  Value<int> totalDurationInMins,
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
            Value<int> totalDurationInMins = const Value.absent(),
            Value<List<bool>> scheduleDays = const Value.absent(),
            Value<bool> isScheduleOn = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              BedtimeScheduleTableCompanion(
            id: id,
            startTimeInMins: startTimeInMins,
            endTimeInMins: endTimeInMins,
            totalDurationInMins: totalDurationInMins,
            scheduleDays: scheduleDays,
            isScheduleOn: isScheduleOn,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int startTimeInMins,
            required int endTimeInMins,
            required int totalDurationInMins,
            required List<bool> scheduleDays,
            required bool isScheduleOn,
            required bool shouldStartDnd,
            required List<String> distractingApps,
          }) =>
              BedtimeScheduleTableCompanion.insert(
            id: id,
            startTimeInMins: startTimeInMins,
            endTimeInMins: endTimeInMins,
            totalDurationInMins: totalDurationInMins,
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

  ColumnFilters<int> get totalDurationInMins => $state.composableBuilder(
      column: $state.table.totalDurationInMins,
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

  ColumnOrderings<int> get totalDurationInMins => $state.composableBuilder(
      column: $state.table.totalDurationInMins,
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
  required int longestStreak,
  required int currentStreak,
  required DateTime lastTimeStreakUpdated,
});
typedef $$FocusModeTableTableUpdateCompanionBuilder = FocusModeTableCompanion
    Function({
  Value<int> id,
  Value<SessionType> sessionType,
  Value<int> longestStreak,
  Value<int> currentStreak,
  Value<DateTime> lastTimeStreakUpdated,
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
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required SessionType sessionType,
            required int longestStreak,
            required int currentStreak,
            required DateTime lastTimeStreakUpdated,
          }) =>
              FocusModeTableCompanion.insert(
            id: id,
            sessionType: sessionType,
            longestStreak: longestStreak,
            currentStreak: currentStreak,
            lastTimeStreakUpdated: lastTimeStreakUpdated,
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
}

typedef $$FocusProfileTableTableInsertCompanionBuilder
    = FocusProfileTableCompanion Function({
  Value<SessionType> sessionType,
  required int sessionDuration,
  required bool shouldStartDnd,
  required List<String> distractingApps,
});
typedef $$FocusProfileTableTableUpdateCompanionBuilder
    = FocusProfileTableCompanion Function({
  Value<SessionType> sessionType,
  Value<int> sessionDuration,
  Value<bool> shouldStartDnd,
  Value<List<String>> distractingApps,
});

class $$FocusProfileTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FocusProfileTableTable,
    FocusProfile,
    $$FocusProfileTableTableFilterComposer,
    $$FocusProfileTableTableOrderingComposer,
    $$FocusProfileTableTableProcessedTableManager,
    $$FocusProfileTableTableInsertCompanionBuilder,
    $$FocusProfileTableTableUpdateCompanionBuilder> {
  $$FocusProfileTableTableTableManager(
      _$AppDatabase db, $FocusProfileTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FocusProfileTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$FocusProfileTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$FocusProfileTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<SessionType> sessionType = const Value.absent(),
            Value<int> sessionDuration = const Value.absent(),
            Value<bool> shouldStartDnd = const Value.absent(),
            Value<List<String>> distractingApps = const Value.absent(),
          }) =>
              FocusProfileTableCompanion(
            sessionType: sessionType,
            sessionDuration: sessionDuration,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
          getInsertCompanionBuilder: ({
            Value<SessionType> sessionType = const Value.absent(),
            required int sessionDuration,
            required bool shouldStartDnd,
            required List<String> distractingApps,
          }) =>
              FocusProfileTableCompanion.insert(
            sessionType: sessionType,
            sessionDuration: sessionDuration,
            shouldStartDnd: shouldStartDnd,
            distractingApps: distractingApps,
          ),
        ));
}

class $$FocusProfileTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $FocusProfileTableTable,
        FocusProfile,
        $$FocusProfileTableTableFilterComposer,
        $$FocusProfileTableTableOrderingComposer,
        $$FocusProfileTableTableProcessedTableManager,
        $$FocusProfileTableTableInsertCompanionBuilder,
        $$FocusProfileTableTableUpdateCompanionBuilder> {
  $$FocusProfileTableTableProcessedTableManager(super.$state);
}

class $$FocusProfileTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FocusProfileTableTable> {
  $$FocusProfileTableTableFilterComposer(super.$state);
  ColumnWithTypeConverterFilters<SessionType, SessionType, int>
      get sessionType => $state.composableBuilder(
          column: $state.table.sessionType,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<int> get sessionDuration => $state.composableBuilder(
      column: $state.table.sessionDuration,
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

class $$FocusProfileTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FocusProfileTableTable> {
  $$FocusProfileTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get sessionType => $state.composableBuilder(
      column: $state.table.sessionType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sessionDuration => $state.composableBuilder(
      column: $state.table.sessionDuration,
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
  required int dataResetTimeMins,
  required bool useBottomNavigation,
  required bool useAmoledDark,
  required bool useDynamicColors,
  required DefaultHomeTab defaultHomeTab,
  required List<String> excludedApps,
  required int leftEmergencyPasses,
  required DateTime lastEmergencyUsed,
  required bool isOnboardingDone,
});
typedef $$MindfulSettingsTableTableUpdateCompanionBuilder
    = MindfulSettingsTableCompanion Function({
  Value<int> id,
  Value<AppThemeMode> themeMode,
  Value<String> accentColor,
  Value<String> username,
  Value<String> localeCode,
  Value<int> dataResetTimeMins,
  Value<bool> useBottomNavigation,
  Value<bool> useAmoledDark,
  Value<bool> useDynamicColors,
  Value<DefaultHomeTab> defaultHomeTab,
  Value<List<String>> excludedApps,
  Value<int> leftEmergencyPasses,
  Value<DateTime> lastEmergencyUsed,
  Value<bool> isOnboardingDone,
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
            Value<int> dataResetTimeMins = const Value.absent(),
            Value<bool> useBottomNavigation = const Value.absent(),
            Value<bool> useAmoledDark = const Value.absent(),
            Value<bool> useDynamicColors = const Value.absent(),
            Value<DefaultHomeTab> defaultHomeTab = const Value.absent(),
            Value<List<String>> excludedApps = const Value.absent(),
            Value<int> leftEmergencyPasses = const Value.absent(),
            Value<DateTime> lastEmergencyUsed = const Value.absent(),
            Value<bool> isOnboardingDone = const Value.absent(),
          }) =>
              MindfulSettingsTableCompanion(
            id: id,
            themeMode: themeMode,
            accentColor: accentColor,
            username: username,
            localeCode: localeCode,
            dataResetTimeMins: dataResetTimeMins,
            useBottomNavigation: useBottomNavigation,
            useAmoledDark: useAmoledDark,
            useDynamicColors: useDynamicColors,
            defaultHomeTab: defaultHomeTab,
            excludedApps: excludedApps,
            leftEmergencyPasses: leftEmergencyPasses,
            lastEmergencyUsed: lastEmergencyUsed,
            isOnboardingDone: isOnboardingDone,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required AppThemeMode themeMode,
            required String accentColor,
            required String username,
            required String localeCode,
            required int dataResetTimeMins,
            required bool useBottomNavigation,
            required bool useAmoledDark,
            required bool useDynamicColors,
            required DefaultHomeTab defaultHomeTab,
            required List<String> excludedApps,
            required int leftEmergencyPasses,
            required DateTime lastEmergencyUsed,
            required bool isOnboardingDone,
          }) =>
              MindfulSettingsTableCompanion.insert(
            id: id,
            themeMode: themeMode,
            accentColor: accentColor,
            username: username,
            localeCode: localeCode,
            dataResetTimeMins: dataResetTimeMins,
            useBottomNavigation: useBottomNavigation,
            useAmoledDark: useAmoledDark,
            useDynamicColors: useDynamicColors,
            defaultHomeTab: defaultHomeTab,
            excludedApps: excludedApps,
            leftEmergencyPasses: leftEmergencyPasses,
            lastEmergencyUsed: lastEmergencyUsed,
            isOnboardingDone: isOnboardingDone,
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

  ColumnFilters<bool> get useDynamicColors => $state.composableBuilder(
      column: $state.table.useDynamicColors,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<DefaultHomeTab, DefaultHomeTab, int>
      get defaultHomeTab => $state.composableBuilder(
          column: $state.table.defaultHomeTab,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get excludedApps => $state.composableBuilder(
          column: $state.table.excludedApps,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnFilters<int> get leftEmergencyPasses => $state.composableBuilder(
      column: $state.table.leftEmergencyPasses,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastEmergencyUsed => $state.composableBuilder(
      column: $state.table.lastEmergencyUsed,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isOnboardingDone => $state.composableBuilder(
      column: $state.table.isOnboardingDone,
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

  ColumnOrderings<bool> get useDynamicColors => $state.composableBuilder(
      column: $state.table.useDynamicColors,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get defaultHomeTab => $state.composableBuilder(
      column: $state.table.defaultHomeTab,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get excludedApps => $state.composableBuilder(
      column: $state.table.excludedApps,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get leftEmergencyPasses => $state.composableBuilder(
      column: $state.table.leftEmergencyPasses,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastEmergencyUsed => $state.composableBuilder(
      column: $state.table.lastEmergencyUsed,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isOnboardingDone => $state.composableBuilder(
      column: $state.table.isOnboardingDone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$InvincibleModeTableTableInsertCompanionBuilder
    = InvincibleModeTableCompanion Function({
  Value<int> id,
  required bool isInvincibleModeOn,
  required bool includeAppsTimer,
  required bool includeAppsLaunchLimit,
  required bool includeGroupsTimer,
  required bool includeShortsTimer,
  required bool includeBedtimeSchedule,
});
typedef $$InvincibleModeTableTableUpdateCompanionBuilder
    = InvincibleModeTableCompanion Function({
  Value<int> id,
  Value<bool> isInvincibleModeOn,
  Value<bool> includeAppsTimer,
  Value<bool> includeAppsLaunchLimit,
  Value<bool> includeGroupsTimer,
  Value<bool> includeShortsTimer,
  Value<bool> includeBedtimeSchedule,
});

class $$InvincibleModeTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $InvincibleModeTableTable,
    InvincibleMode,
    $$InvincibleModeTableTableFilterComposer,
    $$InvincibleModeTableTableOrderingComposer,
    $$InvincibleModeTableTableProcessedTableManager,
    $$InvincibleModeTableTableInsertCompanionBuilder,
    $$InvincibleModeTableTableUpdateCompanionBuilder> {
  $$InvincibleModeTableTableTableManager(
      _$AppDatabase db, $InvincibleModeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$InvincibleModeTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$InvincibleModeTableTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$InvincibleModeTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<bool> isInvincibleModeOn = const Value.absent(),
            Value<bool> includeAppsTimer = const Value.absent(),
            Value<bool> includeAppsLaunchLimit = const Value.absent(),
            Value<bool> includeGroupsTimer = const Value.absent(),
            Value<bool> includeShortsTimer = const Value.absent(),
            Value<bool> includeBedtimeSchedule = const Value.absent(),
          }) =>
              InvincibleModeTableCompanion(
            id: id,
            isInvincibleModeOn: isInvincibleModeOn,
            includeAppsTimer: includeAppsTimer,
            includeAppsLaunchLimit: includeAppsLaunchLimit,
            includeGroupsTimer: includeGroupsTimer,
            includeShortsTimer: includeShortsTimer,
            includeBedtimeSchedule: includeBedtimeSchedule,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required bool isInvincibleModeOn,
            required bool includeAppsTimer,
            required bool includeAppsLaunchLimit,
            required bool includeGroupsTimer,
            required bool includeShortsTimer,
            required bool includeBedtimeSchedule,
          }) =>
              InvincibleModeTableCompanion.insert(
            id: id,
            isInvincibleModeOn: isInvincibleModeOn,
            includeAppsTimer: includeAppsTimer,
            includeAppsLaunchLimit: includeAppsLaunchLimit,
            includeGroupsTimer: includeGroupsTimer,
            includeShortsTimer: includeShortsTimer,
            includeBedtimeSchedule: includeBedtimeSchedule,
          ),
        ));
}

class $$InvincibleModeTableTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $InvincibleModeTableTable,
        InvincibleMode,
        $$InvincibleModeTableTableFilterComposer,
        $$InvincibleModeTableTableOrderingComposer,
        $$InvincibleModeTableTableProcessedTableManager,
        $$InvincibleModeTableTableInsertCompanionBuilder,
        $$InvincibleModeTableTableUpdateCompanionBuilder> {
  $$InvincibleModeTableTableProcessedTableManager(super.$state);
}

class $$InvincibleModeTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $InvincibleModeTableTable> {
  $$InvincibleModeTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isInvincibleModeOn => $state.composableBuilder(
      column: $state.table.isInvincibleModeOn,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get includeAppsTimer => $state.composableBuilder(
      column: $state.table.includeAppsTimer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get includeAppsLaunchLimit => $state.composableBuilder(
      column: $state.table.includeAppsLaunchLimit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get includeGroupsTimer => $state.composableBuilder(
      column: $state.table.includeGroupsTimer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get includeShortsTimer => $state.composableBuilder(
      column: $state.table.includeShortsTimer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get includeBedtimeSchedule => $state.composableBuilder(
      column: $state.table.includeBedtimeSchedule,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$InvincibleModeTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $InvincibleModeTableTable> {
  $$InvincibleModeTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isInvincibleModeOn => $state.composableBuilder(
      column: $state.table.isInvincibleModeOn,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get includeAppsTimer => $state.composableBuilder(
      column: $state.table.includeAppsTimer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get includeAppsLaunchLimit => $state.composableBuilder(
      column: $state.table.includeAppsLaunchLimit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get includeGroupsTimer => $state.composableBuilder(
      column: $state.table.includeGroupsTimer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get includeShortsTimer => $state.composableBuilder(
      column: $state.table.includeShortsTimer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get includeBedtimeSchedule => $state.composableBuilder(
      column: $state.table.includeBedtimeSchedule,
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
  required List<String> blockedWebsites,
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
  Value<List<String>> blockedWebsites,
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
            Value<List<String>> blockedWebsites = const Value.absent(),
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
            blockedWebsites: blockedWebsites,
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
            required List<String> blockedWebsites,
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
            blockedWebsites: blockedWebsites,
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
      get blockedWebsites => $state.composableBuilder(
          column: $state.table.blockedWebsites,
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

  ColumnOrderings<String> get blockedWebsites => $state.composableBuilder(
      column: $state.table.blockedWebsites,
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
  $$FocusProfileTableTableTableManager get focusProfileTable =>
      $$FocusProfileTableTableTableManager(_db, _db.focusProfileTable);
  $$FocusSessionsTableTableTableManager get focusSessionsTable =>
      $$FocusSessionsTableTableTableManager(_db, _db.focusSessionsTable);
  $$MindfulSettingsTableTableTableManager get mindfulSettingsTable =>
      $$MindfulSettingsTableTableTableManager(_db, _db.mindfulSettingsTable);
  $$InvincibleModeTableTableTableManager get invincibleModeTable =>
      $$InvincibleModeTableTableTableManager(_db, _db.invincibleModeTable);
  $$RestrictionGroupsTableTableTableManager get restrictionGroupsTable =>
      $$RestrictionGroupsTableTableTableManager(
          _db, _db.restrictionGroupsTable);
  $$WellbeingTableTableTableManager get wellbeingTable =>
      $$WellbeingTableTableTableManager(_db, _db.wellbeingTable);
}
