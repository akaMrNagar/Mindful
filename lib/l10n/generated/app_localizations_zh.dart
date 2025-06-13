import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get mindful_tagline => '聚焦重要的事';

  @override
  String get unlock_button_label => '解锁';

  @override
  String get permission_status_off => '关';

  @override
  String get permission_status_allowed => '允许';

  @override
  String get permission_status_not_allowed => '不允许';

  @override
  String get permission_button_grant_permission => '授权';

  @override
  String get permission_button_agree_and_continue => '同意并继续';

  @override
  String get permission_button_not_now => '稍后再说';

  @override
  String get permission_button_help => '帮助？';

  @override
  String get permission_sheet_privacy_info => 'Mindful 安全且不使用互联网。我们不收集或存储任何个人数据。';

  @override
  String permission_grant_step_one(String button_label) {
    return '1. 点击 $button_label 按钮。';
  }

  @override
  String get permission_grant_step_two => '2. 请在下一个屏幕中选择 Mindful。';

  @override
  String get permission_grant_step_three => '3. 点击并开启如下开关。';

  @override
  String get permission_notification_title => '发送通知';

  @override
  String get permission_alarms_title => '闹钟和提醒';

  @override
  String get permission_alarms_info => '请授予设置提醒和提醒的权限。 这将使您能够及时启动您的床上时间表，并且每天午夜重置应用程序计时器，并帮助您保持正常状态。';

  @override
  String get permission_alarms_device_tile_label => '允许设置闹钟和提醒';

  @override
  String get permission_usage_title => '使用访问';

  @override
  String get permission_usage_info => '请授予使用访问权限。这将允许Mindful监控应用使用情况并管理对某些应用的访问，确保更专注和受控的数字环境。';

  @override
  String get permission_usage_device_tile_label => '允许使用访问';

  @override
  String get permission_overlay_title => '显示叠加层';

  @override
  String get permission_overlay_info => '请授予显示叠加层权限。这将允许Mindful在暂停的应用打开时显示叠加层，帮助您保持专注并维持您的日程安排。';

  @override
  String get permission_overlay_device_tile_label => '允许在其他应用上显示';

  @override
  String get permission_accessibility_title => '无障碍';

  @override
  String get permission_accessibility_info => '请授予无障碍权限。这将允许Mindful限制社交媒体应用和浏览器中的短视频内容（例如Reels、Shorts）访问，并过滤不当网站。';

  @override
  String get permission_accessibility_required => 'Mindful需要无障碍权限才能有效阻止短内容和网站。';

  @override
  String get permission_accessibility_device_tile_label => '使用Mindful';

  @override
  String get permission_dnd_title => '请勿打扰';

  @override
  String get permission_dnd_info => '请授予请勿打扰访问权限。这将允许Mindful在睡眠时间表期间开始和停止请勿打扰模式。';

  @override
  String get permission_dnd_tile_title => '开始DND';

  @override
  String get permission_dnd_tile_subtitle => '同时启用请勿打扰模式。';

  @override
  String get permission_battery_optimization_tile_title => '忽略电池优化';

  @override
  String get permission_battery_optimization_status_enabled => '已解除限制';

  @override
  String get permission_battery_optimization_status_disabled => '禁用后台限制';

  @override
  String get permission_battery_optimization_allow_info => '允许\'忽略电池优化\'将在某些设备上自动授予\'闹钟和提醒\'权限。';

  @override
  String get permission_vpn_title => '创建VPN';

  @override
  String get permission_vpn_info => '请授予创建虚拟专用网络（VPN）连接的权限。这将使Mindful能够通过在设备上创建本地VPN来限制指定应用程序的互联网访问。';

  @override
  String get permission_admin_title => '管理员';

  @override
  String get permission_admin_info => '仅需要管理权限进行基本操作，以确保应用程序正常工作并保持防篡改。';

  @override
  String get permission_admin_snack_alert => '篡改保护只能在选定的时间窗口内禁用。';

  @override
  String get permission_notification_access_title => '通知访问';

  @override
  String get permission_notification_access_info => '请授予通知访问权限。这将允许Mindful组织您的通知并按照您的日程安排进行交付。';

  @override
  String get permission_notification_access_required => 'Mindful需要通知访问权限来批量和安排通知。';

  @override
  String get permission_notification_access_device_tile_label => '允许通知访问';

  @override
  String get day_today => '今天';

  @override
  String get day_yesterday => '昨天';

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
  String get timer_status_active => '活动中';

  @override
  String get timer_status_paused => '暂停';

  @override
  String get create_button => '创建';

  @override
  String get update_button => '更新';

  @override
  String get dialog_button_cancel => '取消';

  @override
  String get dialog_button_remove => '移除';

  @override
  String get dialog_button_set => '设置';

  @override
  String get dialog_button_reset => '重置';

  @override
  String get dialog_button_infinite => '无限';

  @override
  String get schedule_start_label => '开始';

  @override
  String get schedule_end_label => '结束';

  @override
  String get exit_without_saving_dialog_info => '您是否确定您要退出而不保存？';

  @override
  String get development_dialog_info => 'Mindful 目前处于开发阶段，可能存在漏洞或不完整的功能。如果您遇到任何问题，请报告以帮助我们改进。\n\n感谢您的反馈！';

  @override
  String get development_dialog_button_report_issue => '报告问题';

  @override
  String get development_dialog_button_close => '关闭';

  @override
  String get dnd_settings_tile_title => '勿扰设置';

  @override
  String get dnd_settings_tile_subtitle => '管理哪些应用和通知可以在勿扰模式下到达您。';

  @override
  String get quick_actions_heading => '快速操作';

  @override
  String get select_distracting_apps_heading => '选择分散注意力的应用';

  @override
  String get your_distracting_apps_heading => '您的分散注意力应用';

  @override
  String get select_more_apps_heading => '选择更多应用';

  @override
  String get imp_distracting_apps_snack_alert => '不允许将重要系统应用添加到分散注意力的应用列表中。';

  @override
  String get custom_apps_quick_actions_unavailable_warning => '此应用的屏幕使用和限制不可用，目前仅可访问网络使用情况';

  @override
  String get create_group_fab_button => '创建群组';

  @override
  String get active_period_info => '设置允许访问的时间段。超出此时间范围，访问将受到限制。';

  @override
  String get minimum_distracting_apps_snack_alert => '至少选择一个分散注意力的应用。';

  @override
  String get donation_card_title => '支持我们';

  @override
  String get donation_card_info => 'Mindful 是免费且开源的，经过数月的奉献开发。如果它对您有帮助，您的捐款将对我们意义重大。每一份贡献都帮助我们继续改进和维护它，以造福所有人。';

  @override
  String get operation_failed_snack_alert => '操作失败，出了问题！';

  @override
  String get donation_card_button_donate => '捐赠';

  @override
  String get app_restart_dialog_title => '需要重启';

  @override
  String get app_restart_dialog_info => 'Mindful 将在倒计时结束后自动重启。请耐心等待，应用正在应用更改。';

  @override
  String get accessibility_tip => '需要更智能，更省电的拦截吗？为Mindful启动无障碍权限。';

  @override
  String get battery_optimization_tip => 'Mindful无法运行？在设置中启用“忽略电池优化”以便可以更流畅的运行。';

  @override
  String get invincible_mode_tip => '不小心移除了限制？使用隐藏模式锁定它们，直到第二天或调整窗口。';

  @override
  String get glance_usage_tip => '想要深入了解？查看 Glance 功能，了解你的使用模式和屏幕使用时间。';

  @override
  String get tamper_protection_tip => '正在卸载 Mindful？请先启用卸载窗口以安全地禁用防篡改保护。';

  @override
  String get notification_blocking_tip => '需要减少打扰？使用通知拦截以静音所选择的应用。';

  @override
  String get usage_history_tip => '想复盘一下你的习惯吗？查看使用历史记录，了解之前的使用模式。';

  @override
  String get focus_mode_tip => '需要更加专注？打开专注模式以在执行任务时不被应用和通知打扰。';

  @override
  String get bedtime_reminder_tip => '想要提升你的睡眠质量？设置一个睡眠提醒以提升睡眠品质。';

  @override
  String get custom_blocking_tip => '需要自定义体验？创建符合您需求的应用拦截规则。';

  @override
  String get session_timeline_tip => '想要追踪专注力过程？查看时间线，了解你的专注历程。';

  @override
  String get short_content_blocking_tip => '社交应用让你分心？屏蔽 Instagram、YouTube 等平台上的短视频，保持专注。';

  @override
  String get parental_controls_tip => '需要家长管理？为孩子的设备设置限制，确保安全使用。';

  @override
  String get notification_batching_tip => '想要减少干扰？使用通知批量处理功能，将通知分组并一次性查看。';

  @override
  String get notification_scheduling_tip => '需要管理通知？安排特定的时间以接收所选择应用的通知。';

  @override
  String get quick_focus_tile_tip => '想更快专注？添加“专注”快捷方式即可立即激活专注模式。';

  @override
  String get app_shortcuts_tip => '想要即时访问应用？长按应用图标即可添加快捷方式。';

  @override
  String get backup_usage_db_tip => '想要保存数据？备份您的数据，确保数据安全。';

  @override
  String get dynamic_material_color_tip => '想要自定义主题？启用动态材质颜色，使其与设备主题匹配。';

  @override
  String get amoled_dark_theme_tip => '想要更加省电？使用 AMOLED 深色主题，降低 OLED 屏幕的耗电。';

  @override
  String get customize_usage_history_tip => '想要保留使用记录？自定义使用记录中存储的周数。';

  @override
  String get grouped_apps_blocking_tip => '想要同时屏蔽多个应用？使用“限制组”功能，对应用限制进行分组，即可同时屏蔽多个应用。';

  @override
  String get websites_blocking_tip => '想要更干净的浏览体验？屏蔽自定义或 NSFW 网站，更专注于上网。';

  @override
  String get data_usage_tip => '想要追踪你的数据？监控你的手机和 Wi-Fi 数据使用情况，了解互联网使用情况。';

  @override
  String get block_internet_tip => '需要阻止某个应用的网络连接？从应用的控制面板中切断特定应用的网络连接。';

  @override
  String get emergency_passes_tip => '需要休息一下？每天使用 3 张紧急通行证，即可暂时解锁应用程序 5 分钟。';

  @override
  String get onboarding_skip_btn_label => '跳过';

  @override
  String get onboarding_finish_setup_btn_label => '完成设置';

  @override
  String get onboarding_page_one_title => '掌握专注。';

  @override
  String get onboarding_page_one_info => '暂停分散注意力的应用，屏蔽短内容，并通过可定制的专注会话保持在正轨上。不论你是在工作、学习或放松，Mindful都能帮助你保持控制。';

  @override
  String get onboarding_page_two_title => '屏蔽干扰。';

  @override
  String get onboarding_page_two_info => '设置使用限制，自动暂停应用，并创建更健康的数字习惯。使用睡前模式放松并享受无干扰的夜晚。';

  @override
  String get onboarding_page_three_title => '以隐私为首要。';

  @override
  String get onboarding_page_three_info => 'Mindful 是 100% 开源的，并且完全离线运行。我们不收集或分享您的个人数据——您的隐私在每个方面都得到保证。';

  @override
  String get onboarding_page_permissions_title => '必要权限。';

  @override
  String get onboarding_page_permissions_info => 'Mindful 需要以下必要权限来跟踪和管理您的屏幕时间，帮助减少干扰并提高专注度。';

  @override
  String get dashboard_tab_title => '仪表盘';

  @override
  String get focus_now_fab_button => '立即专注';

  @override
  String get welcome_greetings => '欢迎回来，';

  @override
  String get username_snack_alert => '长按编辑用户名。';

  @override
  String get username_dialog_title => '用户名';

  @override
  String get username_dialog_info => '输入将在仪表盘上显示的用户名。';

  @override
  String get username_dialog_button_apply => '应用';

  @override
  String get glance_tile_title => '一瞥';

  @override
  String get glance_tile_subtitle => '快速查看您的使用情况。';

  @override
  String get parental_controls_tile_subtitle => '无敌模式和防篡改保护。';

  @override
  String get restrictions_heading => '限制';

  @override
  String get apps_blocking_tile_title => '应用屏蔽';

  @override
  String get apps_blocking_tile_subtitle => '以多种方式限制应用。';

  @override
  String get grouped_apps_blocking_tile_title => '分组应用屏蔽';

  @override
  String get grouped_apps_blocking_tile_subtitle => '同时限制一组应用。';

  @override
  String get shorts_blocking_tile_subtitle => '在多个平台上限制短内容。';

  @override
  String get websites_blocking_tile_subtitle => '限制成人和自定义网站。';

  @override
  String get screen_time_label => '屏幕时间';

  @override
  String get total_data_label => '总数据';

  @override
  String get mobile_data_label => '移动数据';

  @override
  String get wifi_data_label => 'WIFI 数据';

  @override
  String get focus_today_label => '今日专注';

  @override
  String get focus_weekly_label => '本周专注';

  @override
  String get focus_monthly_label => '本月专注';

  @override
  String get focus_lifetime_label => '生涯专注';

  @override
  String get longest_streak_label => '最长连续记录';

  @override
  String get current_streak_label => '当前连续记录';

  @override
  String get successful_sessions_label => '成功会话';

  @override
  String get failed_sessions_label => '失败会话';

  @override
  String get statistics_tab_title => '统计';

  @override
  String get screen_segment_label => '屏幕';

  @override
  String get data_segment_label => '数据';

  @override
  String get mobile_label => '移动';

  @override
  String get wifi_label => 'Wi-Fi';

  @override
  String get most_used_apps_heading => '最常用应用';

  @override
  String get show_all_apps_tile_title => '显示所有应用';

  @override
  String get search_apps_hint => '搜寻应用……';

  @override
  String get notifications_tab_title => '通知';

  @override
  String get notifications_tab_info => '批量处理来自应用的通知，并设置每天的早晨、中午、下午和晚上的时间表。无需不断打断即可保持更新。';

  @override
  String get batched_apps_tile_title => '批量应用';

  @override
  String get batch_recap_dropdown_title => '批量概括类型';

  @override
  String get batch_recap_dropdown_info => '选择触发计划时要推送的内容。\n所有通知或仅摘要。';

  @override
  String get batch_recap_option_summery_only => '摘要而已';

  @override
  String get batch_recap_option_all_notifications => '所有通知';

  @override
  String get notification_history_tile_title => '通知历史';

  @override
  String get store_all_tile_title => '储存所有通知';

  @override
  String get store_all_tile_subtitle => '一并保存未分组通知。';

  @override
  String get schedules_heading => '时间表';

  @override
  String get new_schedule_fab_button => '新建时间表';

  @override
  String get new_schedule_dialog_info => '为通知时间表输入一个名称，以便于识别。';

  @override
  String get new_schedule_dialog_field_label => '时间表名称';

  @override
  String get bedtime_tab_title => '睡眠时间';

  @override
  String get bedtime_tab_info => '通过选择时间段和一周中的某些天来设置睡眠时间表。选择分散注意力的应用以进行屏蔽，并启用勿扰模式（DND），以便度过一个宁静的夜晚。';

  @override
  String get schedule_tile_title => '时间表';

  @override
  String get schedule_tile_subtitle => '启用或禁用每日时间表。';

  @override
  String get bedtime_no_days_selected_snack_alert => '请至少选择一周中的某一天。';

  @override
  String get bedtime_minimum_duration_snack_alert => '睡眠时间的总时长必须至少为30分钟。';

  @override
  String get distracting_apps_tile_title => '分散注意力的应用';

  @override
  String get distracting_apps_tile_subtitle => '选择哪些应用会干扰你的睡前例行程序。';

  @override
  String get bedtime_distracting_apps_modify_snack_alert => '在睡眠时间表激活时，不允许修改分散注意力的应用列表。';

  @override
  String get parental_controls_tab_title => '家长控制';

  @override
  String get invincible_mode_heading => '无敌模式';

  @override
  String get invincible_mode_tile_title => '激活无敌模式';

  @override
  String get invincible_mode_info => '当无敌模式开启时，您将无法在达到每日配额后调整选定的限制。然而，您可以在选定的10分钟无敌窗口内进行更改。';

  @override
  String get invincible_mode_snack_alert => '由于无敌模式，限制的修改不被允许。';

  @override
  String get invincible_mode_dialog_info => '您确定要启用无敌模式吗？此操作是不可逆的。一旦无敌模式开启，除非卸载此应用，否则无法关闭。';

  @override
  String get invincible_mode_turn_off_snack_alert => '只要此应用安装在您的设备上，无敌模式就无法关闭。';

  @override
  String get invincible_mode_dialog_button_start_anyway => '无论如何开始';

  @override
  String get invincible_mode_include_timer_tile_title => '包含计时器';

  @override
  String get invincible_mode_include_launch_limit_tile_title => '包含启动限制';

  @override
  String get invincible_mode_include_active_period_tile_title => '包含活跃期';

  @override
  String get invincible_mode_app_restrictions_tile_title => '应用限制';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle => '防止在每日限制被超过后更改应用的选定限制。';

  @override
  String get invincible_mode_group_restrictions_tile_title => '组限制';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle => '防止在每日限制被超过后更改组的选定限制。';

  @override
  String get invincible_mode_include_shorts_timer_tile_title => '包含短视频计时器';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle => '防止在达到每日短视频限制后进行更改。';

  @override
  String get invincible_mode_include_bedtime_tile_title => '包含睡眠时间';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle => '防止在活跃的睡眠时间表期间进行更改。';

  @override
  String get protected_access_tile_title => '受保护访问';

  @override
  String get protected_access_tile_subtitle => '使用设备锁保护Mindful。';

  @override
  String get protected_access_no_lock_snack_alert => '请先在设备上设置生物识别锁以启用此功能。';

  @override
  String get protected_access_removed_lock_snack_alert => '您的设备锁已被移除。为了继续，请设置一个新锁。';

  @override
  String get protected_access_failed_lock_snack_alert => '身份验证失败。您需要验证设备锁才能继续。';

  @override
  String get tamper_protection_tile_title => '防篡改保护';

  @override
  String get tamper_protection_tile_subtitle => '防止卸载和强制停止应用。';

  @override
  String get tamper_protection_confirmation_dialog_info => '一旦启用，您将无法卸载、强制停止或清除 Mindful 的数据，除非在指定的卸载时间段内。没有其他例外。\n\n请自行承担风险。';

  @override
  String get uninstall_window_tile_title => '卸载窗口';

  @override
  String get uninstall_window_tile_subtitle => '防篡改保护可以在选定时间后的10分钟内被禁用。';

  @override
  String get invincible_window_tile_title => '无敌窗口';

  @override
  String get invincible_window_tile_subtitle => '选定的限制可以在选定时间后的10分钟内被修改。';

  @override
  String get shorts_blocking_tab_title => '短视频阻止';

  @override
  String get shorts_blocking_tab_info => '控制您在Instagram、YouTube、Snapchat和Facebook等平台上花费在短内容上的时间，包括它们的网站。';

  @override
  String get short_content_heading => '短内容';

  @override
  String shorts_time_left_from(String timeShortString) {
    return '剩余 $timeShortString';
  }

  @override
  String get short_content_timer_picker_dialog_info => '为短内容设置每日时间限制。一旦达到限制，短内容将在午夜前暂停。';

  @override
  String get instagram_features_tile_title => 'Instagram';

  @override
  String get instagram_features_tile_subtitle => '限制Instagram的功能。';

  @override
  String get instagram_features_block_reels => '限制视频段部分。';

  @override
  String get instagram_features_block_explore => '限制发现部分。';

  @override
  String get snapchat_features_tile_title => 'Snapchat';

  @override
  String get snapchat_features_tile_subtitle => '限制Snapchat的功能。';

  @override
  String get snapchat_features_block_spotlight => '限制聚光灯部分。';

  @override
  String get snapchat_features_block_discover => '限制发现部分。';

  @override
  String get youtube_features_tile_title => 'YouTube';

  @override
  String get youtube_features_tile_subtitle => '限制YouTube的短视频。';

  @override
  String get facebook_features_tile_title => 'Facebook';

  @override
  String get facebook_features_tile_subtitle => '限制Facebook的视频段。';

  @override
  String get reddit_features_tile_title => 'Reddit';

  @override
  String get reddit_features_tile_subtitle => '限制Reddit的短视频。';

  @override
  String get websites_blocking_tab_title => '网站屏蔽';

  @override
  String get websites_blocking_tab_info => '屏蔽成人网站和自定义网站，以创建更安全、更专注的在线体验。掌控你的浏览，保持无干扰。';

  @override
  String get adult_content_heading => '成人内容';

  @override
  String get block_nsfw_title => '屏蔽NSFW';

  @override
  String get block_nsfw_subtitle => '限制浏览器打开成人和色情网站。';

  @override
  String get block_nsfw_dialog_info => '确定吗？此操作不可逆。只要应用程序安装在设备上，启用成人网站屏蔽后就无法关闭。';

  @override
  String get block_nsfw_dialog_button_block_anyway => '仍然屏蔽';

  @override
  String get blocked_websites_heading => '已屏蔽的网站';

  @override
  String get blocked_websites_empty_list_hint => '点击 \'+ 添加网站\' 按钮添加你想屏蔽的分散注意力的网站。';

  @override
  String get add_website_fab_button => '添加网站';

  @override
  String get add_website_dialog_title => '分散注意力的网站';

  @override
  String get add_website_dialog_info => '输入你想屏蔽的网站的URL。';

  @override
  String get add_website_dialog_is_nsfw => '是否为NSFW网站？';

  @override
  String get add_website_dialog_nsfw_warning => '警告：添加后NSFW网站无法移除。';

  @override
  String get add_website_dialog_button_block => '屏蔽';

  @override
  String get add_website_already_exist_snack_alert => '该URL已添加到已屏蔽的网站列表中。';

  @override
  String get add_website_invalid_url_snack_alert => '无效的URL！无法解析主机名。';

  @override
  String get remove_website_dialog_title => '移除网站';

  @override
  String remove_website_dialog_info(String websitehost) {
    return '确定吗？你想从已屏蔽的网站中移除 \'$websitehost\'。';
  }

  @override
  String get focus_tab_title => '专注';

  @override
  String get focus_tab_info => '当你需要专注时，通过选择类型、暂停干扰应用并启用请勿打扰模式来开始新会话，以实现无干扰的专注。';

  @override
  String get active_session_card_title => '活动会话';

  @override
  String get active_session_card_info => '你有一个正在运行的专注会话！点击“查看”以检查你的进度并查看已过去的时间。';

  @override
  String get active_session_card_view_button => '查看';

  @override
  String get focus_distracting_apps_removal_snack_alert => '在专注会话活动期间，不允许从干扰应用列表中删除应用程序。但是，你仍然可以在此期间将其他应用程序添加到列表中。';

  @override
  String get focus_profile_tile_title => '专注类型';

  @override
  String get focus_session_duration_tile_title => '会话时长';

  @override
  String get focus_session_duration_tile_subtitle => '无限（除非你停止）';

  @override
  String get focus_session_duration_dialog_info => '请选择此次专注会话的期望时长，以确定你希望保持专注和无干扰的时间长度。';

  @override
  String get focus_profile_customization_tile_title => '类型自定义';

  @override
  String get focus_profile_customization_tile_subtitle => '自定义所选择的类型。';

  @override
  String get focus_enforce_tile_title => '强制会话';

  @override
  String get focus_enforce_tile_subtitle => '防止在计时结束前结束会话。';

  @override
  String get focus_session_start_fab_button => '开始会话';

  @override
  String get focus_session_minimum_apps_snack_alert => '请至少选择一个干扰应用以开始专注会话';

  @override
  String get focus_session_already_active_snack_alert => '你已经有一个正在运行的专注会话。请在开始新会话之前完成或停止当前会话。';

  @override
  String get focus_session_type_study => '学习';

  @override
  String get focus_session_type_work => '工作';

  @override
  String get focus_session_type_exercise => '锻炼';

  @override
  String get focus_session_type_meditation => '冥想';

  @override
  String get focus_session_type_creativeWriting => '创意写作';

  @override
  String get focus_session_type_reading => '阅读';

  @override
  String get focus_session_type_programming => '编程';

  @override
  String get focus_session_type_chores => '家务';

  @override
  String get focus_session_type_projectPlanning => '项目规划';

  @override
  String get focus_session_type_artAndDesign => '艺术与设计';

  @override
  String get focus_session_type_languageLearning => '语言学习';

  @override
  String get focus_session_type_musicPractice => '音乐练习';

  @override
  String get focus_session_type_selfCare => '自我护理';

  @override
  String get focus_session_type_brainstorming => '头脑风暴';

  @override
  String get focus_session_type_skillDevelopment => '技能发展';

  @override
  String get focus_session_type_research => '研究';

  @override
  String get focus_session_type_networking => '人脉拓展';

  @override
  String get focus_session_type_cooking => '烹饪';

  @override
  String get focus_session_type_sportsTraining => '体育训练';

  @override
  String get focus_session_type_restAndRelaxation => '休息放松';

  @override
  String get focus_session_type_other => '其他';

  @override
  String get timeline_tab_title => '时间轴';

  @override
  String get focus_timeline_tab_info => '从日历中选择日期，探索你的专注之旅。追踪你的进度，回顾你的成功，并从挑战中学习。';

  @override
  String selected_month_productive_time_snack_alert(String timeString) {
    return '您在选定月份的总高效时间为 $timeString。';
  }

  @override
  String get selected_month_productive_days_label => '高效天数';

  @override
  String selected_month_productive_days_snack_alert(num daysCount) {
    return '您在选定月份共有 $daysCount 天高效。';
  }

  @override
  String get selected_day_focused_time_label => '专注时间';

  @override
  String selected_day_focused_time_snack_alert(String timeString) {
    return '您在选定日期的总专注时间为 $timeString。';
  }

  @override
  String get calender_heading => '日历';

  @override
  String get your_sessions_heading => '您的会话';

  @override
  String get your_sessions_empty_list_hint => '未记录选定日期的专注会话。';

  @override
  String get focus_session_tile_timestamp_label => '时间线';

  @override
  String get focus_session_tile_duration_label => '时长';

  @override
  String get focus_session_tile_reflection_label => '反映';

  @override
  String get focus_session_state_active => '进行中';

  @override
  String get focus_session_state_successful => '成功';

  @override
  String get focus_session_state_failed => '失败';

  @override
  String get active_session_tab_title => '会话';

  @override
  String get active_session_none_warning => '未找到活跃会话。返回主屏幕。';

  @override
  String get active_session_dialog_button_keep_pushing => '继续推进';

  @override
  String get active_session_finish_dialog_title => '完成';

  @override
  String get active_session_finish_dialog_info => '坚持下去！你正在建立宝贵的专注力。确定要结束这个专注会话吗？每多一刻都能帮助你实现目标。';

  @override
  String get active_session_giveup_dialog_title => '放弃';

  @override
  String get active_session_giveup_dialog_info => '坚持住！你快成功了，现在不要放弃！确定要提前结束这个专注会话吗？进度将会丢失。';

  @override
  String get active_session_reflection_dialog_title => '会话反思';

  @override
  String get active_session_reflection_dialog_info => '花一点时间反思一下你的进展。\n你这次会议的目标是什么？你在这次会议中取得了哪些成果？';

  @override
  String get active_session_reflection_dialog_tip => '小提示：您可以随时在会话时间线中编辑此内容。';

  @override
  String get active_session_giveup_snack_alert => '你放弃了！别担心，下次你可以做得更好。每一次努力都很重要——继续前进吧';

  @override
  String get active_session_quote_one => '每一步都很重要，坚强地继续前进';

  @override
  String get active_session_quote_two => '保持专注！你正在取得惊人的进步';

  @override
  String get active_session_quote_three => '你做得非常棒！继续保持动力';

  @override
  String get active_session_quote_four => '只剩一点了，你做得非常出色';

  @override
  String active_session_quote_five(String durationString) {
    return '恭喜你 🎉 \n 你已完成时长为 $durationString 的专注会话。\n\n 做得非常好，继续保持惊人的工作';
  }

  @override
  String get restriction_groups_tab_title => '限制组';

  @override
  String get restriction_groups_tab_info => '为一组应用设置综合屏幕使用时间限制。一旦总使用时间达到你的限制，组内所有应用将被暂停，以帮助保持专注和平衡。';

  @override
  String get restriction_group_time_spent_label => '今日使用时间';

  @override
  String get restriction_group_time_left_label => '今日剩余时间';

  @override
  String get restriction_group_name_tile_title => '组名称';

  @override
  String get restriction_group_name_picker_dialog_info => '为限制组输入一个名称，以便于识别和管理。';

  @override
  String get restriction_group_timer_tile_title => '组定时器';

  @override
  String get restriction_group_timer_picker_dialog_info => '为该组设置每日时间限制。一旦达到你的限制，组内所有应用将在午夜前暂停。';

  @override
  String get restriction_group_active_period_tile_title => '组活跃期';

  @override
  String get remove_restriction_group_dialog_title => '删除组';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return '确定吗？你要从限制组中删除 \'$groupName\'。';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert => '请设置定时器或活跃期限制。';

  @override
  String get notifications_empty_list_hint => '今日没有被批量处理的通知。';

  @override
  String get conversations_label => '会话';

  @override
  String get last_24_hours_heading => '过去24小时';

  @override
  String get notification_timeline_tab_info => '从日历中选择日期浏览您的通知记录。看看是哪些应用吸引了您的注意力，并反思您的使用习惯。';

  @override
  String get monthly_label => '每月';

  @override
  String get daily_label => '每日';

  @override
  String get search_notifications_sheet_info => '使用标题或内容以方便的寻找过往的通知。帮助你快速找到重要的通知。';

  @override
  String get search_notifications_hint => '寻找通知……';

  @override
  String get search_notifications_empty_list_hint => '没有与你的搜索匹配的通知。';

  @override
  String get app_info_none_warning => '无法找到给定包名的应用程序。返回主屏幕。';

  @override
  String get emergency_fab_button => '紧急';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return '此操作将暂停应用程序阻止器5分钟。您还剩 $leftPassesCount 次机会。使用完所有机会后，应用程序将保持阻止状态，直到午夜或当前专注会话结束。\n\n您仍然要继续吗？';
  }

  @override
  String get emergency_dialog_button_use_anyway => '无论如何使用';

  @override
  String get emergency_started_snack_alert => '应用程序阻止器已暂停，并将在5分钟后恢复阻止。';

  @override
  String get emergency_already_active_snack_alert => '应用程序阻止器当前处于暂停或非活动状态。如果启用了通知，您将收到有关剩余时间的更新。';

  @override
  String get emergency_no_pass_left_snack_alert => '您已经使用了所有紧急通行证。被阻止的应用程序将保持阻止状态，直到午夜或当前专注会话结束。';

  @override
  String get app_limit_status_not_set => '未设置';

  @override
  String get app_timer_tile_title => '应用程序定时器';

  @override
  String get app_timer_picker_dialog_info => '为此应用程序设置每日时间限制。一旦达到限制，应用程序将暂停，直到午夜。';

  @override
  String get usage_reminders_tile_title => '使用提醒';

  @override
  String get usage_reminders_tile_subtitle => '使用定时应用程序时获得提醒。';

  @override
  String get app_launch_limit_tile_title => '启动限制';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return '今天已启动 $count 次。';
  }

  @override
  String get app_launch_limit_picker_dialog_info => '设置每天可以打开此应用程序的次数。一旦达到限制，应用程序将暂停，直到午夜。';

  @override
  String get app_active_period_tile_title => '活动周期';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return '从 $startTime 到 $endTime';
  }

  @override
  String get internet_access_tile_title => '互联网访问';

  @override
  String get internet_access_tile_subtitle => '关闭以阻止应用程序访问互联网。';

  @override
  String internet_access_blocked_snack_alert(String appName) {
    return '$appName 的互联网已被阻止。';
  }

  @override
  String internet_access_unblocked_snack_alert(String appName) {
    return '$appName 的互联网访问已解除限制。';
  }

  @override
  String get launch_app_tile_title => '启动应用';

  @override
  String launch_app_tile_subtitle(String appName) {
    return '打开 $appName。';
  }

  @override
  String get go_to_app_settings_tile_title => '前往应用设置';

  @override
  String get go_to_app_settings_tile_subtitle => '管理应用设置，如通知、权限、存储等。';

  @override
  String get include_in_stats_tile_title => '包含在屏幕使用统计中';

  @override
  String get include_in_stats_tile_subtitle => '关闭后将排除此应用在总屏幕使用统计中。';

  @override
  String app_excluded_from_stats_snack_alert(String appName) {
    return '$appName 已排除在总屏幕使用统计之外。';
  }

  @override
  String app_include_to_stats_snack_alert(String appName) {
    return '$appName 已加入总屏幕使用统计中。';
  }

  @override
  String get general_tab_title => '通用';

  @override
  String get appearance_heading => '外观';

  @override
  String get theme_mode_tile_title => '主题模式';

  @override
  String get theme_mode_system_label => '系统';

  @override
  String get theme_mode_light_label => '浅色';

  @override
  String get theme_mode_dark_label => '深色';

  @override
  String get material_color_tile_title => 'Material 颜色';

  @override
  String get amoled_dark_tile_title => 'AMOLED 深色';

  @override
  String get amoled_dark_tile_subtitle => '使用纯黑色作为深色主题。';

  @override
  String get dynamic_colors_tile_title => '动态颜色';

  @override
  String get dynamic_colors_tile_subtitle => '如果支持，则使用设备颜色。';

  @override
  String get defaults_heading => '默认设置';

  @override
  String get app_language_tile_title => '应用语言';

  @override
  String get default_home_tab_tile_title => '主页标签';

  @override
  String get usage_history_tile_title => '使用历史';

  @override
  String get usage_history_15_days => '15 天';

  @override
  String get usage_history_1_month => '1 个月';

  @override
  String get usage_history_3_month => '3 个月';

  @override
  String get usage_history_6_month => '6 个月';

  @override
  String get usage_history_1_year => '1 年';

  @override
  String get service_heading => '服务';

  @override
  String get service_stopping_warning => '如果 Mindful 意外停止工作，请授予“忽略电池优化”权限以保持后台运行。如果问题持续，请将 Mindful 加入白名单以获得无间断性能。';

  @override
  String get whitelist_app_tile_title => '将 Mindful 加入白名单';

  @override
  String get whitelist_app_tile_subtitle => '允许 Mindful 自动启动。';

  @override
  String get whitelist_app_unsupported_snack_alert => '该设备不支持自动启动管理。';

  @override
  String get database_tab_title => '数据库';

  @override
  String get import_db_tile_title => '导入数据库';

  @override
  String get import_db_tile_subtitle => '从文件导入数据库';

  @override
  String get export_db_tile_title => '导出数据库';

  @override
  String get export_db_tile_subtitle => '将数据库导出至文件';

  @override
  String get crash_logs_heading => '崩溃日志';

  @override
  String get crash_logs_info => '若遇到任何问题，您可将日志文件提交至GitHub进行反馈。该文件包含设备制造商、型号、Android版本、SDK版本及崩溃日志等信息，这些数据将帮助我们更有效地定位并解决问题。';

  @override
  String get crash_logs_export_tile_title => '导出崩溃日志';

  @override
  String get crash_logs_export_tile_subtitle => '将崩溃日志导出至json文件';

  @override
  String get crash_logs_view_tile_title => '查看日志';

  @override
  String get crash_logs_view_tile_subtitle => '浏览存储的崩溃日志';

  @override
  String get crash_logs_empty_list_hint => '当前暂无崩溃日志记录';

  @override
  String get crash_logs_clear_tile_title => '清除日志';

  @override
  String get crash_logs_clear_tile_subtitle => '从数据库中删除所有崩溃日志';

  @override
  String get crash_logs_clear_dialog_info => '确定要从数据库中清除所有崩溃日志吗？';

  @override
  String get crash_logs_clear_dialog_button_clear_anyway => '无论如何清除';

  @override
  String get about_tab_title => '关于';

  @override
  String get changelog_tile_title => '更新日志';

  @override
  String get changelog_tile_subtitle => '了解最新变化。';

  @override
  String get full_changelog_tile_title => '完整更新日志';

  @override
  String get redirected_to_github_subtitle => '您将被重定向到 GitHub。';

  @override
  String get contribute_heading => '贡献';

  @override
  String get github_tile_title => 'GitHub';

  @override
  String get github_tile_subtitle => '查看源代码。';

  @override
  String get report_issue_tile_title => '报告问题';

  @override
  String get suggest_idea_tile_title => '提出建议';

  @override
  String get write_email_tile_title => '通过电子邮件联系我们';

  @override
  String get write_email_tile_subtitle => '您将被重定向到电子邮件应用。';

  @override
  String get privacy_policy_heading => '隐私政策';

  @override
  String get privacy_policy_info => 'Mindful 致力于保护您的隐私。我们不收集、存储或传输任何类型的用户数据。该应用完全离线运行，不需要互联网连接，确保您的个人信息在您的设备上保持私密和安全。作为免费开源软件 (FOSS) 应用，Mindful 保证对用户数据的完全透明度和用户控制。';

  @override
  String get more_details_button => '更多详情';
}
