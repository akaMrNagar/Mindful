import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get mindful_tagline => 'Focus on what truly Matters';

  @override
  String get unlock_button_label => 'Unlock';

  @override
  String get permission_status_off => 'Off';

  @override
  String get permission_status_allowed => 'Allowed';

  @override
  String get permission_status_not_allowed => 'Not allowed';

  @override
  String get permission_button_grant_permission => 'Grant Permission';

  @override
  String get permission_button_agree_and_continue => 'Agree & Continue';

  @override
  String get permission_button_not_now => 'Not Now';

  @override
  String get permission_button_help => 'Help?';

  @override
  String get permission_sheet_privacy_info => 'Mindful is 100% secure and works offline. We do not collect or store any personal data.';

  @override
  String permission_grant_step_one(String button_label) {
    return '1. Click on $button_label button.';
  }

  @override
  String get permission_grant_step_two => '2. Select Mindful in the next screen.';

  @override
  String get permission_grant_step_three => '3. Click and turn on the switch like below.';

  @override
  String get permission_notification_title => 'Send Notifications';

  @override
  String get permission_alarms_title => 'Alarms & Reminders';

  @override
  String get permission_alarms_info => 'Please grant permission for setting alarms and reminders. This will allow Mindful to start your bedtime schedule on time and reset app timers daily at midnight and help you stay on track.';

  @override
  String get permission_alarms_device_tile_label => 'Allow setting alarms and reminders';

  @override
  String get permission_usage_title => 'Usage Access';

  @override
  String get permission_usage_info => 'Please grant usage access permission. This will allow Mindful to monitor app usage and manage access to certain apps, ensuring a more focused and controlled digital environment.';

  @override
  String get permission_usage_device_tile_label => 'Permit usage access';

  @override
  String get permission_overlay_title => 'Display Overlay';

  @override
  String get permission_overlay_info => 'Please grant display overlay permission. This will allow Mindful to show an overlay when a paused app is opened, helping you stay focused and maintain your schedule.';

  @override
  String get permission_overlay_device_tile_label => 'Allow display over other apps';

  @override
  String get permission_accessibility_title => 'Accessibility';

  @override
  String get permission_accessibility_info => 'Please grant accessibility permission. This will allow Mindful to restrict access to short-form video content (e.g., Reels, Shorts) within social media apps and browsers, and filter inappropriate websites.';

  @override
  String get permission_accessibility_required => 'Mindful requires accessibility permission to block short content and websites effectively.';

  @override
  String get permission_accessibility_device_tile_label => 'Use Mindful';

  @override
  String get permission_dnd_title => 'Do not disturb';

  @override
  String get permission_dnd_info => 'Please grant Do Not Disturb access. This will allow Mindful to start and stop Do Not Disturb mode during the bedtime schedule.';

  @override
  String get permission_dnd_tile_title => 'Start DND';

  @override
  String get permission_dnd_tile_subtitle => 'Also enable Do Not Disturb mode.';

  @override
  String get permission_battery_optimization_tile_title => 'Ignore Battery Optimization';

  @override
  String get permission_battery_optimization_status_enabled => 'Already unrestricted';

  @override
  String get permission_battery_optimization_status_disabled => 'Disable background restriction';

  @override
  String get permission_battery_optimization_allow_info => 'Allowing \'Ignore Battery Optimization\' will automatically grant the \'Alarms & Reminders\' permission on some devices.';

  @override
  String get permission_vpn_title => 'Create VPN';

  @override
  String get permission_vpn_info => 'Please grant permission to create virtual private network (VPN) connection. This will enable Mindful to restrict internet access for designated applications by creating local on device VPN.';

  @override
  String get permission_admin_title => 'Admin';

  @override
  String get permission_admin_info => 'Administrative privileges are needed only for essential operations to ensure the app works properly and remains tamper-proof.';

  @override
  String get permission_admin_snack_alert => 'Tamper protection can only be disabled during the selected time window.';

  @override
  String get permission_notification_access_title => 'Notification Access';

  @override
  String get permission_notification_access_info => 'Please grant notification access permission. This will allow Mindful to organize your notifications and deliver them on your schedule.';

  @override
  String get permission_notification_access_required => 'Mindful requires notification access to batch and schedule notifications.';

  @override
  String get permission_notification_access_device_tile_label => 'Allow notification access';

  @override
  String get day_today => 'Today';

  @override
  String get day_yesterday => 'Yesterday';

  @override
  String nDays(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString days',
      one: '1 day',
      zero: '0 day',
    );
    return '$_temp0';
  }

  @override
  String nHours(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString hours',
      one: '1 hour',
      zero: '0 hour',
    );
    return '$_temp0';
  }

  @override
  String nMinutes(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString minutes',
      one: '1 minute',
      zero: '0 minute',
    );
    return '$_temp0';
  }

  @override
  String nSeconds(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString seconds',
      one: '1 second',
      zero: '0 second',
    );
    return '$_temp0';
  }

  @override
  String get time_separator_and => 'and';

  @override
  String get timer_status_active => 'Active';

  @override
  String get timer_status_paused => 'Paused';

  @override
  String get create_button => 'Create';

  @override
  String get update_button => 'Update';

  @override
  String get dialog_button_cancel => 'Cancel';

  @override
  String get dialog_button_remove => 'Remove';

  @override
  String get dialog_button_set => 'Set';

  @override
  String get dialog_button_reset => 'Reset';

  @override
  String get dialog_button_infinite => 'Infinite';

  @override
  String get schedule_start_label => 'Start';

  @override
  String get schedule_end_label => 'End';

  @override
  String get development_dialog_info => 'Mindful is currently under development and may have bugs or incomplete features. If you encounter any issues, please report them to help us improve.\n\nThank you for your feedback!';

  @override
  String get development_dialog_button_report_issue => 'Report Issue';

  @override
  String get development_dialog_button_close => 'Close';

  @override
  String get dnd_settings_tile_title => 'Do not disturb settings';

  @override
  String get dnd_settings_tile_subtitle => 'Manage which apps and notifications can reach you in DND.';

  @override
  String get quick_actions_heading => 'Quick actions';

  @override
  String get select_distracting_apps_heading => 'Select distracting apps';

  @override
  String get your_distracting_apps_heading => 'Your distracting apps';

  @override
  String get select_more_apps_heading => 'Select more apps';

  @override
  String get imp_distracting_apps_snack_alert => 'Adding important system apps to the list of distracting apps is not permitted.';

  @override
  String get custom_apps_quick_actions_unavailable_warning => 'Screen usage and restrictions are unavailable for this application. At present, only network usage is accessible';

  @override
  String get create_group_fab_button => 'Create Group';

  @override
  String get active_period_info => 'Set a time period during which access will be allowed. Outside of this time frame, access will be restricted.';

  @override
  String get minimum_distracting_apps_snack_alert => 'Select at least one distracting app.';

  @override
  String get donation_card_title => 'Support us';

  @override
  String get donation_card_info => 'Mindful is free and open-source, developed with months of dedication. If it has helped you, your donation would mean the world to us. Every contribution helps us continue improving and maintaining it for everyone.';

  @override
  String get operation_failed_snack_alert => 'Operation failed, something went wrong!';

  @override
  String get donation_card_button_donate => 'Donate';

  @override
  String get app_restart_dialog_title => 'Need restart';

  @override
  String get app_restart_dialog_info => 'Mindful will automatically restart once the countdown finishes. Please be patient as changes are applied.';

  @override
  String get accessibility_tip => 'Want smarter, more battery-friendly blocking? Enable Accessibility permission for Mindful.';

  @override
  String get battery_optimization_tip => 'Mindful not working? Allow \'Ignore Battery Optimization\' in Settings to keep it running smoothly.';

  @override
  String get invincible_mode_tip => 'Accidentally removed restrictions? Use Invincible Mode to lock them until the next day or adjustment window.';

  @override
  String get glance_usage_tip => 'Want insights? Check the Glance section to view your usage patterns and screen time.';

  @override
  String get tamper_protection_tip => 'Uninstalling Mindful? Enable the Uninstall Window to safely disable tamper protection first.';

  @override
  String get notification_blocking_tip => 'Want to reduce distractions? Use Notification Blocking to silence selected apps.';

  @override
  String get usage_history_tip => 'Want to reflect on your habits? Check Usage History to see past patterns.';

  @override
  String get focus_mode_tip => 'Need deep focus? Turn on Focus Mode to block apps and notifications during tasks.';

  @override
  String get bedtime_reminder_tip => 'Want to improve your sleep? Set a Bedtime Reminder to wind down nightly.';

  @override
  String get custom_blocking_tip => 'Need a custom experience? Create app blocking rules that fit your needs.';

  @override
  String get session_timeline_tip => 'Want to track focus sessions? View timeline to see your focus journey.';

  @override
  String get short_content_blocking_tip => 'Distracted by social apps? Block short content on Instagram, YouTube, etc., to stay focused.';

  @override
  String get parental_controls_tip => 'Need parental control? Set restrictions for your child\'s device to ensure a safe experience.';

  @override
  String get notification_batching_tip => 'Want to reduce distractions? Use Notification Batching to group notifications and check them at once.';

  @override
  String get notification_scheduling_tip => 'Need to manage notifications? Schedule when you receive notifications for specific apps.';

  @override
  String get quick_focus_tile_tip => 'Need quick access to focus? Add a Quick Focus Tile to instantly activate Focus Mode.';

  @override
  String get app_shortcuts_tip => 'Want instant app access? Add shortcuts by long-pressing the app icon for quick actions.';

  @override
  String get backup_usage_db_tip => 'Want to save your data? Backup your usage database to keep your records safe.';

  @override
  String get dynamic_material_color_tip => 'Want a custom theme? Enable Dynamic Material You color to match your device\'s theme.';

  @override
  String get amoled_dark_theme_tip => 'Want to save battery? Use AMOLED Dark Theme to reduce power consumption on OLED screens.';

  @override
  String get customize_usage_history_tip => 'Want to keep usage history? Customize how many weeks of data to store in Usage History.';

  @override
  String get grouped_apps_blocking_tip => 'Want to block apps together? Use Restriction Groups to group app limits and block multiple apps at once.';

  @override
  String get websites_blocking_tip => 'Want a cleaner browsing experience? Block custom or NSFW websites for a more focused online time.';

  @override
  String get data_usage_tip => 'Want to track your data? Monitor your mobile and Wi-Fi data usage for internet consumption.';

  @override
  String get block_internet_tip => 'Need to block an app\'s internet? Cut off internet for specific app from app\'s dashboard.';

  @override
  String get emergency_passes_tip => 'Need a break? Use 3 Emergency Passes daily to temporarily unblock apps for 5 minutes.';

  @override
  String get onboarding_skip_btn_label => 'Skip';

  @override
  String get onboarding_finish_setup_btn_label => 'Finish Setup';

  @override
  String get onboarding_page_one_title => 'Master Focus.';

  @override
  String get onboarding_page_one_info => 'Pause distracting apps, block short content, and stay on track with customizable focus sessions. Whether you\'re working, studying, or relaxing, Mindful helps you stay in control.';

  @override
  String get onboarding_page_two_title => 'Block Distractions.';

  @override
  String get onboarding_page_two_info => 'Set usage limits, automatically pause apps, and create healthier digital habits. Use Bedtime Mode to unwind and enjoy a distraction-free night.';

  @override
  String get onboarding_page_three_title => 'Privacy First.';

  @override
  String get onboarding_page_three_info => 'Mindful is 100% open-source and operates entirely offline. We don\'t collect or share your personal data — your privacy is guaranteed in every way.';

  @override
  String get onboarding_page_permissions_title => 'Essential Permissions.';

  @override
  String get onboarding_page_permissions_info => 'Mindful requires following essential permissions to track and manage your screen time, helping reduce distractions and improve focus.';

  @override
  String get dashboard_tab_title => 'Dashboard';

  @override
  String get focus_now_fab_button => 'Focus now';

  @override
  String get welcome_greetings => 'Welcome back,';

  @override
  String get username_snack_alert => 'Long press to edit username.';

  @override
  String get username_dialog_title => 'Username';

  @override
  String get username_dialog_info => 'Enter your username which will be displayed on dashboard.';

  @override
  String get username_dialog_button_apply => 'Apply';

  @override
  String get glance_tile_title => 'Glance';

  @override
  String get glance_tile_subtitle => 'Take a quick glance at your usage.';

  @override
  String get parental_controls_tile_subtitle => 'Invincible mode and tamper protection.';

  @override
  String get restrictions_heading => 'Restrictions';

  @override
  String get apps_blocking_tile_title => 'Apps blocking';

  @override
  String get apps_blocking_tile_subtitle => 'Limit apps in multiple ways.';

  @override
  String get grouped_apps_blocking_tile_title => 'Grouped apps blocking';

  @override
  String get grouped_apps_blocking_tile_subtitle => 'Limit group of apps simultaneously.';

  @override
  String get shorts_blocking_tile_subtitle => 'Limit short content on multiple platforms.';

  @override
  String get websites_blocking_tile_subtitle => 'Limit adult and custom websites.';

  @override
  String get screen_time_label => 'Screen time';

  @override
  String get total_data_label => 'Total data';

  @override
  String get mobile_data_label => 'Mobile data';

  @override
  String get wifi_data_label => 'Wifi data';

  @override
  String get focus_today_label => 'Focus today';

  @override
  String get focus_weekly_label => 'Focus weekly';

  @override
  String get focus_monthly_label => 'Focus monthly';

  @override
  String get focus_lifetime_label => 'Focus lifetime';

  @override
  String get longest_streak_label => 'Longest streak';

  @override
  String get current_streak_label => 'Current streak';

  @override
  String get successful_sessions_label => 'Successful sessions';

  @override
  String get failed_sessions_label => 'Failed sessions';

  @override
  String get statistics_tab_title => 'Statistics';

  @override
  String get screen_segment_label => 'Screen';

  @override
  String get data_segment_label => 'Data';

  @override
  String get mobile_label => 'Mobile';

  @override
  String get wifi_label => 'Wifi';

  @override
  String get most_used_apps_heading => 'Most used apps';

  @override
  String get show_all_apps_tile_title => 'Show all apps';

  @override
  String get search_apps_hint => 'Search apps...';

  @override
  String get notifications_tab_title => 'Notifications';

  @override
  String get notifications_tab_info => 'Batch notification from apps and set schedules like morning, noon, evening and night. Stay updated without constant interruptions.';

  @override
  String get batched_apps_tile_title => 'Batched apps';

  @override
  String get batch_recap_dropdown_title => 'Batch recap type';

  @override
  String get batch_recap_dropdown_info => 'Choose what to push when a schedule triggers — all notifications or just a summary.';

  @override
  String get batch_recap_option_summery_only => 'Summery only';

  @override
  String get batch_recap_option_all_notifications => 'All notifications';

  @override
  String get notification_history_tile_title => 'Notification history';

  @override
  String get store_all_tile_title => 'Store all notifications';

  @override
  String get store_all_tile_subtitle => 'Save non-batched notifications too.';

  @override
  String get schedules_heading => 'Schedules';

  @override
  String get new_schedule_fab_button => 'New Schedule';

  @override
  String get new_schedule_dialog_info => 'Enter a name for the notification schedule to help identify it easily.';

  @override
  String get new_schedule_dialog_field_label => 'Schedule name';

  @override
  String get bedtime_tab_title => 'Bedtime';

  @override
  String get bedtime_tab_info => 'Set your bedtime schedule by selecting a time period and days of the week. Choose distracting apps to block and enable Do Not Disturb (DND) mode for a peaceful night.';

  @override
  String get schedule_tile_title => 'Schedule';

  @override
  String get schedule_tile_subtitle => 'Enable or disable daily schedule.';

  @override
  String get bedtime_no_days_selected_snack_alert => 'Select at least one day of the week.';

  @override
  String get bedtime_minimum_duration_snack_alert => 'The total bedtime duration must be at least 30 minutes.';

  @override
  String get distracting_apps_tile_title => 'Distracting apps';

  @override
  String get distracting_apps_tile_subtitle => 'Select which apps are distracting you from your bedtime routine.';

  @override
  String get bedtime_distracting_apps_modify_snack_alert => 'Modifications to the list of distracting apps is not permitted while the bedtime schedule is active.';

  @override
  String get parental_controls_tab_title => 'Parental controls';

  @override
  String get invincible_mode_heading => 'Invincible mode';

  @override
  String get invincible_mode_tile_title => 'Activate invincible mode';

  @override
  String get invincible_mode_info => 'When Invincible Mode is on, you won\'t be able to adjust selected limits after reaching your daily quota. However, you can make changes within a selected 10-minute invincible window.';

  @override
  String get invincible_mode_snack_alert => 'Due to invincible mode, modifications to restrictions is not allowed.';

  @override
  String get invincible_mode_dialog_info => 'Are you absolutely sure you want to enable Invincible Mode? This action is irreversible. Once Invincible Mode is turned on, you cannot turn it off as long as this app is installed on your device.';

  @override
  String get invincible_mode_turn_off_snack_alert => 'Invincible Mode cannot be turned off as long as this app remains installed on your device.';

  @override
  String get invincible_mode_dialog_button_start_anyway => 'Start anyway';

  @override
  String get invincible_mode_include_timer_tile_title => 'Include timer';

  @override
  String get invincible_mode_include_launch_limit_tile_title => 'Include launch limit';

  @override
  String get invincible_mode_include_active_period_tile_title => 'Include active period';

  @override
  String get invincible_mode_app_restrictions_tile_title => 'App restrictions';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle => 'Prevent changes to the app\'s selected restrictions once the daily limits are exceeded.';

  @override
  String get invincible_mode_group_restrictions_tile_title => 'Group restrictions';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle => 'Prevent changes to the group\'s selected restrictions once the daily limits are exceeded.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title => 'Include shorts timer';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle => 'Prevents changes after reaching your daily shorts limit.';

  @override
  String get invincible_mode_include_bedtime_tile_title => 'Include bedtime';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle => 'Prevents changes during the active bedtime schedule.';

  @override
  String get protected_access_tile_title => 'Protected access';

  @override
  String get protected_access_tile_subtitle => 'Protect Mindful with your device lock.';

  @override
  String get protected_access_no_lock_snack_alert => 'Please set up a biometric lock on your device first to enable this feature.';

  @override
  String get protected_access_removed_lock_snack_alert => 'Your device lock has been removed. To continue, please set up a new lock.';

  @override
  String get protected_access_failed_lock_snack_alert => 'Authentication failed. You need to verify your device lock to proceed.';

  @override
  String get tamper_protection_tile_title => 'Tamper protection';

  @override
  String get tamper_protection_tile_subtitle => 'Prevent uninstalling and force stopping the app.';

  @override
  String get tamper_protection_confirmation_dialog_info => 'Once enabled, you won\'t be able to uninstall, force stop, or clear Mindful\'s data, except during the selected uninstall window. There are no workarounds.\n\nProceed at your own risk.';

  @override
  String get uninstall_window_tile_title => 'Uninstall window';

  @override
  String get uninstall_window_tile_subtitle => 'Tamper protection can be disabled within 10 minutes from the selected time.';

  @override
  String get invincible_window_tile_title => 'Invincible window';

  @override
  String get invincible_window_tile_subtitle => 'Selected limits can be modified within 10 minutes from the selected time.';

  @override
  String get shorts_blocking_tab_title => 'Shorts blocking';

  @override
  String get shorts_blocking_tab_info => 'Control how much time you spend on short content across platforms like Instagram, YouTube, Snapchat, and Facebook, including their websites.';

  @override
  String get short_content_heading => 'Short content';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Left from $timeShortString';
  }

  @override
  String get short_content_timer_picker_dialog_info => 'Set a daily time limit for short content. Once your limit is reached, the short content will be paused until midnight.';

  @override
  String get instagram_features_tile_title => 'Instagram';

  @override
  String get instagram_features_tile_subtitle => 'Restrict features on instagram.';

  @override
  String get instagram_features_block_reels => 'Restrict reels section.';

  @override
  String get instagram_features_block_explore => 'Restrict explore section.';

  @override
  String get snapchat_features_tile_title => 'Snapchat';

  @override
  String get snapchat_features_tile_subtitle => 'Restrict features on snapchat.';

  @override
  String get snapchat_features_block_spotlight => 'Restrict spotlight section.';

  @override
  String get snapchat_features_block_discover => 'Restrict discover section.';

  @override
  String get youtube_features_tile_title => 'Youtube';

  @override
  String get youtube_features_tile_subtitle => 'Restrict shorts on youtube.';

  @override
  String get facebook_features_tile_title => 'Facebook';

  @override
  String get facebook_features_tile_subtitle => 'Restrict reels on facebook.';

  @override
  String get reddit_features_tile_title => 'Reddit';

  @override
  String get reddit_features_tile_subtitle => 'Restrict shorts on reddit.';

  @override
  String get websites_blocking_tab_title => 'Websites blocking';

  @override
  String get websites_blocking_tab_info => 'Block adult websites and any custom sites you choose to create a safer and more focused online experience. Take charge of your browsing and stay distraction-free.';

  @override
  String get adult_content_heading => 'Adult content';

  @override
  String get block_nsfw_title => 'Block Nsfw';

  @override
  String get block_nsfw_subtitle => 'Restrict browsers from opening adult and porn websites.';

  @override
  String get block_nsfw_dialog_info => 'Are you sure? This action is irreversible. Once adult sites blocker is turned ON, you cannot turn it OFF as long as this app is installed on your device.';

  @override
  String get block_nsfw_dialog_button_block_anyway => 'Block anyway';

  @override
  String get blocked_websites_heading => 'Blocked websites';

  @override
  String get blocked_websites_empty_list_hint => 'Click on \'+ Add Website\' button to add distracting websites which you wish to block.';

  @override
  String get add_website_fab_button => 'Add Website';

  @override
  String get add_website_dialog_title => 'Distracting website';

  @override
  String get add_website_dialog_info => 'Enter url of a website which you want to block.';

  @override
  String get add_website_dialog_is_nsfw => 'Is nsfw site?';

  @override
  String get add_website_dialog_nsfw_warning => 'Warning: Nsfw sites cannot be removed once added.';

  @override
  String get add_website_dialog_button_block => 'Block';

  @override
  String get add_website_already_exist_snack_alert => 'The URL has already been added to the list of blocked websites.';

  @override
  String get add_website_invalid_url_snack_alert => 'Invalid URL! Unable to parse the host name.';

  @override
  String get remove_website_dialog_title => 'Remove website';

  @override
  String remove_website_dialog_info(String websitehost) {
    return 'Are you sure? you want to remove \'$websitehost\' from blocked websites.';
  }

  @override
  String get focus_tab_title => 'Focus';

  @override
  String get focus_tab_info => 'When you need time to focus, start a new session by selecting the type, choosing distracting apps to pause, and enabling Do Not Disturb for uninterrupted concentration.';

  @override
  String get active_session_card_title => 'Active session';

  @override
  String get active_session_card_info => 'You have an active focus session running! Click \'View\' to check your progress and see how much time has elapsed.';

  @override
  String get active_session_card_view_button => 'View';

  @override
  String get focus_distracting_apps_removal_snack_alert => 'Removal of apps from the distracting apps list is not permitted while a Focus Session is active. However, you may still add additional apps to the list during this time.';

  @override
  String get focus_profile_tile_title => 'Focus profile';

  @override
  String get focus_session_duration_tile_title => 'Session duration';

  @override
  String get focus_session_duration_tile_subtitle => 'Infinite (unless you stop)';

  @override
  String get focus_session_duration_dialog_info => 'Please select the desired duration for this focus session, determining how long you wish to remain focused and distraction-free.';

  @override
  String get focus_profile_customization_tile_title => 'Profile customization';

  @override
  String get focus_profile_customization_tile_subtitle => 'Customize settings for the selected profile.';

  @override
  String get focus_enforce_tile_title => 'Enforce session';

  @override
  String get focus_enforce_tile_subtitle => 'Prevents ending a session before time ends.';

  @override
  String get focus_session_start_fab_button => 'Start Session';

  @override
  String get focus_session_minimum_apps_snack_alert => 'Select at least one distracting app to start focus session';

  @override
  String get focus_session_already_active_snack_alert => 'You already have an active focus session running. Please complete or stop your current session before starting a new one.';

  @override
  String get focus_session_type_study => 'Study';

  @override
  String get focus_session_type_work => 'Work';

  @override
  String get focus_session_type_exercise => 'Exercise';

  @override
  String get focus_session_type_meditation => 'Meditation';

  @override
  String get focus_session_type_creativeWriting => 'Creative Writing';

  @override
  String get focus_session_type_reading => 'Reading';

  @override
  String get focus_session_type_programming => 'Programming';

  @override
  String get focus_session_type_chores => 'Chores';

  @override
  String get focus_session_type_projectPlanning => 'Project Planning';

  @override
  String get focus_session_type_artAndDesign => 'Art and Design';

  @override
  String get focus_session_type_languageLearning => 'Language Learning';

  @override
  String get focus_session_type_musicPractice => 'Music Practice';

  @override
  String get focus_session_type_selfCare => 'Self Care';

  @override
  String get focus_session_type_brainstorming => 'Brainstorming';

  @override
  String get focus_session_type_skillDevelopment => 'Skill Development';

  @override
  String get focus_session_type_research => 'Research';

  @override
  String get focus_session_type_networking => 'Networking';

  @override
  String get focus_session_type_cooking => 'Cooking';

  @override
  String get focus_session_type_sportsTraining => 'Sports Training';

  @override
  String get focus_session_type_restAndRelaxation => 'Rest and Relaxation';

  @override
  String get focus_session_type_other => 'Other';

  @override
  String get timeline_tab_title => 'Timeline';

  @override
  String get focus_timeline_tab_info => 'Explore your focus journey by selecting a date from the calendar. Track your progress, revisit your successes, and learn from the challenges.';

  @override
  String selected_month_productive_time_snack_alert(String timeString) {
    return 'Your total productive time for the selected month is $timeString.';
  }

  @override
  String get selected_month_productive_days_label => 'Productive days';

  @override
  String selected_month_productive_days_snack_alert(num daysCount) {
    return 'You\'ve had a total of $daysCount productive days in the selected month.';
  }

  @override
  String get selected_day_focused_time_label => 'Focused time';

  @override
  String selected_day_focused_time_snack_alert(String timeString) {
    return 'Your total focused time for the selected day is $timeString.';
  }

  @override
  String get calender_heading => 'Calender';

  @override
  String get your_sessions_heading => 'Your sessions';

  @override
  String get your_sessions_empty_list_hint => 'No focus sessions recorded for the selected day.';

  @override
  String get focus_session_tile_timestamp_label => 'Timestamp';

  @override
  String get focus_session_tile_duration_label => 'Duration';

  @override
  String get focus_session_tile_reflection_label => 'Reflection';

  @override
  String get focus_session_state_active => 'Active';

  @override
  String get focus_session_state_successful => 'Successful';

  @override
  String get focus_session_state_failed => 'Failed';

  @override
  String get active_session_tab_title => 'Session';

  @override
  String get active_session_none_warning => 'No active session found. Returning to the home screen.';

  @override
  String get active_session_dialog_button_keep_pushing => 'Keep pushing';

  @override
  String get active_session_finish_dialog_title => 'Finish';

  @override
  String get active_session_finish_dialog_info => 'Stay strong! You\'re building valuable focus. Are you sure you want to end this focus session? Every extra moment counts toward your goals.';

  @override
  String get active_session_giveup_dialog_title => 'Give up';

  @override
  String get active_session_giveup_dialog_info => 'Hold on! You\'re almost there don\'t give up now! Are you sure you want to end this focus session early? Progress will be lost.';

  @override
  String get active_session_reflection_dialog_title => 'Session reflection';

  @override
  String get active_session_reflection_dialog_info => 'Take a moment to reflect on your progress. What\'s your goal for this session? What did you accomplish during this session?';

  @override
  String get active_session_reflection_dialog_tip => 'Tip: You can always edit this later in the session timeline.';

  @override
  String get active_session_giveup_snack_alert => 'You gave up! Don\'t worry, you can do better next time. Every effort counts - just keep going';

  @override
  String get active_session_quote_one => 'Every step counts, stay strong and keep going';

  @override
  String get active_session_quote_two => 'Stay focused! you\'re making amazing progress';

  @override
  String get active_session_quote_three => 'You\'re crushing it! Keep the momentum going';

  @override
  String get active_session_quote_four => 'Just a little more to go, you\'re doing fantastic';

  @override
  String active_session_quote_five(String durationString) {
    return 'Congratulations 🎉 \n You\'ve completed your focus session of $durationString.\n\nGreat job, keep up the amazing work';
  }

  @override
  String get restriction_groups_tab_title => 'Restriction groups';

  @override
  String get restriction_groups_tab_info => 'Set a combined screen time limit for a group of apps. Once the total usage reaches your limit, all apps in the group will be paused to help maintain focus and balance.';

  @override
  String get restriction_group_time_spent_label => 'Time spent today';

  @override
  String get restriction_group_time_left_label => 'Time left today';

  @override
  String get restriction_group_name_tile_title => 'Group name';

  @override
  String get restriction_group_name_picker_dialog_info => 'Enter a name for the restriction group to help identify and manage it easily.';

  @override
  String get restriction_group_timer_tile_title => 'Group timer';

  @override
  String get restriction_group_timer_picker_dialog_info => 'Set a daily time limit for this group. Once your limit is reached, all the apps in this group will be paused until midnight.';

  @override
  String get restriction_group_active_period_tile_title => 'Group active period';

  @override
  String get remove_restriction_group_dialog_title => 'Remove group';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return 'Are you sure? you want to remove \'$groupName\' from restriction groups.';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert => 'Set either a timer or an active period limit.';

  @override
  String get notifications_empty_list_hint => 'No notifications have been batched for the day.';

  @override
  String get conversations_label => 'Conversations';

  @override
  String get last_24_hours_heading => 'Last 24 hours';

  @override
  String get notification_timeline_tab_info => 'Browse your notification history by selecting a date from the calendar. See which apps grabbed your attention and reflect on your digital habits.';

  @override
  String get monthly_label => 'Monthly';

  @override
  String get daily_label => 'Daily';

  @override
  String get search_notifications_sheet_info => 'Easily find past notifications by searching through their title or content. Helps you quickly locate important alerts.';

  @override
  String get search_notifications_hint => 'Search notifications...';

  @override
  String get app_info_none_warning => 'Couldn\'t find the app for the given package. Returning to the home screen.';

  @override
  String get emergency_fab_button => 'Emergency';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return 'This action will pause the app blocker for next 5 minutes. You have $leftPassesCount passes left. After using all passes, the app will stay blocked until midnight, or the active focus session ends.\n\nDo you still wish to proceed?';
  }

  @override
  String get emergency_dialog_button_use_anyway => 'Use anyway';

  @override
  String get emergency_started_snack_alert => 'The app blocker is paused and will resume blocking in 5 minutes.';

  @override
  String get emergency_already_active_snack_alert => 'The app blocker is currently either paused or inactive. If notifications are enabled, you will receive updates regarding the remaining time.';

  @override
  String get emergency_no_pass_left_snack_alert => 'You have used all your emergency passes. The blocked apps will stay blocked until midnight, or the active focus session ends.';

  @override
  String get app_limit_status_not_set => 'Not set';

  @override
  String get app_timer_tile_title => 'App timer';

  @override
  String get app_timer_picker_dialog_info => 'Set a daily time limit for this app. Once your limit is reached, the app will be paused until midnight.';

  @override
  String get app_launch_limit_tile_title => 'Launch limit';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Launched $count times today.';
  }

  @override
  String get app_launch_limit_picker_dialog_info => 'Set how many times you can open this app each day. Once the limit is reached, it will be paused until midnight.';

  @override
  String get app_active_period_tile_title => 'Active period';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return 'From $startTime to $endTime';
  }

  @override
  String get internet_access_tile_title => 'Internet access';

  @override
  String get internet_access_tile_subtitle => 'Switch off to block app\'s internet.';

  @override
  String internet_access_blocked_snack_alert(String appName) {
    return '$appName\'s internet is blocked.';
  }

  @override
  String internet_access_unblocked_snack_alert(String appName) {
    return '$appName\'s internet is unblocked.';
  }

  @override
  String get launch_app_tile_title => 'Launch app';

  @override
  String launch_app_tile_subtitle(String appName) {
    return 'Open $appName.';
  }

  @override
  String get go_to_app_settings_tile_title => 'Go to app settings';

  @override
  String get go_to_app_settings_tile_subtitle => 'Manage app settings like notifications, permissions, storage and more.';

  @override
  String get include_in_stats_tile_title => 'Include in screen usage';

  @override
  String get include_in_stats_tile_subtitle => 'Switch off to exclude this app from total screen usage.';

  @override
  String app_excluded_from_stats_snack_alert(String appName) {
    return '$appName is excluded from total screen usage.';
  }

  @override
  String app_include_to_stats_snack_alert(String appName) {
    return '$appName is included to total screen usage.';
  }

  @override
  String get general_tab_title => 'General';

  @override
  String get appearance_heading => 'Appearance';

  @override
  String get theme_mode_tile_title => 'Theme mode';

  @override
  String get theme_mode_system_label => 'System';

  @override
  String get theme_mode_light_label => 'Light';

  @override
  String get theme_mode_dark_label => 'Dark';

  @override
  String get material_color_tile_title => 'Material color';

  @override
  String get amoled_dark_tile_title => 'AMOLED dark';

  @override
  String get amoled_dark_tile_subtitle => 'Use pure black color for the dark theme.';

  @override
  String get dynamic_colors_tile_title => 'Dynamic colors';

  @override
  String get dynamic_colors_tile_subtitle => 'Use device colors if supported.';

  @override
  String get defaults_heading => 'Defaults';

  @override
  String get app_language_tile_title => 'App language';

  @override
  String get default_home_tab_tile_title => 'Home tab';

  @override
  String get usage_history_tile_title => 'Usage history';

  @override
  String get usage_history_15_days => '15 days';

  @override
  String get usage_history_1_month => '1 month';

  @override
  String get usage_history_3_month => '3 months';

  @override
  String get usage_history_6_month => '6 months';

  @override
  String get usage_history_1_year => '1 year';

  @override
  String get service_heading => 'Service';

  @override
  String get service_stopping_warning => 'If Mindful stops working unexpectedly, please grant the \'Ignore Battery Optimization\' permission to keep it running in the background. If the issue continues, try whitelisting Mindful for uninterrupted performance.';

  @override
  String get whitelist_app_tile_title => 'Whitelist Mindful';

  @override
  String get whitelist_app_tile_subtitle => 'Allow Mindful to auto start.';

  @override
  String get whitelist_app_unsupported_snack_alert => 'This device does not support automatic startup management.';

  @override
  String get database_tab_title => 'Database';

  @override
  String get import_db_tile_title => 'Import database';

  @override
  String get import_db_tile_subtitle => 'Import database from a file.';

  @override
  String get export_db_tile_title => 'Export database';

  @override
  String get export_db_tile_subtitle => 'Export database to a file.';

  @override
  String get crash_logs_heading => 'Crash logs';

  @override
  String get crash_logs_info => 'If you encounter any issue, you can report it on GitHub along with the log file. The file will include details such as your device\'s manufacturer, model, Android version, SDK version, and crash logs. This information will help us identify and resolve the problem more effectively.';

  @override
  String get crash_logs_export_tile_title => 'Export crash logs';

  @override
  String get crash_logs_export_tile_subtitle => 'Export crash logs to a json file.';

  @override
  String get crash_logs_view_tile_title => 'View logs';

  @override
  String get crash_logs_view_tile_subtitle => 'Explore stored crash logs.';

  @override
  String get crash_logs_empty_list_hint => 'No crash logged till now.';

  @override
  String get crash_logs_clear_tile_title => 'Clear logs';

  @override
  String get crash_logs_clear_tile_subtitle => 'Delete all crash logs from database.';

  @override
  String get crash_logs_clear_dialog_info => 'Are you sure you wish to clear all crash logs from the database?';

  @override
  String get crash_logs_clear_dialog_button_clear_anyway => 'Clear anyway';

  @override
  String get about_tab_title => 'About';

  @override
  String get changelog_tile_title => 'Changelog';

  @override
  String get changelog_tile_subtitle => 'Find out what\'s new.';

  @override
  String get full_changelog_tile_title => 'Full changelog';

  @override
  String get redirected_to_github_subtitle => 'You will be redirected to GitHub.';

  @override
  String get contribute_heading => 'Contribute';

  @override
  String get github_tile_title => 'GitHub';

  @override
  String get github_tile_subtitle => 'View the source code.';

  @override
  String get report_issue_tile_title => 'Report an issue';

  @override
  String get suggest_idea_tile_title => 'Suggest an idea';

  @override
  String get write_email_tile_title => 'Write to us via email';

  @override
  String get write_email_tile_subtitle => 'You will be redirected to Email app.';

  @override
  String get privacy_policy_heading => 'Privacy policy';

  @override
  String get privacy_policy_info => 'Mindful is committed to protecting your privacy. We do not collect, store, or transfer any type of user data. The app operates entirely offline and does not require an internet connection, ensuring that your personal information remains private and secure on your device. As a Free and Open Source Software (FOSS) application, Mindful guarantees complete transparency and user control over their data.';

  @override
  String get more_details_button => 'More details';
}
