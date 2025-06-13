import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get mindful_tagline => 'Фокусирај се на оно што је заиста важно';

  @override
  String get unlock_button_label => 'Откључај';

  @override
  String get permission_status_off => 'Искључено';

  @override
  String get permission_status_allowed => 'Дозвољено';

  @override
  String get permission_status_not_allowed => 'Није дозвољено';

  @override
  String get permission_button_grant_permission => 'Дозволи';

  @override
  String get permission_button_agree_and_continue => 'Прихвати и настави';

  @override
  String get permission_button_not_now => 'Не сада';

  @override
  String get permission_button_help => 'Помоћ?';

  @override
  String get permission_sheet_privacy_info => 'Mindful је 100% сигуран и ради ван мреже. Не прикупљамо, нити чувамо било какве личне податке.';

  @override
  String permission_grant_step_one(String button_label) {
    return '1. Кликни на дугме $button_label.';
  }

  @override
  String get permission_grant_step_two => '2. Изабери Mindful на следећем екрану.';

  @override
  String get permission_grant_step_three => '3. Кликни и укључи подешавање испод.';

  @override
  String get permission_notification_title => 'Пошаљи обавештења';

  @override
  String get permission_alarms_title => 'Аларми и подсетници';

  @override
  String get permission_alarms_info => 'Молимо те да одобриш дозволу за постављање аларма и подсећања. Ово ће омогућити Mindful да на време започне твој распоред за спавање. Такође, апликација ће дневно ресетовати тајмере у поноћ и помоћи ти да останеш на правом путу.';

  @override
  String get permission_alarms_device_tile_label => 'Омогући подешавање аларма и подсетника';

  @override
  String get permission_usage_title => 'Приступ коришћењу';

  @override
  String get permission_usage_info => 'Молимо дозволите приступ подацима о коришћењу. Ово ће омогућити да Mindful прати употребу апликација и управља приступом одређеним апликацијама, обезбеђујући фокусираније и контролисаније дигитално окружење.';

  @override
  String get permission_usage_device_tile_label => 'Дозволи приступ коришћењу';

  @override
  String get permission_overlay_title => 'Приказ преко других апликација';

  @override
  String get permission_overlay_info => 'Молимо одобрите дозволу за приказ преко других апликација. Ово ће омогућити апликацији да прикаже преклоп када се отвори паузирана апликација, што ће вам помоћи да останете фокусирани и придржавате се свог распореда.';

  @override
  String get permission_overlay_device_tile_label => 'Дозволи приказ преко других апликација';

  @override
  String get permission_accessibility_title => 'Приступачност';

  @override
  String get permission_accessibility_info => 'Молимо одобрите дозволу за приступачност. Ово ће омогућити апликацији Mindful да ограничи приступ кратком видео садржају (нпр. Reels, Shorts) у оквиру апликација друштвених мрежа и интернет прегледача, као и да филтрира непримерене веб-сајтове.';

  @override
  String get permission_accessibility_required => 'Mindful захтева дозволу за приступачност како би ефикасно блокирао кратки садржај и веб-сајтове.';

  @override
  String get permission_accessibility_device_tile_label => 'Користи Mindful';

  @override
  String get permission_dnd_title => 'Не ометај';

  @override
  String get permission_dnd_info => 'Дозволи приступ за режим „Не ометај“. Ово ће омогућити Mindful да покрене и заустави режим „Не ометај“ током распореда за спавање.';

  @override
  String get permission_dnd_tile_title => 'Покрени DND (Не ометај)';

  @override
  String get permission_dnd_tile_subtitle => 'Укључи режим „Не ометај“.';

  @override
  String get permission_battery_optimization_tile_title => 'Занемари оптимизацију батерије';

  @override
  String get permission_battery_optimization_status_enabled => 'Већ неограничено';

  @override
  String get permission_battery_optimization_status_disabled => 'Онемогући позадинска ограничења';

  @override
  String get permission_battery_optimization_allow_info => 'Дозвола за „Занемаривање оптимизације батерије“ на неким уређајима такође аутоматски омогућава приступ „Алармима и подсетницима“.';

  @override
  String get permission_vpn_title => 'Креирај VPN';

  @override
  String get permission_vpn_info => 'Одобри дозволу за креирање виртуелне приватне мреже (VPN). Ово ће омогућити апликацији Mindful да ограничи приступ интернету за одређене апликације креирањем локалне VPN мреже на уређају.';

  @override
  String get permission_admin_title => 'Админ';

  @override
  String get permission_admin_info => 'Администраторске привилегије су потребне само за основне операције како би апликација радило исправно и остала заштићена од манипулација.';

  @override
  String get permission_admin_snack_alert => 'Заштита од манипулација може бити онемогућена само у оквиру изабраног временског периода.';

  @override
  String get permission_notification_access_title => 'Приступ обавештењима';

  @override
  String get permission_notification_access_info => 'Молимо те да одобриш дозволу за приступ обавештењима. Ово ће омогућити Mindful да организује твоја обавештења и достави их по твом распореду.';

  @override
  String get permission_notification_access_required => 'Апликација Mindful захтева приступ обавештењима како би груписао и заказивао обавештења.';

  @override
  String get permission_notification_access_device_tile_label => 'Дозволи приступ обавештењима';

  @override
  String get day_today => 'Данас';

  @override
  String get day_yesterday => 'Јуче';

  @override
  String nDays(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString дана',
      one: '1 дан',
      zero: '0 дана',
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
      other: '$countString сати',
      one: '1 сат',
      zero: '0 сати',
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
      other: '$countString минута',
      one: '1 минута',
      zero: '0 минута',
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
      other: '$countString секунди',
      one: '1 секунда',
      zero: '0 секунди',
    );
    return '$_temp0';
  }

  @override
  String get time_separator_and => 'и';

  @override
  String get timer_status_active => 'Активан';

  @override
  String get timer_status_paused => 'Паузирано';

  @override
  String get create_button => 'Креирај';

  @override
  String get update_button => 'Ажурирај';

  @override
  String get dialog_button_cancel => 'Поништи';

  @override
  String get dialog_button_remove => 'Уклони';

  @override
  String get dialog_button_set => 'Постави';

  @override
  String get dialog_button_reset => 'Ресетуј';

  @override
  String get dialog_button_infinite => 'Бесконачно';

  @override
  String get schedule_start_label => 'Почетак';

  @override
  String get schedule_end_label => 'Крај';

  @override
  String get exit_without_saving_dialog_info => 'Are you sure you want to exit without saving?';

  @override
  String get development_dialog_info => 'Mindful је тренутно у развоју и могуће је да садржи грешке или непотпуне функције. Ако наиђеш на проблем, пријави га како бисмо могли да побољшамо апликацију.\n\nХвала на повратним информацијама!';

  @override
  String get development_dialog_button_report_issue => 'Пријави проблем';

  @override
  String get development_dialog_button_close => 'Затвори';

  @override
  String get dnd_settings_tile_title => 'Подешавања режима „Не узнемиравај“';

  @override
  String get dnd_settings_tile_subtitle => 'Управљање тиме које апликације и обавештења могу да прођу кроз режим „Не узнемиравај“.';

  @override
  String get quick_actions_heading => 'Брзе радње';

  @override
  String get select_distracting_apps_heading => 'Избор апликација које одвлаче пажњу';

  @override
  String get your_distracting_apps_heading => 'Апликације које одвлаче пажњу';

  @override
  String get select_more_apps_heading => 'Изаберите још апликација';

  @override
  String get imp_distracting_apps_snack_alert => 'Додавање важних системских апликација на листу апликација које одвлаче пажњу није дозвољено.';

  @override
  String get custom_apps_quick_actions_unavailable_warning => 'Подаци о коришћењу екрана и ограничењима нису доступни за ову апликацију. Тренутно је доступан само преглед коришћења мреже.';

  @override
  String get create_group_fab_button => 'Направи групу';

  @override
  String get active_period_info => 'Подеси временски период током ког ће приступ бити дозвољен. Ван тог периода, приступ ће бити ограничен.';

  @override
  String get minimum_distracting_apps_snack_alert => 'Изабери бар једну апликацију која одвлачи пажњу.';

  @override
  String get donation_card_title => 'Подржи нас';

  @override
  String get donation_card_info => 'Mindful је бесплатна апликација отвореног кода, развијана месецима уз велику посвећеност. Ако ти је била од помоћи, донација би нам значила пуно. Сваки допринос нам помаже да наставимо са унапређивањем и одржавањем апликације за све.';

  @override
  String get operation_failed_snack_alert => 'Mindful је бесплатна апликација отвореног кода, развијана месецима уз велику посвећеност. Ако ти је била од помоћи, донација би нам значила пуно. Сваки допринос нам помаже да наставимо са унапређивањем и одржавањем апликације за све.\n';

  @override
  String get donation_card_button_donate => 'Донирај';

  @override
  String get app_restart_dialog_title => 'Потребно је поновно покретање';

  @override
  String get app_restart_dialog_info => 'Mindful ће се аутоматски поново покренути када се одбројавање заврши. Молимо за стрпљење док се измене примењују.';

  @override
  String get accessibility_tip => 'Желиш паметније блокирање које троши мање батерије? Одобри дозволу за приступачност за апликацију Mindful да би све радило боље и ефикасније.';

  @override
  String get battery_optimization_tip => 'Mindful не ради како треба?\nДозволи „Игнориши оптимизацију батерије“ у подешавањима како би Mindful несметано радио у позадини.';

  @override
  String get invincible_mode_tip => 'Случајно си уклонио ограничења?\nКористећи режим строге контроле како би ограничења остала активна до сутра или до следеће измене.';

  @override
  String get glance_usage_tip => 'Желиш увид у своје навике?\nMindful нуди одељак преглед где можеш да сазнаш како проводиш време на телефону.';

  @override
  String get tamper_protection_tip => 'Желиш да деинсталираш Mindful? Прво укључи прозор за деинсталацију да би безбедно искључио заштиту од уклањања.';

  @override
  String get notification_blocking_tip => 'Желиш мање ометања? Mindful ти нуди опцију блокирања обавештења како би утишао жељене апликације.';

  @override
  String get usage_history_tip => 'Желиш да размислиш о својим навикама? Погледај историју коришћења да видиш претходне обрасце.';

  @override
  String get focus_mode_tip => 'Желиш дубоку концентрацију? Укључи режим фокуса да блокираш апликације и обавештења док радиш.';

  @override
  String get bedtime_reminder_tip => 'Желиш да бољи и квалитетнији сан? Подеси подсетник за спавање да се сваке вечери лагано искључиш.';

  @override
  String get custom_blocking_tip => 'Желиш да све буде по твојој мери? Направи сопствена правила за блокирање апликација која ти одговарају.';

  @override
  String get session_timeline_tip => 'Желиш да пратиш своје фокус сесије? Погледај хронологију и испрати свој напредак.';

  @override
  String get short_content_blocking_tip => 'Скрећу ти пажњу друштвене мреже? Блокирај кратак садржај са апликација Instagram, YouTube и сличних како би остао концентрисан.';

  @override
  String get parental_controls_tip => 'Треба ти родитељска контрола? Постави ограничења на уређају свог детета како би осигурао безбедно коришћење.';

  @override
  String get notification_batching_tip => 'Желиш мање ометања? Користи груписање обавештења како би ти стизала сва одједном, уместо појединачно.';

  @override
  String get notification_scheduling_tip => 'Желиш да имаш више контроле над обавештењима? Подеси када ти која апликација може слати обавештења.';

  @override
  String get quick_focus_tile_tip => 'Треба ти брз приступ фокусу? Додај брзи фокус тастер да одмах активираш режим фокуса.';

  @override
  String get app_shortcuts_tip => 'Желиш бржи приступ апликацијама? Дугим притиском на иконицу апликације додај пречице.';

  @override
  String get backup_usage_db_tip => 'Желиш да сачуваш своје податке? Направи резервну копију података да би сачувао своје записе.';

  @override
  String get dynamic_material_color_tip => 'Желиш прилагођену тему? Укључи Динамичку Material You боју да усагласиш тему са изгледом свог уређаја.';

  @override
  String get amoled_dark_theme_tip => 'Желиш да уштедиш батерију? Користи AMOLED тамну тему да смањиш потрошњу енергије на OLED екрану.';

  @override
  String get customize_usage_history_tip => 'Желиш да сачуваш историју коришћења? Подеси број недеља које желиш да чуваш у Историји коришћења.';

  @override
  String get grouped_apps_blocking_tip => 'Желиш да блокираш апликације истовремено? Користи групна ограничења да групишеш лимите за апликације и блокираш више њих одједном.';

  @override
  String get websites_blocking_tip => 'Желиш лакше интернет претраживање? Блокирај прилагођене или NSFW веб сајтове за безбрижно и фокусирано онлајн искуство.';

  @override
  String get data_usage_tip => 'Желиш да видиш колико и како трошиш интернет? Прати коришћење мобилних и Wi-Fi података за бољи увид у интернет потрошњу.';

  @override
  String get block_internet_tip => 'Желиш да блокираш интернет приступ некој од апликација?\nОнемогући интернет за одређену апликацију из њеног подешавања.';

  @override
  String get emergency_passes_tip => 'Треба ти пауза? На располагању имаш 3 хитне пропуснице које ти дају приступ блокираним апликацијама на 5 минута.';

  @override
  String get onboarding_skip_btn_label => 'Прескочи';

  @override
  String get onboarding_finish_setup_btn_label => 'Завршите подешавање';

  @override
  String get onboarding_page_one_title => 'Мастер фокус.';

  @override
  String get onboarding_page_one_info => 'Паузирај апликације које те ометају, блокирај кратак садржај и остани фокусиран уз флексибилне фокус сесије. Без обзира да ли радиш, учиш или се одмараш, Mindful ти помаже да задржиш контролу.';

  @override
  String get onboarding_page_two_title => 'Блокирај ометања.';

  @override
  String get onboarding_page_two_info => 'Ограничи коришћење апликација, паузирај их аутоматски и изгради здравије дигиталне навике. Активирај режим за спавање како би се опустио и провео вече без ометања.';

  @override
  String get onboarding_page_three_title => 'Приватност на првом месту.';

  @override
  String get onboarding_page_three_info => 'Mindful је у 100% отвореног кода и ради потпуно офлајн. Не прикупљамо нити делимо било какве личне податке — твоја приватност је у потпуности загарантована.';

  @override
  String get onboarding_page_permissions_title => 'Основне дозволе.';

  @override
  String get onboarding_page_permissions_info => 'Mindful захтева следеће основне дозволе како би могао да прати и управља временом проведеним испред екрана, смањи ометања и побољша фокус.';

  @override
  String get dashboard_tab_title => 'Контролна табла';

  @override
  String get focus_now_fab_button => 'Добродошао/ла назад!';

  @override
  String get welcome_greetings => 'Добродошао/ла назад,';

  @override
  String get username_snack_alert => 'Дуго притисни да измениш корисничко име.';

  @override
  String get username_dialog_title => 'Корисничко име';

  @override
  String get username_dialog_info => 'Унеси корисничко име које ће бити приказано на контролној табли.';

  @override
  String get username_dialog_button_apply => 'Примени';

  @override
  String get glance_tile_title => 'Преглед';

  @override
  String get glance_tile_subtitle => 'Брзо погледај како користиш уређај.';

  @override
  String get parental_controls_tile_subtitle => 'Режим који не може да се прекине.';

  @override
  String get restrictions_heading => 'Ограничења';

  @override
  String get apps_blocking_tile_title => 'Блокирање апликација';

  @override
  String get apps_blocking_tile_subtitle => 'Ограничи апликације на више начина.';

  @override
  String get grouped_apps_blocking_tile_title => 'Блокирање груписаних апликација';

  @override
  String get grouped_apps_blocking_tile_subtitle => 'Ограничи групу апликација истовремено.';

  @override
  String get shorts_blocking_tile_subtitle => 'Ограничи кратак садржај са различитих платформа.';

  @override
  String get websites_blocking_tile_subtitle => 'Ограничи садржај за одрасле и одабране веб сајтове.';

  @override
  String get screen_time_label => 'Време испред екрана';

  @override
  String get total_data_label => 'Укупни интернет подаци';

  @override
  String get mobile_data_label => 'Мобилни подаци';

  @override
  String get wifi_data_label => 'Wi-Fi подаци';

  @override
  String get focus_today_label => 'Фокус за данас';

  @override
  String get focus_weekly_label => 'Фокус за недељу';

  @override
  String get focus_monthly_label => 'Фокус за месец';

  @override
  String get focus_lifetime_label => 'Фокус за цео живот';

  @override
  String get longest_streak_label => 'Најдужи низ';

  @override
  String get current_streak_label => 'Тренутни низ';

  @override
  String get successful_sessions_label => 'Успешне сесије';

  @override
  String get failed_sessions_label => 'Неуспешне сесије';

  @override
  String get statistics_tab_title => 'Статистика';

  @override
  String get screen_segment_label => 'Екран';

  @override
  String get data_segment_label => 'Подаци';

  @override
  String get mobile_label => 'Мобилни подаци';

  @override
  String get wifi_label => 'Wi-Fi';

  @override
  String get most_used_apps_heading => 'Најчешће коришћене апликације';

  @override
  String get show_all_apps_tile_title => 'Прикажи све апликације';

  @override
  String get search_apps_hint => 'Претражи апликације...';

  @override
  String get notifications_tab_title => 'Обавештења';

  @override
  String get notifications_tab_info => 'Групна обавештења од апликација и подешавање распореда као што су јутро, подне, вече и ноћ. Остани у току без сталних прекида.';

  @override
  String get batched_apps_tile_title => 'Груписане апликације';

  @override
  String get batch_recap_dropdown_title => 'Тип груписања обавештења';

  @override
  String get batch_recap_dropdown_info => 'Тип груписаних обавештења: Изабери шта да пошаљеш када се активира распоред — сва обавештења или само сажетак.';

  @override
  String get batch_recap_option_summery_only => 'Само сажетак';

  @override
  String get batch_recap_option_all_notifications => 'Сва обавештења';

  @override
  String get notification_history_tile_title => 'Историја обавештења';

  @override
  String get store_all_tile_title => 'Складишти сва обавештења';

  @override
  String get store_all_tile_subtitle => 'Чувај и обавештења која нису груписана.';

  @override
  String get schedules_heading => 'Распореди';

  @override
  String get new_schedule_fab_button => 'Нови распоред';

  @override
  String get new_schedule_dialog_info => 'Унеси име за распоред обавештења како би га лакше препознао/ла.';

  @override
  String get new_schedule_dialog_field_label => 'Назив распореда';

  @override
  String get bedtime_tab_title => 'Распоред за спавање';

  @override
  String get bedtime_tab_info => 'Постави свој распоред за спавање тако што ћеш одабрати временски период и дане у недељи. Изабери апликације које желиш да блокираш и омогући режим „Не узнемиравај“ (DND) за мирну ноћ.';

  @override
  String get schedule_tile_title => 'Распоред';

  @override
  String get schedule_tile_subtitle => 'Омогући или онемогући дневни распоред.';

  @override
  String get bedtime_no_days_selected_snack_alert => 'Изабери бар један дан у недељи.';

  @override
  String get bedtime_minimum_duration_snack_alert => 'Укупно време за спавање мора бити најмање 30 минута.';

  @override
  String get distracting_apps_tile_title => 'Апликације које одвлаче пажњу';

  @override
  String get distracting_apps_tile_subtitle => 'Изабери које те апликације ометају у ноћној рутини.';

  @override
  String get bedtime_distracting_apps_modify_snack_alert => 'Измене листе апликација које те ометају нису дозвољене док је распоред за спавање активан.';

  @override
  String get parental_controls_tab_title => 'Родитељски надзор';

  @override
  String get invincible_mode_heading => 'Режим строге контроле';

  @override
  String get invincible_mode_tile_title => 'Укључи режим строге контроле';

  @override
  String get invincible_mode_info => 'Када је укључен режим строге контроле, нећеш моћи да мењаш изабрана ограничења након што достигнеш дневну квоту. Ипак, измене су могуће у оквиру изабраног десетоминутног прозора.';

  @override
  String get invincible_mode_snack_alert => 'Због активног режима строге контроле, измене ограничења нису дозвољене.';

  @override
  String get invincible_mode_dialog_info => 'Да ли си сигуран да желиш да укључиш режим строге контроле? Ова радња је неповратна. Када се режим једном активира, не може се искључити све док је ова апликација инсталирана на твом уређају.';

  @override
  String get invincible_mode_turn_off_snack_alert => 'Режим строге контроле не може се искључити све док је ова апликација инсталирана на твом уређају.';

  @override
  String get invincible_mode_dialog_button_start_anyway => 'Покрени свеједно';

  @override
  String get invincible_mode_include_timer_tile_title => 'Укључи тајмер';

  @override
  String get invincible_mode_include_launch_limit_tile_title => 'Укључи ограничење покретања';

  @override
  String get invincible_mode_include_active_period_tile_title => 'Укључи активни период';

  @override
  String get invincible_mode_app_restrictions_tile_title => 'Ограничења апликација';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle => 'Онемогући измене изабраних ограничења након што се дневне квоте премаше.';

  @override
  String get invincible_mode_group_restrictions_tile_title => ' Онемогући измене изабраних ограничења након што се дневне квоте премаше.';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle => 'Онемогући измене изабраних ограничења након што се дневне квоте премаше.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title => 'Укључи тајмер за кратке видео-садржаје';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle => 'Онемогућава измене након што се достигне дневна квота за кратке видео-садржаје.';

  @override
  String get invincible_mode_include_bedtime_tile_title => 'Укључи режим спавања';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle => 'Онемогућава измене током активног распореда за спавање.';

  @override
  String get protected_access_tile_title => 'Заштићен приступ';

  @override
  String get protected_access_tile_subtitle => 'Заштити апликацију Mindful помоћу закључавања уређаја.';

  @override
  String get protected_access_no_lock_snack_alert => 'Постави биометријско закључавање на уређају да би омогућио ову функцију.';

  @override
  String get protected_access_removed_lock_snack_alert => 'Опција закључавања уређаја је уклоњена. Да би наставио, постави ново закључавање.';

  @override
  String get protected_access_failed_lock_snack_alert => 'Аутентификација није успела. Мораш да потврдиш закључавање уређаја да би наставио.';

  @override
  String get tamper_protection_tile_title => 'Заштита од манипулације';

  @override
  String get tamper_protection_tile_subtitle => 'Спречи деинсталацију и присилно заустављање апликације.';

  @override
  String get tamper_protection_confirmation_dialog_info => 'Када буде омогућено, нећеш моћи да деинсталираш, принудно зауставиш или очистиш податке апликације Mindful, осим током изабраног периода за деинсталацију. Нема заобилазних решења.\n\nНастави на своју одговорност.';

  @override
  String get uninstall_window_tile_title => 'Прозор за деинсталацију';

  @override
  String get uninstall_window_tile_subtitle => 'Заштита од манипулације може бити онемогућена у року од 10 минута од изабраног времена.';

  @override
  String get invincible_window_tile_title => 'Прозор режима строге контроле';

  @override
  String get invincible_window_tile_subtitle => 'Изабрана ограничења могу се мењати у року од 10 минута од изабраног времена.';

  @override
  String get shorts_blocking_tab_title => 'Блокирање кратких садржаја';

  @override
  String get shorts_blocking_tab_info => 'Контролиши колико времена проводиш гледајући кратке садржаје на платформама као што су Instagram, YouTube, Snapchat и Facebook, укључујући и њихове веб-сајтове.';

  @override
  String get short_content_heading => 'Кратки садржаји';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Преостало: $timeShortString';
  }

  @override
  String get short_content_timer_picker_dialog_info => 'Постави дневно временско ограничење за кратке садржаје. Када достигнеш лимит, кратки садржаји ће бити паузирани до поноћи.';

  @override
  String get instagram_features_tile_title => 'Instagram';

  @override
  String get instagram_features_tile_subtitle => 'Ограничи функције у оквиру апликације Instagram.';

  @override
  String get instagram_features_block_reels => 'Ограничи одељак Reels.';

  @override
  String get instagram_features_block_explore => 'Ограничи одељак Explore.';

  @override
  String get snapchat_features_tile_title => 'Snapchat';

  @override
  String get snapchat_features_tile_subtitle => 'Ограничи функције у оквиру апликације Snapchat.';

  @override
  String get snapchat_features_block_spotlight => 'Ограничи одељак Spotlight.';

  @override
  String get snapchat_features_block_discover => 'Ограничи одељак Discover.';

  @override
  String get youtube_features_tile_title => 'Youtube';

  @override
  String get youtube_features_tile_subtitle => 'Ограничи кратке видео-садржаје на YouTube платформи.';

  @override
  String get facebook_features_tile_title => 'Facebook';

  @override
  String get facebook_features_tile_subtitle => 'Ограничи Reels у оквиру апликације Facebook.';

  @override
  String get reddit_features_tile_title => 'Reddit';

  @override
  String get reddit_features_tile_subtitle => 'Ограничи кратке видео-садржаје на Reddit платформи.';

  @override
  String get websites_blocking_tab_title => 'Блокирање сајтова';

  @override
  String get websites_blocking_tab_info => 'Блокирај сајтове са садржајем за одрасле и друге сајтове по сопственом избору како би креирао безбедније и фокусираније онлајн искуство. Преузми контролу над својом интернет претрагом и смањи ометања.';

  @override
  String get adult_content_heading => 'Садржај за одрасле';

  @override
  String get block_nsfw_title => 'Блокирај неприкладан садржај';

  @override
  String get block_nsfw_subtitle => 'Ограничи претраживач да не приступа сајтовима за одрасле и порнографији.';

  @override
  String get block_nsfw_dialog_info => 'Да ли си сигуран/сигурна? Ова радња је неповратна. Када укључиш блокатор за сајтове за одрасле, нећеш моћи да га искључиш све док је ова апликација инсталирана на твом уређају.';

  @override
  String get block_nsfw_dialog_button_block_anyway => 'Блокирај у сваком случају';

  @override
  String get blocked_websites_heading => 'Блокирани сајтови';

  @override
  String get blocked_websites_empty_list_hint => 'Кликни на дугме „+ Додај сајт“ да додаш сајтове који те ометају и које желиш да блокираш.';

  @override
  String get add_website_fab_button => 'Додај сајт';

  @override
  String get add_website_dialog_title => 'Сајт који одвлачи пажњу';

  @override
  String get add_website_dialog_info => 'Унеси URL сајта који желиш да блокираш.';

  @override
  String get add_website_dialog_is_nsfw => 'Да ли је овај сајт NSFW (неприкладног садржаја)?';

  @override
  String get add_website_dialog_nsfw_warning => 'Упозорење: NSFW сајтови не могу бити уклоњени након што су додати..';

  @override
  String get add_website_dialog_button_block => 'Блокирај';

  @override
  String get add_website_already_exist_snack_alert => 'URL је већ додат на листу блокираних сајтова.';

  @override
  String get add_website_invalid_url_snack_alert => 'Неважећа URL адреса! Сајт није пронађен.';

  @override
  String get remove_website_dialog_title => 'Уклони сајт';

  @override
  String remove_website_dialog_info(String websitehost) {
    return 'Да ли си сигуран/сигурна? Желиш ли да уклониш \'$websitehost\' са листе блокираних сајтова?';
  }

  @override
  String get focus_tab_title => 'Фокус';

  @override
  String get focus_tab_info => 'Када ти је потребно време за фокусирање, започни нову сесију тако што ћеш изабрати тип, одабрати апликације које те ометају да паузираш и омогућити \"Не узнемиравај\" за несметано концентрисање.';

  @override
  String get active_session_card_title => 'Активни период';

  @override
  String get active_session_card_info => 'Имаш активну фокус сесију! Кликни на „Прегледај“ да видиш свој напредак и колико је времена прошло.';

  @override
  String get active_session_card_view_button => 'Преглед';

  @override
  String get focus_distracting_apps_removal_snack_alert => 'Уклањање апликација са листе ометајућих апликација није дозвољено док је фокус сесија активна. Међутим, током овог времена можеш додати додатне апликације на листу.';

  @override
  String get focus_profile_tile_title => 'Профил фокуса';

  @override
  String get focus_session_duration_tile_title => 'Трајање сесије';

  @override
  String get focus_session_duration_tile_subtitle => 'Бескрајно (осим ако не зауставиш)';

  @override
  String get focus_session_duration_dialog_info => 'Молимо те да изабереш жељено трајање ове фокус сесије. Одреди колико дуго желиш да останеш фокусиран и без ометања.';

  @override
  String get focus_profile_customization_tile_title => 'Уређивање профила';

  @override
  String get focus_profile_customization_tile_subtitle => 'Прилагоди подешавања за одабрани профил.';

  @override
  String get focus_enforce_tile_title => 'Принудна сесија';

  @override
  String get focus_enforce_tile_subtitle => 'Онемогућава прекид сесије пре него што време истекне.';

  @override
  String get focus_session_start_fab_button => 'Започни сесију';

  @override
  String get focus_session_minimum_apps_snack_alert => 'Изабери бар једну апликацију која те омета да започнеш фокус сесију.';

  @override
  String get focus_session_already_active_snack_alert => 'Већ имаш активну фокус сесију. Молимо те да завршиш или зауставиш тренутну сесију пре него што започнеш нову.';

  @override
  String get focus_session_type_study => 'Учење';

  @override
  String get focus_session_type_work => 'Посао';

  @override
  String get focus_session_type_exercise => 'Тренирање';

  @override
  String get focus_session_type_meditation => 'Медитација';

  @override
  String get focus_session_type_creativeWriting => 'Креативно писање';

  @override
  String get focus_session_type_reading => 'Читање';

  @override
  String get focus_session_type_programming => 'Програмирање';

  @override
  String get focus_session_type_chores => 'Обавезе';

  @override
  String get focus_session_type_projectPlanning => 'Планирање пројеката';

  @override
  String get focus_session_type_artAndDesign => 'Уметност и дизајн';

  @override
  String get focus_session_type_languageLearning => 'Учење језика';

  @override
  String get focus_session_type_musicPractice => 'Вежбање инструмента';

  @override
  String get focus_session_type_selfCare => 'Брига о себи';

  @override
  String get focus_session_type_brainstorming => 'Брејнсторминг';

  @override
  String get focus_session_type_skillDevelopment => 'Развој вештина';

  @override
  String get focus_session_type_research => 'Истраживање';

  @override
  String get focus_session_type_networking => 'Повезивање';

  @override
  String get focus_session_type_cooking => 'Припрема хране';

  @override
  String get focus_session_type_sportsTraining => 'Спорт';

  @override
  String get focus_session_type_restAndRelaxation => 'Одмарање и опуштање';

  @override
  String get focus_session_type_other => 'Остало';

  @override
  String get timeline_tab_title => 'Временска линија';

  @override
  String get focus_timeline_tab_info => 'Истражи пут до фокуса одабиром датума. Прати напредак, присети се успеха и учи из изазова.';

  @override
  String selected_month_productive_time_snack_alert(String timeString) {
    return 'Твој укупни продуктивни временски период за одабрани месец је $timeString.';
  }

  @override
  String get selected_month_productive_days_label => 'Продуктивни дани';

  @override
  String selected_month_productive_days_snack_alert(num daysCount) {
    return 'Имаш укупно $daysCount продуктивних дана у одабраном месецу.';
  }

  @override
  String get selected_day_focused_time_label => 'Време проведено у фокусу';

  @override
  String selected_day_focused_time_snack_alert(String timeString) {
    return 'Твој укупни временски период проведен у фокусу за одабрани дан је $timeString.';
  }

  @override
  String get calender_heading => 'Календар';

  @override
  String get your_sessions_heading => 'Твоје сесије';

  @override
  String get your_sessions_empty_list_hint => 'Нема записаних сесија фокуса за одабрани дан.';

  @override
  String get focus_session_tile_timestamp_label => 'Време';

  @override
  String get focus_session_tile_duration_label => 'Трајање';

  @override
  String get focus_session_tile_reflection_label => 'Осврт';

  @override
  String get focus_session_state_active => 'Активност';

  @override
  String get focus_session_state_successful => 'Успешно';

  @override
  String get focus_session_state_failed => 'Неуспешно';

  @override
  String get active_session_tab_title => 'Сесија';

  @override
  String get active_session_none_warning => 'Нема активне сесије. Враћам те на почетни екран.';

  @override
  String get active_session_dialog_button_keep_pushing => 'Настави да се трудиш';

  @override
  String get active_session_finish_dialog_title => 'Заврши';

  @override
  String get active_session_finish_dialog_info => 'Држи се, можеш ти то! Вредно радиш на свом фокусу. Да ли си сигуран да желиш да прекинеш ову сесију? Сваки минут који уложиш ти помаже да достигнеш жељени циљ.';

  @override
  String get active_session_giveup_dialog_title => 'Одустајем';

  @override
  String get active_session_giveup_dialog_info => 'Скоро си ту, не одустај сада! Да ли си сигуран да желиш да прекинеш ову сесију фокуса раније?';

  @override
  String get active_session_reflection_dialog_title => 'Осврт на сесију';

  @override
  String get active_session_reflection_dialog_info => 'Одвоји тренутак да размислиш о свом напретку. Који ти је циљ за ову сесију? Шта си постигао током ње?';

  @override
  String get active_session_reflection_dialog_tip => 'Савет: Ово увек можеш касније изменити у временској линији сесије.';

  @override
  String get active_session_giveup_snack_alert => 'Главу горе. Не брини, следећи пут ћеш бити бољи. Сваки напор се рачуна – само настави да радиш на себи';

  @override
  String get active_session_quote_one => 'Сваки корак се рачуна, остани снажан и настави даље';

  @override
  String get active_session_quote_two => 'Остани фокусиран! Ово су сјајни резултати';

  @override
  String get active_session_quote_three => 'На правом си путу! Настави са одличним радом';

  @override
  String get active_session_quote_four => 'Само још мало, иде ти супер';

  @override
  String active_session_quote_five(String durationString) {
    return 'Браво! 🎉 \n Завршио си своју сесију фокуса у трајању од $durationString.\n\nОдличан посао, настави са невероватним радом';
  }

  @override
  String get restriction_groups_tab_title => 'Групе ограничења';

  @override
  String get restriction_groups_tab_info => 'Постави укупно временско ограничење за групу апликација. Када укупно време коришћења достигне твоје ограничење, све апликације у групи ће бити паузиране како би ти помогле да одржиш фокус и баланс.';

  @override
  String get restriction_group_time_spent_label => 'Време проведено данас';

  @override
  String get restriction_group_time_left_label => 'Преостало време данас';

  @override
  String get restriction_group_name_tile_title => 'Назив групе';

  @override
  String get restriction_group_name_picker_dialog_info => 'Унеси име групе ограничења како би је лако препознао и управљао њоме.';

  @override
  String get restriction_group_timer_tile_title => 'Тајмер групе';

  @override
  String get restriction_group_timer_picker_dialog_info => 'Постави дневно временско ограничење за ову групу. Када достигнеш своје ограничење, све апликације у групи ће бити паузиране до поноћи.';

  @override
  String get restriction_group_active_period_tile_title => 'Активни период групе';

  @override
  String get remove_restriction_group_dialog_title => 'Уклони групу';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return 'Да ли си сигуран да желиш да уклониш \'$groupName\' из група ограничења?';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert => 'Подесите тајмер или ограничење активног периода.';

  @override
  String get notifications_empty_list_hint => 'Ниједно обавештење није груписано данас.';

  @override
  String get conversations_label => 'Преписке';

  @override
  String get last_24_hours_heading => 'Последња 24 сата';

  @override
  String get notification_timeline_tab_info => 'Прегледај историју обавештења бирањем датума са календара.\nПогледај које су ти апликације највише одвлачиле пажњу и размисли о својим дигиталним навикама.';

  @override
  String get monthly_label => 'На месечном нивоу';

  @override
  String get daily_label => 'Дневно';

  @override
  String get search_notifications_sheet_info => 'Лако пронађи стара обавештења претрагом по наслову или садржају.\nОлакшава брзо проналажење важних обавештења.';

  @override
  String get search_notifications_hint => 'Претрага обавештења...';

  @override
  String get search_notifications_empty_list_hint => 'Нема обавештења која се поклапају са претрагом.';

  @override
  String get app_info_none_warning => 'Није могуће пронаћи апликацију за дати пакет. Враћам се на почетни екран.';

  @override
  String get emergency_fab_button => 'Упозорење';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return 'Ова радња ће паузирати блокатор апликација на наредних 5 минута. Преостало ти је $leftPassesCount пропусница. Након што искористиш све пропуснице, апликација ће остати блокирана до поноћи, или док активна фокус сесија не заврши.\n\nДа ли желиш да наставиш?';
  }

  @override
  String get emergency_dialog_button_use_anyway => 'Користи у сваком случају';

  @override
  String get emergency_started_snack_alert => 'Блокатор апликација је паузиран и наставиће са блокирањем за 5 минута.';

  @override
  String get emergency_already_active_snack_alert => 'Блокатор апликација је тренутно паузиран или неактиван. Ако су обавештења омогућена, добићеш ажурирања о преосталом времену.';

  @override
  String get emergency_no_pass_left_snack_alert => 'Искористио си све своје хитне пропуснице. Блокиране апликације ће остати блокиране до поноћи, или док се активна фокус сесија не заврши.';

  @override
  String get app_limit_status_not_set => 'Није подешено';

  @override
  String get app_timer_tile_title => 'Тајмер апликације';

  @override
  String get app_timer_picker_dialog_info => 'Постави дневно временско ограничење за ову апликацију. Када достигнеш своје ограничење, коришћење апликације ће бити онемогућено до поноћи.';

  @override
  String get usage_reminders_tile_title => 'Обавештења о коришћењу';

  @override
  String get usage_reminders_tile_subtitle => 'Подсетници при коришћењу апликација са временским ограничењем.';

  @override
  String get app_launch_limit_tile_title => 'Ограничење покретања';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Започето $count пута данас.';
  }

  @override
  String get app_launch_limit_picker_dialog_info => 'Постави колико пута можеш да отвориш ову апликацију сваког дана. Када се достигне лимит, апликација ће бити паузирана до поноћи.';

  @override
  String get app_active_period_tile_title => 'Активни период';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return 'Од $startTime до $endTime';
  }

  @override
  String get internet_access_tile_title => 'Приступ интернету';

  @override
  String get internet_access_tile_subtitle => 'Искључи да блокираш интернет за апликацију.';

  @override
  String internet_access_blocked_snack_alert(String appName) {
    return 'Интернет за апликацију $appName је блокиран.';
  }

  @override
  String internet_access_unblocked_snack_alert(String appName) {
    return ' Интернет за апликацију $appName је блокиран.';
  }

  @override
  String get launch_app_tile_title => 'Покрени апликацију';

  @override
  String launch_app_tile_subtitle(String appName) {
    return 'Отвори $appName.';
  }

  @override
  String get go_to_app_settings_tile_title => 'Отвори подешавања апликације';

  @override
  String get go_to_app_settings_tile_subtitle => 'Управљај подешавањима апликације као што су обавештења, дозволе, складиштење и друго.';

  @override
  String get include_in_stats_tile_title => 'Укључи у коришћење екрана';

  @override
  String get include_in_stats_tile_subtitle => 'Искључи ову апликацију из укупног времена проведеног испред екрана.';

  @override
  String app_excluded_from_stats_snack_alert(String appName) {
    return '$appName је искључен из укупног времена проведеног испред екрану.';
  }

  @override
  String app_include_to_stats_snack_alert(String appName) {
    return '$appName је укључен у укупно време коришћења екрана.';
  }

  @override
  String get general_tab_title => 'Опште';

  @override
  String get appearance_heading => 'Приказ';

  @override
  String get theme_mode_tile_title => 'Режим теме';

  @override
  String get theme_mode_system_label => 'Системски';

  @override
  String get theme_mode_light_label => 'Светла';

  @override
  String get theme_mode_dark_label => 'Тамна';

  @override
  String get material_color_tile_title => 'Боја у стилу Material дизајна';

  @override
  String get amoled_dark_tile_title => 'AMOLED тамна';

  @override
  String get amoled_dark_tile_subtitle => 'Користи чисто црну боју за тамну тему.';

  @override
  String get dynamic_colors_tile_title => 'Динамичне боје';

  @override
  String get dynamic_colors_tile_subtitle => 'Користи боје уређаја ако су подржане.';

  @override
  String get defaults_heading => 'Подразумеване вредности';

  @override
  String get app_language_tile_title => 'Језик апликације';

  @override
  String get default_home_tab_tile_title => 'Почетна картица';

  @override
  String get usage_history_tile_title => 'Историја употребе';

  @override
  String get usage_history_15_days => '15 дана';

  @override
  String get usage_history_1_month => '1 месец';

  @override
  String get usage_history_3_month => '3 месеца';

  @override
  String get usage_history_6_month => '6 месеци';

  @override
  String get usage_history_1_year => '1 година';

  @override
  String get service_heading => 'Услуга';

  @override
  String get service_stopping_warning => 'Ако Mindful престане да ради изненада, молимо те да доделиш дозволу \'Игнориши оптимизацију батерије\' како би апликација наставила да ради у позадини. Ако то не реши проблем, покушај да ставиш Mindful на белу листу за неометан рад.';

  @override
  String get whitelist_app_tile_title => 'Додај Mindful на белу листу';

  @override
  String get whitelist_app_tile_subtitle => 'Одобри да се Mindful аутоматски покреће.';

  @override
  String get whitelist_app_unsupported_snack_alert => 'Овај уређај не подржава управљање аутоматским покретањем.';

  @override
  String get database_tab_title => 'База података';

  @override
  String get import_db_tile_title => 'Увоз базе података';

  @override
  String get import_db_tile_subtitle => 'Увоз базе података из фајла.';

  @override
  String get export_db_tile_title => 'Извоз базе података';

  @override
  String get export_db_tile_subtitle => 'Извоз базе података у фајл.';

  @override
  String get crash_logs_heading => 'Извештаји о квару';

  @override
  String get crash_logs_info => 'Ако наидеш на било који проблем, можеш да га пријавиш на GitHub уз извештаје о квару. Фајл ће садржати детаље као што су произвођач твог уређаја, модел, верзија Андроида, верзија SDK-а и извештаје о квару. Ове информације ће нам помоћи да ефикасније идентификујемо и решимо проблем.';

  @override
  String get crash_logs_export_tile_title => 'Извези извештаје о квару';

  @override
  String get crash_logs_export_tile_subtitle => 'Извези извештаје о квару као json фајл.';

  @override
  String get crash_logs_view_tile_title => 'Прегледај извештаје (логове)';

  @override
  String get crash_logs_view_tile_subtitle => 'Прегледај извештаје (логове)';

  @override
  String get crash_logs_empty_list_hint => 'До сада није забележен ниједан квар.';

  @override
  String get crash_logs_clear_tile_title => 'Очисти записнике';

  @override
  String get crash_logs_clear_tile_subtitle => 'Обриши све извештаје (логове) квара из базе података.';

  @override
  String get crash_logs_clear_dialog_info => 'Да ли си сигуран да желиш да обришеш све логове квара из базе података?';

  @override
  String get crash_logs_clear_dialog_button_clear_anyway => 'Обриши';

  @override
  String get about_tab_title => 'О нама';

  @override
  String get changelog_tile_title => 'Историја измена';

  @override
  String get changelog_tile_subtitle => 'Сазнај шта је ново.';

  @override
  String get full_changelog_tile_title => 'Целокупан дневник измена';

  @override
  String get redirected_to_github_subtitle => 'Бићеш преусмерен на GitHub.';

  @override
  String get contribute_heading => 'Допринеси';

  @override
  String get github_tile_title => 'GitHub';

  @override
  String get github_tile_subtitle => 'Погледај изворни код.';

  @override
  String get report_issue_tile_title => 'Пријави проблем';

  @override
  String get suggest_idea_tile_title => 'Пошаљи нам предлог';

  @override
  String get write_email_tile_title => 'Пиши нам путем мејла';

  @override
  String get write_email_tile_subtitle => 'Бићеш преусмерен у апликацију за е-пошту.';

  @override
  String get privacy_policy_heading => 'Политика приватности';

  @override
  String get privacy_policy_info => 'Mindful је посвећен заштити твоје приватности. Не прикупљамо, не чувамо и не делимо било какве податке наших корисника. Апликација ради потпуно офлајн и не захтева интернет везу. Твоје личне информације остају приватне и безбедне на твом уређају. Као апликација отвореног кода (FOSS), Mindful гарантује потпуну транспарентност и контролу корисника над сопственим подацима.';

  @override
  String get more_details_button => 'Још детаља';
}
