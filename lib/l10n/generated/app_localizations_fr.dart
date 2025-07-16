// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get mindful_tagline => 'Concentrez-vous sur ce qui compte vraiment';

  @override
  String get unlock_button_label => 'Débloquer';

  @override
  String get permission_status_off => 'Désactivé';

  @override
  String get permission_status_allowed => 'Autorisé';

  @override
  String get permission_status_not_allowed => 'Accès non autorisé';

  @override
  String get permission_button_grant_permission => 'Donner l\'autorisation';

  @override
  String get permission_button_agree_and_continue => 'Accepter et continuer';

  @override
  String get permission_button_not_now => 'Pas maintenant';

  @override
  String get permission_button_help => 'Besoin d\'aide ?';

  @override
  String get permission_sheet_privacy_info =>
      'Mindful est 100% sécurisé et fonctionne hors ligne. Nous ne collectons ni stockons aucune donnée personnelle.';

  @override
  String permission_grant_step_one(String button_label) {
    return '1. Cliquez sur le bouton $button_label.';
  }

  @override
  String get permission_grant_step_two =>
      '2. Sélectionnez Mindful sur l\'écran suivant.';

  @override
  String get permission_grant_step_three =>
      '3. Cliquez sur le bouton et activez-le comme ci-dessous.';

  @override
  String get permission_notification_title => 'Envoyer des notifications';

  @override
  String get permission_alarms_title => 'Alarmes & Rappels';

  @override
  String get permission_alarms_info =>
      'Veuillez accorder la permission de régler les alarmes et les rappels. Cela permettra à Mindful de démarrer votre horaire de coucher à l\'heure, de réinitialiser les minuteurs de l\'application tous les jours à minuit et de vous aider à rester sur la bonne voie.';

  @override
  String get permission_alarms_device_tile_label =>
      'Autoriser à définir des alarmes et des rappels';

  @override
  String get permission_usage_title => 'Accès aux données d\'utilisation';

  @override
  String get permission_usage_info =>
      'Veuillez accorder l\'autorisation d\'accès aux données d\'utilisation. Cela permettra à Mindful de surveiller l\'utilisation des applications et de gérer l\'accès à certaines applications, pour un environnement numérique plus contrôlé et propice à la concentration.';

  @override
  String get permission_usage_device_tile_label =>
      'Autoriser l\'accès aux données d\'utilisation';

  @override
  String get permission_overlay_title => 'Afficher la superposition';

  @override
  String get permission_overlay_info =>
      'Veuillez accorder la permission d\'afficher la superposition. Cela permettra à Mindful d\'afficher une surcouche quand une application en pause est ouverte, ce qui vous aidera à rester concentré et à maintenir votre planning.';

  @override
  String get permission_overlay_device_tile_label =>
      'Autoriser la superposition sur d\'autres applis';

  @override
  String get permission_accessibility_title => 'Accessibilité';

  @override
  String get permission_accessibility_info =>
      'Veuillez accorder l\'autorisation d\'accessibilité. Cela permettra à Mindful de restreindre l\'accès au contenu vidéo court (ex : Reels, Shorts) dans les applications de réseaux sociaux et les navigateurs, et filtrer les sites Web inappropriés.';

  @override
  String get permission_accessibility_required =>
      'Mindful a besoin des permissions d\'accessibilité pour mieux bloquer les sites internet et les formats courts.';

  @override
  String get permission_accessibility_device_tile_label => 'Utiliser Mindful';

  @override
  String get permission_dnd_title => 'Ne pas déranger';

  @override
  String get permission_dnd_info =>
      'Veuillez autoriser l\'accès au mode Ne pas déranger. Cela permettra à Mindful de démarrer et d\'arrêter le mode Ne pas déranger pendant l\'horaire du sommeil.';

  @override
  String get permission_dnd_tile_title => 'Lancer Ne pas déranger';

  @override
  String get permission_dnd_tile_subtitle =>
      'Activer aussi le mode Ne pas déranger.';

  @override
  String get permission_battery_optimization_tile_title =>
      'Désactiver l\'optimisation de la batterie';

  @override
  String get permission_battery_optimization_status_enabled =>
      'Déjà non restreint';

  @override
  String get permission_battery_optimization_status_disabled =>
      'Désactiver la restriction d\'arrière-plan';

  @override
  String get permission_battery_optimization_allow_info =>
      'Autoriser la désactivation de l\'optimisation de la batterie accordera automatiquement la permission \'Alarmes & Rappels\' sur certains appareils.';

  @override
  String get permission_vpn_title => 'Créer un VPN';

  @override
  String get permission_vpn_info =>
      'Veuillez accorder la permission de créer une connexion au réseau privé virtuel (VPN). Cela permettra à Mindful de restreindre l\'accès à Internet pour les applications désignées en créant un VPN local sur le périphérique.';

  @override
  String get permission_admin_title => 'Admin';

  @override
  String get permission_admin_info =>
      'Les privilèges d\'administration ne sont nécessaires que pour les opérations essentielles afin de s\'assurer que l\'application fonctionne correctement et reste protégée contre les modifications.';

  @override
  String get permission_admin_snack_alert =>
      'La protection contre les modifications ne peut être désactivée que dans la plage horaire sélectionnée.';

  @override
  String get permission_notification_access_title => 'Accès aux notifications';

  @override
  String get permission_notification_access_info =>
      'Veuillez accorder l\'autorisation d\'accès aux notifications. Cela permettra à Mindful d\'organiser vos notifications et de les envoyer selon votre planning.';

  @override
  String get permission_notification_access_required =>
      'Mindful nécessite un accès aux notifications pour regrouper et planifier les notifications.';

  @override
  String get permission_notification_access_device_tile_label =>
      'Autoriser l\'accès aux notifications';

  @override
  String get day_today => 'Aujourd’hui';

  @override
  String get day_yesterday => 'Hier';

  @override
  String nDays(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString jours',
      one: '1 jour',
      zero: '0 jour',
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
      other: '$countString heures',
      one: '1 heure',
      zero: '0 heure',
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
      other: '$countString secondes',
      one: '1 seconde',
      zero: '0 seconde',
    );
    return '$_temp0';
  }

  @override
  String get time_separator_and => 'et';

  @override
  String get timer_status_active => 'Activé';

  @override
  String get timer_status_paused => 'En pause';

  @override
  String get create_button => 'Créer';

  @override
  String get update_button => 'Mettre à jour';

  @override
  String get dialog_button_cancel => 'Annuler';

  @override
  String get dialog_button_remove => 'Supprimer';

  @override
  String get dialog_button_set => 'Définir';

  @override
  String get dialog_button_reset => 'Réinitialiser';

  @override
  String get dialog_button_infinite => 'Infini';

  @override
  String get schedule_start_label => 'Démarrer';

  @override
  String get schedule_end_label => 'Fin';

  @override
  String get exit_without_saving_dialog_info =>
      'Are you sure you want to exit without saving?';

  @override
  String get development_dialog_info =>
      'Mindful est actuellement en cours de développement et peut avoir des bugs ou des fonctionnalités incomplètes. Si vous rencontrez des problèmes, merci de les signaler pour nous aider à nous améliorer.\n\nMerci pour vos retours !';

  @override
  String get development_dialog_button_report_issue => 'Signaler un problème';

  @override
  String get development_dialog_button_close => 'Fermer';

  @override
  String get dnd_settings_tile_title => 'Paramètres \"Ne pas déranger\"';

  @override
  String get dnd_settings_tile_subtitle =>
      'Gérer quelles apps et notifications peuvent vous solliciter dans le mode Ne pas déranger.';

  @override
  String get quick_actions_heading => 'Actions rapides';

  @override
  String get select_distracting_apps_heading =>
      'Sélectionner les apps qui vous distraient';

  @override
  String get your_distracting_apps_heading => 'Apps qui vous distraient';

  @override
  String get select_more_apps_heading => 'Sélectionnez plus d\'apps';

  @override
  String get imp_distracting_apps_snack_alert =>
      'L\'ajout d\'applications système importantes à la liste des applications qui vous déconcentrent n\'est pas autorisé.';

  @override
  String get custom_apps_quick_actions_unavailable_warning =>
      'Le temps d\'écran et les restrictions ne sont pas disponibles pour cette application. Pour l\'instant, seulement la consommation de données est disponible';

  @override
  String get create_group_fab_button => 'Créer un groupe';

  @override
  String get active_period_info =>
      'Définissez une période pendant laquelle l\'accès sera autorisé. En dehors de cette période, l\'accès sera restreint.';

  @override
  String get minimum_distracting_apps_snack_alert =>
      'Sélectionnez au moins une app qui vous distrait.';

  @override
  String get donation_card_title => 'Soutenez-nous';

  @override
  String get donation_card_info =>
      'Mindful est une application gratuite et open-source, développée avec dévouement durant des mois. Si elle vous a aidé, votre don signifierait beaucoup pour nous. Chaque don nous permet de continuer à l\'améliorer et la maintenir pour tous.';

  @override
  String get operation_failed_snack_alert =>
      'L\'opération a échoué, une erreur s\'est produite !';

  @override
  String get donation_card_button_donate => 'Faire un don';

  @override
  String get app_restart_dialog_title => 'Redémarrage nécessaire';

  @override
  String get app_restart_dialog_info =>
      'Mindful redémarrera automatiquement à la fin du compte à rebours. Merci de patienter le temps que les modifications soient appliquées.';

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
  String get onboarding_skip_btn_label => 'Passer';

  @override
  String get onboarding_finish_setup_btn_label => 'Terminer la configuration';

  @override
  String get onboarding_page_one_title => 'Maitriser votre concentration.';

  @override
  String get onboarding_page_one_info =>
      'Que vous travailliez, étudiiez, ou que vous reposiez, Mindful met en pause les distractions et vous permet de garder le contrôle avec des sessions de concentration personnalisables.';

  @override
  String get onboarding_page_two_title => 'Bloquer les distractions.';

  @override
  String get onboarding_page_two_info =>
      'Définissez des limites d\'utilisation, mettez automatiquement en pause les applications et créez des habitudes numériques plus saines. Utilisez le mode temps de sommeil pour vous détendre et profiter d\'une nuit sans distraction.';

  @override
  String get onboarding_page_three_title => 'Confidentialité avant tout.';

  @override
  String get onboarding_page_three_info =>
      'Mindful est 100% open-source et fonctionne entièrement hors ligne. Nous ne collectons ni ne partageons pas vos données personnelles — votre vie privée est garantie à tous les niveaux.';

  @override
  String get onboarding_page_permissions_title => 'Permissions indispensables.';

  @override
  String get onboarding_page_permissions_info =>
      'Mindful a besoin des autorisations suivantes pour suivre et gérer votre temps d\'écran, vous aider à réduire les distractions et améliorer votre concentration.';

  @override
  String get dashboard_tab_title => 'Tableau de bord';

  @override
  String get focus_now_fab_button => 'Se concentrer';

  @override
  String get welcome_greetings => 'Bienvenue à nouveau,';

  @override
  String get username_snack_alert =>
      'Appuyez longuement pour modifier le nom d\'utilisateur.';

  @override
  String get username_dialog_title => 'Nom d’utilisateur';

  @override
  String get username_dialog_info =>
      'Entrez le nom d\'utilisateur qui s\'affichera sur le tableau de bord.';

  @override
  String get username_dialog_button_apply => 'Confirmer';

  @override
  String get glance_tile_title => 'Glance';

  @override
  String get glance_tile_subtitle =>
      'Jetez un coup d\'œil à vos statistiques d\'utilisation.';

  @override
  String get parental_controls_tile_subtitle =>
      'Mode invincible et protection anti-modification.';

  @override
  String get restrictions_heading => 'Restrictions';

  @override
  String get apps_blocking_tile_title => 'Blocage des applications';

  @override
  String get apps_blocking_tile_subtitle =>
      'Limitez vos applications de plusieurs façons.';

  @override
  String get grouped_apps_blocking_tile_title => 'Blocage groupé';

  @override
  String get grouped_apps_blocking_tile_subtitle =>
      'Limitez plusieurs groupes simultanément.';

  @override
  String get shorts_blocking_tile_subtitle =>
      'Limit short content on multiple platforms.';

  @override
  String get websites_blocking_tile_subtitle =>
      'Limit adult and custom websites.';

  @override
  String get screen_time_label => 'Temps d\'écran';

  @override
  String get total_data_label => 'Total d\'utilisation des données mobiles';

  @override
  String get mobile_data_label => 'Données mobiles';

  @override
  String get wifi_data_label => 'Données Wifi';

  @override
  String get focus_today_label => 'Se concentrer aujourd\'hui';

  @override
  String get focus_weekly_label => 'Focus weekly';

  @override
  String get focus_monthly_label => 'Focus monthly';

  @override
  String get focus_lifetime_label => 'Focus lifetime';

  @override
  String get longest_streak_label => 'Plus longue série';

  @override
  String get current_streak_label => 'Série en cours';

  @override
  String get successful_sessions_label => 'Sessions réussies';

  @override
  String get failed_sessions_label => 'Sessions échouées';

  @override
  String get statistics_tab_title => 'Statistiques';

  @override
  String get screen_segment_label => 'Écran';

  @override
  String get data_segment_label => 'Données';

  @override
  String get mobile_label => 'Mobile';

  @override
  String get wifi_label => 'Wi-Fi';

  @override
  String get most_used_apps_heading => 'Applications les plus utilisées';

  @override
  String get show_all_apps_tile_title => 'Afficher toutes les apps';

  @override
  String get search_apps_hint => 'Search apps...';

  @override
  String get notifications_tab_title => 'Notifications';

  @override
  String get notifications_tab_info =>
      'Batch notification from apps and set schedules like morning, noon, evening and night. Stay updated without constant interruptions.';

  @override
  String get batched_apps_tile_title => 'Apps regroupées';

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
  String get schedules_heading => 'Horaires';

  @override
  String get new_schedule_fab_button => 'Nouvel horaire';

  @override
  String get new_schedule_dialog_info =>
      'Entrez un nom pour l\'horaire de notification pour l\'identifier facilement.';

  @override
  String get new_schedule_dialog_field_label => 'Nom de l\'horaire';

  @override
  String get bedtime_tab_title => 'Dormir';

  @override
  String get bedtime_tab_info =>
      'Fixer l\'heure du coucher en sélectionnant une période et des jours de la semaine. Choisissez les applications qui vous distraient à bloquer et activer le mode Ne pas déranger pour une nuit paisible.';

  @override
  String get schedule_tile_title => 'Planifier';

  @override
  String get schedule_tile_subtitle =>
      'Activer ou désactiver la planification quotidienne.';

  @override
  String get bedtime_no_days_selected_snack_alert =>
      'Sélectionnez au moins un jour de la semaine.';

  @override
  String get bedtime_minimum_duration_snack_alert =>
      'La durée totale du temps de sommeil doit être d\'au moins 30 min.';

  @override
  String get distracting_apps_tile_title => 'Apps qui vous distraient';

  @override
  String get distracting_apps_tile_subtitle =>
      'Sélectionnez les applications qui vous distraient de votre routine du coucher.';

  @override
  String get bedtime_distracting_apps_modify_snack_alert =>
      'Modifications to the list of distracting apps is not permitted while the bedtime schedule is active.';

  @override
  String get parental_controls_tab_title => 'Parental controls';

  @override
  String get invincible_mode_heading => 'Mode invincible';

  @override
  String get invincible_mode_tile_title => 'Activer le mode invincible';

  @override
  String get invincible_mode_info =>
      'When Invincible Mode is on, you won\'t be able to adjust selected limits after reaching your daily quota. However, you can make changes within a selected 10-minute invincible window.';

  @override
  String get invincible_mode_snack_alert =>
      'En raison du mode invincible, les modifications des restrictions ne sont pas autorisées.';

  @override
  String get invincible_mode_dialog_info =>
      'Êtes-vous absolument sûr de vouloir activer le Mode Invincible ? Cette action est irréversible. Une fois que le Mode Invincible est activé, vous ne pouvez pas le désactiver tant que cette application est installée sur votre appareil.';

  @override
  String get invincible_mode_turn_off_snack_alert =>
      'Le mode invincible ne peut pas être désactivé tant que cette application reste installée sur votre appareil.';

  @override
  String get invincible_mode_dialog_button_start_anyway =>
      'Démarrer quand même';

  @override
  String get invincible_mode_include_timer_tile_title => 'Include timer';

  @override
  String get invincible_mode_include_launch_limit_tile_title =>
      'Inclure la limite de lancement';

  @override
  String get invincible_mode_include_active_period_tile_title =>
      'Include active period';

  @override
  String get invincible_mode_app_restrictions_tile_title =>
      'Restrictions d\'applications';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle =>
      'Empêcher toute modification des restrictions de l\'application sélectionnée une fois les limites quotidiennes dépassées.';

  @override
  String get invincible_mode_group_restrictions_tile_title =>
      'Restrictions groupées';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle =>
      'Empêcher toute modification des restrictions de du groupe d\'applications sélectionné une fois les limites quotidiennes dépassées.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title =>
      'Inclure les temps de contenus courts';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle =>
      'Empêcher toute modification une fois votre limite quotidienne de contenus courts dépassée.';

  @override
  String get invincible_mode_include_bedtime_tile_title =>
      'Inclure le temps de sommeil';

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
  String get short_content_heading => 'Contenu court';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Temps restant sur $timeShortString';
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
  String get adult_content_heading => 'Contenu pour adultes';

  @override
  String get block_nsfw_title => 'Bloquer le NSFW';

  @override
  String get block_nsfw_subtitle =>
      'Empêcher les navigateurs d\'ouvrir des sites pour adultes et pornographiques.';

  @override
  String get block_nsfw_dialog_info =>
      'Êtes-vous sûr(e) ? Cette action est irréversible. Une fois que le bloqueur de sites pour adultes est activé, vous ne pouvez pas le désactiver tant que cette application est installée sur votre appareil.';

  @override
  String get block_nsfw_dialog_button_block_anyway => 'Bloquer quand même';

  @override
  String get blocked_websites_heading => 'Sites web bloqués';

  @override
  String get blocked_websites_empty_list_hint =>
      'Click on \'+ Add Website\' button to add distracting websites which you wish to block.';

  @override
  String get add_website_fab_button => 'Ajouter un site web';

  @override
  String get add_website_dialog_title => 'Sites web qui vous distraient';

  @override
  String get add_website_dialog_info =>
      'Entrez l\'Url d\'un site web que vous voulez bloquer.';

  @override
  String get add_website_dialog_is_nsfw => 'Is nsfw site?';

  @override
  String get add_website_dialog_nsfw_warning =>
      'Warning: Nsfw sites cannot be removed once added.';

  @override
  String get add_website_dialog_button_block => 'Bloquer';

  @override
  String get add_website_already_exist_snack_alert =>
      'L\'URL a déjà été ajouté à la liste des sites web bloqués.';

  @override
  String get add_website_invalid_url_snack_alert =>
      'URL invalide ! Impossible d\'analyser le nom d\'hôte.';

  @override
  String get remove_website_dialog_title => 'Retirer le site web';

  @override
  String remove_website_dialog_info(String websitehost) {
    return 'Êtes-vous sûr(e) ? Vous voulez supprimer \'$websitehost\' des sites web bloqués.';
  }

  @override
  String get focus_tab_title => 'Se concentrer';

  @override
  String get focus_tab_info =>
      'Lorsque vous avez besoin de temps pour vous concentrer, démarrez une nouvelle session en sélectionnant le type, en choisissant les applications à mettre en pause, et en activant le mode Ne pas déranger pour une concentration ininterrompue.';

  @override
  String get active_session_card_title => 'Session active';

  @override
  String get active_session_card_info =>
      'Vous avez une session de concentration active en cours ! Cliquez sur \'Voir\' pour vérifier votre progression et voir combien de temps s\'est écoulé.';

  @override
  String get active_session_card_view_button => 'Voir';

  @override
  String get focus_distracting_apps_removal_snack_alert =>
      'La suppression d\'applications de la liste des applications qui vous distraient n\'est pas autorisée tant qu\'une session de concentration est active. Cependant, vous pouvez toujours ajouter des applications supplémentaires à la liste pendant cette période.';

  @override
  String get focus_profile_tile_title => 'Focus profile';

  @override
  String get focus_session_duration_tile_title => 'Durée de la session';

  @override
  String get focus_session_duration_tile_subtitle =>
      'Infini (jusqu\'à ce que vous l\'arrêtiez)';

  @override
  String get focus_session_duration_dialog_info =>
      'Veuillez sélectionner la durée souhaitée pour cette session de concentration, en déterminant la durée pendant laquelle vous souhaitez rester concentré et sans distraction.';

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
      'Sélectionnez au moins une application qui vous distrait pour démarrer la session de concentration';

  @override
  String get focus_session_already_active_snack_alert =>
      'Vous avez déjà une session de concentration active en cours d\'exécution. Veuillez terminer ou arrêter votre session actuelle avant d\'en commencer une nouvelle.';

  @override
  String get focus_session_type_study => 'Étude';

  @override
  String get focus_session_type_work => 'Travail';

  @override
  String get focus_session_type_exercise => 'Exercice';

  @override
  String get focus_session_type_meditation => 'Méditation';

  @override
  String get focus_session_type_creativeWriting => 'Écriture créative';

  @override
  String get focus_session_type_reading => 'Lecture';

  @override
  String get focus_session_type_programming => 'Programmation';

  @override
  String get focus_session_type_chores => 'Chores';

  @override
  String get focus_session_type_projectPlanning => 'Project Planning';

  @override
  String get focus_session_type_artAndDesign => 'Art et design';

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
  String get restriction_group_time_spent_label => 'Temps passé aujourd\'hui';

  @override
  String get restriction_group_time_left_label => 'Temps restant aujourd\'hui';

  @override
  String get restriction_group_name_tile_title => 'Nom du groupe';

  @override
  String get restriction_group_name_picker_dialog_info =>
      'Entrez un nom pour le groupe de restriction afin de l\'identifier et de le gérer facilement.';

  @override
  String get restriction_group_timer_tile_title => 'Minuteur pour le groupe';

  @override
  String get restriction_group_timer_picker_dialog_info =>
      'Définissez une limite de temps quotidienne pour ce groupe. Une fois votre limite atteinte, toutes les applications de ce groupe seront suspendues jusqu\'à minuit.';

  @override
  String get restriction_group_active_period_tile_title =>
      'Période d\'activité du groupe';

  @override
  String get remove_restriction_group_dialog_title => 'Supprimer groupe';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return 'Êtes-vous sûr ? Vous voulez supprimer \'$groupName\' des groupes de restrictions.';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert =>
      'Définissez une limite de temps ou une limite de période d\'activité.';

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
  String get emergency_fab_button => 'Urgence';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return 'Cette action mettra en pause le bloqueur de l\'application pour les 5 prochaines minutes. Il vous reste $leftPassesCount délais. Après avoir utilisé tous les délais, l\'application restera bloquée jusqu\'à minuit, ou la session de concentration active se terminera.\n\nContinuer quand même ?';
  }

  @override
  String get emergency_dialog_button_use_anyway => 'Utiliser quand même';

  @override
  String get emergency_started_snack_alert =>
      'Le bloqueur d\'application est suspendu et reprendra le blocage dans 5 minutes.';

  @override
  String get emergency_already_active_snack_alert =>
      'Le bloqueur de l\'application est actuellement suspendu ou inactif. Si les notifications sont activées, vous recevrez informations concernant le temps restant.';

  @override
  String get emergency_no_pass_left_snack_alert =>
      'Vous avez utilisé tous vos délais d\'urgence. Les applications bloquées resteront bloquées jusqu\'à minuit, ou la session de concentration active se termine.';

  @override
  String get app_limit_status_not_set => 'Non défini';

  @override
  String get app_timer_tile_title => 'Minuteur de l\'application';

  @override
  String get app_timer_picker_dialog_info =>
      'Définissez une limite de temps quotidienne pour cette application. Une fois votre limite atteinte, l\'application sera suspendue jusqu\'à minuit.';

  @override
  String get usage_reminders_tile_title => 'Usage reminders';

  @override
  String get usage_reminders_tile_subtitle =>
      'Gentle nudges when using timed apps.';

  @override
  String get app_launch_limit_tile_title => 'Limite de lancements';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Lancé $count fois aujourd\'hui.';
  }

  @override
  String get app_launch_limit_picker_dialog_info =>
      'Définissez combien de fois vous pouvez ouvrir cette application chaque jour. Une fois la limite atteinte, elle sera suspendue jusqu\'à minuit.';

  @override
  String get app_active_period_tile_title => 'Période d\'activité';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return 'De $startTime à $endTime';
  }

  @override
  String get internet_access_tile_title => 'Accès internet';

  @override
  String get internet_access_tile_subtitle =>
      'Désactivez pour bloquer Internet pour l\'app.';

  @override
  String internet_access_blocked_snack_alert(String appName) {
    return 'Internet est bloqué pour $appName.';
  }

  @override
  String internet_access_unblocked_snack_alert(String appName) {
    return 'Internet est débloqué pour $appName.';
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
