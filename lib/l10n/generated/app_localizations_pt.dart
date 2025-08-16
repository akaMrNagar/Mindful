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
      'Mindful requer permissão de acessibilidade para bloquear conteúdo curto e websites de forma eficaz.';

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
      'Os privilégios administrativos são necessários apenas para operações essenciais para garantir que o aplicativo funcione de adequadamente e permaneça à prova da proteção contra desinstalação.';

  @override
  String get permission_admin_snack_alert =>
      'A proteção contra desinstalação só pode ser desativada durante a janela de tempo selecionada.';

  @override
  String get permission_notification_access_title => 'Acesso às Notificações';

  @override
  String get permission_notification_access_info =>
      'Conceda permissão de acesso à notificação. Isso permitirá que Mindful  organize suas notificações e leva-las em sua agenda.';

  @override
  String get permission_notification_access_required =>
      'Mindful requer acesso a notificações para agrupar e agendar notificações.';

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
      'Você tem certeza que deseja sair sem salvar?';

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
      'O uso e restrições da tela estão indisponíveis para este aplicativo. Atualmente, apenas o uso da rede está acessível';

  @override
  String get create_group_fab_button => 'Criar Grupo';

  @override
  String get active_period_info =>
      'Defina um período durante o qual o acesso será permitido. Fora deste intervalo, o acesso será restrito.';

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
      'Mindful será reiniciado automaticamente quando a contagem regressiva terminar. Por favor, seja paciente como as mudanças são aplicadas.';

  @override
  String get accessibility_tip =>
      'Quer um bloqueio mais inteligente e amigável à bateria? Ative a permissão de acessibilidade para o Mindful.';

  @override
  String get battery_optimization_tip =>
      'Mindful não está funcionando? Permitir \'Ignorar Otimização da bateria\' nas Configurações para mantê-lo funcionando sem problemas.';

  @override
  String get invincible_mode_tip =>
      'Restrições removidas acidentalmente? Use o Modo Invencível para bloqueá-los até o dia seguinte ou até o período de ajuste.';

  @override
  String get glance_usage_tip =>
      'Quer ideias? Verifique a seção Resumo rápido para ver seus padrões de uso e tempo de tela.';

  @override
  String get tamper_protection_tip =>
      'Desinstalar o Mindful? Habilite a Janela de Desinstalação para desativar a proteção de desinstalação com segurança primeiro.';

  @override
  String get notification_blocking_tip =>
      'Quer reduzir as distrações? Use o Bloqueio de Notificações para silenciar os aplicativos selecionados.';

  @override
  String get usage_history_tip =>
      'Quer refletir sobre seus hábitos? Verifique o Histórico de Uso para ver os padrões anteriores.';

  @override
  String get focus_mode_tip =>
      'Precisa de foco profundo? Ative o Modo Foco para bloquear aplicativos e notificações durante tarefas.';

  @override
  String get bedtime_reminder_tip =>
      'Quer melhorar seu sono? Defina um Lembrete de Horário de Dormir para relaxar à noite.';

  @override
  String get custom_blocking_tip =>
      'Precisa de uma experiência personalizada? Crie regras de bloqueio de aplicativos que atendam às suas necessidades.';

  @override
  String get session_timeline_tip =>
      'Quer acompanhar as sessões de foco? Veja o cronograma para ver sua jornada de foco.';

  @override
  String get short_content_blocking_tip =>
      'Distraído(a) por aplicativos sociais? Bloqueie conteúdo curto no Instagram, YouTube, etc. para se manter o foco.';

  @override
  String get parental_controls_tip =>
      'Precisa de controle dos pais? Defina restrições para o dispositivo do seu filho para garantir uma experiência segura.';

  @override
  String get notification_batching_tip =>
      'Quer reduzir distrações? Use o Agrupamento de Notificações para agrupar notificações e verificá-las de uma vez.';

  @override
  String get notification_scheduling_tip =>
      'Precisa gerenciar as notificações? Programe quando você receber notificações de aplicativos específicos.';

  @override
  String get quick_focus_tile_tip =>
      'Precisa de acesso rápido ao foco? Adicione um Atalho de Foco Rápido para ativar o Modo de Foco instantaneamente.';

  @override
  String get app_shortcuts_tip =>
      'Quer acesso instantâneo ao aplicativo? Adicione atalhos pressionando longamente o ícone do aplicativo para ações rápidas.';

  @override
  String get backup_usage_db_tip =>
      'Quer salvar seus dados? Faça backup do seu banco de dados para manter os seus registros seguros.';

  @override
  String get dynamic_material_color_tip =>
      'Quer um tema personalizado? Ative a cor dinâmica do Material You para combinar com o tema do seu dispositivo.';

  @override
  String get amoled_dark_theme_tip =>
      'Quer economizar bateria? Use o Tema Escuro AMOLED para reduzir o consumo de energia em telas OLED.';

  @override
  String get customize_usage_history_tip =>
      'Quer manter o histórico de uso? Personalize quantas semanas de dados serão armazenados no Histórico de Uso.';

  @override
  String get grouped_apps_blocking_tip =>
      'Quer bloquear aplicativos juntos? Use Grupos de Restrições para agrupar limites de aplicativos e bloquear vários aplicativos de uma só vez.';

  @override
  String get websites_blocking_tip =>
      'Quer uma experiência de navegação mais limpa? Bloqueie websites personalizados ou NSFW para um tempo on-line mais focado.';

  @override
  String get data_usage_tip =>
      'Quer rastrear seus dados? Monitore seu uso de dados móveis e Wi-Fi para consumo na internet.';

  @override
  String get block_internet_tip =>
      'Precisa bloquear a internet de um aplicativo? Desligue a internet para um aplicativo específico no painel do aplicativo.';

  @override
  String get emergency_passes_tip =>
      'Precisa de uma pausa? Use 3 Passes de Emergência diariamente para desbloquear temporariamente os aplicativos por 5 minutos.';

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
  String get focus_now_fab_button => 'Focar agora';

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
  String get glance_tile_title => 'Resumo rápido';

  @override
  String get glance_tile_subtitle => 'Dê uma olhada rápida em seu uso.';

  @override
  String get parental_controls_tile_subtitle =>
      'Modo invencível e proteção contra desinstalação.';

  @override
  String get restrictions_heading => 'Restrições';

  @override
  String get apps_blocking_tile_title => 'Bloqueio de aplicativos';

  @override
  String get apps_blocking_tile_subtitle =>
      'Limite os aplicativos de múltiplas maneiras.';

  @override
  String get grouped_apps_blocking_tile_title =>
      'Bloqueio de aplicativos agrupados';

  @override
  String get grouped_apps_blocking_tile_subtitle =>
      'Limite grupo de aplicativos simultaneamente.';

  @override
  String get shorts_blocking_tile_subtitle =>
      'Limite conteúdo curto em múltiplas plataformas.';

  @override
  String get websites_blocking_tile_subtitle =>
      'Limite sites adultos e personalizados.';

  @override
  String get screen_time_label => 'Tempo de tela';

  @override
  String get total_data_label => 'Dados totais';

  @override
  String get mobile_data_label => 'Dados móveis';

  @override
  String get wifi_data_label => 'Dados Wi-Fi';

  @override
  String get focus_today_label => 'Foco hoje';

  @override
  String get focus_weekly_label => 'Foco semanal';

  @override
  String get focus_monthly_label => 'Focar mensal';

  @override
  String get focus_lifetime_label => 'Foco total';

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
  String get search_apps_hint => 'Procurar aplicativos...';

  @override
  String get notifications_tab_title => 'Notificações';

  @override
  String get notifications_tab_info =>
      'Agrupe notificações de aplicativos e defina horários como manhã, meio-dia e noite. Fique atualizado sem interrupções constantes.';

  @override
  String get batched_apps_tile_title => 'Aplicativos em grupo';

  @override
  String get batch_recap_dropdown_title => 'Tipo de resumo agrupado';

  @override
  String get batch_recap_dropdown_info =>
      'Escolha o que enviar quando um agendamento disparar — todas as notificações ou apenas um resumo.';

  @override
  String get batch_recap_option_summery_only => 'Apenas resumo';

  @override
  String get batch_recap_option_all_notifications => 'Todas as notificações';

  @override
  String get notification_history_tile_title => 'Histórico de notificações';

  @override
  String get store_all_tile_title => 'Armazenar todas as notificações';

  @override
  String get store_all_tile_subtitle =>
      'Salvar também notificações não agrupadas.';

  @override
  String get schedules_heading => 'Agendamentos';

  @override
  String get new_schedule_fab_button => 'Novo agendamento';

  @override
  String get new_schedule_dialog_info =>
      'Digite um nome para o agendamento de notificações para ajudá-lo a identificá-lo facilmente.';

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
  String get parental_controls_tab_title => 'Controle de Pais';

  @override
  String get invincible_mode_heading => 'Modo Invencível';

  @override
  String get invincible_mode_tile_title => 'Ativar modo invencível';

  @override
  String get invincible_mode_info =>
      'Quando o Modo Invencível está ativado, você não poderá ajustar os limites selecionados após atingir sua cota diária. No entanto, você pode fazer alterações dentro de uma janela invencível de 10 minutos.';

  @override
  String get invincible_mode_snack_alert =>
      'Devido ao Modo Invencível, modificações nas restrições não são permitidas.';

  @override
  String get invincible_mode_dialog_info =>
      'Tem certeza de que deseja ativar o modo Invencível? Esta ação é irreversível. Visto que o modo invencível está ligado, você não pode desligá-lo enquanto este aplicativo estiver instalado no seu dispositivo.';

  @override
  String get invincible_mode_turn_off_snack_alert =>
      'O Modo Invencível não pode ser desativado enquanto este aplicativo permanecer instalado no seu dispositivo.';

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
      'Impede alterações nas restrições selecionadas do aplicativo quando os limites diários forem excedidos.';

  @override
  String get invincible_mode_group_restrictions_tile_title =>
      'Restrições de grupo';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle =>
      'Impede alterações nas restrições selecionadas do grupo quando os limites diários forem excedidos.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title =>
      'Incluir temporizador curto';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle =>
      'Impede alterações após atingir seu limite diário de vídeos curtos.';

  @override
  String get invincible_mode_include_bedtime_tile_title =>
      'Incluir horário de dormir';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle =>
      'Impede alterações durante a programação do horário de dormir ativa.';

  @override
  String get protected_access_tile_title => 'Acesso protegido';

  @override
  String get protected_access_tile_subtitle =>
      'Proteja Mindful com o bloqueio do seu dispositivo.';

  @override
  String get protected_access_no_lock_snack_alert =>
      'Por favor, configure um bloqueio biométrico no seu dispositivo primeiro para ativar esta função.';

  @override
  String get protected_access_removed_lock_snack_alert =>
      'O bloqueio do seu dispositivo foi removido. Para continuar, por favor configure um novo bloqueio.';

  @override
  String get protected_access_failed_lock_snack_alert =>
      'Falha na autenticação. Você precisa verificar o bloqueio do seu dispositivo para continuar.';

  @override
  String get tamper_protection_tile_title => 'Proteção contra desinstalação';

  @override
  String get tamper_protection_tile_subtitle =>
      'Impede a desinstalação e força a parada do aplicativo.';

  @override
  String get tamper_protection_confirmation_dialog_info =>
      'Uma vez ativado, você não poderá desinstalar, forçar parada ou limpar os dados do Mindful, exceto durante a janela de desinstalação selecionada. Não há soluções alternativas.\n\nProssiga por sua conta e risco.';

  @override
  String get uninstall_window_tile_title => 'Desinstalar uma janela';

  @override
  String get uninstall_window_tile_subtitle =>
      'A proteção contra desinstalação pode ser desativada dentro de 10 minutos a partir horário selecionado.';

  @override
  String get invincible_window_tile_title => 'Janela invencível';

  @override
  String get invincible_window_tile_subtitle =>
      'Os limites selecionados podem ser modificados dentro de 10 minutos a partir do horário selecionado.';

  @override
  String get shorts_blocking_tab_title => 'Bloqueio de vídeos curtos';

  @override
  String get shorts_blocking_tab_info =>
      'Controle quanto tempo você gasta em conteúdo curto em plataformas como Instagram, YouTube, Snapchat e Facebook, incluindo seus sites.';

  @override
  String get short_content_heading => 'Conteúdo curto';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Restantes de $timeShortString';
  }

  @override
  String get short_content_timer_picker_dialog_info =>
      'Defina um tempo diário para conteúdo curto. Quando seu limite for atingido, o conteúdo curto será pausado até a meia-noite.';

  @override
  String get instagram_features_tile_title => 'Instagram';

  @override
  String get instagram_features_tile_subtitle =>
      'Restringir recursos no Instagram.';

  @override
  String get instagram_features_block_reels => 'Restringir a seção de reels.';

  @override
  String get instagram_features_block_explore => 'Restringir a seção explorar.';

  @override
  String get snapchat_features_tile_title => 'Snapchat';

  @override
  String get snapchat_features_tile_subtitle =>
      'Restringir recursos no Snapchat.';

  @override
  String get snapchat_features_block_spotlight =>
      'Restringir a seção spotlight.';

  @override
  String get snapchat_features_block_discover =>
      'Restringir a seção de descobrir.';

  @override
  String get youtube_features_tile_title => 'YouTube';

  @override
  String get youtube_features_tile_subtitle => 'Restringir shorts no YouTube.';

  @override
  String get facebook_features_tile_title => 'Facebook';

  @override
  String get facebook_features_tile_subtitle => 'Restringir reels no Facebook.';

  @override
  String get reddit_features_tile_title => 'Reddit';

  @override
  String get reddit_features_tile_subtitle => 'Restringir shorts no Reddit.';

  @override
  String get websites_blocking_tab_title => 'Bloqueio de websites';

  @override
  String get websites_blocking_tab_info =>
      'Bloqueie websites adultos e qualquer site personalizado que escolher para criar uma experiência on-line mais segura e mais focada. Assuma o controle da sua navegação e mantenha-se livre de distrações.';

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
  String get add_website_dialog_is_nsfw => 'É um website com conteúdo adulto?';

  @override
  String get add_website_dialog_nsfw_warning =>
      'Aviso: Websites com conteúdo adulto não podem ser removidos uma vez adicionados.';

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
  String get focus_profile_tile_title => 'Perfil de foco';

  @override
  String get focus_session_duration_tile_title => 'Duração de sessão';

  @override
  String get focus_session_duration_tile_subtitle =>
      'Infinito (A menos que você pare)';

  @override
  String get focus_session_duration_dialog_info =>
      'Por favor, selecione a duração desejada para esta sessão de foco, determinando quanto tempo você deseja permanecer focado e livre de distrações.';

  @override
  String get focus_profile_customization_tile_title =>
      'Personalização do perfil';

  @override
  String get focus_profile_customization_tile_subtitle =>
      'Personalize as configurações do perfil selecionado.';

  @override
  String get focus_enforce_tile_title => 'Forçar sessão';

  @override
  String get focus_enforce_tile_subtitle =>
      'Impede terminar uma sessão antes do tempo terminar.';

  @override
  String get focus_session_start_button => 'Deslize para iniciar a sessão';

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
      'Explore sua jornada de foco selecionando uma data do calendário. Acompanhe seu progresso, revisite seus sucessos e aprenda com os desafios.';

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
  String get focus_session_tile_timestamp_label => 'Marcação de data/hora';

  @override
  String get focus_session_tile_duration_label => 'Duração';

  @override
  String get focus_session_tile_reflection_label => 'Reflexão';

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
      'Nenhuma sessão ativa encontrada. Retornando à tela inicial.';

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
  String get active_session_reflection_dialog_title => 'Reflexo de sessão';

  @override
  String get active_session_reflection_dialog_info =>
      'Dedique um momento para refletir sobre seu progresso. Qual é o seu objetivo para esta sessão? O que você cumpriu durante esta sessão?';

  @override
  String get active_session_reflection_dialog_tip =>
      'Dica: Você sempre pode editar isso mais tarde na linha do tempo da sessão.';

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
      'Defina um limite combinado de tempo de tela para um grupo de aplicativos. Quando o uso total atingir o seu limite, todos os aplicativos no grupo serão pausados para ajudar a manter o foco e o equilíbrio.';

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
      'Período ativo do grupo';

  @override
  String get remove_restriction_group_dialog_title => 'Remover grupo';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return 'Tem certeza? Você quer remover \'$groupName\' de grupos restritos.';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert =>
      'Defina um temporizador ou um limite de período ativo.';

  @override
  String get notifications_empty_list_hint =>
      'Nenhuma notificação foi agrupada no dia.';

  @override
  String get conversations_label => 'Conversas';

  @override
  String get last_24_hours_heading => 'Últimas 24 horas';

  @override
  String get notification_timeline_tab_info =>
      'Navegue pelo seu histórico de notificações selecionando uma data do calendário. Veja quais aplicativos pegaram sua atenção e reflita sobre seus hábitos digitais.';

  @override
  String get monthly_label => 'Mensalmente';

  @override
  String get daily_label => 'Diariamente';

  @override
  String get search_notifications_sheet_info =>
      'Encontre notificações anteriores facilmente procurando pelo título ou conteúdo delas. Isso ajuda você a localizar rapidamente alertas importantes.';

  @override
  String get search_notifications_hint => 'Pesquisar notificações...';

  @override
  String get search_notifications_empty_list_hint =>
      'Nenhuma notificação encontrada que corresponde à sua pesquisa.';

  @override
  String get app_info_none_warning =>
      'Não foi possível encontrar o aplicativo para o pacote informado. Retornando à tela inicial.';

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
      'Defina um limite diário de tempo para este aplicativo. Quando seu limite for atingido, o aplicativo será pausado até a meia-noite.';

  @override
  String get usage_reminders_tile_title => 'Lembretes de uso';

  @override
  String get usage_reminders_tile_subtitle =>
      'Alertas suaves ao usar aplicativos com tempo limitado.';

  @override
  String get app_launch_limit_tile_title => 'Limite de inicialização';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Lançou $count vezes hoje.';
  }

  @override
  String get app_launch_limit_picker_dialog_info =>
      'Defina quantas vezes você pode abrir este aplicativo por dia. Quando o limite for atingido, ele será pausado até a meia-noite.';

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
      'Gerencie as configurações do aplicativo como notificações, permissões, armazenamento e mais.';

  @override
  String get include_in_stats_tile_title => 'Incluir no uso de tela';

  @override
  String get include_in_stats_tile_subtitle =>
      'Desative para excluir este aplicativo do uso total de tela.';

  @override
  String app_excluded_from_stats_snack_alert(String appName) {
    return '$appName foi excluído do total de uso da tela.';
  }

  @override
  String app_include_to_stats_snack_alert(String appName) {
    return '$appName está incluído no total de uso de tela.';
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
  String get usage_history_tile_title => 'Histórico de uso';

  @override
  String get usage_history_15_days => '15 dias';

  @override
  String get usage_history_1_month => '1 mês';

  @override
  String get usage_history_3_month => '3 meses';

  @override
  String get usage_history_6_month => '6 Meses';

  @override
  String get usage_history_1_year => '1 ano';

  @override
  String get service_heading => 'Serviço';

  @override
  String get service_stopping_warning =>
      'Se o Mindful parar de funcionar inesperadamente, por favor, conceda a permissão \'Ignorar Otimização de bateria\' para mantê-lo em execução em segundo plano. Se o problema continuar, tente incluir o Mindful na lista de permissões para um desempenho ininterrupto.';

  @override
  String get whitelist_app_tile_title =>
      'Colocar Mindful na lista de permissões';

  @override
  String get whitelist_app_tile_subtitle =>
      'Permitir que o Mindful inicie automaticamente.';

  @override
  String get whitelist_app_unsupported_snack_alert =>
      'Este dispositivo não suporta gerenciamento automático de inicialização.';

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
      'Exportar registro de falhas para um arquivo json.';

  @override
  String get crash_logs_view_tile_title => 'Ver registros';

  @override
  String get crash_logs_view_tile_subtitle =>
      'Explore os registros de falhas armazenados.';

  @override
  String get crash_logs_empty_list_hint =>
      'Nenhuma falha registrada até agora.';

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
  String get changelog_tile_subtitle => 'Descubra o que há de novo.';

  @override
  String get full_changelog_tile_title => 'Histórico completo de alterações';

  @override
  String get redirected_to_github_subtitle =>
      'Você vai ser redirecionado para o GitHub.';

  @override
  String get contribute_heading => 'Contribuir';

  @override
  String get github_tile_title => 'GitHub';

  @override
  String get github_tile_subtitle => 'Veja o código-fonte.';

  @override
  String get report_issue_tile_title => 'Reportar um problema';

  @override
  String get suggest_idea_tile_title => 'Sugerir uma ideia';

  @override
  String get write_email_tile_title => 'Escreva-nos via e-mail';

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
