// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get mindful_tagline => 'Concentre-se no que realmente importa';

  @override
  String get unlock_button_label => 'Desbloquear';

  @override
  String get permission_status_off => 'Desligado';

  @override
  String get permission_status_allowed => 'Permitido';

  @override
  String get permission_status_not_allowed => 'Não permitido';

  @override
  String get permission_button_grant_permission => 'Conceder Permissão';

  @override
  String get permission_button_agree_and_continue => 'Concordar e continuar';

  @override
  String get permission_button_not_now => 'Agora não';

  @override
  String get permission_button_help => 'Ajuda?';

  @override
  String get permission_sheet_privacy_info =>
      'O Mindful é 100% seguro e funciona offline. Não recolhemos nem armazenamos quaisquer dados pessoais.';

  @override
  String permission_grant_step_one(String button_label) {
    return '1. Clique no botão $button_label.';
  }

  @override
  String get permission_grant_step_two =>
      '2. Selecione Mindful na próxima tela.';

  @override
  String get permission_grant_step_three => '3. Clique e ative a opção abaixo.';

  @override
  String get permission_notification_title => 'Enviar notificações';

  @override
  String get permission_alarms_title => 'Alarmes e Lembretes';

  @override
  String get permission_alarms_info =>
      'Por favor, conceda permissão para definir alarmes e lembretes. Isso permitirá que o Mindful inicie sua programação de hora de dormir a tempo e redefina os cronômetros do aplicativo diariamente à meia-noite e ajude você a ficar no caminho certo.';

  @override
  String get permission_alarms_device_tile_label =>
      'Autorizar a definição de alarmes e lembretes';

  @override
  String get permission_usage_title => 'Acesso ao uso';

  @override
  String get permission_usage_info =>
      'Por favor, conceda permissão de acesso ao uso. Isso permitirá que a Mindful monitore o uso de aplicativos e gerencie o acesso a determinados aplicativos, garantindo um ambiente digital mais focado e controlado.';

  @override
  String get permission_usage_device_tile_label => 'Permitir acesso ao uso';

  @override
  String get permission_overlay_title => 'Sobreposição de tela';

  @override
  String get permission_overlay_info =>
      'Por favor, conceda permissão de sobreposição de tela. Isso permitirá que o Mindful mostre uma sobreposição quando um aplicativo pausado é aberto, ajudando você a manter o foco e manter sua agenda.';

  @override
  String get permission_overlay_device_tile_label =>
      'Permitir a exibição em outros aplicativos';

  @override
  String get permission_accessibility_title => 'Acessibilidade';

  @override
  String get permission_accessibility_info =>
      'Por favor, conceda permissão de acessibilidade. Isso permitirá que o Mindful restrinja o acesso ao conteúdo de vídeo curto (por exemplo, Reels, Shorts) dentro dos aplicativos e navegadores de mídia social e filtre sites inadequados.';

  @override
  String get permission_accessibility_required =>
      'Mindful requires accessibility permission to block short content and websites effectively.';

  @override
  String get permission_accessibility_device_tile_label => 'Usar Mindful';

  @override
  String get permission_dnd_title => 'Não perturbe';

  @override
  String get permission_dnd_info =>
      'Por favor, conceda acesso a Não Perturbe. Isso permitirá que o Mindful inicie e pare o modo Não Perturbe durante a programação da hora de dormir.';

  @override
  String get permission_dnd_tile_title => 'Ativar DND';

  @override
  String get permission_dnd_tile_subtitle => 'Também ativar o Não Perturbe.';

  @override
  String get permission_battery_optimization_tile_title =>
      'Ignorar a otimização de bateria';

  @override
  String get permission_battery_optimization_status_enabled => 'Já irrestrito';

  @override
  String get permission_battery_optimization_status_disabled =>
      'Desativar restrição em segundo plano';

  @override
  String get permission_battery_optimization_allow_info =>
      'Permitir \'Ignorar otimização da bateria\' automaticamente concede a permissão de \'Alarmes & Lembretes\' em alguns dispositivos.';

  @override
  String get permission_vpn_title => 'Criar uma VPN';

  @override
  String get permission_vpn_info =>
      'Por favor, conceda permissão para criar uma conexão de rede privada virtual (VPN). Isso permitirá que o Mindful restrinja o acesso à internet para aplicativos designados, criando uma VPN local no dispositivo.';

  @override
  String get permission_admin_title => 'Administrador';

  @override
  String get permission_admin_info =>
      'Administrative privileges are needed only for essential operations to ensure the app works properly and remains tamper-proof.';

  @override
  String get permission_admin_snack_alert =>
      'Tamper protection can only be disabled during the selected time window.';

  @override
  String get permission_notification_access_title => 'Acesso às Notificações';

  @override
  String get permission_notification_access_info =>
      'Conceda permissão de acesso à notificação. Isso permitirá que Mindful  organize suas notificações e leva-las em sua agenda.';

  @override
  String get permission_notification_access_required =>
      'Mindful requires notification access to batch and schedule notifications.';

  @override
  String get permission_notification_access_device_tile_label =>
      'Permite acesso à notificação';

  @override
  String get day_today => 'Hoje';

  @override
  String get day_yesterday => 'Ontem';

  @override
  String nDays(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString dias',
      one: '1 dia',
      zero: '0 dias',
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
      other: '$countString horas',
      one: '1 hora',
      zero: '0 horas',
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
      other: '$countString minutos',
      one: '1 minuto',
      zero: '0 minutos',
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
      other: '$countString segundos',
      one: '1 segundo',
      zero: '0 segundos',
    );
    return '$_temp0';
  }

  @override
  String get time_separator_and => 'e';

  @override
  String get timer_status_active => 'Ativo';

  @override
  String get timer_status_paused => 'Pausado';

  @override
  String get create_button => 'Criar';

  @override
  String get update_button => 'Atualizar';

  @override
  String get dialog_button_cancel => 'Cancelar';

  @override
  String get dialog_button_remove => 'Remover';

  @override
  String get dialog_button_set => 'Definir';

  @override
  String get dialog_button_reset => 'Redefinir';

  @override
  String get dialog_button_infinite => 'Infinito';

  @override
  String get schedule_start_label => 'Começar';

  @override
  String get schedule_end_label => 'Término';

  @override
  String get exit_without_saving_dialog_info =>
      'Are you sure you want to exit without saving?';

  @override
  String get development_dialog_info =>
      'Mindful está atualmente em desenvolvimento e pode ter bugs ou recursos incompletos. Se você encontrar algum problema, por favor informe-os para nos ajudar a melhorar. Obrigado pelo seu feedback!';

  @override
  String get development_dialog_button_report_issue => 'Reportar problema';

  @override
  String get development_dialog_button_close => 'Fechar';

  @override
  String get dnd_settings_tile_title => 'Configurações de Não Perturbe';

  @override
  String get dnd_settings_tile_subtitle =>
      'Gerencie quais aplicativos e notificações podem te notificar no modo DND.';

  @override
  String get quick_actions_heading => 'Ações rápidas';

  @override
  String get select_distracting_apps_heading =>
      'Selecione os aplicativos que te distraem';

  @override
  String get your_distracting_apps_heading => 'Seus aplicativos de distração';

  @override
  String get select_more_apps_heading => 'Selecionar mais apps';

  @override
  String get imp_distracting_apps_snack_alert =>
      'Adicionar aplicativos do sistema importantes à lista de aplicativos que distraem não é permitido.';

  @override
  String get custom_apps_quick_actions_unavailable_warning =>
      'Screen usage and restrictions are unavailable for this application. At present, only network usage is accessible';

  @override
  String get create_group_fab_button => 'Criar Grupo';

  @override
  String get active_period_info =>
      'Set a time period during which access will be allowed. Outside of this time frame, access will be restricted.';

  @override
  String get minimum_distracting_apps_snack_alert =>
      'Selecione pelo menos um aplicativo de distração';

  @override
  String get donation_card_title => 'Nos apoie';

  @override
  String get donation_card_info =>
      'Mindful é de graça e de código aberto, desenvolvido com meses de dedicação. Se isso ajudou você, sua doação significaria o mundo para nós. Toda contribuição nos ajudam continuar melhorando e revisando isso para todos.';

  @override
  String get operation_failed_snack_alert =>
      'Falha na operação, algo deu errado!';

  @override
  String get donation_card_button_donate => 'Doar';

  @override
  String get app_restart_dialog_title => 'Precisa reiniciar';

  @override
  String get app_restart_dialog_info =>
      'Mindful will automatically restart once the countdown finishes. Please be patient as changes are applied.';

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
  String get onboarding_skip_btn_label => 'Pular';

  @override
  String get onboarding_finish_setup_btn_label => 'Finalizar Configuração';

  @override
  String get onboarding_page_one_title => 'Domine o foco.';

  @override
  String get onboarding_page_one_info =>
      'Pause apps que distraem, bloqueie conteúdo curto e mantenha-se no caminho certo com sessões de foco personalizáveis. Se você está trabalhando, estudando ou relaxando, Mindful ajuda você a ficar no controle.';

  @override
  String get onboarding_page_two_title => 'Bloquear Distrações.';

  @override
  String get onboarding_page_two_info =>
      'Defina limites de uso, pause automaticamente os aplicativos e crie hábitos digitais mais saudáveis. Use o modo Hora de dormir para relaxar e desfrutar de uma noite livre de distrações.';

  @override
  String get onboarding_page_three_title => 'Privacidade em primeiro lugar.';

  @override
  String get onboarding_page_three_info =>
      'A Mindful é 100% open-source e opera totalmente offline. Não recolhemos nem partilhamos os seus dados pessoais — a sua privacidade está garantida de todas as formas.';

  @override
  String get onboarding_page_permissions_title => 'Permissões Essenciais.';

  @override
  String get onboarding_page_permissions_info =>
      'O Mindful requer as seguintes permissões essenciais para rastrear e gerenciar seu tempo de tela, ajudando a reduzir distrações e melhorar o foco.';

  @override
  String get dashboard_tab_title => 'Painel de controle';

  @override
  String get focus_now_fab_button => 'Focus now';

  @override
  String get welcome_greetings => 'Bem-vindo(a) de volta,';

  @override
  String get username_snack_alert => 'Pressione para editar o nome de usuário.';

  @override
  String get username_dialog_title => 'Nome de usuário';

  @override
  String get username_dialog_info =>
      'Digite seu nome de usuário que será exibido no painel.';

  @override
  String get username_dialog_button_apply => 'Aplicar';

  @override
  String get glance_tile_title => 'Glance';

  @override
  String get glance_tile_subtitle => 'Take a quick glance at your usage.';

  @override
  String get parental_controls_tile_subtitle =>
      'Invincible mode and tamper protection.';

  @override
  String get restrictions_heading => 'Restrições';

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
  String get screen_time_label => 'Tempo de tela';

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
  String get longest_streak_label => 'Sequência mais longa';

  @override
  String get current_streak_label => 'Sequência atual';

  @override
  String get successful_sessions_label => 'Sessões bem sucedidas';

  @override
  String get failed_sessions_label => 'Sessões falhas';

  @override
  String get statistics_tab_title => 'Estatísticas';

  @override
  String get screen_segment_label => 'Tela';

  @override
  String get data_segment_label => 'Dados';

  @override
  String get mobile_label => 'Móvel';

  @override
  String get wifi_label => 'Wi-Fi';

  @override
  String get most_used_apps_heading => 'Aplicativos mais usados';

  @override
  String get show_all_apps_tile_title => 'Mostrar todos os aplicativos';

  @override
  String get search_apps_hint => 'Search apps...';

  @override
  String get notifications_tab_title => 'Notifications';

  @override
  String get notifications_tab_info =>
      'Batch notification from apps and set schedules like morning, noon, evening and night. Stay updated without constant interruptions.';

  @override
  String get batched_apps_tile_title => 'Aplicativos em grupo';

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
  String get schedules_heading => 'Agendamentos';

  @override
  String get new_schedule_fab_button => 'Novo agendamento';

  @override
  String get new_schedule_dialog_info =>
      'Enter a name for the notification schedule to help identify it easily.';

  @override
  String get new_schedule_dialog_field_label => 'Nome do agendamento';

  @override
  String get bedtime_tab_title => 'Hora de dormir';

  @override
  String get bedtime_tab_info =>
      'Defina o seu horário de dormir, selecionando um período e dias da semana. Escolha apps de distração para bloquear e ativar o modo Não Perturbe (DND) para uma noite tranquila.';

  @override
  String get schedule_tile_title => 'Agendar';

  @override
  String get schedule_tile_subtitle =>
      'Ativar ou desativar agendamento diário.';

  @override
  String get bedtime_no_days_selected_snack_alert =>
      'Selecione pelo menos um dia da semana.';

  @override
  String get bedtime_minimum_duration_snack_alert =>
      'A duração total do tempo de dormir deve ser de pelo menos 30 minutos.';

  @override
  String get distracting_apps_tile_title => 'Aplicativos distrativos';

  @override
  String get distracting_apps_tile_subtitle =>
      'Selecione quais aplicativos estão distraindo você de sua rotina de dormir.';

  @override
  String get bedtime_distracting_apps_modify_snack_alert =>
      'Modificações na lista de aplicativos distrativos não são permitidas enquanto o horário de dormir estiver ativo.';

  @override
  String get parental_controls_tab_title => 'Parental controls';

  @override
  String get invincible_mode_heading => 'Modo Invencível';

  @override
  String get invincible_mode_tile_title => 'Ativar modo invencível';

  @override
  String get invincible_mode_info =>
      'When Invincible Mode is on, you won\'t be able to adjust selected limits after reaching your daily quota. However, you can make changes within a selected 10-minute invincible window.';

  @override
  String get invincible_mode_snack_alert =>
      'Due to invincible mode, modifications to restrictions is not allowed.';

  @override
  String get invincible_mode_dialog_info =>
      'Tem certeza de que deseja ativar o modo Invencível? Esta ação é irreversível. Visto que o modo invencível está ligado, você não pode desligá-lo enquanto este aplicativo estiver instalado no seu dispositivo.';

  @override
  String get invincible_mode_turn_off_snack_alert =>
      'Invincible Mode cannot be turned off as long as this app remains installed on your device.';

  @override
  String get invincible_mode_dialog_button_start_anyway =>
      'Iniciar mesmo assim';

  @override
  String get invincible_mode_include_timer_tile_title => 'Incluir cronômetro';

  @override
  String get invincible_mode_include_launch_limit_tile_title =>
      'Incluir limite de inicialização';

  @override
  String get invincible_mode_include_active_period_tile_title =>
      'Incluir período ativo';

  @override
  String get invincible_mode_app_restrictions_tile_title =>
      'Restrições do aplicativo';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle =>
      'Prevent changes to the app\'s selected restrictions once the daily limits are exceeded.';

  @override
  String get invincible_mode_group_restrictions_tile_title =>
      'Restrições de grupo';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle =>
      'Prevent changes to the group\'s selected restrictions once the daily limits are exceeded.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title =>
      'Incluir temporizador curto';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle =>
      'Prevents changes after reaching your daily shorts limit.';

  @override
  String get invincible_mode_include_bedtime_tile_title =>
      'Incluir horário de dormir';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle =>
      'Prevents changes during the active bedtime schedule.';

  @override
  String get protected_access_tile_title => 'Acesso protegido';

  @override
  String get protected_access_tile_subtitle =>
      'Proteja Mindful com o bloqueio do seu dispositivo.';

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
  String get uninstall_window_tile_title => 'Desinstalar uma janela';

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
  String get short_content_heading => 'Conteúdo curto';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Restantes de $timeShortString';
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
  String get adult_content_heading => 'Conteúdo adulto';

  @override
  String get block_nsfw_title => 'Bloquear Nsfw';

  @override
  String get block_nsfw_subtitle =>
      'Restringir que navegadores abram sites adultos e pornográficos.';

  @override
  String get block_nsfw_dialog_info =>
      'Tem certeza? Esta ação é irreversível. Uma vez que o bloqueador de sites para adultos está ligado, você não pode desligá-lo enquanto este aplicativo estiver instalado no seu dispositivo.';

  @override
  String get block_nsfw_dialog_button_block_anyway => 'Bloquear mesmo assim';

  @override
  String get blocked_websites_heading => 'Sites bloqueados';

  @override
  String get blocked_websites_empty_list_hint =>
      'Clique no botão \'+ Adicionar Site\' para adicionar sites que você deseja bloquear.';

  @override
  String get add_website_fab_button => 'Adicionar site';

  @override
  String get add_website_dialog_title => 'Site distrativo';

  @override
  String get add_website_dialog_info =>
      'Digite o URL de um site que você deseja bloquear.';

  @override
  String get add_website_dialog_is_nsfw => 'Is nsfw site?';

  @override
  String get add_website_dialog_nsfw_warning =>
      'Warning: Nsfw sites cannot be removed once added.';

  @override
  String get add_website_dialog_button_block => 'Bloquear';

  @override
  String get add_website_already_exist_snack_alert =>
      'O URL já foi adicionado à lista de sites bloqueados.';

  @override
  String get add_website_invalid_url_snack_alert =>
      'URL inválido! Não foi possível analisar o nome do host.';

  @override
  String get remove_website_dialog_title => 'Remover site';

  @override
  String remove_website_dialog_info(String websitehost) {
    return 'Você tem certeza? Você quer remover \'$websitehost\' de sites bloqueados.';
  }

  @override
  String get focus_tab_title => 'Foco';

  @override
  String get focus_tab_info =>
      'Quando precisar de tempo para se concentrar, inicie uma nova sessão selecionando o tipo, escolhendo apps distrativos para pausar e ativando a opção Não perturbar para uma concentração ininterrupta.';

  @override
  String get active_session_card_title => 'Sessão ativa';

  @override
  String get active_session_card_info =>
      'Você tem uma sessão de foco ativo em execução! Clique em \'Ver\' para verificar o seu progresso e ver quanto tempo se passou.';

  @override
  String get active_session_card_view_button => 'Exibir';

  @override
  String get focus_distracting_apps_removal_snack_alert =>
      'Não é permitido remover aplicativos da lista de aplicativos distrativos enquanto uma sessão de foco estiver ativa. No entanto, você ainda pode adicionar aplicativos adicionais à lista durante esse período.';

  @override
  String get focus_profile_tile_title => 'Focus profile';

  @override
  String get focus_session_duration_tile_title => 'Duração de sessão';

  @override
  String get focus_session_duration_tile_subtitle =>
      'Infinito (A menos que você pare)';

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
      'Selecione pelo menos um aplicativo de distração para iniciar a sessão de foco';

  @override
  String get focus_session_already_active_snack_alert =>
      'Você já tem uma sessão de foco ativa em execução. Por favor, complete ou pare a sua sessão atual antes de iniciar uma nova.';

  @override
  String get focus_session_type_study => 'Estudos';

  @override
  String get focus_session_type_work => 'Trabalho';

  @override
  String get focus_session_type_exercise => 'Treinar';

  @override
  String get focus_session_type_meditation => 'Meditação';

  @override
  String get focus_session_type_creativeWriting => 'Escrita criativa';

  @override
  String get focus_session_type_reading => 'Leitura';

  @override
  String get focus_session_type_programming => 'Programando';

  @override
  String get focus_session_type_chores => 'Tarefas domésticas';

  @override
  String get focus_session_type_projectPlanning => 'Planejamento de projeto';

  @override
  String get focus_session_type_artAndDesign => 'Arte e Design';

  @override
  String get focus_session_type_languageLearning => 'Aprendizagem de idiomas';

  @override
  String get focus_session_type_musicPractice => 'Prática musical';

  @override
  String get focus_session_type_selfCare => 'Cuidados pessoais';

  @override
  String get focus_session_type_brainstorming => 'Chuva de Ideias';

  @override
  String get focus_session_type_skillDevelopment =>
      'Desenvolvimento de Habilidades';

  @override
  String get focus_session_type_research => 'Pesquisa';

  @override
  String get focus_session_type_networking => 'Socialização';

  @override
  String get focus_session_type_cooking => 'Cozinhar';

  @override
  String get focus_session_type_sportsTraining => 'Treinamento Esportivo';

  @override
  String get focus_session_type_restAndRelaxation => 'Descansar e Relaxar';

  @override
  String get focus_session_type_other => 'Outros';

  @override
  String get timeline_tab_title => 'Linha do Tempo';

  @override
  String get focus_timeline_tab_info =>
      'Explore your focus journey by selecting a date from the calendar. Track your progress, revisit your successes, and learn from the challenges.';

  @override
  String selected_month_productive_time_snack_alert(String timeString) {
    return 'Seu tempo produtivo total para o mês selecionado é de $timeString.';
  }

  @override
  String get selected_month_productive_days_label => 'Dias produtivos';

  @override
  String selected_month_productive_days_snack_alert(num daysCount) {
    return 'Você teve um total de $daysCount dias produtivos no mês selecionado.';
  }

  @override
  String get selected_day_focused_time_label => 'Tempo focado';

  @override
  String selected_day_focused_time_snack_alert(String timeString) {
    return 'Seu tempo total focado para o dia selecionado é de $timeString.';
  }

  @override
  String get calender_heading => 'Calendário';

  @override
  String get your_sessions_heading => 'Suas sessões';

  @override
  String get your_sessions_empty_list_hint =>
      'Nenhuma sessão de foco registrada para o dia selecionado.';

  @override
  String get focus_session_tile_timestamp_label => 'Timestamp';

  @override
  String get focus_session_tile_duration_label => 'Duração';

  @override
  String get focus_session_tile_reflection_label => 'Reflection';

  @override
  String get focus_session_state_active => 'Ativo';

  @override
  String get focus_session_state_successful => 'Bem-sucedido';

  @override
  String get focus_session_state_failed => 'Mal-sucedido';

  @override
  String get active_session_tab_title => 'Sessão';

  @override
  String get active_session_none_warning =>
      'No active session found. Returning to the home screen.';

  @override
  String get active_session_dialog_button_keep_pushing => 'Continue insistindo';

  @override
  String get active_session_finish_dialog_title => 'Finalizar';

  @override
  String get active_session_finish_dialog_info =>
      'Mantenha-se forte! Você está construindo um foco valioso. Tem certeza que você quer terminar essa sessão de foco? Todo momento extra conta para seus objetivos';

  @override
  String get active_session_giveup_dialog_title => 'Desistir';

  @override
  String get active_session_giveup_dialog_info =>
      'Espere! Você está quase lá não desista agora! Tem certeza que quer terminar esta sessão de foco mais cedo? O progresso será perdido.';

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
      'Você desistiu! Não se preocupe, você pode fazer melhor da próxima vez. Cada esforço conta — apenas continue';

  @override
  String get active_session_quote_one =>
      'Cada passo conta, fique forte e continue!';

  @override
  String get active_session_quote_two =>
      'Fique focado! Você está fazendo um progresso incrível!';

  @override
  String get active_session_quote_three =>
      'Você está esmagando! Mantenha o ritmo!';

  @override
  String get active_session_quote_four =>
      'Só mais um pouco, você está indo muito bem!';

  @override
  String active_session_quote_five(String durationString) {
    return 'Parabéns! 🎉\n Você concluiu sua sessão de foco de $durationString.';
  }

  @override
  String get restriction_groups_tab_title => 'Grupos restringidos';

  @override
  String get restriction_groups_tab_info =>
      'Set a combined screen time limit for a group of apps. Once the total usage reaches your limit, all apps in the group will be paused to help maintain focus and balance.';

  @override
  String get restriction_group_time_spent_label => 'Tempo gasto hoje';

  @override
  String get restriction_group_time_left_label => 'Tempo restante hoje';

  @override
  String get restriction_group_name_tile_title => 'Nome do grupo';

  @override
  String get restriction_group_name_picker_dialog_info =>
      'Digite um nome para os grupos restringidos para ajudar a identificar e gerenciá-los facilmente.';

  @override
  String get restriction_group_timer_tile_title => 'Temporizador do grupo';

  @override
  String get restriction_group_timer_picker_dialog_info =>
      'Defina um limite diário para este grupo. Dado que o seu limite seja atingido, todos os aplicativos desse grupo serão pausados até a meia-noite.';

  @override
  String get restriction_group_active_period_tile_title =>
      'Group active period';

  @override
  String get remove_restriction_group_dialog_title => 'Remover grupo';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return 'Tem certeza? Você quer remover \'$groupName\' de grupos restritos.';
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
  String get emergency_fab_button => 'Emergência';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return 'Esta ação irá pausar o bloqueador de aplicativos pelos próximos 5 minutos. Você tem $leftPassesCount passes restantes. Após usar todos os passes, o aplicativo permanecerá bloqueado até a meia-noite ou a sessão de foco ativo terminará.\n\nVocê ainda deseja prosseguir?';
  }

  @override
  String get emergency_dialog_button_use_anyway => 'Usar mesmo assim';

  @override
  String get emergency_started_snack_alert =>
      'O bloqueador de apps está em pausa e continuará bloqueando por 5 minutos.';

  @override
  String get emergency_already_active_snack_alert =>
      'O bloqueador de aplicativos está pausado ou inativo. Se as notificações estiverem ativadas, você receberá atualizações sobre o tempo restante.';

  @override
  String get emergency_no_pass_left_snack_alert =>
      'Você usou todos os seus passes de emergência. Os aplicativos bloqueados permanecerão bloqueados até a meia-noite ou até a sessão de foco ativo terminar.';

  @override
  String get app_limit_status_not_set => 'Não definido';

  @override
  String get app_timer_tile_title => 'Cronômetro do app';

  @override
  String get app_timer_picker_dialog_info =>
      'Set a daily time limit for this app. Once your limit is reached, the app will be paused until midnight.';

  @override
  String get usage_reminders_tile_title => 'Usage reminders';

  @override
  String get usage_reminders_tile_subtitle =>
      'Gentle nudges when using timed apps.';

  @override
  String get app_launch_limit_tile_title => 'Limite de inicialização';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Lançou $count vezes hoje.';
  }

  @override
  String get app_launch_limit_picker_dialog_info =>
      'Set how many times you can open this app each day. Once the limit is reached, it will be paused until midnight.';

  @override
  String get app_active_period_tile_title => 'Período ativo';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return 'De $startTime para $endTime';
  }

  @override
  String get internet_access_tile_title => 'Acesso à internet';

  @override
  String get internet_access_tile_subtitle =>
      'Desative para bloquear a internet do app.';

  @override
  String internet_access_blocked_snack_alert(String appName) {
    return 'A rede do $appName está bloqueada.';
  }

  @override
  String internet_access_unblocked_snack_alert(String appName) {
    return 'A rede do $appName está desbloqueada.';
  }

  @override
  String get launch_app_tile_title => 'Iniciar aplicativo';

  @override
  String launch_app_tile_subtitle(String appName) {
    return 'Abrir $appName.';
  }

  @override
  String get go_to_app_settings_tile_title =>
      'Vá para Configurações de aplicativo';

  @override
  String get go_to_app_settings_tile_subtitle =>
      'Manage app settings like notifications, permissions, storage and more.';

  @override
  String get include_in_stats_tile_title => 'Incluir no uso de tela';

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
  String get general_tab_title => 'Geral';

  @override
  String get appearance_heading => 'Aparência';

  @override
  String get theme_mode_tile_title => 'Modo do tema';

  @override
  String get theme_mode_system_label => 'Sistemas';

  @override
  String get theme_mode_light_label => 'Claro';

  @override
  String get theme_mode_dark_label => 'Escuro';

  @override
  String get material_color_tile_title => 'Cores materiais';

  @override
  String get amoled_dark_tile_title => 'Escuro (AMOLED)';

  @override
  String get amoled_dark_tile_subtitle =>
      'Use cor preta pura para o tema escuro.';

  @override
  String get dynamic_colors_tile_title => 'Cores dinâmicas';

  @override
  String get dynamic_colors_tile_subtitle =>
      'Use as cores do dispositivo, se suportado.';

  @override
  String get defaults_heading => 'Padrões';

  @override
  String get app_language_tile_title => 'Idioma do aplicativo';

  @override
  String get default_home_tab_tile_title => 'Aba inicial';

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
  String get service_heading => 'Serviço';

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
  String get database_tab_title => 'Banco de dados';

  @override
  String get import_db_tile_title => 'Importar o banco de dados';

  @override
  String get import_db_tile_subtitle =>
      'Importar o banco de dados de um arquivo.';

  @override
  String get export_db_tile_title => 'Exportar banco de dados';

  @override
  String get export_db_tile_subtitle =>
      'Exportar o banco de dados de um arquivo.';

  @override
  String get crash_logs_heading => 'Relatório de erros';

  @override
  String get crash_logs_info =>
      'Se você encontrar algum problema, pode reportá-lo no GitHub com o arquivo de log. O arquivo incluirá detalhes como o fabricante, modelo, versão do Android, versão do SDK e registros de falha. Estas informações nos ajuda a identificar e a resolver o problema de forma eficaz.';

  @override
  String get crash_logs_export_tile_title => 'Exportar registros de erro';

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
  String get crash_logs_clear_tile_title => 'Limpar registros';

  @override
  String get crash_logs_clear_tile_subtitle =>
      'Apagar todos os registros de erro do banco de dados.';

  @override
  String get crash_logs_clear_dialog_info =>
      'Tem certeza de que deseja limpar todos os registros de erro do banco de dados?';

  @override
  String get crash_logs_clear_dialog_button_clear_anyway =>
      'Limpar mesmo assim';

  @override
  String get about_tab_title => 'Sobre';

  @override
  String get changelog_tile_title => 'Histórico de mudanças';

  @override
  String get changelog_tile_subtitle => 'Find out what\'s new.';

  @override
  String get full_changelog_tile_title => 'Full changelog';

  @override
  String get redirected_to_github_subtitle =>
      'Você vai ser redirecionado para o GitHub.';

  @override
  String get contribute_heading => 'Contribute';

  @override
  String get github_tile_title => 'GitHub';

  @override
  String get github_tile_subtitle => 'View the source code.';

  @override
  String get report_issue_tile_title => 'Reportar um problema';

  @override
  String get suggest_idea_tile_title => 'Sugerir uma ideia';

  @override
  String get write_email_tile_title => 'Write to us via email';

  @override
  String get write_email_tile_subtitle =>
      'Você será redirecionado para o aplicativo de E-mail.';

  @override
  String get privacy_policy_heading => 'Política de privacidade';

  @override
  String get privacy_policy_info =>
      'A Mindful está empenhado em proteger a sua privacidade. Não recolhemos, armazenamos ou transferimos qualquer tipo de dados do usuário. O aplicativo funciona totalmente offline e não requer uma conexão com a Internet, garantindo que suas informações pessoais permaneçam privadas e seguras em seu dispositivo. Como um aplicativo de software livre e de código aberto (FOSS), o Mindful garante total transparência e controle do usuário sobre seus dados.';

  @override
  String get more_details_button => 'Mais detalhes';
}
