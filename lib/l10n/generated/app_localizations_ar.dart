// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get mindful_tagline => 'التركيز على ما هو مهم حقًا';

  @override
  String get unlock_button_label => 'فتح';

  @override
  String get permission_status_off => 'إيقاف';

  @override
  String get permission_status_allowed => 'مسموح';

  @override
  String get permission_status_not_allowed => 'غير مسموح';

  @override
  String get permission_button_grant_permission => 'منح الإذن';

  @override
  String get permission_button_agree_and_continue => 'موافق ومتابعة';

  @override
  String get permission_button_not_now => 'ليس الآن';

  @override
  String get permission_button_help => 'مساعدة؟';

  @override
  String get permission_sheet_privacy_info =>
      'تطبيق Mindful آمن بنسبة ١٠٠% ويعمل دون اتصال بالإنترنت. ولا نقوم بجمع أو تخزين أي بيانات شخصية.';

  @override
  String permission_grant_step_one(String button_label) {
    return '١. انقر على زر $button_label.';
  }

  @override
  String get permission_grant_step_two => '٢. حدد Mindful في الشاشة التالية.';

  @override
  String get permission_grant_step_three =>
      '٣. انقر فوق المفتاح وقم بتشغيله كما هو موضح أدناه.';

  @override
  String get permission_notification_title => 'إرسال الإشعارات';

  @override
  String get permission_alarms_title => 'التنبيهات والتذكيرات';

  @override
  String get permission_alarms_info =>
      'يرجى منح الإذن لضبط التنبيهات والتذكيرات. سيسمح هذا لتطبيق Mindful ببدء جدول وقت النوم في الوقت المحدد وإعادة ضبط مؤقتات التطبيق يوميًا عند منتصف الليل ومساعدتك على البقاء على المسار الصحيح.';

  @override
  String get permission_alarms_device_tile_label =>
      'السماح بإعداد التنبيهات والتذكيرات';

  @override
  String get permission_usage_title => 'الوصول إلى الاستخدام';

  @override
  String get permission_usage_info =>
      'يرجى منح إذن الوصول إلى الاستخدام. سيسمح هذا لـ Mindful بمراقبة استخدام التطبيق وإدارة الوصول إلى تطبيقات معينة، مما يضمن بيئة رقمية أكثر تركيزًا وتحكمًا.';

  @override
  String get permission_usage_device_tile_label =>
      'السماح بالوصول إلى الاستخدام';

  @override
  String get permission_overlay_title => 'عرض التراكب';

  @override
  String get permission_overlay_info =>
      'يرجى منح إذن عرض التراكب. سيسمح هذا لتطبيق Mindful بعرض تراكب عند فتح تطبيق متوقف مؤقتًا، مما يساعدك على البقاء مركزًا والالتزام بجدولك الزمني.';

  @override
  String get permission_overlay_device_tile_label =>
      'السماح بالعرض على التطبيقات الأخرى';

  @override
  String get permission_accessibility_title => 'إمكانية الوصول';

  @override
  String get permission_accessibility_info =>
      'يرجى منح إذن الوصول. سيسمح هذا لشركة Mindful بتقييد الوصول إلى محتوى الفيديو القصير (مثل Reels وShorts) داخل تطبيقات الوسائط الاجتماعية والمتصفحات، وتصفية المواقع الإلكترونية غير المناسبة.';

  @override
  String get permission_accessibility_required =>
      'Mindful requires accessibility permission to block short content and websites effectively.';

  @override
  String get permission_accessibility_device_tile_label => 'استخدم Mindful';

  @override
  String get permission_dnd_title => 'عدم الإزعاج';

  @override
  String get permission_dnd_info =>
      'يرجى منح ميزة \"عدم الإزعاج\" حق الوصول. سيسمح هذا لتطبيق Mindful ببدء وإيقاف وضع \"عدم الإزعاج\" أثناء جدول وقت النوم.';

  @override
  String get permission_dnd_tile_title => 'ابدأ عدم الإزعاج';

  @override
  String get permission_dnd_tile_subtitle => 'قم أيضًا بتمكين وضع عدم الإزعاج.';

  @override
  String get permission_battery_optimization_tile_title =>
      'تجاهل تحسين البطارية';

  @override
  String get permission_battery_optimization_status_enabled =>
      'غير مقيد بالفعل';

  @override
  String get permission_battery_optimization_status_disabled =>
      'تعطيل تقييد الخلفية';

  @override
  String get permission_battery_optimization_allow_info =>
      'سيؤدي السماح بـ \"تجاهل تحسين البطارية\" إلى منح إذن \"التنبيهات والتذكيرات\" تلقائيًا على بعض الأجهزة';

  @override
  String get permission_vpn_title => 'إنشاء VPN';

  @override
  String get permission_vpn_info =>
      'يرجى منح الإذن لإنشاء اتصال بشبكة خاصة افتراضية (VPN). سيسمح هذا لـ Mindful بتقييد الوصول إلى الإنترنت للتطبيقات المحددة من خلال إنشاء شبكة VPN محلية على الجهاز.';

  @override
  String get permission_admin_title => 'مسؤول';

  @override
  String get permission_admin_info =>
      'تكون الامتيازات الإدارية ضرورية فقط للعمليات الأساسية لضمان عمل التطبيق بشكل صحيح وبقائه مقاومًا للتلاعب.';

  @override
  String get permission_admin_snack_alert =>
      'لا يمكن تعطيل الحماية من العبث إلا خلال فترة زمنية محددة.';

  @override
  String get permission_notification_access_title => 'الوصول إلى الإشعارات';

  @override
  String get permission_notification_access_info =>
      'يرجى منح إذن الوصول إلى الإشعارات. سيسمح هذا لـ Mindful بتنظيم إشعاراتك وتسليمها حسب جدولك.';

  @override
  String get permission_notification_access_required =>
      'يتطلب Mindful الوصول إلى الإشعارات للدفعات والإشعارات المجدولة.';

  @override
  String get permission_notification_access_device_tile_label =>
      'السماح بالوصول إلى الإشعارات';

  @override
  String get day_today => 'اليوم';

  @override
  String get day_yesterday => 'أمس';

  @override
  String nDays(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString أيام',
      one: 'يوم واحد',
      zero: '٠ يوم',
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
      other: '$countString ساعات',
      one: 'ساعة واحدة',
      zero: '٠ ساعة',
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
      other: '$countString دقائق',
      one: 'دقيقة واحدة',
      zero: '٠ دقيقة',
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
      other: '$countString ثواني',
      one: 'ثانية واحدة',
      zero: '٩ ثانية',
    );
    return '$_temp0';
  }

  @override
  String get time_separator_and => 'و';

  @override
  String get timer_status_active => 'نشيط';

  @override
  String get timer_status_paused => 'متوقف مؤقتا';

  @override
  String get create_button => 'إنشاء';

  @override
  String get update_button => 'تحديث';

  @override
  String get dialog_button_cancel => 'إلغاء';

  @override
  String get dialog_button_remove => 'حذف';

  @override
  String get dialog_button_set => 'تعيين';

  @override
  String get dialog_button_reset => 'إعادة ضبط';

  @override
  String get dialog_button_infinite => 'لانهائي';

  @override
  String get schedule_start_label => 'يبدأ';

  @override
  String get schedule_end_label => 'نهاية';

  @override
  String get exit_without_saving_dialog_info =>
      'Are you sure you want to exit without saving?';

  @override
  String get development_dialog_info =>
      'تطبيق Mindful قيد التطوير حاليًا وقد يحتوي على أخطاء أو ميزات غير مكتملة. إذا واجهت أي مشكلات، فيرجى الإبلاغ عنها لمساعدتنا على التحسين.\n\nشكرًا لك على ملاحظاتك!';

  @override
  String get development_dialog_button_report_issue => 'الإبلاغ عن المشكلة';

  @override
  String get development_dialog_button_close => 'غلق';

  @override
  String get dnd_settings_tile_title => 'إعدادات عدم الإزعاج';

  @override
  String get dnd_settings_tile_subtitle =>
      'إدارة التطبيقات والإشعارات التي يمكنها الوصول إليك في وضع عدم الإزعاج.';

  @override
  String get quick_actions_heading => 'الإجراءات السريعة';

  @override
  String get select_distracting_apps_heading =>
      'حدد التطبيقات المشتتة للانتباه';

  @override
  String get your_distracting_apps_heading => 'تطبيقاتك المشتتة للانتباه';

  @override
  String get select_more_apps_heading => 'حدد المزيد من التطبيقات';

  @override
  String get imp_distracting_apps_snack_alert =>
      'لا يُسمح بإضافة تطبيقات النظام المهمة إلى قائمة التطبيقات المشتتة للانتباه.';

  @override
  String get custom_apps_quick_actions_unavailable_warning =>
      'لا يتوفر استخدام الشاشة والقيود لهذا التطبيق. في الوقت الحالي، يمكن الوصول إلى استخدام الشبكة فقط';

  @override
  String get create_group_fab_button => 'إنشاء مجموعة';

  @override
  String get active_period_info =>
      'حدد مدّة زمنية يُسمح خلالها بالوصول. وخارج هذه المدّة الزمنية، سيتم تقييد الوصول.';

  @override
  String get minimum_distracting_apps_snack_alert =>
      'حدد تطبيقًا واحدًا علي الأقل يشتت انتباهك.';

  @override
  String get donation_card_title => 'ادعمنا';

  @override
  String get donation_card_info =>
      'Mindful هو تطبيق مجاني ومفتوح المصدر، تم تطويره بعد شهور من التفاني. إذا ساعدك التطبيق، فإن تبرعك يعني الكثير بالنسبة لنا. تساعدنا كل مساهمة في تحسينه وصيانته من أجل الجميع.';

  @override
  String get operation_failed_snack_alert => 'فشلت العملية، حدث خطأ ما!';

  @override
  String get donation_card_button_donate => 'تبرع';

  @override
  String get app_restart_dialog_title => 'بحاجة لإعادة التشغيل';

  @override
  String get app_restart_dialog_info =>
      'سيتم إعادة تشغيل Mindful تلقائيًا بمجرد انتهاء العد التنازلي. يرجى التحلي بالصبر أثناء تطبيق التغييرات.';

  @override
  String get accessibility_tip =>
      'Want smarter, more battery-friendly blocking? Enable Accessibility permission for Mindful.';

  @override
  String get battery_optimization_tip =>
      'Mindful not working? Allow \'Ignore Battery Optimization\' in Settings to keep it running smoothly.';

  @override
  String get invincible_mode_tip =>
      'Accidentally removed restrictions? Use Invincible Mode to lock them until the next day or adjustment window.';

  @override
  String get glance_usage_tip =>
      'Want insights? Check the Glance section to view your usage patterns and screen time.';

  @override
  String get tamper_protection_tip =>
      'Uninstalling Mindful? Enable the Uninstall Window to safely disable tamper protection first.';

  @override
  String get notification_blocking_tip =>
      'Want to reduce distractions? Use Notification Blocking to silence selected apps.';

  @override
  String get usage_history_tip =>
      'Want to reflect on your habits? Check Usage History to see past patterns.';

  @override
  String get focus_mode_tip =>
      'Need deep focus? Turn on Focus Mode to block apps and notifications during tasks.';

  @override
  String get bedtime_reminder_tip =>
      'Want to improve your sleep? Set a Bedtime Reminder to wind down nightly.';

  @override
  String get custom_blocking_tip =>
      'Need a custom experience? Create app blocking rules that fit your needs.';

  @override
  String get session_timeline_tip =>
      'Want to track focus sessions? View timeline to see your focus journey.';

  @override
  String get short_content_blocking_tip =>
      'Distracted by social apps? Block short content on Instagram, YouTube, etc., to stay focused.';

  @override
  String get parental_controls_tip =>
      'Need parental control? Set restrictions for your child\'s device to ensure a safe experience.';

  @override
  String get notification_batching_tip =>
      'Want to reduce distractions? Use Notification Batching to group notifications and check them at once.';

  @override
  String get notification_scheduling_tip =>
      'Need to manage notifications? Schedule when you receive notifications for specific apps.';

  @override
  String get quick_focus_tile_tip =>
      'Need quick access to focus? Add a Quick Focus Tile to instantly activate Focus Mode.';

  @override
  String get app_shortcuts_tip =>
      'Want instant app access? Add shortcuts by long-pressing the app icon for quick actions.';

  @override
  String get backup_usage_db_tip =>
      'Want to save your data? Backup your usage database to keep your records safe.';

  @override
  String get dynamic_material_color_tip =>
      'Want a custom theme? Enable Dynamic Material You color to match your device\'s theme.';

  @override
  String get amoled_dark_theme_tip =>
      'Want to save battery? Use AMOLED Dark Theme to reduce power consumption on OLED screens.';

  @override
  String get customize_usage_history_tip =>
      'Want to keep usage history? Customize how many weeks of data to store in Usage History.';

  @override
  String get grouped_apps_blocking_tip =>
      'Want to block apps together? Use Restriction Groups to group app limits and block multiple apps at once.';

  @override
  String get websites_blocking_tip =>
      'Want a cleaner browsing experience? Block custom or NSFW websites for a more focused online time.';

  @override
  String get data_usage_tip =>
      'Want to track your data? Monitor your mobile and Wi-Fi data usage for internet consumption.';

  @override
  String get block_internet_tip =>
      'Need to block an app\'s internet? Cut off internet for specific app from app\'s dashboard.';

  @override
  String get emergency_passes_tip =>
      'Need a break? Use 3 Emergency Passes daily to temporarily unblock apps for 5 minutes.';

  @override
  String get onboarding_skip_btn_label => 'تخطي';

  @override
  String get onboarding_finish_setup_btn_label => 'إنهاء الإعداد';

  @override
  String get onboarding_page_one_title => 'التركيز المتقن.';

  @override
  String get onboarding_page_one_info =>
      'قم بإيقاف التطبيقات المشتتة للانتباه مؤقتًا، وحظر المحتوى القصير، والتزم بالمسار الصحيح من خلال جلسات التركيز القابلة للتخصيص. سواء كنت تعمل أو تدرس أو تسترخي، يساعدك Mindful على البقاء متحكمًا.';

  @override
  String get onboarding_page_two_title => 'منع التشتيتات.';

  @override
  String get onboarding_page_two_info =>
      'قم بتعيين حدود الاستخدام وإيقاف التطبيقات تلقائيًا وإنشاء عادات رقمية أكثر صحة. استخدم وضع وقت النوم للاسترخاء والاستمتاع بليلة خالية من التشتيت.';

  @override
  String get onboarding_page_three_title => 'الخصوصية أولاً.';

  @override
  String get onboarding_page_three_info =>
      'Mindful هو تطبيق مفتوح المصدر بنسبة ١٠٠% ويعمل دون اتصال بالإنترنت بالكامل. نحن لا نجمع أو نشارك بياناتك الشخصية — خصوصيتك مضمونة بكل الطرق.';

  @override
  String get onboarding_page_permissions_title => 'الأذونات الأساسية.';

  @override
  String get onboarding_page_permissions_info =>
      'يتطلب Mindful اتباع الأذونات الأساسية لتتبع وإدارة وقت الشاشة، مما يساعد على تقليل عوامل التشتيت وتحسين التركيز.';

  @override
  String get dashboard_tab_title => 'لوحة التحكم';

  @override
  String get focus_now_fab_button => 'Focus now';

  @override
  String get welcome_greetings => 'مرحبًا بعودتك،';

  @override
  String get username_snack_alert => 'اضغط لفترة طويلة لتعديل أسم المستخدم.';

  @override
  String get username_dialog_title => 'أسم المستخدم';

  @override
  String get username_dialog_info =>
      'أدخل أسم المستخدم الخاص بك والذي سيتم عرضه على لوحة التحكم.';

  @override
  String get username_dialog_button_apply => 'تطبيق';

  @override
  String get glance_tile_title => 'Glance';

  @override
  String get glance_tile_subtitle => 'Take a quick glance at your usage.';

  @override
  String get parental_controls_tile_subtitle =>
      'Invincible mode and tamper protection.';

  @override
  String get restrictions_heading => 'Restrictions';

  @override
  String get apps_blocking_tile_title => 'Apps blocking';

  @override
  String get apps_blocking_tile_subtitle => 'Limit apps in multiple ways.';

  @override
  String get grouped_apps_blocking_tile_title => 'Grouped apps blocking';

  @override
  String get grouped_apps_blocking_tile_subtitle =>
      'Limit group of apps simultaneously.';

  @override
  String get shorts_blocking_tile_subtitle =>
      'Limit short content on multiple platforms.';

  @override
  String get websites_blocking_tile_subtitle =>
      'Limit adult and custom websites.';

  @override
  String get screen_time_label => 'وقت استخدام الشاشة';

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
  String get statistics_tab_title => 'إحصائيات';

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
  String get notifications_tab_info =>
      'Batch notification from apps and set schedules like morning, noon, evening and night. Stay updated without constant interruptions.';

  @override
  String get batched_apps_tile_title => 'Batched apps';

  @override
  String get batch_recap_dropdown_title => 'Batch recap type';

  @override
  String get batch_recap_dropdown_info =>
      'Choose what to push when a schedule triggers — all notifications or just a summary.';

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
  String get new_schedule_dialog_info =>
      'Enter a name for the notification schedule to help identify it easily.';

  @override
  String get new_schedule_dialog_field_label => 'Schedule name';

  @override
  String get bedtime_tab_title => 'Bedtime';

  @override
  String get bedtime_tab_info =>
      'Set your bedtime schedule by selecting a time period and days of the week. Choose distracting apps to block and enable Do Not Disturb (DND) mode for a peaceful night.';

  @override
  String get schedule_tile_title => 'Schedule';

  @override
  String get schedule_tile_subtitle => 'Enable or disable daily schedule.';

  @override
  String get bedtime_no_days_selected_snack_alert =>
      'Select at least one day of the week.';

  @override
  String get bedtime_minimum_duration_snack_alert =>
      'The total bedtime duration must be at least 30 minutes.';

  @override
  String get distracting_apps_tile_title => 'Distracting apps';

  @override
  String get distracting_apps_tile_subtitle =>
      'Select which apps are distracting you from your bedtime routine.';

  @override
  String get bedtime_distracting_apps_modify_snack_alert =>
      'Modifications to the list of distracting apps is not permitted while the bedtime schedule is active.';

  @override
  String get parental_controls_tab_title => 'Parental controls';

  @override
  String get invincible_mode_heading => 'Invincible mode';

  @override
  String get invincible_mode_tile_title => 'Activate invincible mode';

  @override
  String get invincible_mode_info =>
      'When Invincible Mode is on, you won\'t be able to adjust selected limits after reaching your daily quota. However, you can make changes within a selected 10-minute invincible window.';

  @override
  String get invincible_mode_snack_alert =>
      'Due to invincible mode, modifications to restrictions is not allowed.';

  @override
  String get invincible_mode_dialog_info =>
      'Are you absolutely sure you want to enable Invincible Mode? This action is irreversible. Once Invincible Mode is turned on, you cannot turn it off as long as this app is installed on your device.';

  @override
  String get invincible_mode_turn_off_snack_alert =>
      'Invincible Mode cannot be turned off as long as this app remains installed on your device.';

  @override
  String get invincible_mode_dialog_button_start_anyway => 'Start anyway';

  @override
  String get invincible_mode_include_timer_tile_title => 'Include timer';

  @override
  String get invincible_mode_include_launch_limit_tile_title =>
      'Include launch limit';

  @override
  String get invincible_mode_include_active_period_tile_title =>
      'Include active period';

  @override
  String get invincible_mode_app_restrictions_tile_title => 'App restrictions';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle =>
      'Prevent changes to the app\'s selected restrictions once the daily limits are exceeded.';

  @override
  String get invincible_mode_group_restrictions_tile_title =>
      'Group restrictions';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle =>
      'Prevent changes to the group\'s selected restrictions once the daily limits are exceeded.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title =>
      'Include shorts timer';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle =>
      'Prevents changes after reaching your daily shorts limit.';

  @override
  String get invincible_mode_include_bedtime_tile_title => 'Include bedtime';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle =>
      'Prevents changes during the active bedtime schedule.';

  @override
  String get protected_access_tile_title => 'Protected access';

  @override
  String get protected_access_tile_subtitle =>
      'Protect Mindful with your device lock.';

  @override
  String get protected_access_no_lock_snack_alert =>
      'Please set up a biometric lock on your device first to enable this feature.';

  @override
  String get protected_access_removed_lock_snack_alert =>
      'Your device lock has been removed. To continue, please set up a new lock.';

  @override
  String get protected_access_failed_lock_snack_alert =>
      'Authentication failed. You need to verify your device lock to proceed.';

  @override
  String get tamper_protection_tile_title => 'Tamper protection';

  @override
  String get tamper_protection_tile_subtitle =>
      'Prevent uninstalling and force stopping the app.';

  @override
  String get tamper_protection_confirmation_dialog_info =>
      'Once enabled, you won\'t be able to uninstall, force stop, or clear Mindful\'s data, except during the selected uninstall window. There are no workarounds.\n\nProceed at your own risk.';

  @override
  String get uninstall_window_tile_title => 'Uninstall window';

  @override
  String get uninstall_window_tile_subtitle =>
      'Tamper protection can be disabled within 10 minutes from the selected time.';

  @override
  String get invincible_window_tile_title => 'Invincible window';

  @override
  String get invincible_window_tile_subtitle =>
      'Selected limits can be modified within 10 minutes from the selected time.';

  @override
  String get shorts_blocking_tab_title => 'Shorts blocking';

  @override
  String get shorts_blocking_tab_info =>
      'Control how much time you spend on short content across platforms like Instagram, YouTube, Snapchat, and Facebook, including their websites.';

  @override
  String get short_content_heading => 'Short content';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Left from $timeShortString';
  }

  @override
  String get short_content_timer_picker_dialog_info =>
      'Set a daily time limit for short content. Once your limit is reached, the short content will be paused until midnight.';

  @override
  String get instagram_features_tile_title => 'Instagram';

  @override
  String get instagram_features_tile_subtitle =>
      'Restrict features on instagram.';

  @override
  String get instagram_features_block_reels => 'Restrict reels section.';

  @override
  String get instagram_features_block_explore => 'Restrict explore section.';

  @override
  String get snapchat_features_tile_title => 'Snapchat';

  @override
  String get snapchat_features_tile_subtitle =>
      'Restrict features on snapchat.';

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
  String get websites_blocking_tab_info =>
      'Block adult websites and any custom sites you choose to create a safer and more focused online experience. Take charge of your browsing and stay distraction-free.';

  @override
  String get adult_content_heading => 'Adult content';

  @override
  String get block_nsfw_title => 'Block Nsfw';

  @override
  String get block_nsfw_subtitle =>
      'Restrict browsers from opening adult and porn websites.';

  @override
  String get block_nsfw_dialog_info =>
      'Are you sure? This action is irreversible. Once adult sites blocker is turned ON, you cannot turn it OFF as long as this app is installed on your device.';

  @override
  String get block_nsfw_dialog_button_block_anyway => 'Block anyway';

  @override
  String get blocked_websites_heading => 'Blocked websites';

  @override
  String get blocked_websites_empty_list_hint =>
      'Click on \'+ Add Website\' button to add distracting websites which you wish to block.';

  @override
  String get add_website_fab_button => 'Add Website';

  @override
  String get add_website_dialog_title => 'Distracting website';

  @override
  String get add_website_dialog_info =>
      'Enter url of a website which you want to block.';

  @override
  String get add_website_dialog_is_nsfw => 'Is nsfw site?';

  @override
  String get add_website_dialog_nsfw_warning =>
      'Warning: Nsfw sites cannot be removed once added.';

  @override
  String get add_website_dialog_button_block => 'Block';

  @override
  String get add_website_already_exist_snack_alert =>
      'The URL has already been added to the list of blocked websites.';

  @override
  String get add_website_invalid_url_snack_alert =>
      'Invalid URL! Unable to parse the host name.';

  @override
  String get remove_website_dialog_title => 'Remove website';

  @override
  String remove_website_dialog_info(String websitehost) {
    return 'Are you sure? you want to remove \'$websitehost\' from blocked websites.';
  }

  @override
  String get focus_tab_title => 'Focus';

  @override
  String get focus_tab_info =>
      'When you need time to focus, start a new session by selecting the type, choosing distracting apps to pause, and enabling Do Not Disturb for uninterrupted concentration.';

  @override
  String get active_session_card_title => 'Active session';

  @override
  String get active_session_card_info =>
      'You have an active focus session running! Click \'View\' to check your progress and see how much time has elapsed.';

  @override
  String get active_session_card_view_button => 'View';

  @override
  String get focus_distracting_apps_removal_snack_alert =>
      'Removal of apps from the distracting apps list is not permitted while a Focus Session is active. However, you may still add additional apps to the list during this time.';

  @override
  String get focus_profile_tile_title => 'Focus profile';

  @override
  String get focus_session_duration_tile_title => 'Session duration';

  @override
  String get focus_session_duration_tile_subtitle =>
      'Infinite (unless you stop)';

  @override
  String get focus_session_duration_dialog_info =>
      'Please select the desired duration for this focus session, determining how long you wish to remain focused and distraction-free.';

  @override
  String get focus_profile_customization_tile_title => 'Profile customization';

  @override
  String get focus_profile_customization_tile_subtitle =>
      'Customize settings for the selected profile.';

  @override
  String get focus_enforce_tile_title => 'Enforce session';

  @override
  String get focus_enforce_tile_subtitle =>
      'Prevents ending a session before time ends.';

  @override
  String get focus_session_start_button => 'Swipe to start Session';

  @override
  String get focus_session_minimum_apps_snack_alert =>
      'Select at least one distracting app to start focus session';

  @override
  String get focus_session_already_active_snack_alert =>
      'You already have an active focus session running. Please complete or stop your current session before starting a new one.';

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
  String get focus_timeline_tab_info =>
      'Explore your focus journey by selecting a date from the calendar. Track your progress, revisit your successes, and learn from the challenges.';

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
  String get your_sessions_empty_list_hint =>
      'No focus sessions recorded for the selected day.';

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
  String get active_session_none_warning =>
      'No active session found. Returning to the home screen.';

  @override
  String get active_session_dialog_button_keep_pushing => 'Keep pushing';

  @override
  String get active_session_finish_dialog_title => 'Finish';

  @override
  String get active_session_finish_dialog_info =>
      'Stay strong! You\'re building valuable focus. Are you sure you want to end this focus session? Every extra moment counts toward your goals.';

  @override
  String get active_session_giveup_dialog_title => 'Give up';

  @override
  String get active_session_giveup_dialog_info =>
      'Hold on! You\'re almost there don\'t give up now! Are you sure you want to end this focus session early? Progress will be lost.';

  @override
  String get active_session_reflection_dialog_title => 'Session reflection';

  @override
  String get active_session_reflection_dialog_info =>
      'Take a moment to reflect on your progress. What\'s your goal for this session? What did you accomplish during this session?';

  @override
  String get active_session_reflection_dialog_tip =>
      'Tip: You can always edit this later in the session timeline.';

  @override
  String get active_session_giveup_snack_alert =>
      'You gave up! Don\'t worry, you can do better next time. Every effort counts - just keep going';

  @override
  String get active_session_quote_one =>
      'Every step counts, stay strong and keep going';

  @override
  String get active_session_quote_two =>
      'Stay focused! you\'re making amazing progress';

  @override
  String get active_session_quote_three =>
      'You\'re crushing it! Keep the momentum going';

  @override
  String get active_session_quote_four =>
      'Just a little more to go, you\'re doing fantastic';

  @override
  String active_session_quote_five(String durationString) {
    return 'Congratulations 🎉 \n You\'ve completed your focus session of $durationString.\n\nGreat job, keep up the amazing work';
  }

  @override
  String get restriction_groups_tab_title => 'Restriction groups';

  @override
  String get restriction_groups_tab_info =>
      'Set a combined screen time limit for a group of apps. Once the total usage reaches your limit, all apps in the group will be paused to help maintain focus and balance.';

  @override
  String get restriction_group_time_spent_label => 'Time spent today';

  @override
  String get restriction_group_time_left_label => 'Time left today';

  @override
  String get restriction_group_name_tile_title => 'Group name';

  @override
  String get restriction_group_name_picker_dialog_info =>
      'Enter a name for the restriction group to help identify and manage it easily.';

  @override
  String get restriction_group_timer_tile_title => 'Group timer';

  @override
  String get restriction_group_timer_picker_dialog_info =>
      'Set a daily time limit for this group. Once your limit is reached, all the apps in this group will be paused until midnight.';

  @override
  String get restriction_group_active_period_tile_title =>
      'Group active period';

  @override
  String get remove_restriction_group_dialog_title => 'Remove group';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return 'Are you sure? you want to remove \'$groupName\' from restriction groups.';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert =>
      'Set either a timer or an active period limit.';

  @override
  String get notifications_empty_list_hint =>
      'No notifications have been batched for the day.';

  @override
  String get conversations_label => 'Conversations';

  @override
  String get last_24_hours_heading => 'Last 24 hours';

  @override
  String get notification_timeline_tab_info =>
      'Browse your notification history by selecting a date from the calendar. See which apps grabbed your attention and reflect on your digital habits.';

  @override
  String get monthly_label => 'Monthly';

  @override
  String get daily_label => 'Daily';

  @override
  String get search_notifications_sheet_info =>
      'Easily find past notifications by searching through their title or content. Helps you quickly locate important alerts.';

  @override
  String get search_notifications_hint => 'Search notifications...';

  @override
  String get search_notifications_empty_list_hint =>
      'No notifications found matching your search.';

  @override
  String get app_info_none_warning =>
      'Couldn\'t find the app for the given package. Returning to the home screen.';

  @override
  String get emergency_fab_button => 'Emergency';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return 'This action will pause the app blocker for next 5 minutes. You have $leftPassesCount passes left. After using all passes, the app will stay blocked until midnight, or the active focus session ends.\n\nDo you still wish to proceed?';
  }

  @override
  String get emergency_dialog_button_use_anyway => 'Use anyway';

  @override
  String get emergency_started_snack_alert =>
      'The app blocker is paused and will resume blocking in 5 minutes.';

  @override
  String get emergency_already_active_snack_alert =>
      'The app blocker is currently either paused or inactive. If notifications are enabled, you will receive updates regarding the remaining time.';

  @override
  String get emergency_no_pass_left_snack_alert =>
      'You have used all your emergency passes. The blocked apps will stay blocked until midnight, or the active focus session ends.';

  @override
  String get app_limit_status_not_set => 'Not set';

  @override
  String get app_timer_tile_title => 'App timer';

  @override
  String get app_timer_picker_dialog_info =>
      'Set a daily time limit for this app. Once your limit is reached, the app will be paused until midnight.';

  @override
  String get usage_reminders_tile_title => 'Usage reminders';

  @override
  String get usage_reminders_tile_subtitle =>
      'Gentle nudges when using timed apps.';

  @override
  String get app_launch_limit_tile_title => 'Launch limit';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Launched $count times today.';
  }

  @override
  String get app_launch_limit_picker_dialog_info =>
      'Set how many times you can open this app each day. Once the limit is reached, it will be paused until midnight.';

  @override
  String get app_active_period_tile_title => 'Active period';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return 'From $startTime to $endTime';
  }

  @override
  String get internet_access_tile_title => 'Internet access';

  @override
  String get internet_access_tile_subtitle =>
      'Switch off to block app\'s internet.';

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
  String get go_to_app_settings_tile_subtitle =>
      'Manage app settings like notifications, permissions, storage and more.';

  @override
  String get include_in_stats_tile_title => 'Include in screen usage';

  @override
  String get include_in_stats_tile_subtitle =>
      'Switch off to exclude this app from total screen usage.';

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
  String get amoled_dark_tile_subtitle =>
      'Use pure black color for the dark theme.';

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
  String get service_stopping_warning =>
      'If Mindful stops working unexpectedly, please grant the \'Ignore Battery Optimization\' permission to keep it running in the background. If the issue continues, try whitelisting Mindful for uninterrupted performance.';

  @override
  String get whitelist_app_tile_title => 'Whitelist Mindful';

  @override
  String get whitelist_app_tile_subtitle => 'Allow Mindful to auto start.';

  @override
  String get whitelist_app_unsupported_snack_alert =>
      'This device does not support automatic startup management.';

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
  String get crash_logs_info =>
      'If you encounter any issue, you can report it on GitHub along with the log file. The file will include details such as your device\'s manufacturer, model, Android version, SDK version, and crash logs. This information will help us identify and resolve the problem more effectively.';

  @override
  String get crash_logs_export_tile_title => 'Export crash logs';

  @override
  String get crash_logs_export_tile_subtitle =>
      'Export crash logs to a json file.';

  @override
  String get crash_logs_view_tile_title => 'View logs';

  @override
  String get crash_logs_view_tile_subtitle => 'Explore stored crash logs.';

  @override
  String get crash_logs_empty_list_hint => 'No crash logged till now.';

  @override
  String get crash_logs_clear_tile_title => 'Clear logs';

  @override
  String get crash_logs_clear_tile_subtitle =>
      'Delete all crash logs from database.';

  @override
  String get crash_logs_clear_dialog_info =>
      'Are you sure you wish to clear all crash logs from the database?';

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
  String get redirected_to_github_subtitle =>
      'You will be redirected to GitHub.';

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
  String get write_email_tile_subtitle =>
      'You will be redirected to Email app.';

  @override
  String get privacy_policy_heading => 'Privacy policy';

  @override
  String get privacy_policy_info =>
      'Mindful is committed to protecting your privacy. We do not collect, store, or transfer any type of user data. The app operates entirely offline and does not require an internet connection, ensuring that your personal information remains private and secure on your device. As a Free and Open Source Software (FOSS) application, Mindful guarantees complete transparency and user control over their data.';

  @override
  String get more_details_button => 'More details';
}
