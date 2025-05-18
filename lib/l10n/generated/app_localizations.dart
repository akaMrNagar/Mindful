import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('tr'),
    Locale('zh')
  ];

  /// No description provided for @mindful_tagline.
  ///
  /// In en, this message translates to:
  /// **'Focus on what truly Matters'**
  String get mindful_tagline;

  /// No description provided for @unlock_button_label.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock_button_label;

  /// No description provided for @permission_status_off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get permission_status_off;

  /// No description provided for @permission_status_allowed.
  ///
  /// In en, this message translates to:
  /// **'Allowed'**
  String get permission_status_allowed;

  /// No description provided for @permission_status_not_allowed.
  ///
  /// In en, this message translates to:
  /// **'Not allowed'**
  String get permission_status_not_allowed;

  /// No description provided for @permission_button_grant_permission.
  ///
  /// In en, this message translates to:
  /// **'Grant Permission'**
  String get permission_button_grant_permission;

  /// No description provided for @permission_button_agree_and_continue.
  ///
  /// In en, this message translates to:
  /// **'Agree & Continue'**
  String get permission_button_agree_and_continue;

  /// No description provided for @permission_button_not_now.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get permission_button_not_now;

  /// No description provided for @permission_button_help.
  ///
  /// In en, this message translates to:
  /// **'Help?'**
  String get permission_button_help;

  /// No description provided for @permission_sheet_privacy_info.
  ///
  /// In en, this message translates to:
  /// **'Mindful is 100% secure and works offline. We do not collect or store any personal data.'**
  String get permission_sheet_privacy_info;

  /// No description provided for @permission_grant_step_one.
  ///
  /// In en, this message translates to:
  /// **'1. Click on {button_label} button.'**
  String permission_grant_step_one(String button_label);

  /// No description provided for @permission_grant_step_two.
  ///
  /// In en, this message translates to:
  /// **'2. Select Mindful in the next screen.'**
  String get permission_grant_step_two;

  /// No description provided for @permission_grant_step_three.
  ///
  /// In en, this message translates to:
  /// **'3. Click and turn on the switch like below.'**
  String get permission_grant_step_three;

  /// No description provided for @permission_notification_title.
  ///
  /// In en, this message translates to:
  /// **'Send Notifications'**
  String get permission_notification_title;

  /// No description provided for @permission_alarms_title.
  ///
  /// In en, this message translates to:
  /// **'Alarms & Reminders'**
  String get permission_alarms_title;

  /// No description provided for @permission_alarms_info.
  ///
  /// In en, this message translates to:
  /// **'Please grant permission for setting alarms and reminders. This will allow Mindful to start your bedtime schedule on time and reset app timers daily at midnight and help you stay on track.'**
  String get permission_alarms_info;

  /// No description provided for @permission_alarms_device_tile_label.
  ///
  /// In en, this message translates to:
  /// **'Allow setting alarms and reminders'**
  String get permission_alarms_device_tile_label;

  /// No description provided for @permission_usage_title.
  ///
  /// In en, this message translates to:
  /// **'Usage Access'**
  String get permission_usage_title;

  /// No description provided for @permission_usage_info.
  ///
  /// In en, this message translates to:
  /// **'Please grant usage access permission. This will allow Mindful to monitor app usage and manage access to certain apps, ensuring a more focused and controlled digital environment.'**
  String get permission_usage_info;

  /// No description provided for @permission_usage_device_tile_label.
  ///
  /// In en, this message translates to:
  /// **'Permit usage access'**
  String get permission_usage_device_tile_label;

  /// No description provided for @permission_overlay_title.
  ///
  /// In en, this message translates to:
  /// **'Display Overlay'**
  String get permission_overlay_title;

  /// No description provided for @permission_overlay_info.
  ///
  /// In en, this message translates to:
  /// **'Please grant display overlay permission. This will allow Mindful to show an overlay when a paused app is opened, helping you stay focused and maintain your schedule.'**
  String get permission_overlay_info;

  /// No description provided for @permission_overlay_device_tile_label.
  ///
  /// In en, this message translates to:
  /// **'Allow display over other apps'**
  String get permission_overlay_device_tile_label;

  /// No description provided for @permission_accessibility_title.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get permission_accessibility_title;

  /// No description provided for @permission_accessibility_info.
  ///
  /// In en, this message translates to:
  /// **'Please grant accessibility permission. This will allow Mindful to restrict access to short-form video content (e.g., Reels, Shorts) within social media apps and browsers, and filter inappropriate websites.'**
  String get permission_accessibility_info;

  /// No description provided for @permission_accessibility_required.
  ///
  /// In en, this message translates to:
  /// **'Mindful requires accessibility permission to block short content and websites effectively.'**
  String get permission_accessibility_required;

  /// No description provided for @permission_accessibility_device_tile_label.
  ///
  /// In en, this message translates to:
  /// **'Use Mindful'**
  String get permission_accessibility_device_tile_label;

  /// No description provided for @permission_dnd_title.
  ///
  /// In en, this message translates to:
  /// **'Do not disturb'**
  String get permission_dnd_title;

  /// No description provided for @permission_dnd_info.
  ///
  /// In en, this message translates to:
  /// **'Please grant Do Not Disturb access. This will allow Mindful to start and stop Do Not Disturb mode during the bedtime schedule.'**
  String get permission_dnd_info;

  /// No description provided for @permission_dnd_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Start DND'**
  String get permission_dnd_tile_title;

  /// No description provided for @permission_dnd_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Also enable Do Not Disturb mode.'**
  String get permission_dnd_tile_subtitle;

  /// No description provided for @permission_battery_optimization_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Ignore Battery Optimization'**
  String get permission_battery_optimization_tile_title;

  /// No description provided for @permission_battery_optimization_status_enabled.
  ///
  /// In en, this message translates to:
  /// **'Already unrestricted'**
  String get permission_battery_optimization_status_enabled;

  /// No description provided for @permission_battery_optimization_status_disabled.
  ///
  /// In en, this message translates to:
  /// **'Disable background restriction'**
  String get permission_battery_optimization_status_disabled;

  /// No description provided for @permission_battery_optimization_allow_info.
  ///
  /// In en, this message translates to:
  /// **'Allowing \'Ignore Battery Optimization\' will automatically grant the \'Alarms & Reminders\' permission on some devices.'**
  String get permission_battery_optimization_allow_info;

  /// No description provided for @permission_vpn_title.
  ///
  /// In en, this message translates to:
  /// **'Create VPN'**
  String get permission_vpn_title;

  /// No description provided for @permission_vpn_info.
  ///
  /// In en, this message translates to:
  /// **'Please grant permission to create virtual private network (VPN) connection. This will enable Mindful to restrict internet access for designated applications by creating local on device VPN.'**
  String get permission_vpn_info;

  /// No description provided for @permission_admin_title.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get permission_admin_title;

  /// No description provided for @permission_admin_info.
  ///
  /// In en, this message translates to:
  /// **'Administrative privileges are needed only for essential operations to ensure the app works properly and remains tamper-proof.'**
  String get permission_admin_info;

  /// No description provided for @permission_admin_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Tamper protection can only be disabled during the selected time window.'**
  String get permission_admin_snack_alert;

  /// No description provided for @permission_notification_access_title.
  ///
  /// In en, this message translates to:
  /// **'Notification Access'**
  String get permission_notification_access_title;

  /// No description provided for @permission_notification_access_info.
  ///
  /// In en, this message translates to:
  /// **'Please grant notification access permission. This will allow Mindful to organize your notifications and deliver them on your schedule.'**
  String get permission_notification_access_info;

  /// No description provided for @permission_notification_access_required.
  ///
  /// In en, this message translates to:
  /// **'Mindful requires notification access to batch and schedule notifications.'**
  String get permission_notification_access_required;

  /// No description provided for @permission_notification_access_device_tile_label.
  ///
  /// In en, this message translates to:
  /// **'Allow notification access'**
  String get permission_notification_access_device_tile_label;

  /// No description provided for @day_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get day_today;

  /// No description provided for @day_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get day_yesterday;

  /// No description provided for @nDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 day} =1{1 day} other{{count} days}}'**
  String nDays(num count);

  /// No description provided for @nHours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 hour} =1{1 hour} other{{count} hours}}'**
  String nHours(num count);

  /// No description provided for @nMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 minute} =1{1 minute} other{{count} minutes}}'**
  String nMinutes(num count);

  /// No description provided for @nSeconds.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 second} =1{1 second} other{{count} seconds}}'**
  String nSeconds(num count);

  /// Separator used between time like, 10 hours 'and' 15 minutes
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get time_separator_and;

  /// No description provided for @timer_status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get timer_status_active;

  /// No description provided for @timer_status_paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get timer_status_paused;

  /// No description provided for @create_button.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create_button;

  /// No description provided for @update_button.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update_button;

  /// No description provided for @dialog_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialog_button_cancel;

  /// No description provided for @dialog_button_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get dialog_button_remove;

  /// No description provided for @dialog_button_set.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get dialog_button_set;

  /// No description provided for @dialog_button_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get dialog_button_reset;

  /// No description provided for @dialog_button_infinite.
  ///
  /// In en, this message translates to:
  /// **'Infinite'**
  String get dialog_button_infinite;

  /// No description provided for @schedule_start_label.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get schedule_start_label;

  /// No description provided for @schedule_end_label.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get schedule_end_label;

  /// No description provided for @development_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Mindful is currently under development and may have bugs or incomplete features. If you encounter any issues, please report them to help us improve.\n\nThank you for your feedback!'**
  String get development_dialog_info;

  /// No description provided for @development_dialog_button_report_issue.
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get development_dialog_button_report_issue;

  /// No description provided for @development_dialog_button_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get development_dialog_button_close;

  /// No description provided for @dnd_settings_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Do not disturb settings'**
  String get dnd_settings_tile_title;

  /// No description provided for @dnd_settings_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage which apps and notifications can reach you in DND.'**
  String get dnd_settings_tile_subtitle;

  /// No description provided for @quick_actions_heading.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get quick_actions_heading;

  /// No description provided for @select_distracting_apps_heading.
  ///
  /// In en, this message translates to:
  /// **'Select distracting apps'**
  String get select_distracting_apps_heading;

  /// No description provided for @your_distracting_apps_heading.
  ///
  /// In en, this message translates to:
  /// **'Your distracting apps'**
  String get your_distracting_apps_heading;

  /// No description provided for @select_more_apps_heading.
  ///
  /// In en, this message translates to:
  /// **'Select more apps'**
  String get select_more_apps_heading;

  /// No description provided for @imp_distracting_apps_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Adding important system apps to the list of distracting apps is not permitted.'**
  String get imp_distracting_apps_snack_alert;

  /// No description provided for @custom_apps_quick_actions_unavailable_warning.
  ///
  /// In en, this message translates to:
  /// **'Screen usage and restrictions are unavailable for this application. At present, only network usage is accessible'**
  String get custom_apps_quick_actions_unavailable_warning;

  /// No description provided for @create_group_fab_button.
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get create_group_fab_button;

  /// No description provided for @active_period_info.
  ///
  /// In en, this message translates to:
  /// **'Set a time period during which access will be allowed. Outside of this time frame, access will be restricted.'**
  String get active_period_info;

  /// No description provided for @minimum_distracting_apps_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Select at least one distracting app.'**
  String get minimum_distracting_apps_snack_alert;

  /// No description provided for @donation_card_title.
  ///
  /// In en, this message translates to:
  /// **'Support us'**
  String get donation_card_title;

  /// No description provided for @donation_card_info.
  ///
  /// In en, this message translates to:
  /// **'Mindful is free and open-source, developed with months of dedication. If it has helped you, your donation would mean the world to us. Every contribution helps us continue improving and maintaining it for everyone.'**
  String get donation_card_info;

  /// No description provided for @operation_failed_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Operation failed, something went wrong!'**
  String get operation_failed_snack_alert;

  /// No description provided for @donation_card_button_donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donation_card_button_donate;

  /// No description provided for @app_restart_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Need restart'**
  String get app_restart_dialog_title;

  /// No description provided for @app_restart_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Mindful will automatically restart once the countdown finishes. Please be patient as changes are applied.'**
  String get app_restart_dialog_info;

  /// No description provided for @accessibility_tip.
  ///
  /// In en, this message translates to:
  /// **'Want smarter, more battery-friendly blocking? Enable Accessibility permission for Mindful.'**
  String get accessibility_tip;

  /// No description provided for @battery_optimization_tip.
  ///
  /// In en, this message translates to:
  /// **'Mindful not working? Allow \'Ignore Battery Optimization\' in Settings to keep it running smoothly.'**
  String get battery_optimization_tip;

  /// No description provided for @invincible_mode_tip.
  ///
  /// In en, this message translates to:
  /// **'Accidentally removed restrictions? Use Invincible Mode to lock them until the next day or adjustment window.'**
  String get invincible_mode_tip;

  /// No description provided for @glance_usage_tip.
  ///
  /// In en, this message translates to:
  /// **'Want insights? Check the Glance section to view your usage patterns and screen time.'**
  String get glance_usage_tip;

  /// No description provided for @tamper_protection_tip.
  ///
  /// In en, this message translates to:
  /// **'Uninstalling Mindful? Enable the Uninstall Window to safely disable tamper protection first.'**
  String get tamper_protection_tip;

  /// No description provided for @notification_blocking_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to reduce distractions? Use Notification Blocking to silence selected apps.'**
  String get notification_blocking_tip;

  /// No description provided for @usage_history_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to reflect on your habits? Check Usage History to see past patterns.'**
  String get usage_history_tip;

  /// No description provided for @focus_mode_tip.
  ///
  /// In en, this message translates to:
  /// **'Need deep focus? Turn on Focus Mode to block apps and notifications during tasks.'**
  String get focus_mode_tip;

  /// No description provided for @bedtime_reminder_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to improve your sleep? Set a Bedtime Reminder to wind down nightly.'**
  String get bedtime_reminder_tip;

  /// No description provided for @custom_blocking_tip.
  ///
  /// In en, this message translates to:
  /// **'Need a custom experience? Create app blocking rules that fit your needs.'**
  String get custom_blocking_tip;

  /// No description provided for @session_timeline_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to track focus sessions? View timeline to see your focus journey.'**
  String get session_timeline_tip;

  /// No description provided for @short_content_blocking_tip.
  ///
  /// In en, this message translates to:
  /// **'Distracted by social apps? Block short content on Instagram, YouTube, etc., to stay focused.'**
  String get short_content_blocking_tip;

  /// No description provided for @parental_controls_tip.
  ///
  /// In en, this message translates to:
  /// **'Need parental control? Set restrictions for your child\'s device to ensure a safe experience.'**
  String get parental_controls_tip;

  /// No description provided for @notification_batching_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to reduce distractions? Use Notification Batching to group notifications and check them at once.'**
  String get notification_batching_tip;

  /// No description provided for @notification_scheduling_tip.
  ///
  /// In en, this message translates to:
  /// **'Need to manage notifications? Schedule when you receive notifications for specific apps.'**
  String get notification_scheduling_tip;

  /// No description provided for @quick_focus_tile_tip.
  ///
  /// In en, this message translates to:
  /// **'Need quick access to focus? Add a Quick Focus Tile to instantly activate Focus Mode.'**
  String get quick_focus_tile_tip;

  /// No description provided for @app_shortcuts_tip.
  ///
  /// In en, this message translates to:
  /// **'Want instant app access? Add shortcuts by long-pressing the app icon for quick actions.'**
  String get app_shortcuts_tip;

  /// No description provided for @backup_usage_db_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to save your data? Backup your usage database to keep your records safe.'**
  String get backup_usage_db_tip;

  /// No description provided for @dynamic_material_color_tip.
  ///
  /// In en, this message translates to:
  /// **'Want a custom theme? Enable Dynamic Material You color to match your device\'s theme.'**
  String get dynamic_material_color_tip;

  /// No description provided for @amoled_dark_theme_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to save battery? Use AMOLED Dark Theme to reduce power consumption on OLED screens.'**
  String get amoled_dark_theme_tip;

  /// No description provided for @customize_usage_history_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to keep usage history? Customize how many weeks of data to store in Usage History.'**
  String get customize_usage_history_tip;

  /// No description provided for @grouped_apps_blocking_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to block apps together? Use Restriction Groups to group app limits and block multiple apps at once.'**
  String get grouped_apps_blocking_tip;

  /// No description provided for @websites_blocking_tip.
  ///
  /// In en, this message translates to:
  /// **'Want a cleaner browsing experience? Block custom or NSFW websites for a more focused online time.'**
  String get websites_blocking_tip;

  /// No description provided for @data_usage_tip.
  ///
  /// In en, this message translates to:
  /// **'Want to track your data? Monitor your mobile and Wi-Fi data usage for internet consumption.'**
  String get data_usage_tip;

  /// No description provided for @block_internet_tip.
  ///
  /// In en, this message translates to:
  /// **'Need to block an app\'s internet? Cut off internet for specific app from app\'s dashboard.'**
  String get block_internet_tip;

  /// No description provided for @emergency_passes_tip.
  ///
  /// In en, this message translates to:
  /// **'Need a break? Use 3 Emergency Passes daily to temporarily unblock apps for 5 minutes.'**
  String get emergency_passes_tip;

  /// No description provided for @onboarding_skip_btn_label.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip_btn_label;

  /// No description provided for @onboarding_finish_setup_btn_label.
  ///
  /// In en, this message translates to:
  /// **'Finish Setup'**
  String get onboarding_finish_setup_btn_label;

  /// No description provided for @onboarding_page_one_title.
  ///
  /// In en, this message translates to:
  /// **'Master Focus.'**
  String get onboarding_page_one_title;

  /// No description provided for @onboarding_page_one_info.
  ///
  /// In en, this message translates to:
  /// **'Pause distracting apps, block short content, and stay on track with customizable focus sessions. Whether you\'re working, studying, or relaxing, Mindful helps you stay in control.'**
  String get onboarding_page_one_info;

  /// No description provided for @onboarding_page_two_title.
  ///
  /// In en, this message translates to:
  /// **'Block Distractions.'**
  String get onboarding_page_two_title;

  /// No description provided for @onboarding_page_two_info.
  ///
  /// In en, this message translates to:
  /// **'Set usage limits, automatically pause apps, and create healthier digital habits. Use Bedtime Mode to unwind and enjoy a distraction-free night.'**
  String get onboarding_page_two_info;

  /// No description provided for @onboarding_page_three_title.
  ///
  /// In en, this message translates to:
  /// **'Privacy First.'**
  String get onboarding_page_three_title;

  /// No description provided for @onboarding_page_three_info.
  ///
  /// In en, this message translates to:
  /// **'Mindful is 100% open-source and operates entirely offline. We don\'t collect or share your personal data — your privacy is guaranteed in every way.'**
  String get onboarding_page_three_info;

  /// No description provided for @onboarding_page_permissions_title.
  ///
  /// In en, this message translates to:
  /// **'Essential Permissions.'**
  String get onboarding_page_permissions_title;

  /// No description provided for @onboarding_page_permissions_info.
  ///
  /// In en, this message translates to:
  /// **'Mindful requires following essential permissions to track and manage your screen time, helping reduce distractions and improve focus.'**
  String get onboarding_page_permissions_info;

  /// No description provided for @dashboard_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard_tab_title;

  /// No description provided for @focus_now_fab_button.
  ///
  /// In en, this message translates to:
  /// **'Focus now'**
  String get focus_now_fab_button;

  /// No description provided for @welcome_greetings.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcome_greetings;

  /// No description provided for @username_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Long press to edit username.'**
  String get username_snack_alert;

  /// No description provided for @username_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username_dialog_title;

  /// No description provided for @username_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Enter your username which will be displayed on dashboard.'**
  String get username_dialog_info;

  /// No description provided for @username_dialog_button_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get username_dialog_button_apply;

  /// No description provided for @glance_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Glance'**
  String get glance_tile_title;

  /// No description provided for @glance_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Take a quick glance at your usage.'**
  String get glance_tile_subtitle;

  /// No description provided for @parental_controls_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Invincible mode and tamper protection.'**
  String get parental_controls_tile_subtitle;

  /// No description provided for @restrictions_heading.
  ///
  /// In en, this message translates to:
  /// **'Restrictions'**
  String get restrictions_heading;

  /// No description provided for @apps_blocking_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Apps blocking'**
  String get apps_blocking_tile_title;

  /// No description provided for @apps_blocking_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Limit apps in multiple ways.'**
  String get apps_blocking_tile_subtitle;

  /// No description provided for @grouped_apps_blocking_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Grouped apps blocking'**
  String get grouped_apps_blocking_tile_title;

  /// No description provided for @grouped_apps_blocking_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Limit group of apps simultaneously.'**
  String get grouped_apps_blocking_tile_subtitle;

  /// No description provided for @shorts_blocking_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Limit short content on multiple platforms.'**
  String get shorts_blocking_tile_subtitle;

  /// No description provided for @websites_blocking_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Limit adult and custom websites.'**
  String get websites_blocking_tile_subtitle;

  /// No description provided for @screen_time_label.
  ///
  /// In en, this message translates to:
  /// **'Screen time'**
  String get screen_time_label;

  /// No description provided for @total_data_label.
  ///
  /// In en, this message translates to:
  /// **'Total data'**
  String get total_data_label;

  /// No description provided for @mobile_data_label.
  ///
  /// In en, this message translates to:
  /// **'Mobile data'**
  String get mobile_data_label;

  /// No description provided for @wifi_data_label.
  ///
  /// In en, this message translates to:
  /// **'Wifi data'**
  String get wifi_data_label;

  /// No description provided for @focus_today_label.
  ///
  /// In en, this message translates to:
  /// **'Focus today'**
  String get focus_today_label;

  /// No description provided for @focus_weekly_label.
  ///
  /// In en, this message translates to:
  /// **'Focus weekly'**
  String get focus_weekly_label;

  /// No description provided for @focus_monthly_label.
  ///
  /// In en, this message translates to:
  /// **'Focus monthly'**
  String get focus_monthly_label;

  /// No description provided for @focus_lifetime_label.
  ///
  /// In en, this message translates to:
  /// **'Focus lifetime'**
  String get focus_lifetime_label;

  /// No description provided for @longest_streak_label.
  ///
  /// In en, this message translates to:
  /// **'Longest streak'**
  String get longest_streak_label;

  /// No description provided for @current_streak_label.
  ///
  /// In en, this message translates to:
  /// **'Current streak'**
  String get current_streak_label;

  /// No description provided for @successful_sessions_label.
  ///
  /// In en, this message translates to:
  /// **'Successful sessions'**
  String get successful_sessions_label;

  /// No description provided for @failed_sessions_label.
  ///
  /// In en, this message translates to:
  /// **'Failed sessions'**
  String get failed_sessions_label;

  /// No description provided for @statistics_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics_tab_title;

  /// No description provided for @screen_segment_label.
  ///
  /// In en, this message translates to:
  /// **'Screen'**
  String get screen_segment_label;

  /// No description provided for @data_segment_label.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data_segment_label;

  /// No description provided for @mobile_label.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile_label;

  /// No description provided for @wifi_label.
  ///
  /// In en, this message translates to:
  /// **'Wifi'**
  String get wifi_label;

  /// No description provided for @most_used_apps_heading.
  ///
  /// In en, this message translates to:
  /// **'Most used apps'**
  String get most_used_apps_heading;

  /// No description provided for @show_all_apps_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Show all apps'**
  String get show_all_apps_tile_title;

  /// No description provided for @search_apps_hint.
  ///
  /// In en, this message translates to:
  /// **'Search apps...'**
  String get search_apps_hint;

  /// No description provided for @notifications_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications_tab_title;

  /// No description provided for @notifications_tab_info.
  ///
  /// In en, this message translates to:
  /// **'Batch notification from apps and set schedules like morning, noon, evening and night. Stay updated without constant interruptions.'**
  String get notifications_tab_info;

  /// No description provided for @batched_apps_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Batched apps'**
  String get batched_apps_tile_title;

  /// No description provided for @batch_recap_dropdown_title.
  ///
  /// In en, this message translates to:
  /// **'Batch recap type'**
  String get batch_recap_dropdown_title;

  /// No description provided for @batch_recap_dropdown_info.
  ///
  /// In en, this message translates to:
  /// **'Choose what to push when a schedule triggers — all notifications or just a summary.'**
  String get batch_recap_dropdown_info;

  /// No description provided for @batch_recap_option_summery_only.
  ///
  /// In en, this message translates to:
  /// **'Summery only'**
  String get batch_recap_option_summery_only;

  /// No description provided for @batch_recap_option_all_notifications.
  ///
  /// In en, this message translates to:
  /// **'All notifications'**
  String get batch_recap_option_all_notifications;

  /// No description provided for @notification_history_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Notification history'**
  String get notification_history_tile_title;

  /// No description provided for @store_all_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Store all notifications'**
  String get store_all_tile_title;

  /// No description provided for @store_all_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Save non-batched notifications too.'**
  String get store_all_tile_subtitle;

  /// No description provided for @schedules_heading.
  ///
  /// In en, this message translates to:
  /// **'Schedules'**
  String get schedules_heading;

  /// No description provided for @new_schedule_fab_button.
  ///
  /// In en, this message translates to:
  /// **'New Schedule'**
  String get new_schedule_fab_button;

  /// No description provided for @new_schedule_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Enter a name for the notification schedule to help identify it easily.'**
  String get new_schedule_dialog_info;

  /// No description provided for @new_schedule_dialog_field_label.
  ///
  /// In en, this message translates to:
  /// **'Schedule name'**
  String get new_schedule_dialog_field_label;

  /// No description provided for @bedtime_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get bedtime_tab_title;

  /// No description provided for @bedtime_tab_info.
  ///
  /// In en, this message translates to:
  /// **'Set your bedtime schedule by selecting a time period and days of the week. Choose distracting apps to block and enable Do Not Disturb (DND) mode for a peaceful night.'**
  String get bedtime_tab_info;

  /// No description provided for @schedule_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule_tile_title;

  /// No description provided for @schedule_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable daily schedule.'**
  String get schedule_tile_subtitle;

  /// No description provided for @bedtime_no_days_selected_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day of the week.'**
  String get bedtime_no_days_selected_snack_alert;

  /// No description provided for @bedtime_minimum_duration_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'The total bedtime duration must be at least 30 minutes.'**
  String get bedtime_minimum_duration_snack_alert;

  /// No description provided for @distracting_apps_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Distracting apps'**
  String get distracting_apps_tile_title;

  /// No description provided for @distracting_apps_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Select which apps are distracting you from your bedtime routine.'**
  String get distracting_apps_tile_subtitle;

  /// No description provided for @bedtime_distracting_apps_modify_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Modifications to the list of distracting apps is not permitted while the bedtime schedule is active.'**
  String get bedtime_distracting_apps_modify_snack_alert;

  /// No description provided for @parental_controls_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Parental controls'**
  String get parental_controls_tab_title;

  /// No description provided for @invincible_mode_heading.
  ///
  /// In en, this message translates to:
  /// **'Invincible mode'**
  String get invincible_mode_heading;

  /// No description provided for @invincible_mode_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Activate invincible mode'**
  String get invincible_mode_tile_title;

  /// No description provided for @invincible_mode_info.
  ///
  /// In en, this message translates to:
  /// **'When Invincible Mode is on, you won\'t be able to adjust selected limits after reaching your daily quota. However, you can make changes within a selected 10-minute invincible window.'**
  String get invincible_mode_info;

  /// No description provided for @invincible_mode_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Due to invincible mode, modifications to restrictions is not allowed.'**
  String get invincible_mode_snack_alert;

  /// No description provided for @invincible_mode_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Are you absolutely sure you want to enable Invincible Mode? This action is irreversible. Once Invincible Mode is turned on, you cannot turn it off as long as this app is installed on your device.'**
  String get invincible_mode_dialog_info;

  /// No description provided for @invincible_mode_turn_off_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Invincible Mode cannot be turned off as long as this app remains installed on your device.'**
  String get invincible_mode_turn_off_snack_alert;

  /// No description provided for @invincible_mode_dialog_button_start_anyway.
  ///
  /// In en, this message translates to:
  /// **'Start anyway'**
  String get invincible_mode_dialog_button_start_anyway;

  /// No description provided for @invincible_mode_include_timer_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Include timer'**
  String get invincible_mode_include_timer_tile_title;

  /// No description provided for @invincible_mode_include_launch_limit_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Include launch limit'**
  String get invincible_mode_include_launch_limit_tile_title;

  /// No description provided for @invincible_mode_include_active_period_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Include active period'**
  String get invincible_mode_include_active_period_tile_title;

  /// No description provided for @invincible_mode_app_restrictions_tile_title.
  ///
  /// In en, this message translates to:
  /// **'App restrictions'**
  String get invincible_mode_app_restrictions_tile_title;

  /// No description provided for @invincible_mode_app_restrictions_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Prevent changes to the app\'s selected restrictions once the daily limits are exceeded.'**
  String get invincible_mode_app_restrictions_tile_subtitle;

  /// No description provided for @invincible_mode_group_restrictions_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Group restrictions'**
  String get invincible_mode_group_restrictions_tile_title;

  /// No description provided for @invincible_mode_group_restrictions_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Prevent changes to the group\'s selected restrictions once the daily limits are exceeded.'**
  String get invincible_mode_group_restrictions_tile_subtitle;

  /// No description provided for @invincible_mode_include_shorts_timer_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Include shorts timer'**
  String get invincible_mode_include_shorts_timer_tile_title;

  /// No description provided for @invincible_mode_include_shorts_timer_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Prevents changes after reaching your daily shorts limit.'**
  String get invincible_mode_include_shorts_timer_tile_subtitle;

  /// No description provided for @invincible_mode_include_bedtime_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Include bedtime'**
  String get invincible_mode_include_bedtime_tile_title;

  /// No description provided for @invincible_mode_include_bedtime_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Prevents changes during the active bedtime schedule.'**
  String get invincible_mode_include_bedtime_tile_subtitle;

  /// No description provided for @protected_access_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Protected access'**
  String get protected_access_tile_title;

  /// No description provided for @protected_access_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Protect Mindful with your device lock.'**
  String get protected_access_tile_subtitle;

  /// No description provided for @protected_access_no_lock_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Please set up a biometric lock on your device first to enable this feature.'**
  String get protected_access_no_lock_snack_alert;

  /// No description provided for @protected_access_removed_lock_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Your device lock has been removed. To continue, please set up a new lock.'**
  String get protected_access_removed_lock_snack_alert;

  /// No description provided for @protected_access_failed_lock_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. You need to verify your device lock to proceed.'**
  String get protected_access_failed_lock_snack_alert;

  /// No description provided for @tamper_protection_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Tamper protection'**
  String get tamper_protection_tile_title;

  /// No description provided for @tamper_protection_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Prevent uninstalling and force stopping the app.'**
  String get tamper_protection_tile_subtitle;

  /// No description provided for @tamper_protection_confirmation_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Once enabled, you won\'t be able to uninstall, force stop, or clear Mindful\'s data, except during the selected uninstall window. There are no workarounds.\n\nProceed at your own risk.'**
  String get tamper_protection_confirmation_dialog_info;

  /// No description provided for @uninstall_window_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Uninstall window'**
  String get uninstall_window_tile_title;

  /// No description provided for @uninstall_window_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tamper protection can be disabled within 10 minutes from the selected time.'**
  String get uninstall_window_tile_subtitle;

  /// No description provided for @invincible_window_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Invincible window'**
  String get invincible_window_tile_title;

  /// No description provided for @invincible_window_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Selected limits can be modified within 10 minutes from the selected time.'**
  String get invincible_window_tile_subtitle;

  /// No description provided for @shorts_blocking_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Shorts blocking'**
  String get shorts_blocking_tab_title;

  /// No description provided for @shorts_blocking_tab_info.
  ///
  /// In en, this message translates to:
  /// **'Control how much time you spend on short content across platforms like Instagram, YouTube, Snapchat, and Facebook, including their websites.'**
  String get shorts_blocking_tab_info;

  /// No description provided for @short_content_heading.
  ///
  /// In en, this message translates to:
  /// **'Short content'**
  String get short_content_heading;

  /// No description provided for @shorts_time_left_from.
  ///
  /// In en, this message translates to:
  /// **'Left from {timeShortString}'**
  String shorts_time_left_from(String timeShortString);

  /// No description provided for @short_content_timer_picker_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Set a daily time limit for short content. Once your limit is reached, the short content will be paused until midnight.'**
  String get short_content_timer_picker_dialog_info;

  /// No description provided for @instagram_features_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram_features_tile_title;

  /// No description provided for @instagram_features_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restrict features on instagram.'**
  String get instagram_features_tile_subtitle;

  /// No description provided for @instagram_features_block_reels.
  ///
  /// In en, this message translates to:
  /// **'Restrict reels section.'**
  String get instagram_features_block_reels;

  /// No description provided for @instagram_features_block_explore.
  ///
  /// In en, this message translates to:
  /// **'Restrict explore section.'**
  String get instagram_features_block_explore;

  /// No description provided for @snapchat_features_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Snapchat'**
  String get snapchat_features_tile_title;

  /// No description provided for @snapchat_features_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restrict features on snapchat.'**
  String get snapchat_features_tile_subtitle;

  /// No description provided for @snapchat_features_block_spotlight.
  ///
  /// In en, this message translates to:
  /// **'Restrict spotlight section.'**
  String get snapchat_features_block_spotlight;

  /// No description provided for @snapchat_features_block_discover.
  ///
  /// In en, this message translates to:
  /// **'Restrict discover section.'**
  String get snapchat_features_block_discover;

  /// No description provided for @youtube_features_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Youtube'**
  String get youtube_features_tile_title;

  /// No description provided for @youtube_features_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restrict shorts on youtube.'**
  String get youtube_features_tile_subtitle;

  /// No description provided for @facebook_features_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook_features_tile_title;

  /// No description provided for @facebook_features_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restrict reels on facebook.'**
  String get facebook_features_tile_subtitle;

  /// No description provided for @reddit_features_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Reddit'**
  String get reddit_features_tile_title;

  /// No description provided for @reddit_features_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restrict shorts on reddit.'**
  String get reddit_features_tile_subtitle;

  /// No description provided for @websites_blocking_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Websites blocking'**
  String get websites_blocking_tab_title;

  /// No description provided for @websites_blocking_tab_info.
  ///
  /// In en, this message translates to:
  /// **'Block adult websites and any custom sites you choose to create a safer and more focused online experience. Take charge of your browsing and stay distraction-free.'**
  String get websites_blocking_tab_info;

  /// No description provided for @adult_content_heading.
  ///
  /// In en, this message translates to:
  /// **'Adult content'**
  String get adult_content_heading;

  /// No description provided for @block_nsfw_title.
  ///
  /// In en, this message translates to:
  /// **'Block Nsfw'**
  String get block_nsfw_title;

  /// No description provided for @block_nsfw_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Restrict browsers from opening adult and porn websites.'**
  String get block_nsfw_subtitle;

  /// No description provided for @block_nsfw_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This action is irreversible. Once adult sites blocker is turned ON, you cannot turn it OFF as long as this app is installed on your device.'**
  String get block_nsfw_dialog_info;

  /// No description provided for @block_nsfw_dialog_button_block_anyway.
  ///
  /// In en, this message translates to:
  /// **'Block anyway'**
  String get block_nsfw_dialog_button_block_anyway;

  /// No description provided for @blocked_websites_heading.
  ///
  /// In en, this message translates to:
  /// **'Blocked websites'**
  String get blocked_websites_heading;

  /// No description provided for @blocked_websites_empty_list_hint.
  ///
  /// In en, this message translates to:
  /// **'Click on \'+ Add Website\' button to add distracting websites which you wish to block.'**
  String get blocked_websites_empty_list_hint;

  /// No description provided for @add_website_fab_button.
  ///
  /// In en, this message translates to:
  /// **'Add Website'**
  String get add_website_fab_button;

  /// No description provided for @add_website_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Distracting website'**
  String get add_website_dialog_title;

  /// No description provided for @add_website_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Enter url of a website which you want to block.'**
  String get add_website_dialog_info;

  /// No description provided for @add_website_dialog_is_nsfw.
  ///
  /// In en, this message translates to:
  /// **'Is nsfw site?'**
  String get add_website_dialog_is_nsfw;

  /// No description provided for @add_website_dialog_nsfw_warning.
  ///
  /// In en, this message translates to:
  /// **'Warning: Nsfw sites cannot be removed once added.'**
  String get add_website_dialog_nsfw_warning;

  /// No description provided for @add_website_dialog_button_block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get add_website_dialog_button_block;

  /// No description provided for @add_website_already_exist_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'The URL has already been added to the list of blocked websites.'**
  String get add_website_already_exist_snack_alert;

  /// No description provided for @add_website_invalid_url_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL! Unable to parse the host name.'**
  String get add_website_invalid_url_snack_alert;

  /// No description provided for @remove_website_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Remove website'**
  String get remove_website_dialog_title;

  /// No description provided for @remove_website_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? you want to remove \'{websitehost}\' from blocked websites.'**
  String remove_website_dialog_info(String websitehost);

  /// No description provided for @focus_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get focus_tab_title;

  /// No description provided for @focus_tab_info.
  ///
  /// In en, this message translates to:
  /// **'When you need time to focus, start a new session by selecting the type, choosing distracting apps to pause, and enabling Do Not Disturb for uninterrupted concentration.'**
  String get focus_tab_info;

  /// No description provided for @active_session_card_title.
  ///
  /// In en, this message translates to:
  /// **'Active session'**
  String get active_session_card_title;

  /// No description provided for @active_session_card_info.
  ///
  /// In en, this message translates to:
  /// **'You have an active focus session running! Click \'View\' to check your progress and see how much time has elapsed.'**
  String get active_session_card_info;

  /// No description provided for @active_session_card_view_button.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get active_session_card_view_button;

  /// No description provided for @focus_distracting_apps_removal_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Removal of apps from the distracting apps list is not permitted while a Focus Session is active. However, you may still add additional apps to the list during this time.'**
  String get focus_distracting_apps_removal_snack_alert;

  /// No description provided for @focus_profile_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Focus profile'**
  String get focus_profile_tile_title;

  /// No description provided for @focus_session_duration_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Session duration'**
  String get focus_session_duration_tile_title;

  /// No description provided for @focus_session_duration_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Infinite (unless you stop)'**
  String get focus_session_duration_tile_subtitle;

  /// No description provided for @focus_session_duration_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Please select the desired duration for this focus session, determining how long you wish to remain focused and distraction-free.'**
  String get focus_session_duration_dialog_info;

  /// No description provided for @focus_profile_customization_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Profile customization'**
  String get focus_profile_customization_tile_title;

  /// No description provided for @focus_profile_customization_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize settings for the selected profile.'**
  String get focus_profile_customization_tile_subtitle;

  /// No description provided for @focus_enforce_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Enforce session'**
  String get focus_enforce_tile_title;

  /// No description provided for @focus_enforce_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Prevents ending a session before time ends.'**
  String get focus_enforce_tile_subtitle;

  /// No description provided for @focus_session_start_fab_button.
  ///
  /// In en, this message translates to:
  /// **'Start Session'**
  String get focus_session_start_fab_button;

  /// No description provided for @focus_session_minimum_apps_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Select at least one distracting app to start focus session'**
  String get focus_session_minimum_apps_snack_alert;

  /// No description provided for @focus_session_already_active_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'You already have an active focus session running. Please complete or stop your current session before starting a new one.'**
  String get focus_session_already_active_snack_alert;

  /// No description provided for @focus_session_type_study.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get focus_session_type_study;

  /// No description provided for @focus_session_type_work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get focus_session_type_work;

  /// No description provided for @focus_session_type_exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get focus_session_type_exercise;

  /// No description provided for @focus_session_type_meditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get focus_session_type_meditation;

  /// No description provided for @focus_session_type_creativeWriting.
  ///
  /// In en, this message translates to:
  /// **'Creative Writing'**
  String get focus_session_type_creativeWriting;

  /// No description provided for @focus_session_type_reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get focus_session_type_reading;

  /// No description provided for @focus_session_type_programming.
  ///
  /// In en, this message translates to:
  /// **'Programming'**
  String get focus_session_type_programming;

  /// No description provided for @focus_session_type_chores.
  ///
  /// In en, this message translates to:
  /// **'Chores'**
  String get focus_session_type_chores;

  /// No description provided for @focus_session_type_projectPlanning.
  ///
  /// In en, this message translates to:
  /// **'Project Planning'**
  String get focus_session_type_projectPlanning;

  /// No description provided for @focus_session_type_artAndDesign.
  ///
  /// In en, this message translates to:
  /// **'Art and Design'**
  String get focus_session_type_artAndDesign;

  /// No description provided for @focus_session_type_languageLearning.
  ///
  /// In en, this message translates to:
  /// **'Language Learning'**
  String get focus_session_type_languageLearning;

  /// No description provided for @focus_session_type_musicPractice.
  ///
  /// In en, this message translates to:
  /// **'Music Practice'**
  String get focus_session_type_musicPractice;

  /// No description provided for @focus_session_type_selfCare.
  ///
  /// In en, this message translates to:
  /// **'Self Care'**
  String get focus_session_type_selfCare;

  /// No description provided for @focus_session_type_brainstorming.
  ///
  /// In en, this message translates to:
  /// **'Brainstorming'**
  String get focus_session_type_brainstorming;

  /// No description provided for @focus_session_type_skillDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Skill Development'**
  String get focus_session_type_skillDevelopment;

  /// No description provided for @focus_session_type_research.
  ///
  /// In en, this message translates to:
  /// **'Research'**
  String get focus_session_type_research;

  /// No description provided for @focus_session_type_networking.
  ///
  /// In en, this message translates to:
  /// **'Networking'**
  String get focus_session_type_networking;

  /// No description provided for @focus_session_type_cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get focus_session_type_cooking;

  /// No description provided for @focus_session_type_sportsTraining.
  ///
  /// In en, this message translates to:
  /// **'Sports Training'**
  String get focus_session_type_sportsTraining;

  /// No description provided for @focus_session_type_restAndRelaxation.
  ///
  /// In en, this message translates to:
  /// **'Rest and Relaxation'**
  String get focus_session_type_restAndRelaxation;

  /// No description provided for @focus_session_type_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get focus_session_type_other;

  /// No description provided for @timeline_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline_tab_title;

  /// No description provided for @focus_timeline_tab_info.
  ///
  /// In en, this message translates to:
  /// **'Explore your focus journey by selecting a date from the calendar. Track your progress, revisit your successes, and learn from the challenges.'**
  String get focus_timeline_tab_info;

  /// No description provided for @selected_month_productive_time_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Your total productive time for the selected month is {timeString}.'**
  String selected_month_productive_time_snack_alert(String timeString);

  /// No description provided for @selected_month_productive_days_label.
  ///
  /// In en, this message translates to:
  /// **'Productive days'**
  String get selected_month_productive_days_label;

  /// No description provided for @selected_month_productive_days_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'You\'ve had a total of {daysCount} productive days in the selected month.'**
  String selected_month_productive_days_snack_alert(num daysCount);

  /// No description provided for @selected_day_focused_time_label.
  ///
  /// In en, this message translates to:
  /// **'Focused time'**
  String get selected_day_focused_time_label;

  /// No description provided for @selected_day_focused_time_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Your total focused time for the selected day is {timeString}.'**
  String selected_day_focused_time_snack_alert(String timeString);

  /// No description provided for @calender_heading.
  ///
  /// In en, this message translates to:
  /// **'Calender'**
  String get calender_heading;

  /// No description provided for @your_sessions_heading.
  ///
  /// In en, this message translates to:
  /// **'Your sessions'**
  String get your_sessions_heading;

  /// No description provided for @your_sessions_empty_list_hint.
  ///
  /// In en, this message translates to:
  /// **'No focus sessions recorded for the selected day.'**
  String get your_sessions_empty_list_hint;

  /// No description provided for @focus_session_tile_timestamp_label.
  ///
  /// In en, this message translates to:
  /// **'Timestamp'**
  String get focus_session_tile_timestamp_label;

  /// No description provided for @focus_session_tile_duration_label.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get focus_session_tile_duration_label;

  /// No description provided for @focus_session_tile_reflection_label.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get focus_session_tile_reflection_label;

  /// No description provided for @focus_session_state_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get focus_session_state_active;

  /// No description provided for @focus_session_state_successful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get focus_session_state_successful;

  /// No description provided for @focus_session_state_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get focus_session_state_failed;

  /// No description provided for @active_session_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get active_session_tab_title;

  /// No description provided for @active_session_none_warning.
  ///
  /// In en, this message translates to:
  /// **'No active session found. Returning to the home screen.'**
  String get active_session_none_warning;

  /// No description provided for @active_session_dialog_button_keep_pushing.
  ///
  /// In en, this message translates to:
  /// **'Keep pushing'**
  String get active_session_dialog_button_keep_pushing;

  /// No description provided for @active_session_finish_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get active_session_finish_dialog_title;

  /// No description provided for @active_session_finish_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Stay strong! You\'re building valuable focus. Are you sure you want to end this focus session? Every extra moment counts toward your goals.'**
  String get active_session_finish_dialog_info;

  /// No description provided for @active_session_giveup_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Give up'**
  String get active_session_giveup_dialog_title;

  /// No description provided for @active_session_giveup_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Hold on! You\'re almost there don\'t give up now! Are you sure you want to end this focus session early? Progress will be lost.'**
  String get active_session_giveup_dialog_info;

  /// No description provided for @active_session_reflection_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Session reflection'**
  String get active_session_reflection_dialog_title;

  /// No description provided for @active_session_reflection_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to reflect on your progress. What\'s your goal for this session? What did you accomplish during this session?'**
  String get active_session_reflection_dialog_info;

  /// No description provided for @active_session_reflection_dialog_tip.
  ///
  /// In en, this message translates to:
  /// **'Tip: You can always edit this later in the session timeline.'**
  String get active_session_reflection_dialog_tip;

  /// No description provided for @active_session_giveup_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'You gave up! Don\'t worry, you can do better next time. Every effort counts - just keep going'**
  String get active_session_giveup_snack_alert;

  /// No description provided for @active_session_quote_one.
  ///
  /// In en, this message translates to:
  /// **'Every step counts, stay strong and keep going'**
  String get active_session_quote_one;

  /// No description provided for @active_session_quote_two.
  ///
  /// In en, this message translates to:
  /// **'Stay focused! you\'re making amazing progress'**
  String get active_session_quote_two;

  /// No description provided for @active_session_quote_three.
  ///
  /// In en, this message translates to:
  /// **'You\'re crushing it! Keep the momentum going'**
  String get active_session_quote_three;

  /// No description provided for @active_session_quote_four.
  ///
  /// In en, this message translates to:
  /// **'Just a little more to go, you\'re doing fantastic'**
  String get active_session_quote_four;

  /// No description provided for @active_session_quote_five.
  ///
  /// In en, this message translates to:
  /// **'Congratulations 🎉 \n You\'ve completed your focus session of {durationString}.\n\nGreat job, keep up the amazing work'**
  String active_session_quote_five(String durationString);

  /// No description provided for @restriction_groups_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Restriction groups'**
  String get restriction_groups_tab_title;

  /// No description provided for @restriction_groups_tab_info.
  ///
  /// In en, this message translates to:
  /// **'Set a combined screen time limit for a group of apps. Once the total usage reaches your limit, all apps in the group will be paused to help maintain focus and balance.'**
  String get restriction_groups_tab_info;

  /// No description provided for @restriction_group_time_spent_label.
  ///
  /// In en, this message translates to:
  /// **'Time spent today'**
  String get restriction_group_time_spent_label;

  /// No description provided for @restriction_group_time_left_label.
  ///
  /// In en, this message translates to:
  /// **'Time left today'**
  String get restriction_group_time_left_label;

  /// No description provided for @restriction_group_name_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get restriction_group_name_tile_title;

  /// No description provided for @restriction_group_name_picker_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Enter a name for the restriction group to help identify and manage it easily.'**
  String get restriction_group_name_picker_dialog_info;

  /// No description provided for @restriction_group_timer_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Group timer'**
  String get restriction_group_timer_tile_title;

  /// No description provided for @restriction_group_timer_picker_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Set a daily time limit for this group. Once your limit is reached, all the apps in this group will be paused until midnight.'**
  String get restriction_group_timer_picker_dialog_info;

  /// No description provided for @restriction_group_active_period_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Group active period'**
  String get restriction_group_active_period_tile_title;

  /// No description provided for @remove_restriction_group_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Remove group'**
  String get remove_restriction_group_dialog_title;

  /// No description provided for @remove_restriction_group_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? you want to remove \'{groupName}\' from restriction groups.'**
  String remove_restriction_group_dialog_info(String groupName);

  /// No description provided for @restriction_group_invalid_limits_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'Set either a timer or an active period limit.'**
  String get restriction_group_invalid_limits_snack_alert;

  /// No description provided for @notifications_empty_list_hint.
  ///
  /// In en, this message translates to:
  /// **'No notifications have been batched for the day.'**
  String get notifications_empty_list_hint;

  /// No description provided for @conversations_label.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get conversations_label;

  /// No description provided for @last_24_hours_heading.
  ///
  /// In en, this message translates to:
  /// **'Last 24 hours'**
  String get last_24_hours_heading;

  /// No description provided for @notification_timeline_tab_info.
  ///
  /// In en, this message translates to:
  /// **'Browse your notification history by selecting a date from the calendar. See which apps grabbed your attention and reflect on your digital habits.'**
  String get notification_timeline_tab_info;

  /// No description provided for @monthly_label.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly_label;

  /// No description provided for @daily_label.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily_label;

  /// No description provided for @search_notifications_sheet_info.
  ///
  /// In en, this message translates to:
  /// **'Easily find past notifications by searching through their title or content. Helps you quickly locate important alerts.'**
  String get search_notifications_sheet_info;

  /// No description provided for @search_notifications_hint.
  ///
  /// In en, this message translates to:
  /// **'Search notifications...'**
  String get search_notifications_hint;

  /// No description provided for @search_notifications_empty_list_hint.
  ///
  /// In en, this message translates to:
  /// **'No notifications found matching your search.'**
  String get search_notifications_empty_list_hint;

  /// No description provided for @app_info_none_warning.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find the app for the given package. Returning to the home screen.'**
  String get app_info_none_warning;

  /// No description provided for @emergency_fab_button.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency_fab_button;

  /// No description provided for @emergency_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'This action will pause the app blocker for next 5 minutes. You have {leftPassesCount} passes left. After using all passes, the app will stay blocked until midnight, or the active focus session ends.\n\nDo you still wish to proceed?'**
  String emergency_dialog_info(num leftPassesCount);

  /// No description provided for @emergency_dialog_button_use_anyway.
  ///
  /// In en, this message translates to:
  /// **'Use anyway'**
  String get emergency_dialog_button_use_anyway;

  /// No description provided for @emergency_started_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'The app blocker is paused and will resume blocking in 5 minutes.'**
  String get emergency_started_snack_alert;

  /// No description provided for @emergency_already_active_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'The app blocker is currently either paused or inactive. If notifications are enabled, you will receive updates regarding the remaining time.'**
  String get emergency_already_active_snack_alert;

  /// No description provided for @emergency_no_pass_left_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'You have used all your emergency passes. The blocked apps will stay blocked until midnight, or the active focus session ends.'**
  String get emergency_no_pass_left_snack_alert;

  /// No description provided for @app_limit_status_not_set.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get app_limit_status_not_set;

  /// No description provided for @app_timer_tile_title.
  ///
  /// In en, this message translates to:
  /// **'App timer'**
  String get app_timer_tile_title;

  /// No description provided for @app_timer_picker_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Set a daily time limit for this app. Once your limit is reached, the app will be paused until midnight.'**
  String get app_timer_picker_dialog_info;

  /// No description provided for @usage_reminders_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Usage reminders'**
  String get usage_reminders_tile_title;

  /// No description provided for @usage_reminders_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Gentle nudges when using timed apps.'**
  String get usage_reminders_tile_subtitle;

  /// No description provided for @app_launch_limit_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Launch limit'**
  String get app_launch_limit_tile_title;

  /// No description provided for @app_launch_limit_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Launched {count} times today.'**
  String app_launch_limit_tile_subtitle(num count);

  /// No description provided for @app_launch_limit_picker_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Set how many times you can open this app each day. Once the limit is reached, it will be paused until midnight.'**
  String get app_launch_limit_picker_dialog_info;

  /// No description provided for @app_active_period_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Active period'**
  String get app_active_period_tile_title;

  /// No description provided for @app_active_period_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'From {startTime} to {endTime}'**
  String app_active_period_tile_subtitle(String startTime, String endTime);

  /// No description provided for @internet_access_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Internet access'**
  String get internet_access_tile_title;

  /// No description provided for @internet_access_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch off to block app\'s internet.'**
  String get internet_access_tile_subtitle;

  /// No description provided for @internet_access_blocked_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'{appName}\'s internet is blocked.'**
  String internet_access_blocked_snack_alert(String appName);

  /// No description provided for @internet_access_unblocked_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'{appName}\'s internet is unblocked.'**
  String internet_access_unblocked_snack_alert(String appName);

  /// No description provided for @launch_app_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Launch app'**
  String get launch_app_tile_title;

  /// No description provided for @launch_app_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Open {appName}.'**
  String launch_app_tile_subtitle(String appName);

  /// No description provided for @go_to_app_settings_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Go to app settings'**
  String get go_to_app_settings_tile_title;

  /// No description provided for @go_to_app_settings_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage app settings like notifications, permissions, storage and more.'**
  String get go_to_app_settings_tile_subtitle;

  /// No description provided for @include_in_stats_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Include in screen usage'**
  String get include_in_stats_tile_title;

  /// No description provided for @include_in_stats_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch off to exclude this app from total screen usage.'**
  String get include_in_stats_tile_subtitle;

  /// No description provided for @app_excluded_from_stats_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'{appName} is excluded from total screen usage.'**
  String app_excluded_from_stats_snack_alert(String appName);

  /// No description provided for @app_include_to_stats_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'{appName} is included to total screen usage.'**
  String app_include_to_stats_snack_alert(String appName);

  /// No description provided for @general_tab_title.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general_tab_title;

  /// No description provided for @appearance_heading.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance_heading;

  /// No description provided for @theme_mode_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get theme_mode_tile_title;

  /// No description provided for @theme_mode_system_label.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get theme_mode_system_label;

  /// No description provided for @theme_mode_light_label.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_mode_light_label;

  /// No description provided for @theme_mode_dark_label.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_mode_dark_label;

  /// No description provided for @material_color_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Material color'**
  String get material_color_tile_title;

  /// No description provided for @amoled_dark_tile_title.
  ///
  /// In en, this message translates to:
  /// **'AMOLED dark'**
  String get amoled_dark_tile_title;

  /// No description provided for @amoled_dark_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Use pure black color for the dark theme.'**
  String get amoled_dark_tile_subtitle;

  /// No description provided for @dynamic_colors_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Dynamic colors'**
  String get dynamic_colors_tile_title;

  /// No description provided for @dynamic_colors_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Use device colors if supported.'**
  String get dynamic_colors_tile_subtitle;

  /// No description provided for @defaults_heading.
  ///
  /// In en, this message translates to:
  /// **'Defaults'**
  String get defaults_heading;

  /// No description provided for @app_language_tile_title.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get app_language_tile_title;

  /// No description provided for @default_home_tab_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Home tab'**
  String get default_home_tab_tile_title;

  /// No description provided for @usage_history_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Usage history'**
  String get usage_history_tile_title;

  /// No description provided for @usage_history_15_days.
  ///
  /// In en, this message translates to:
  /// **'15 days'**
  String get usage_history_15_days;

  /// No description provided for @usage_history_1_month.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get usage_history_1_month;

  /// No description provided for @usage_history_3_month.
  ///
  /// In en, this message translates to:
  /// **'3 months'**
  String get usage_history_3_month;

  /// No description provided for @usage_history_6_month.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get usage_history_6_month;

  /// No description provided for @usage_history_1_year.
  ///
  /// In en, this message translates to:
  /// **'1 year'**
  String get usage_history_1_year;

  /// No description provided for @service_heading.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service_heading;

  /// No description provided for @service_stopping_warning.
  ///
  /// In en, this message translates to:
  /// **'If Mindful stops working unexpectedly, please grant the \'Ignore Battery Optimization\' permission to keep it running in the background. If the issue continues, try whitelisting Mindful for uninterrupted performance.'**
  String get service_stopping_warning;

  /// No description provided for @whitelist_app_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Whitelist Mindful'**
  String get whitelist_app_tile_title;

  /// No description provided for @whitelist_app_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Mindful to auto start.'**
  String get whitelist_app_tile_subtitle;

  /// No description provided for @whitelist_app_unsupported_snack_alert.
  ///
  /// In en, this message translates to:
  /// **'This device does not support automatic startup management.'**
  String get whitelist_app_unsupported_snack_alert;

  /// No description provided for @database_tab_title.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get database_tab_title;

  /// No description provided for @import_db_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Import database'**
  String get import_db_tile_title;

  /// No description provided for @import_db_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Import database from a file.'**
  String get import_db_tile_subtitle;

  /// No description provided for @export_db_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Export database'**
  String get export_db_tile_title;

  /// No description provided for @export_db_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Export database to a file.'**
  String get export_db_tile_subtitle;

  /// No description provided for @crash_logs_heading.
  ///
  /// In en, this message translates to:
  /// **'Crash logs'**
  String get crash_logs_heading;

  /// No description provided for @crash_logs_info.
  ///
  /// In en, this message translates to:
  /// **'If you encounter any issue, you can report it on GitHub along with the log file. The file will include details such as your device\'s manufacturer, model, Android version, SDK version, and crash logs. This information will help us identify and resolve the problem more effectively.'**
  String get crash_logs_info;

  /// No description provided for @crash_logs_export_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Export crash logs'**
  String get crash_logs_export_tile_title;

  /// No description provided for @crash_logs_export_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Export crash logs to a json file.'**
  String get crash_logs_export_tile_subtitle;

  /// No description provided for @crash_logs_view_tile_title.
  ///
  /// In en, this message translates to:
  /// **'View logs'**
  String get crash_logs_view_tile_title;

  /// No description provided for @crash_logs_view_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore stored crash logs.'**
  String get crash_logs_view_tile_subtitle;

  /// No description provided for @crash_logs_empty_list_hint.
  ///
  /// In en, this message translates to:
  /// **'No crash logged till now.'**
  String get crash_logs_empty_list_hint;

  /// No description provided for @crash_logs_clear_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Clear logs'**
  String get crash_logs_clear_tile_title;

  /// No description provided for @crash_logs_clear_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all crash logs from database.'**
  String get crash_logs_clear_tile_subtitle;

  /// No description provided for @crash_logs_clear_dialog_info.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you wish to clear all crash logs from the database?'**
  String get crash_logs_clear_dialog_info;

  /// No description provided for @crash_logs_clear_dialog_button_clear_anyway.
  ///
  /// In en, this message translates to:
  /// **'Clear anyway'**
  String get crash_logs_clear_dialog_button_clear_anyway;

  /// No description provided for @about_tab_title.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about_tab_title;

  /// No description provided for @changelog_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Changelog'**
  String get changelog_tile_title;

  /// No description provided for @changelog_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Find out what\'s new.'**
  String get changelog_tile_subtitle;

  /// No description provided for @full_changelog_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Full changelog'**
  String get full_changelog_tile_title;

  /// No description provided for @redirected_to_github_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You will be redirected to GitHub.'**
  String get redirected_to_github_subtitle;

  /// No description provided for @contribute_heading.
  ///
  /// In en, this message translates to:
  /// **'Contribute'**
  String get contribute_heading;

  /// No description provided for @github_tile_title.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github_tile_title;

  /// No description provided for @github_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'View the source code.'**
  String get github_tile_subtitle;

  /// No description provided for @report_issue_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Report an issue'**
  String get report_issue_tile_title;

  /// No description provided for @suggest_idea_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Suggest an idea'**
  String get suggest_idea_tile_title;

  /// No description provided for @write_email_tile_title.
  ///
  /// In en, this message translates to:
  /// **'Write to us via email'**
  String get write_email_tile_title;

  /// No description provided for @write_email_tile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'You will be redirected to Email app.'**
  String get write_email_tile_subtitle;

  /// No description provided for @privacy_policy_heading.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacy_policy_heading;

  /// No description provided for @privacy_policy_info.
  ///
  /// In en, this message translates to:
  /// **'Mindful is committed to protecting your privacy. We do not collect, store, or transfer any type of user data. The app operates entirely offline and does not require an internet connection, ensuring that your personal information remains private and secure on your device. As a Free and Open Source Software (FOSS) application, Mindful guarantees complete transparency and user control over their data.'**
  String get privacy_policy_info;

  /// No description provided for @more_details_button.
  ///
  /// In en, this message translates to:
  /// **'More details'**
  String get more_details_button;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja', 'tr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
    case 'tr': return AppLocalizationsTr();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
