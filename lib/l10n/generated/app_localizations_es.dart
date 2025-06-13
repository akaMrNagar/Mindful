import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get mindful_tagline => 'Concéntrate en lo que realmente Importa';

  @override
  String get unlock_button_label => 'Desbloquear';

  @override
  String get permission_status_off => 'Desactivado';

  @override
  String get permission_status_allowed => 'Permitido';

  @override
  String get permission_status_not_allowed => 'No permitido';

  @override
  String get permission_button_grant_permission => 'Autorizar';

  @override
  String get permission_button_agree_and_continue => 'Aceptar y continuar';

  @override
  String get permission_button_not_now => 'Ahora no';

  @override
  String get permission_button_help => '¿Ayuda?';

  @override
  String get permission_sheet_privacy_info => 'Mindful es 100% seguro y funciona sin conexión. No recopilamos ni almacenamos datos personales.';

  @override
  String permission_grant_step_one(String button_label) {
    return '1. Haz clic en el botón $button_label.';
  }

  @override
  String get permission_grant_step_two => '2. Seleccione Mindful en la siguiente pantalla.';

  @override
  String get permission_grant_step_three => '3. Haga clic y encienda el interruptor como abajo.';

  @override
  String get permission_notification_title => 'Enviar notificaciones';

  @override
  String get permission_alarms_title => 'Alarmas y Recordatorios';

  @override
  String get permission_alarms_info => 'Por favor, concede permisos para configurar alarmas y recordatorios. Esto permitirá que Mindful inicie tu horario de sueño a tiempo, reinicie los temporizadores de la aplicación diariamente a medianoche y te ayude a mantener el control.';

  @override
  String get permission_alarms_device_tile_label => 'Permitir establecer alarmas y recordatorios';

  @override
  String get permission_usage_title => 'Acceso al uso';

  @override
  String get permission_usage_info => 'Por favor, concede permiso de acceso de uso. Esto permitirá a Mindful monitorizar el uso de aplicaciones y gestionar el acceso a ciertas apps, asegurando un entorno digital más enfocado y controlado.';

  @override
  String get permission_usage_device_tile_label => 'Permitir acceso al uso';

  @override
  String get permission_overlay_title => 'Mostrar superposición';

  @override
  String get permission_overlay_info => 'Por favor, concede el permiso de superposición de pantalla. Esto permitirá a Mindful mostrar una superposición cuando se abra una aplicación en pausa, ayudándote a mantenerte centrado y así mantener su horario.';

  @override
  String get permission_overlay_device_tile_label => 'Permitir mostrar sobre otras aplicaciones';

  @override
  String get permission_accessibility_title => 'Accesibilidad';

  @override
  String get permission_accessibility_info => 'Por favor, concede el permiso de accesibilidad. Esto permitirá a Mindful restringir el acceso al contenido de \"vídeo corto\" (P. ej., Reels, Shorts) dentro de las apps de redes sociales y los navegadores, y filtrar sitios web inapropiados.';

  @override
  String get permission_accessibility_required => 'Mindful requiere permiso de accesibilidad para bloquear de forma efectiva el contenido corto y los sitios web.';

  @override
  String get permission_accessibility_device_tile_label => 'Usar Mindful';

  @override
  String get permission_dnd_title => 'No molestar';

  @override
  String get permission_dnd_info => 'Por favor, concede acceso a No molestar. Esto permitirá a Mindful iniciar y detener el modo No molestar durante el horario de sueño.';

  @override
  String get permission_dnd_tile_title => 'Iniciar DND';

  @override
  String get permission_dnd_tile_subtitle => 'Activa también el modo No molestar.';

  @override
  String get permission_battery_optimization_tile_title => 'Ignorar la Optimización de la Batería';

  @override
  String get permission_battery_optimization_status_enabled => 'Actualmente \'sin restricciones\'';

  @override
  String get permission_battery_optimization_status_disabled => 'Desactivar las restricciones en segundo plano';

  @override
  String get permission_battery_optimization_allow_info => 'Permitir \'Ignorar la optimización de la batería\' automáticamente concederá el permiso \'Alarmas y Recordatorios\' en algunos dispositivos.';

  @override
  String get permission_vpn_title => 'Crear una VPN';

  @override
  String get permission_vpn_info => 'Por favor, concede el permiso para crear una conexión de Red Privada Virtual (VPN). Esto permitirá a Mindful restringir el acceso a internet para las aplicaciones designadas creando una VPN local en el dispositivo.';

  @override
  String get permission_admin_title => 'Admin';

  @override
  String get permission_admin_info => 'Los privilegios administrativos son necesarios sólo para operaciones esenciales para asegurar que la aplicación funciona correctamente y permanece a prueba de manipulación.';

  @override
  String get permission_admin_snack_alert => 'La protección contra manipulaciones solo se puede desactivar durante el período de tiempo seleccionado.';

  @override
  String get permission_notification_access_title => 'Acceso a Notificaciones';

  @override
  String get permission_notification_access_info => 'Por favor, concede el permiso de acceso a notificaciones. Esto permitirá a Mindful organizar tus notificaciones y entregarlas según tu horario.';

  @override
  String get permission_notification_access_required => 'Mindful requiere acceso a notificaciones para agrupar y programar las mismas.';

  @override
  String get permission_notification_access_device_tile_label => 'Permitir el acceso a las notificaciones';

  @override
  String get day_today => 'Hoy';

  @override
  String get day_yesterday => 'Ayer';

  @override
  String nDays(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString días',
      one: '1 día',
      zero: '0 días',
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
  String get time_separator_and => 'Y';

  @override
  String get timer_status_active => 'Activo';

  @override
  String get timer_status_paused => 'Pausado';

  @override
  String get create_button => 'Crear';

  @override
  String get update_button => 'Actualizar';

  @override
  String get dialog_button_cancel => 'Cancelar';

  @override
  String get dialog_button_remove => 'Eliminar';

  @override
  String get dialog_button_set => 'Aplicar';

  @override
  String get dialog_button_reset => 'Reiniciar';

  @override
  String get dialog_button_infinite => 'Infinito';

  @override
  String get schedule_start_label => 'Comienza';

  @override
  String get schedule_end_label => 'Termina';

  @override
  String get exit_without_saving_dialog_info => '¿Estás seguro de que quieres salir sin guardar?';

  @override
  String get development_dialog_info => 'Mindful se encuentra actualmente en desarrollo y puede contener errores funciones incompletas. Si encuentras algún problema, por favor, infórmanos para ayudarnos a mejorar.\n\n¡Gracias por tus comentarios!';

  @override
  String get development_dialog_button_report_issue => 'Reportar problema';

  @override
  String get development_dialog_button_close => 'Cerrar';

  @override
  String get dnd_settings_tile_title => 'Ajustes del modo no molestar';

  @override
  String get dnd_settings_tile_subtitle => 'Gestiona qué apps y notificaciones pueden llegarte en No Molestar.';

  @override
  String get quick_actions_heading => 'Acciones rápidas';

  @override
  String get select_distracting_apps_heading => 'Selecciona las apps que te distraen';

  @override
  String get your_distracting_apps_heading => 'Tus aplicaciones que te distraen';

  @override
  String get select_more_apps_heading => 'Selecciona más apps';

  @override
  String get imp_distracting_apps_snack_alert => 'No está permitido añadir aplicaciones de sistema importantes a la lista de aplicaciones de distracción.';

  @override
  String get custom_apps_quick_actions_unavailable_warning => 'Las restricciones y el uso de pantalla no están disponibles para esta aplicación. Actualmente, solo el uso de la red es accesible';

  @override
  String get create_group_fab_button => 'Crear Grupo';

  @override
  String get active_period_info => 'Establece un período de tiempo durante el cual se permitirá el acceso. Fuera de este marco de tiempo, el acceso estará restringido.';

  @override
  String get minimum_distracting_apps_snack_alert => 'Selecciona al menos una aplicación que te distraiga.';

  @override
  String get donation_card_title => 'Ayúdanos';

  @override
  String get donation_card_info => 'Mindful es gratuito y de código abierto, desarrollado con meses de dedicación. Si te ha sido útil, tu donación significaría muchísimo para nosotros. Cada contribución nos ayuda a seguir mejorando y manteniéndolo para todos.';

  @override
  String get operation_failed_snack_alert => 'Operación fallida, ¡algo salió mal!';

  @override
  String get donation_card_button_donate => 'Donar';

  @override
  String get app_restart_dialog_title => 'Es necesario reiniciar';

  @override
  String get app_restart_dialog_info => 'Mindful se reiniciará automáticamente una vez que termine la cuenta regresiva. Por favor, ten paciencia mientras se aplican los cambios.';

  @override
  String get accessibility_tip => '¿Quieres un bloqueo más inteligente y que gaste menos batería? Habilita el permiso de Accesibilidad para Mindful.';

  @override
  String get battery_optimization_tip => '¿Mindful no funciona? Permite \'Ignorar la optimización de la batería\' en los Ajustes para que siga funcionando sin problemas.';

  @override
  String get invincible_mode_tip => '¿Quitaste las restricciones por accidente? Usa el Modo Invencible para bloquearlas hasta el día siguiente o la ventana de ajuste.';

  @override
  String get glance_usage_tip => '¿Quieres estadísticas? Revisa la sección \'De un vistazo\' o \'Vistazo rápido\' para ver tus patrones de uso y tiempo de pantalla.';

  @override
  String get tamper_protection_tip => '¿Estas desinstalando Mindful? Habilita la Ventana de Desinstalación para desactivar la protección contra manipulaciones de forma segura primero.';

  @override
  String get notification_blocking_tip => '¿Quieres reducir las distracciones? Usa el Bloqueo de Notificaciones para silenciar las aplicaciones seleccionadas.';

  @override
  String get usage_history_tip => '¿Quieres reflexionar sobre tus hábitos? Revisa el Historial de Uso para ver patrones pasados.';

  @override
  String get focus_mode_tip => '¿Necesitas concentración profunda? Activa el Modo Enfoque para bloquear aplicaciones y notificaciones durante las tareas.';

  @override
  String get bedtime_reminder_tip => '¿Quieres mejorar tu sueño? Configura un Recordatorio para Dormir para desconectar cada noche.';

  @override
  String get custom_blocking_tip => '¿Necesitas una experiencia personalizada? Crea reglas de bloqueo de aplicaciones que se ajusten a tus necesidades.';

  @override
  String get session_timeline_tip => '¿Quieres monitorizar las sesiones de enfoque? Consulta la línea de tiempo para ver tu progreso de concentración.';

  @override
  String get short_content_blocking_tip => '¿Te distraen las redes sociales? Bloquea el contenido corto en Instagram, YouTube, etc. para mantenerte enfocado.';

  @override
  String get parental_controls_tip => '¿Necesitas el control parental? Configura restricciones para el dispositivo de tu hijo/a para asegurar una experiencia segura.';

  @override
  String get notification_batching_tip => '¿Quieres reducir las distracciones? Usa el Agrupamiento de Notificaciones para agruparlas y revisarlas todas a la vez.';

  @override
  String get notification_scheduling_tip => '¿Necesitas gestionar notificaciones? Programa cuándo recibes notificaciones para aplicaciones específicas.';

  @override
  String get quick_focus_tile_tip => '¿Necesitas acceso rápido para concentrarte? Añade un Acceso Rápido para activar el Modo Concentración al instante.';

  @override
  String get app_shortcuts_tip => '¿Quieres acceso instantáneo a una aplicación? Añade atajos manteniendo pulsado el icono de la aplicación para acciones rápidas.';

  @override
  String get backup_usage_db_tip => '¿Quieres guardar tus datos? Haz una copia de seguridad de tu base de datos de uso para mantener tus registros a salvo.';

  @override
  String get dynamic_material_color_tip => '¿Quieres un tema personalizado? Habilita el color dinámico Material You para que coincida con el tema de tu dispositivo.';

  @override
  String get amoled_dark_theme_tip => '¿Quieres ahorrar batería? Usa el Tema Oscuro AMOLED para reducir el consumo de energía en pantallas OLED.';

  @override
  String get customize_usage_history_tip => '¿Quieres conservar el historial de uso? Personaliza cuántas semanas de datos vas a almacenar en el Historial de Uso.';

  @override
  String get grouped_apps_blocking_tip => '¿Quieres bloquear aplicaciones juntas? Usa Grupos Restringidos para agrupar límites de aplicaciones y bloquear múltiples aplicaciones a la vez.';

  @override
  String get websites_blocking_tip => '¿Quieres una experiencia de navegación más limpia? Bloquea sitios web personalizados o webs NSFW para un tiempo online más enfocado.';

  @override
  String get data_usage_tip => '¿Quieres traquear tus datos? Monitoriza tu uso de datos móviles y Wi-Fi para el consumo de internet.';

  @override
  String get block_internet_tip => '¿Necesitas bloquear el internet de una aplicación? Apaga el internet para una aplicación específica desde el panel de control de la app.';

  @override
  String get emergency_passes_tip => '¿Necesitas un descanso? Usa 3 Pases de Emergencia diarios para desbloquear aplicaciones temporalmente por 5 minutos.';

  @override
  String get onboarding_skip_btn_label => 'Saltar';

  @override
  String get onboarding_finish_setup_btn_label => 'Finalizar';

  @override
  String get onboarding_page_one_title => 'Domina el Enfoque';

  @override
  String get onboarding_page_one_info => 'Pausa las apps que te distraen, bloquea el contenido corto y mantente centrado con sesiones de enfoque personalizables. Ya sea que estés trabajando, estudiando o relajándote, Mindful te ayuda a mantener el control.';

  @override
  String get onboarding_page_two_title => 'Bloquea las Distracciones';

  @override
  String get onboarding_page_two_info => 'Establece límites de uso, pausa aplicaciones automáticamente y crea hábitos digitales más saludables. Usa el Modo Descanso para desconectar y disfrutar de una noche sin distracciones.';

  @override
  String get onboarding_page_three_title => 'Privacidad Ante Todo';

  @override
  String get onboarding_page_three_info => 'Mindful es 100% de código abierto y funciona completamente sin conexión. No recopilamos ni compartimos tus datos personales; tu privacidad está garantizada de todas las maneras.';

  @override
  String get onboarding_page_permissions_title => 'Permisos Esenciales';

  @override
  String get onboarding_page_permissions_info => 'Mindful requiere los siguientes permisos esenciales para monitorizar y gestionar tu tiempo de pantalla, ayudando a reducir las distracciones y mejorando el enfoque.';

  @override
  String get dashboard_tab_title => 'Panel de Control';

  @override
  String get focus_now_fab_button => 'Centrarse ahora';

  @override
  String get welcome_greetings => 'Bienvenido,';

  @override
  String get username_snack_alert => 'Mantenga pulsado para editar el nombre de usuario.';

  @override
  String get username_dialog_title => 'Nombre de Usuario';

  @override
  String get username_dialog_info => 'Introduzca su nombre de usuario que se mostrará en el panel de control.';

  @override
  String get username_dialog_button_apply => 'Aplicar';

  @override
  String get glance_tile_title => 'Vista Rápida';

  @override
  String get glance_tile_subtitle => 'Echa un vistazo rápido a tu uso.';

  @override
  String get parental_controls_tile_subtitle => 'Modo Invencible y Protección Antimanipulación';

  @override
  String get restrictions_heading => 'Restricciones';

  @override
  String get apps_blocking_tile_title => 'Bloqueo de apps';

  @override
  String get apps_blocking_tile_subtitle => 'Limita las aplicaciones de muchas maneras.';

  @override
  String get grouped_apps_blocking_tile_title => 'Bloquear apps agrupadas';

  @override
  String get grouped_apps_blocking_tile_subtitle => 'Limita un grupo de aplicaciones simultáneamente.';

  @override
  String get shorts_blocking_tile_subtitle => 'Limitar el contenido corto en múltiples plataformas.';

  @override
  String get websites_blocking_tile_subtitle => 'Limitar sitios para adultos y personalizados.';

  @override
  String get screen_time_label => 'Tiempo de pantalla';

  @override
  String get total_data_label => 'Datos totales';

  @override
  String get mobile_data_label => 'Datos móviles';

  @override
  String get wifi_data_label => 'Datos Wi-Fi';

  @override
  String get focus_today_label => 'Enfoque de hoy';

  @override
  String get focus_weekly_label => 'Enfoque semanal';

  @override
  String get focus_monthly_label => 'Enfoque mensual';

  @override
  String get focus_lifetime_label => 'Enfoque total';

  @override
  String get longest_streak_label => 'Racha más larga';

  @override
  String get current_streak_label => 'Racha actual';

  @override
  String get successful_sessions_label => 'Sesiones exitosas';

  @override
  String get failed_sessions_label => 'Sesiones fallidas';

  @override
  String get statistics_tab_title => 'Estadísticas';

  @override
  String get screen_segment_label => 'Pantalla';

  @override
  String get data_segment_label => 'Datos';

  @override
  String get mobile_label => 'Datos';

  @override
  String get wifi_label => 'Wi-Fi';

  @override
  String get most_used_apps_heading => 'Aplicaciones más usadas';

  @override
  String get show_all_apps_tile_title => 'Mostrar todas las aplicaciones';

  @override
  String get search_apps_hint => 'Buscar aplicaciones...';

  @override
  String get notifications_tab_title => 'Notificaciones';

  @override
  String get notifications_tab_info => 'Agrupa notificaciones de aplicaciones y establece horarios como por la mañana, mediodía, tarde y noche. Mantente actualizado sin interrupciones constantes.';

  @override
  String get batched_apps_tile_title => 'Aplicaciones Agrupadas';

  @override
  String get batch_recap_dropdown_title => 'Tipo de resumen de las agrupaciones';

  @override
  String get batch_recap_dropdown_info => 'Elige qué quieres que se muestre cuando se active un horario — todas las notificaciones o solo un resumen.';

  @override
  String get batch_recap_option_summery_only => 'Solo un resumen';

  @override
  String get batch_recap_option_all_notifications => 'Todas las notificaciones';

  @override
  String get notification_history_tile_title => 'Historial de notificaciones';

  @override
  String get store_all_tile_title => 'Almacenar todas las notificaciones';

  @override
  String get store_all_tile_subtitle => 'Guardar también las notificaciones no agrupadas.';

  @override
  String get schedules_heading => 'Sesiones';

  @override
  String get new_schedule_fab_button => 'Nueva sesión';

  @override
  String get new_schedule_dialog_info => 'Introduce un nombre para el horario de notificaciones que te ayude a identificarlo fácilmente.';

  @override
  String get new_schedule_dialog_field_label => 'Nombre de la programación';

  @override
  String get bedtime_tab_title => 'Descanso';

  @override
  String get bedtime_tab_info => 'Establece tu horario de descanso seleccionando un periodo de tiempo y los días de la semana. Elige las aplicaciones que te distraen para bloquear y habilita el modo No Molestar (DND) para una noche tranquila.';

  @override
  String get schedule_tile_title => 'Horario';

  @override
  String get schedule_tile_subtitle => 'Activar o desactivar horario diario.';

  @override
  String get bedtime_no_days_selected_snack_alert => 'Seleccione al menos un día de la semana.';

  @override
  String get bedtime_minimum_duration_snack_alert => 'La duración total del descanso debe ser de al menos 30 minutos.';

  @override
  String get distracting_apps_tile_title => 'Apps que te distraen';

  @override
  String get distracting_apps_tile_subtitle => 'Selecciona qué aplicaciones te están distrayendo de tu rutina de descanso.';

  @override
  String get bedtime_distracting_apps_modify_snack_alert => 'Las modificaciones a la lista de aplicaciones que distraen no están permitidas mientras el horario de descanso esté activo.';

  @override
  String get parental_controls_tab_title => 'Control parental';

  @override
  String get invincible_mode_heading => 'Modo invencible';

  @override
  String get invincible_mode_tile_title => 'Activar modo invencible';

  @override
  String get invincible_mode_info => 'Cuando el Modo Invencible está activado, no podrás ajustar los límites seleccionados después de alcanzar tu cuota diaria. Sin embargo, puedes hacer cambios dentro de un margen invencible seleccionado de 10 minutos.';

  @override
  String get invincible_mode_snack_alert => 'Debido al modo invencible, las modificaciones a las restricciones no están permitidas.';

  @override
  String get invincible_mode_dialog_info => '¿Estás completamente seguro de que quieres habilitar el Modo Invencible? Esta acción es irreversible. Una vez que el Modo Invencible esté activado, no podrás desactivarlo mientras esta aplicación esté instalada en tu dispositivo.';

  @override
  String get invincible_mode_turn_off_snack_alert => 'El Modo Invencible no se puede desactivar mientras esta aplicación permanezca instalada en tu dispositivo.';

  @override
  String get invincible_mode_dialog_button_start_anyway => 'Iniciar de todos modos';

  @override
  String get invincible_mode_include_timer_tile_title => 'Incluir el temporizador';

  @override
  String get invincible_mode_include_launch_limit_tile_title => 'Incluir el límite de lanzamiento';

  @override
  String get invincible_mode_include_active_period_tile_title => 'Incluye el período activo';

  @override
  String get invincible_mode_app_restrictions_tile_title => 'Restricciones de la app';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle => 'Evita cambios en las restricciones seleccionadas de la aplicación una vez que se superen los límites diarios.';

  @override
  String get invincible_mode_group_restrictions_tile_title => 'Restricciones de los grupos';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle => 'Evita cambios en las restricciones seleccionadas del grupo/s una vez que se superen los límites diarios.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title => 'Incluir el tiempo de los videos cortos';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle => 'Evita cambios después de alcanzar tu límite diario de contenido corto.';

  @override
  String get invincible_mode_include_bedtime_tile_title => 'Incluir hora de descanso';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle => 'Evita cambios durante el horario de descanso activo.';

  @override
  String get protected_access_tile_title => 'Acceso protegido';

  @override
  String get protected_access_tile_subtitle => 'Protege Mindful con el desbloqueo de tu dispositivo.';

  @override
  String get protected_access_no_lock_snack_alert => 'Por favor, configura primero un bloqueo biométrico en tu dispositivo para habilitar esta función.';

  @override
  String get protected_access_removed_lock_snack_alert => 'El bloqueo del dispositivo ha sido eliminado. Para continuar, configure un nuevo bloqueo.';

  @override
  String get protected_access_failed_lock_snack_alert => 'Error de autenticación. Necesitas verificar el bloqueo de tu dispositivo para continuar.';

  @override
  String get tamper_protection_tile_title => 'Protección Antimanipulación';

  @override
  String get tamper_protection_tile_subtitle => 'Evita la desinstalación y el cierre forzado de la aplicación.';

  @override
  String get tamper_protection_confirmation_dialog_info => 'Una vez habilitado, no podrás desinstalar, forzar detención o borrar los datos de Mindful, excepto durante la ventana de desinstalación seleccionada. No hay soluciones alternativas.\n\nProcede bajo tu propio riesgo.';

  @override
  String get uninstall_window_tile_title => 'Ventana de desinstalación';

  @override
  String get uninstall_window_tile_subtitle => 'La protección antimanipulación puede desactivarse dentro de los 10 minutos desde la hora seleccionada.';

  @override
  String get invincible_window_tile_title => 'Modo invencible';

  @override
  String get invincible_window_tile_subtitle => 'Los límites seleccionados se pueden modificar dentro de los 10 minutos desde la hora seleccionada.';

  @override
  String get shorts_blocking_tab_title => 'Bloqueo de vídeos cortos';

  @override
  String get shorts_blocking_tab_info => 'Controla cuánto tiempo pasas en contenido de vídeo corto en plataformas como Instagram, YouTube, Snapchat y Facebook, incluyendo sus sitios web.';

  @override
  String get short_content_heading => 'Contenido Corto';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Faltan $timeShortString';
  }

  @override
  String get short_content_timer_picker_dialog_info => 'Establece un límite de tiempo diario para el contenido corto. Una vez alcanzado tu límite, el contenido corto se pausará hasta la medianoche.';

  @override
  String get instagram_features_tile_title => 'Instagram';

  @override
  String get instagram_features_tile_subtitle => 'Restringir funciones en Instagram.';

  @override
  String get instagram_features_block_reels => 'Restringe la sección de Reels.';

  @override
  String get instagram_features_block_explore => 'Restringir sección de Explorar.';

  @override
  String get snapchat_features_tile_title => 'Snapchat';

  @override
  String get snapchat_features_tile_subtitle => 'Restringir funciones en Snapchat.';

  @override
  String get snapchat_features_block_spotlight => 'Restringe la sección de Spotlight.';

  @override
  String get snapchat_features_block_discover => 'Restringir la sección Descubrir.';

  @override
  String get youtube_features_tile_title => 'YouTube';

  @override
  String get youtube_features_tile_subtitle => 'Restringir Shorts en YouTube.';

  @override
  String get facebook_features_tile_title => 'Facebook';

  @override
  String get facebook_features_tile_subtitle => 'Restringir Reels en Facebook.';

  @override
  String get reddit_features_tile_title => 'Reddit';

  @override
  String get reddit_features_tile_subtitle => 'Restringir Shorts en Reddit.';

  @override
  String get websites_blocking_tab_title => 'Bloqueo de webs';

  @override
  String get websites_blocking_tab_info => 'Bloquea sitios web para adultos y cualquier sitio personalizado que elijas para crear una experiencia online más segura y enfocada. Toma el control de tu navegación y mantente libre de distracciones.';

  @override
  String get adult_content_heading => 'Contenido para adultos';

  @override
  String get block_nsfw_title => 'Bloquear Nsfw';

  @override
  String get block_nsfw_subtitle => 'Restringir a los navegadores de abrir webs para adultos y porno.';

  @override
  String get block_nsfw_dialog_info => '¿Estás seguro? Esta acción es irreversible. Una vez que el bloqueador de sitios para adultos esté ACTIVADO, no podrás DESACTIVARLO mientras esta aplicación esté instalada en tu dispositivo.';

  @override
  String get block_nsfw_dialog_button_block_anyway => 'Bloquear de todos modos';

  @override
  String get blocked_websites_heading => 'Webs bloqueadas';

  @override
  String get blocked_websites_empty_list_hint => 'Haz clic en el botón \"+ Añadir Webs\" para añadir sitios web que te distraen y que deseas bloquear.';

  @override
  String get add_website_fab_button => 'Añadir web';

  @override
  String get add_website_dialog_title => 'Web distractoria';

  @override
  String get add_website_dialog_info => 'Introduce la URL de una web que quieras bloquear.';

  @override
  String get add_website_dialog_is_nsfw => '¿Es un sitio NSFW?';

  @override
  String get add_website_dialog_nsfw_warning => 'Advertencia: Las webs NSFW no se pueden eliminar una vez añadidas.';

  @override
  String get add_website_dialog_button_block => 'Bloquear';

  @override
  String get add_website_already_exist_snack_alert => 'La URL ya ha sido añadida a la lista de webs bloqueadas.';

  @override
  String get add_website_invalid_url_snack_alert => '¡URL inválida! No se puede analizar el nombre del host.';

  @override
  String get remove_website_dialog_title => 'Eliminar sitio web';

  @override
  String remove_website_dialog_info(String websitehost) {
    return '¿Estás seguro? Quieres eliminar \'$websitehost\' de los sitios web bloqueados.';
  }

  @override
  String get focus_tab_title => 'Concentración';

  @override
  String get focus_tab_info => 'Cuando necesites tiempo para enfocarte, inicia una nueva sesión seleccionando el tipo, eligiendo las aplicaciones que te distraen para pausar y habilitando el modo No Molestar para una concentración ininterrumpida.';

  @override
  String get active_session_card_title => 'Sesiones activas';

  @override
  String get active_session_card_info => '¡Tienes una sesión de concentración activa en curso! Haz clic en \"Ver\" para comprobar tu progreso y ver cuánto tiempo ha transcurrido.';

  @override
  String get active_session_card_view_button => 'Ver';

  @override
  String get focus_distracting_apps_removal_snack_alert => 'La eliminación de aplicaciones de la lista de apps que distraen no está permitida mientras una Sesión de Concentración esté activa. Sin embargo, aún puedes añadir aplicaciones adicionales a la lista durante este tiempo.';

  @override
  String get focus_profile_tile_title => 'Perfil de concentración';

  @override
  String get focus_session_duration_tile_title => 'Duración de la sesión';

  @override
  String get focus_session_duration_tile_subtitle => 'Infinito (hasta que lo pares)';

  @override
  String get focus_session_duration_dialog_info => 'Por favor, selecciona la duración deseada para esta sesión de concentración, determinando cuánto tiempo deseas permanecer concentrado y libre de distracciones.';

  @override
  String get focus_profile_customization_tile_title => 'Personalización del Perfil';

  @override
  String get focus_profile_customization_tile_subtitle => 'Personalizar los ajustes para el perfil seleccionado.';

  @override
  String get focus_enforce_tile_title => 'Forzar sesión';

  @override
  String get focus_enforce_tile_subtitle => 'Evita terminar una sesión antes de que termine el tiempo.';

  @override
  String get focus_session_start_fab_button => 'Empezar una sesión';

  @override
  String get focus_session_minimum_apps_snack_alert => 'Seleccione al menos una aplicación distractoria para iniciar la sesión de concentración';

  @override
  String get focus_session_already_active_snack_alert => 'Ya tienes una sesión de concentración activa en curso. Por favor, completa o detén tu sesión actual antes de iniciar una nueva.';

  @override
  String get focus_session_type_study => 'Estudio';

  @override
  String get focus_session_type_work => 'Trabajo';

  @override
  String get focus_session_type_exercise => 'Deporte';

  @override
  String get focus_session_type_meditation => 'Meditación';

  @override
  String get focus_session_type_creativeWriting => 'Escritura Creativa';

  @override
  String get focus_session_type_reading => 'Lectura';

  @override
  String get focus_session_type_programming => 'Programación';

  @override
  String get focus_session_type_chores => 'Quehaceres';

  @override
  String get focus_session_type_projectPlanning => 'Planificación de proyectos';

  @override
  String get focus_session_type_artAndDesign => 'Arte y Diseño';

  @override
  String get focus_session_type_languageLearning => 'Aprendizaje de idiomas';

  @override
  String get focus_session_type_musicPractice => 'Práctica de Música';

  @override
  String get focus_session_type_selfCare => 'Autocuidado';

  @override
  String get focus_session_type_brainstorming => 'Lluvias de ideas';

  @override
  String get focus_session_type_skillDevelopment => 'Desarrollo de Habilidad';

  @override
  String get focus_session_type_research => 'Investigación';

  @override
  String get focus_session_type_networking => 'Networking';

  @override
  String get focus_session_type_cooking => 'Cocinar';

  @override
  String get focus_session_type_sportsTraining => 'Entrenamiento Deportivo';

  @override
  String get focus_session_type_restAndRelaxation => 'Descanso y Relajación';

  @override
  String get focus_session_type_other => 'Otro';

  @override
  String get timeline_tab_title => 'Cronología';

  @override
  String get focus_timeline_tab_info => 'Explora tu diario de concentración seleccionando una fecha del calendario. Sigue tu progreso, revisa tus éxitos y aprende de los desafíos.';

  @override
  String selected_month_productive_time_snack_alert(String timeString) {
    return 'Tu tiempo productivo total para el mes seleccionado es $timeString.';
  }

  @override
  String get selected_month_productive_days_label => 'Días productivos';

  @override
  String selected_month_productive_days_snack_alert(num daysCount) {
    return 'Has tenido un total de $daysCount días productivos durante el mes seleccionado.';
  }

  @override
  String get selected_day_focused_time_label => 'Tiempo concentrado';

  @override
  String selected_day_focused_time_snack_alert(String timeString) {
    return 'Tu tiempo productivo total para el mes seleccionado es $timeString.';
  }

  @override
  String get calender_heading => 'Calendario';

  @override
  String get your_sessions_heading => 'Tus sesiones';

  @override
  String get your_sessions_empty_list_hint => 'No hay sesiones de concentración grabadas para el día seleccionado.';

  @override
  String get focus_session_tile_timestamp_label => 'Marca de Tiempo';

  @override
  String get focus_session_tile_duration_label => 'Duración';

  @override
  String get focus_session_tile_reflection_label => 'Reflexión';

  @override
  String get focus_session_state_active => 'Activo';

  @override
  String get focus_session_state_successful => 'Completado';

  @override
  String get focus_session_state_failed => 'Fallido';

  @override
  String get active_session_tab_title => 'Sesión';

  @override
  String get active_session_none_warning => 'No se encontró ninguna sesión activa. Volviendo a la pantalla de inicio.';

  @override
  String get active_session_dialog_button_keep_pushing => '¡Sigue así!';

  @override
  String get active_session_finish_dialog_title => 'Finalizar';

  @override
  String get active_session_finish_dialog_info => '¡Mantente fuerte! Estás construyendo una concentración valiosa. ¿Estás seguro de que quieres terminar esta sesión de concentración? Cada momento extra cuenta para tus objetivos.';

  @override
  String get active_session_giveup_dialog_title => 'Rendirse';

  @override
  String get active_session_giveup_dialog_info => '¡Aguanta! Ya casi lo tienes, ¡no te rindas ahora! ¿Estás seguro de que quieres terminar esta sesión de concentración antes de tiempo? Se perderá el progreso.';

  @override
  String get active_session_reflection_dialog_title => 'Reflexión de la sesión';

  @override
  String get active_session_reflection_dialog_info => 'Tómate un momento para reflexionar sobre tu progreso. ¿Cuál es tu objetivo para esta sesión? ¿Qué lograste durante esta sesión?';

  @override
  String get active_session_reflection_dialog_tip => 'Consejo: Siempre puedes editar esto más tarde en la línea de tiempo de la sesión.';

  @override
  String get active_session_giveup_snack_alert => '¡Te rendiste! No te preocupes, la próxima vez lo harás mejor. Cada esfuerzo cuenta - ¡solo sigue adelante!';

  @override
  String get active_session_quote_one => 'Cada paso cuenta, mantente fuerte y sigue adelante';

  @override
  String get active_session_quote_two => '¡Mantente concentrado! Estás haciendo un progreso increíble';

  @override
  String get active_session_quote_three => '¡Lo estás bordando! Mantén el ritmo';

  @override
  String get active_session_quote_four => 'Ya queda solo un poco más, lo estás haciendo genial';

  @override
  String active_session_quote_five(String durationString) {
    return '¡Felicitaciones! 🎉 \nHas completado tu sesión de concentración de $durationString.';
  }

  @override
  String get restriction_groups_tab_title => 'Grupos restringidos';

  @override
  String get restriction_groups_tab_info => 'Establece un límite de tiempo de pantalla combinado para un grupo de aplicaciones. Una vez que el uso total alcance tu límite, todas las aplicaciones del grupo se pausarán para ayudar a mantener la concentración y el equilibrio.';

  @override
  String get restriction_group_time_spent_label => 'Tiempo invertido hoy';

  @override
  String get restriction_group_time_left_label => 'Tiempo restante hoy';

  @override
  String get restriction_group_name_tile_title => 'Nombre del grupo';

  @override
  String get restriction_group_name_picker_dialog_info => 'Introduzca un nombre para el grupo restringido para ayudarle a identificarlo y gestionarlo fácilmente.';

  @override
  String get restriction_group_timer_tile_title => 'Temporizador de grupo';

  @override
  String get restriction_group_timer_picker_dialog_info => 'Establece un límite de tiempo diario para este grupo. Una vez que se alcance tu límite, todas las aplicaciones de este grupo se pausarán hasta la medianoche.';

  @override
  String get restriction_group_active_period_tile_title => 'Período activo del grupo';

  @override
  String get remove_restriction_group_dialog_title => 'Eliminar grupo';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return '¿Estás seguro? Quieres eliminar \'$groupName\' de los grupos restringidos.';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert => 'Establece un temporizador o un límite de período activo.';

  @override
  String get notifications_empty_list_hint => 'No se han agrupado notificaciones para el día.';

  @override
  String get conversations_label => 'Conversaciones';

  @override
  String get last_24_hours_heading => 'Últimas 24 horas';

  @override
  String get notification_timeline_tab_info => 'Navega por tu historial de notificaciones seleccionando una fecha del calendario. Mira qué aplicaciones captaron tu atención y reflexiona sobre tus hábitos digitales.';

  @override
  String get monthly_label => 'Mensual';

  @override
  String get daily_label => 'Diario';

  @override
  String get search_notifications_sheet_info => 'Encuentra fácilmente notificaciones pasadas buscando por su título o contenido. Te ayuda a localizar rápidamente alertas importantes.';

  @override
  String get search_notifications_hint => 'Buscar notificaciones...';

  @override
  String get search_notifications_empty_list_hint => 'No se han encontrado notificaciones que coincidan con tu búsqueda.';

  @override
  String get app_info_none_warning => 'No se pudo encontrar la aplicación para el paquete dado. Volviendo a la pantalla de inicio.';

  @override
  String get emergency_fab_button => 'Emergencia';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return 'Esta acción pausará el bloqueador de aplicaciones durante los próximos 5 minutos. Te quedan $leftPassesCount pases. Después de usar todos los pases, la aplicación permanecerá bloqueada hasta medianoche, o hasta que termine la sesión de concentración activa.';
  }

  @override
  String get emergency_dialog_button_use_anyway => 'Usar de todos modos';

  @override
  String get emergency_started_snack_alert => 'El bloqueador de aplicaciones está pausado y se reanudará el bloqueo en 5 minutos.';

  @override
  String get emergency_already_active_snack_alert => 'El bloqueador de aplicaciones está actualmente pausado o inactivo. Si las notificaciones están habilitadas, recibirás actualizaciones sobre el tiempo restante.';

  @override
  String get emergency_no_pass_left_snack_alert => 'Has usado todos tus pases de emergencia. Las aplicaciones bloqueadas permanecerán bloqueadas hasta medianoche, o hasta que termine la sesión de concentración activa.';

  @override
  String get app_limit_status_not_set => 'No establecido';

  @override
  String get app_timer_tile_title => 'Temporizador';

  @override
  String get app_timer_picker_dialog_info => 'Establece un límite de tiempo diario para esta aplicación. Una vez que se alcance tu límite, la aplicación se pausará hasta medianoche.';

  @override
  String get usage_reminders_tile_title => 'Recordatorios de uso';

  @override
  String get usage_reminders_tile_subtitle => 'Recordatorios suaves al usar aplicaciones con temporizador.';

  @override
  String get app_launch_limit_tile_title => 'Límite de lanzamiento';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Lanzado $count veces hoy.';
  }

  @override
  String get app_launch_limit_picker_dialog_info => 'Establece cuántas veces puedes abrir esta aplicación cada día. Una vez que se alcance el límite, se pausará hasta medianoche.';

  @override
  String get app_active_period_tile_title => 'Período activo';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return 'Desde las $startTime hasta las $endTime';
  }

  @override
  String get internet_access_tile_title => 'Acceso a Internet';

  @override
  String get internet_access_tile_subtitle => 'Desactívalo para bloquear el internet de la aplicación.';

  @override
  String internet_access_blocked_snack_alert(String appName) {
    return 'El internet de $appName está bloqueado.';
  }

  @override
  String internet_access_unblocked_snack_alert(String appName) {
    return 'El internet de $appName está desbloqueado.';
  }

  @override
  String get launch_app_tile_title => 'Abrir aplicación';

  @override
  String launch_app_tile_subtitle(String appName) {
    return 'Abrir $appName.';
  }

  @override
  String get go_to_app_settings_tile_title => 'Ir a la configuración de la app';

  @override
  String get go_to_app_settings_tile_subtitle => 'Gestiona la configuración de la aplicación como notificaciones, permisos, almacenamiento y más.';

  @override
  String get include_in_stats_tile_title => 'Incluir en el uso de pantalla.';

  @override
  String get include_in_stats_tile_subtitle => 'Desactívalo para excluir esta aplicación del uso total de pantalla.';

  @override
  String app_excluded_from_stats_snack_alert(String appName) {
    return '$appName está excluido del uso total de la pantalla.';
  }

  @override
  String app_include_to_stats_snack_alert(String appName) {
    return '$appName está incluido en el uso total de la pantalla.';
  }

  @override
  String get general_tab_title => 'General';

  @override
  String get appearance_heading => 'Apariencia';

  @override
  String get theme_mode_tile_title => 'Tema';

  @override
  String get theme_mode_system_label => 'Sistema';

  @override
  String get theme_mode_light_label => 'Claro';

  @override
  String get theme_mode_dark_label => 'Oscuro';

  @override
  String get material_color_tile_title => 'Colores de Material Design';

  @override
  String get amoled_dark_tile_title => 'AMOLED Oscuro';

  @override
  String get amoled_dark_tile_subtitle => 'Usa el negro puro para el tema oscuro.';

  @override
  String get dynamic_colors_tile_title => 'Colores dinámicos';

  @override
  String get dynamic_colors_tile_subtitle => 'Usar colores del dispositivo si es compatible.';

  @override
  String get defaults_heading => 'Ajustes predeterminados';

  @override
  String get app_language_tile_title => 'Idioma de la aplicación';

  @override
  String get default_home_tab_tile_title => 'Pestaña de inicio';

  @override
  String get usage_history_tile_title => 'Historial de uso';

  @override
  String get usage_history_15_days => '15 días';

  @override
  String get usage_history_1_month => '1 mes';

  @override
  String get usage_history_3_month => '3 meses';

  @override
  String get usage_history_6_month => '6 meses';

  @override
  String get usage_history_1_year => '1 año';

  @override
  String get service_heading => 'Servicio';

  @override
  String get service_stopping_warning => 'Si Mindful deja de funcionar inesperadamente, por favor, concede el permiso \"Ignorar Optimización de Batería\" para mantenerlo funcionando en segundo plano. Si el problema persiste, intenta añadir Mindful a la lista blanca para un rendimiento ininterrumpido.';

  @override
  String get whitelist_app_tile_title => 'Añadir Mindful a la lista blanca';

  @override
  String get whitelist_app_tile_subtitle => 'Permitir que Mindful inicie automáticamente.';

  @override
  String get whitelist_app_unsupported_snack_alert => 'Este dispositivo no es compatible con la gestión automática de inicio.';

  @override
  String get database_tab_title => 'Base de datos';

  @override
  String get import_db_tile_title => 'Importar base de datos';

  @override
  String get import_db_tile_subtitle => 'Importar la base de datos desde un archivo.';

  @override
  String get export_db_tile_title => 'Exportar base de datos';

  @override
  String get export_db_tile_subtitle => 'Exportar la base de datos a un archivo.';

  @override
  String get crash_logs_heading => 'Registro de errores';

  @override
  String get crash_logs_info => 'Si encuentras algún problema, puedes reportarlo en GitHub junto con el archivo de registro. El archivo incluirá detalles como el fabricante de tu dispositivo, el modelo, la versión de Android, la versión del SDK y los registros de fallos. Esta información nos ayudará a identificar y resolver el problema de forma más eficaz.';

  @override
  String get crash_logs_export_tile_title => 'Exportar registro de errores';

  @override
  String get crash_logs_export_tile_subtitle => 'Exportar registros de errores a un archivo json.';

  @override
  String get crash_logs_view_tile_title => 'Ver registros';

  @override
  String get crash_logs_view_tile_subtitle => 'Explora los registros de fallos almacenados.';

  @override
  String get crash_logs_empty_list_hint => 'No se ha registrado ningún fallo hasta ahora.';

  @override
  String get crash_logs_clear_tile_title => 'Borrar registros';

  @override
  String get crash_logs_clear_tile_subtitle => 'Eliminar todos los registros de fallos de la base de datos.';

  @override
  String get crash_logs_clear_dialog_info => '¿Estás seguro de que deseas eliminar todos los registros de fallos de la base de datos?';

  @override
  String get crash_logs_clear_dialog_button_clear_anyway => 'Borrar de todos modos';

  @override
  String get about_tab_title => 'Acerca de';

  @override
  String get changelog_tile_title => 'Historial de cambios';

  @override
  String get changelog_tile_subtitle => 'Descubre las últimas novedades.';

  @override
  String get full_changelog_tile_title => 'Registro de cambios completo';

  @override
  String get redirected_to_github_subtitle => 'Serás redirigido a GitHub.';

  @override
  String get contribute_heading => 'Aportar';

  @override
  String get github_tile_title => 'GitHub';

  @override
  String get github_tile_subtitle => 'Ver el código fuente.';

  @override
  String get report_issue_tile_title => 'Informar de un problema';

  @override
  String get suggest_idea_tile_title => 'Sugerir una idea';

  @override
  String get write_email_tile_title => 'Escríbenos por email';

  @override
  String get write_email_tile_subtitle => 'Serás redirigido a la aplicación del correo.';

  @override
  String get privacy_policy_heading => 'Política de Privacidad';

  @override
  String get privacy_policy_info => 'Mindful se compromete a proteger tu privacidad. No recopilamos, almacenamos ni transferimos ningún tipo de datos de usuario. La aplicación funciona completamente sin conexión y no requiere conexión a internet, lo que garantiza que tu información personal permanezca privada y segura en tu dispositivo. Como aplicación de Software Libre y de Código Abierto (FOSS), Mindful garantiza total transparencia y control del usuario sobre sus datos.';

  @override
  String get more_details_button => 'Más información';
}
