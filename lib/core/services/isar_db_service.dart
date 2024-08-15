import 'package:isar/isar.dart';
import 'package:mindful/core/enums/session_state.dart';
import 'package:mindful/models/isar/bedtime_settings.dart';
import 'package:mindful/models/isar/focus_mode_settings.dart';
import 'package:mindful/models/isar/focus_session.dart';
import 'package:mindful/models/isar/restriction_info.dart';
import 'package:mindful/models/isar/wellbeing_settings.dart';
import 'package:mindful/models/isar/app_settings.dart';
import 'package:path_provider/path_provider.dart';

/// A service class responsible for interacting with the Isar database.
///
/// This class provides methods for initializing the Isar database,
/// saving and loading various settings objects.
class IsarDbService {
  /// Private constructor to enforce singleton pattern.
  IsarDbService._();

  /// Singleton instance of the IsarDbService.
  static final IsarDbService instance = IsarDbService._();

  /// Internal Isar instance used for database operations.
  late Isar _isar;

  /// Initializes the Isar database service.
  ///
  /// This method should be called once in the application's main method
  /// to set up the Isar database.
  Future<void> init() async {
    /// Gets the application's directory path for storing the database.
    final appDirectory = await getApplicationDocumentsDirectory();

    /// Initializes the Isar instance with the specified schemas and directory.
    _isar = await Isar.open(
      [
        AppSettingsSchema,
        BedtimeSettingsSchema,
        RestrictionInfoSchema,
        WellBeingSettingsSchema,
        FocusSessionSchema,
        FocusModeSettingsSchema,
      ],
      directory: appDirectory.path,
    );
  }

  Future<void> resetDb() async => _isar.writeTxn(
        () => _isar.clear(),
      );

  // SECTION Saving section -----------------------------------------------------------------

  /// Saves a list of [RestrictionInfo] objects to the Isar database.
  Future<void> saveRestrictionInfos(List<RestrictionInfo> infos) async =>
      _isar.writeTxn(
        () => _isar.restrictionInfos.putAllByAppPackage(infos),
      );

  /// Saves a single [BedtimeSettings] object to the Isar database.
  Future<void> saveBedtimeSettings(BedtimeSettings bedtimeSettings) async =>
      _isar.writeTxn(
        () => _isar.bedtimeSettings.put(bedtimeSettings),
      );

  /// Saves a single [WellBeingSettings] object to the Isar database.
  Future<void> saveWellBeingSettings(
          WellBeingSettings wellbeingSettings) async =>
      _isar.writeTxn(
        () => _isar.wellBeingSettings.put(wellbeingSettings),
      );

  /// Saves a single [AppSettings] object to the Isar database.
  Future<void> saveAppSettings(AppSettings appSettings) async => _isar.writeTxn(
        () => _isar.appSettings.put(appSettings),
      );

  /// Saves a single [FocusModeSettings] object to the Isar database.
  Future<void> saveFocusModeSettings(
          FocusModeSettings focusModeSettings) async =>
      _isar.writeTxn(
        () => _isar.focusModeSettings.put(focusModeSettings),
      );

  /// Inserts or Updates a single [FocusSession] object by id in the Isar database.
  Future<void> insertFocusSession(FocusSession session) async {
    _isar.writeTxn(
      () => _isar.focusSessions.putByIndex('startTimeMsEpoch', session),
    );
  }

  //SECTION Loading section ----------------------------------------------------------

  /// Loads all [RestrictionInfo] objects from the Isar database,
  /// sorted by their app package.
  Future<List<RestrictionInfo>> loadRestrictionInfos() async =>
      _isar.restrictionInfos.where().sortByAppPackage().findAll();

  /// Loads the first (and likely only) [BedtimeSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<BedtimeSettings> loadBedtimeSettings() async =>
      await _isar.bedtimeSettings.where().findFirst() ??
      const BedtimeSettings();

  /// Loads the first (and likely only) [WellBeingSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<WellBeingSettings> loadWellBeingSettings() async =>
      await _isar.wellBeingSettings.where().findFirst() ??
      const WellBeingSettings();

  /// Loads the first (and likely only) [AppSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<AppSettings> loadAppSettings() async =>
      await _isar.appSettings.where().findFirst() ?? const AppSettings();

  /// Loads the first (and likely only) [FocusModeSettings] object
  /// from the Isar database. If none exists, returns a new instance.
  Future<FocusModeSettings> loadFocusModeSettings() async =>
      await _isar.focusModeSettings.where().findFirst() ??
      const FocusModeSettings();

  /// Loads all [FocusSession] objects from the Isar database,
  Future<List<FocusSession>> loadAllFocusSessions() async =>
      await _isar.focusSessions.where().findAll();

  /// Loads the first (and likely only) [FocusSession] object
  /// from the Isar database. If none exists, returns null.
  Future<FocusSession?> loadLastActiveFocusSession() async =>
      await _isar.focusSessions
          .filter()
          .stateEqualTo(SessionState.active)
          .findFirst();
}
