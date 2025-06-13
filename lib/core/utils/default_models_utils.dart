import 'package:mindful/core/database/adapters/time_of_day_adapter.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/default_home_tab.dart';
import 'package:mindful/core/enums/recap_type.dart';
import 'package:mindful/core/enums/reminder_type.dart';
import 'package:mindful/core/enums/session_type.dart';
import 'package:mindful/config/app_constants.dart';
import 'package:mindful/models/notification_schedule.dart';

final defaultMindfulSettingsModel = MindfulSettings(
  id: 0,
  defaultHomeTab: DefaultHomeTab.dashboard,
  themeMode: AppConstants.defaultThemeMode,
  accentColor: AppConstants.defaultMaterialColor,
  username: AppConstants.defaultUsername,
  localeCode: AppConstants.defaultLocale,
  usageHistoryWeeks: 4,
  useAmoledDark: false,
  useDynamicColors: false,
  leftEmergencyPasses: 3,
  lastEmergencyUsed: DateTime(0),
  isOnboardingDone: false,
  appVersion: "",
);

const defaultSharedUniqueDataModel = SharedUniqueData(
  id: 0,
  excludedApps: [],
);

const defaultParentalControlsModel = ParentalControls(
  id: 0,
  protectedAccess: false,
  uninstallWindowTime: TimeOfDayAdapter.zero(),
  isInvincibleModeOn: false,
  invincibleWindowTime: TimeOfDayAdapter.zero(),
  includeAppsTimer: true,
  includeAppsLaunchLimit: false,
  includeAppsActivePeriod: false,
  includeGroupsTimer: false,
  includeGroupsActivePeriod: false,
  includeShortsTimer: false,
  includeBedtimeSchedule: false,
);

const defaultWellbeingModel = Wellbeing(
  id: 0,
  allowedShortsTimeSec: 30 * 60,
  blockedFeatures: [],
  blockNsfwSites: false,
  blockedWebsites: [],
  nsfwWebsites: [],
);

const defaultBedtimeScheduleModel = BedtimeSchedule(
  id: 0,
  scheduleStartTime: TimeOfDayAdapter.zero(),
  scheduleEndTime: TimeOfDayAdapter.zero(),
  scheduleDurationInMins: 0,
  scheduleDays: [true, true, true, true, true, false, false],
  isScheduleOn: false,
  shouldStartDnd: false,
  distractingApps: [],
);

NotificationSettings defaultNotificationSettingsModel = NotificationSettings(
  id: 0,
  recapType: RecapType.summeryOnly,
  storeNonBatchedToo: false,
  notificationHistoryWeeks: 2,
  batchedApps: [],
  schedules: const {
    'Morning': 480,
    'Afternoon': 720,
    'Evening': 960,
    'Night': 1260,
  }
      .entries
      .map(
        (e) => NotificationSchedule(
          label: e.key,
          time: TimeOfDayAdapter.fromMinutes(e.value),
          isActive: false,
        ),
      )
      .toList(),
);

const defaultAppRestrictionModel = AppRestriction(
  appPackage: "",
  timerSec: 0,
  launchLimit: 0,
  activePeriodStart: TimeOfDayAdapter.zero(),
  activePeriodEnd: TimeOfDayAdapter.zero(),
  periodDurationInMins: 0,
  canAccessInternet: true,
  reminderType: ReminderType.toast,
);

final defaultFocusModeModel = FocusMode(
  id: 0,
  sessionType: SessionType.study,
  longestStreak: 0,
  currentStreak: 0,
  lastTimeStreakUpdated: DateTime(0),
);

const defaultFocusProfileModel = FocusProfile(
  sessionType: SessionType.study,
  sessionDuration: 0,
  shouldStartDnd: false,
  enforceSession: false,
  distractingApps: [],
);
