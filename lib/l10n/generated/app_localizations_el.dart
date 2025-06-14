// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get mindful_tagline =>
      'Επικεντρωθείτε σε ό,τι έχει πραγματικά σημασία';

  @override
  String get unlock_button_label => 'Ξεκλείδωμα';

  @override
  String get permission_status_off => 'Απενεργοποιημένο';

  @override
  String get permission_status_allowed => 'Επιτρέπεται';

  @override
  String get permission_status_not_allowed => 'Δεν επιτρέπεται';

  @override
  String get permission_button_grant_permission => 'Εκχώρηση Άδειας';

  @override
  String get permission_button_agree_and_continue => 'Αποδοχή & Συνέχεια';

  @override
  String get permission_button_not_now => 'Αργότερα';

  @override
  String get permission_button_help => 'Βοήθεια;';

  @override
  String get permission_sheet_privacy_info =>
      'Το Mindful είναι 100% ασφαλές και λειτουργεί εκτός σύνδεσης. Δεν συλλέγουμε ή αποθηκεύουμε προσωπικά δεδομένα.';

  @override
  String permission_grant_step_one(String button_label) {
    return '1. Πατήστε το κουμπί $button_label.';
  }

  @override
  String get permission_grant_step_two =>
      '2. Επιλέξτε το Mindful στην επόμενη οθόνη.';

  @override
  String get permission_grant_step_three =>
      '3. Πατήστε και ενεργοποιήστε το διακόπτη όπως παρακάτω.';

  @override
  String get permission_notification_title => 'Αποστολή Ειδοποιήσεων';

  @override
  String get permission_alarms_title => 'Ειδοποιήσεις & Υπενθυμίσεις';

  @override
  String get permission_alarms_info =>
      'Παρακαλώ δώσε την άδεια για τον ορισμό ξυπνητηριών και υπενθυμίσεων. Αυτό θα επιτρέψει στο Mindful να ξεκινήσει το πρόγραμμά ύπνου σου στην ώρα του και να επαναφέρει χρονόμετρα εφαρμογών καθημερινά τα μεσάνυχτα και για να σε βοηθήσει να μείνεις στο σωστό δρόμο.';

  @override
  String get permission_alarms_device_tile_label =>
      'Να επιτρέπεται η ρύθμιση ξυπνητηριών και υπενθυμίσεων';

  @override
  String get permission_usage_title => 'Πρόσβαση Χρήσης';

  @override
  String get permission_usage_info =>
      'Παρακαλούμε εκχώρησε άδεια πρόσβασης χρήσης. Αυτό θα επιτρέψει στο Mindful να παρακολουθεί τη χρήση εφαρμογών και να διαχειρίζεται την πρόσβαση σε ορισμένες εφαρμογές, εξασφαλίζοντας ένα πιο συγκεντρωμένο και ελεγχόμενο ψηφιακό περιβάλλον.';

  @override
  String get permission_usage_device_tile_label =>
      'Να επιτρέπεται η πρόσβαση χρήσης';

  @override
  String get permission_overlay_title => 'Επικάλυψη Οθόνης';

  @override
  String get permission_overlay_info =>
      'Παρακαλώ παραχώρησε δικαιώματα επικάλυψης οθόνης. Αυτό θα επιτρέψει στο Mindful να δείχνει μια επικάλυψη όταν μια εφαρμογή σε παύση είναι ανοιχτή, βοηθώντας σε να παραμείνεις σε συγκέντρωση και να διατηρήσεις το πρόγραμμά σου.';

  @override
  String get permission_overlay_device_tile_label =>
      'Επιτρέπεται η εμφάνιση πάνω σ\' άλλες εφαρμογές';

  @override
  String get permission_accessibility_title => 'Προσβασιμότητα';

  @override
  String get permission_accessibility_info =>
      'Παρακαλούμε εκχώρησε την άδεια προσβασιμότητας. Αυτό θα επιτρέψει στο Mindful να περιορίσει την πρόσβαση σε περιεχόμενο βίντεο μικρής μορφής (πχ. Reels, Shorts) μέσα από εφαρμογές κοινωνικής δικτύωσης και προγράμματα περιήγησης και να φιλτράρει ακατάλληλες ιστοσελίδες.';

  @override
  String get permission_accessibility_required =>
      'Το Mindful απαιτεί δικαιώματα προσβασιμότητας για να μπλοκάρει αποτελεσματικά το σύντομο περιεχόμενο και τις ιστοσελίδες.';

  @override
  String get permission_accessibility_device_tile_label => 'Χρήση Mindful';

  @override
  String get permission_dnd_title => 'Μην ενοχλείτε';

  @override
  String get permission_dnd_info =>
      'Παρακαλώ χορήγησε πρόσβαση στη λειτουργία \"Μην ενοχλείτε\". Αυτό θα επιτρέψει στο Mindful να ξεκινήσει και να σταματήσει τη λειτουργία \"Μην ενοχλείτε\" κατά τη διάρκεια του χρονοδιαγράμματος ύπνου.';

  @override
  String get permission_dnd_tile_title => 'Έναρξη DND';

  @override
  String get permission_dnd_tile_subtitle =>
      'Ενεργοποίηση και της λειτουργίας Μην ενοχλείτε.';

  @override
  String get permission_battery_optimization_tile_title =>
      'Αγνόηση Βελτιστοποίησης Μπαταρίας';

  @override
  String get permission_battery_optimization_status_enabled =>
      'Ήδη χωρίς περιορισμούς';

  @override
  String get permission_battery_optimization_status_disabled =>
      'Απενεργοποίηση περιορισμού παρασκηνίου';

  @override
  String get permission_battery_optimization_allow_info =>
      'Η επιλογή \'Αγνόηση βελτιστοποίησης μπαταρίας\' θα παραχωρήσει αυτόματα δικαιώματα \'Ξυπνητήρια & Υπενθυμίσεις\' σε ορισμένες συσκευές.';

  @override
  String get permission_vpn_title => 'Δημιουργία VPN';

  @override
  String get permission_vpn_info =>
      'Παρακαλώ παραχώρησε άδεια για τη δημιουργία σύνδεσης εικονικού ιδιωτικού δικτύου (VPN). Αυτό θα επιτρέψει στο Mindful να περιορίσει την πρόσβαση στο διαδίκτυο για καθορισμένες εφαρμογές με τη δημιουργία τοπικών στη συσκευή VPN.';

  @override
  String get permission_admin_title => 'Διαχειριστής';

  @override
  String get permission_admin_info =>
      'Απαιτούνται δικαιώματα διαχειριστή μόνο για βασικές λειτουργίες ώστε να διασφαλίζεται ότι η εφαρμογή λειτουργεί σωστά και παραμένει απαραβίαστη.';

  @override
  String get permission_admin_snack_alert =>
      'Η προστασία Παραβίασης μπορεί να απενεργοποιηθεί μόνο κατά τη διάρκεια του επιλεγμένου χρονικού παραθύρου.';

  @override
  String get permission_notification_access_title => 'Πρόσβαση Ειδοποιήσεων';

  @override
  String get permission_notification_access_info =>
      'Παρακαλούμε χορήγησε άδεια πρόσβασης στις ειδοποιήσεις. Αυτό θα επιτρέψει στο Mindful να οργανώσει τις ειδοποιήσεις σου και να τις παραδίδει βάσει του προγράμματός σου.';

  @override
  String get permission_notification_access_required =>
      'Το Mindful απαιτεί πρόσβαση στις ειδοποιήσεις για να τις οργανώνει και να τις χρονοπρογραμματίζει.';

  @override
  String get permission_notification_access_device_tile_label =>
      'Να επιτρέπεται η πρόσβαση στις ειδοποιήσεις';

  @override
  String get day_today => 'Σήμερα';

  @override
  String get day_yesterday => 'Χθες';

  @override
  String nDays(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ημέρες',
      one: '1 ημέρα',
      zero: '0 ημέρα',
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
      other: '$countString ώρες',
      one: '1 ώρα',
      zero: '0 ώρα',
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
      other: '$countString λεπτά',
      one: '1 λεπτό',
      zero: '0 λεπτό',
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
      other: '$countString δευτερόλεπτα',
      one: '1 δευτερόλεπτο',
      zero: '0 δευτερόλεπτο',
    );
    return '$_temp0';
  }

  @override
  String get time_separator_and => 'και';

  @override
  String get timer_status_active => 'Ενεργό';

  @override
  String get timer_status_paused => 'Σε Παύση';

  @override
  String get create_button => 'Δημιουργία';

  @override
  String get update_button => 'Ενημέρωση';

  @override
  String get dialog_button_cancel => 'Ακύρωση';

  @override
  String get dialog_button_remove => 'Αφαίρεση';

  @override
  String get dialog_button_set => 'Ορισμός';

  @override
  String get dialog_button_reset => 'Επαναφορά';

  @override
  String get dialog_button_infinite => 'Άπειρο';

  @override
  String get schedule_start_label => 'Έναρξη';

  @override
  String get schedule_end_label => 'Λήξη';

  @override
  String get exit_without_saving_dialog_info =>
      'Are you sure you want to exit without saving?';

  @override
  String get development_dialog_info =>
      'Το Mindful είναι υπό ανάπτυξη και μπορεί να έχει σφάλματα ή ελλιπή χαρακτηριστικά. Αν αντιμετωπίσεις οποιοδήποτε πρόβλημα, παρακαλούμε να τα αναφέρεις για να μας βοηθήσεις να βελτιωθούμε.\n\nΣε ευχαριστούμε για τα σχόλιά σου!';

  @override
  String get development_dialog_button_report_issue => 'Αναφορά Ζητήματος';

  @override
  String get development_dialog_button_close => 'Κλείσιμο';

  @override
  String get dnd_settings_tile_title => 'Ρυθμίσεις Μην ενοχλείτε';

  @override
  String get dnd_settings_tile_subtitle =>
      'Διαχειρίσου ποιες εφαρμογές και ειδοποιήσεις μπορούν να σε φτάσουν στο DND.';

  @override
  String get quick_actions_heading => 'Γρήγορες ενέργειες';

  @override
  String get select_distracting_apps_heading => 'Επιλογή ενοχλητικών εφαρμογών';

  @override
  String get your_distracting_apps_heading => 'Οι εφαρμογές που σε ενοχλούν';

  @override
  String get select_more_apps_heading => 'Επιλογή περισσότερων εφαρμογών';

  @override
  String get imp_distracting_apps_snack_alert =>
      'Δεν επιτρέπεται η προσθήκη σημαντικών εφαρμογών συστήματος στη λίστα των ενοχλητικών εφαρμογών.';

  @override
  String get custom_apps_quick_actions_unavailable_warning =>
      'Η χρήση και οι περιορισμοί οθόνης δεν είναι διαθέσιμοι για αυτήν την εφαρμογή. Προς το παρόν, μόνο η χρήση δικτύου είναι προσβάσιμη';

  @override
  String get create_group_fab_button => 'Δημιουργία Ομάδας';

  @override
  String get active_period_info =>
      'Όρισε μια χρονική περίοδο κατά την οποία θα επιτρέπεται η πρόσβαση. Εκτός αυτού του χρονικού πλαισίου, η πρόσβαση θα περιοριστεί.';

  @override
  String get minimum_distracting_apps_snack_alert =>
      'Επέλεξε τουλάχιστον μία εφαρμογή που αποσπά την προσοχή.';

  @override
  String get donation_card_title => 'Υποστήριξέ μας';

  @override
  String get donation_card_info =>
      'Το Mindful είναι ελεύθερο και ανοικτού κώδικα, που αναπτύχθηκε με μήνες αφοσίωσης. Αν σ\' έχει βοηθήσει, η δωρεά σου θα σήμαινε τα πάντα σε εμάς. Κάθε συνεισφορά μάς βοηθά να συνεχίσουμε να την βελτιώνουμε και να την συντηρούμε για όλους.';

  @override
  String get operation_failed_snack_alert =>
      'Η λειτουργία απέτυχε, κάτι πήγε στραβά!';

  @override
  String get donation_card_button_donate => 'Δωρεά';

  @override
  String get app_restart_dialog_title => 'Απαιτείται επανεκκίνηση';

  @override
  String get app_restart_dialog_info =>
      'Το Mindful θα επανεκκινήσει αυτόματα μόλις ολοκληρωθεί η αντίστροφη μέτρηση. Παρακαλώ να κάνεις υπομονή καθώς εφαρμόζονται αλλαγές.';

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
  String get onboarding_skip_btn_label => 'Παράλειψη';

  @override
  String get onboarding_finish_setup_btn_label => 'Ολοκλήρωση Ρύθμισης';

  @override
  String get onboarding_page_one_title => 'Κατέκτησε τη Συγκέντρωση.';

  @override
  String get onboarding_page_one_info =>
      'Παύση ενοχλητικών εφαρμογών, φραγή σύντομου περιεχομένου και παραμονή στο σωστό δρόμο με προσαρμόσιμες συνεδρίες εστίασης. Είτε εργάζεσαι, διαβάζεις είτε χαλαρώνεις το Mindful σε βοηθά να έχεις τον έλεγχο.';

  @override
  String get onboarding_page_two_title => 'Αποκλεισμός Περισπασμών.';

  @override
  String get onboarding_page_two_info =>
      'Ορισμός ορίων χρήσης, αυτόματη παύση εφαρμογών και δημιουργία πιο υγιεινών ψηφιακών συνηθειών. Χρησιμοποίησε τη λειτουργία ύπνου για να χαλαρώσεις και να απολαύσεις μια νύχτα χωρίς ενοχλήσεις.';

  @override
  String get onboarding_page_three_title => 'Πρώτα το Απόρρητο.';

  @override
  String get onboarding_page_three_info =>
      'Το Mindful είναι 100% ανοικτού κώδικα και λειτουργεί εξ\' ολοκλήρου εκτός σύνδεσης. Δεν συλλέγουμε ή κοινοποιούμε τα προσωπικά σου δεδομένα - το απόρρητό σου είναι εγγυημένο με κάθε τρόπο.';

  @override
  String get onboarding_page_permissions_title => 'Βασικές Άδειες.';

  @override
  String get onboarding_page_permissions_info =>
      'Το Mindful απαιτεί τα ακόλουθα απαραίτητα δικαιώματα για να παρακολουθεί και να διαχειρίζεται το χρόνο επί οθόνης σου, βοηθώντας στη μείωση των περισπασμών και στη βελτίωση της συγκέντρωσης.';

  @override
  String get dashboard_tab_title => 'Επισκόπηση';

  @override
  String get focus_now_fab_button => 'Εστίαση τώρα';

  @override
  String get welcome_greetings => 'Καλώς ήρθες και πάλι,';

  @override
  String get username_snack_alert =>
      'Πάτα παρατεταμένα για επεξεργασία ονόματος χρήστη.';

  @override
  String get username_dialog_title => 'Όνομα χρήστη';

  @override
  String get username_dialog_info =>
      'Εισήγαγε το όνομα χρήστη σου το οποίο θα εμφανίζεται στην επισκόπηση.';

  @override
  String get username_dialog_button_apply => 'Εφαρμογή';

  @override
  String get glance_tile_title => 'Ματιά';

  @override
  String get glance_tile_subtitle => 'Ρίξε μια γρήγορη ματιά στη χρήση σου.';

  @override
  String get parental_controls_tile_subtitle =>
      'Λειτουργία άτρωτου και προστασία από παραβίαση.';

  @override
  String get restrictions_heading => 'Περιορισμοί';

  @override
  String get apps_blocking_tile_title => 'Αποκλεισμός εφαρμογών';

  @override
  String get apps_blocking_tile_subtitle =>
      'Περιόρισε τις εφαρμογές με πολλούς τρόπους.';

  @override
  String get grouped_apps_blocking_tile_title =>
      'Αποκλεισμός ομαδοποιημένων εφαρμογών';

  @override
  String get grouped_apps_blocking_tile_subtitle =>
      'Περιορισμός ομάδας εφαρμογών ταυτόχρονα.';

  @override
  String get shorts_blocking_tile_subtitle =>
      'Περιορισμός σύντομου περιεχομένου σε πολλαπλές πλατφόρμες.';

  @override
  String get websites_blocking_tile_subtitle =>
      'Περιορισμός ενηλίκων και προσαρμοσμένων ιστοσελίδων.';

  @override
  String get screen_time_label => 'Χρόνος οθόνης';

  @override
  String get total_data_label => 'Συνολικά δεδομένα';

  @override
  String get mobile_data_label => 'Δεδομένα κινητής';

  @override
  String get wifi_data_label => 'Δεδομένα Wifi';

  @override
  String get focus_today_label => 'Εστίαση σήμερα';

  @override
  String get focus_weekly_label => 'Εστίαση εβδομαδιαία';

  @override
  String get focus_monthly_label => 'Εστίαση μηνιαία';

  @override
  String get focus_lifetime_label => 'Εστίαση συνολικά';

  @override
  String get longest_streak_label => 'Μεγαλύτερο σερί';

  @override
  String get current_streak_label => 'Τρέχον σερί';

  @override
  String get successful_sessions_label => 'Επιτυχείς συνεδρίες';

  @override
  String get failed_sessions_label => 'Αποτυχημένες συνεδρίες';

  @override
  String get statistics_tab_title => 'Στατιστικά';

  @override
  String get screen_segment_label => 'Οθόνη';

  @override
  String get data_segment_label => 'Δεδομένα';

  @override
  String get mobile_label => 'Κινητή';

  @override
  String get wifi_label => 'Wifi';

  @override
  String get most_used_apps_heading => 'Πιο χρησιμοποιούμενες εφαρμογές';

  @override
  String get show_all_apps_tile_title => 'Εμφάνιση όλων των εφαρμογών';

  @override
  String get search_apps_hint => 'Search apps...';

  @override
  String get notifications_tab_title => 'Ειδοποιήσεις';

  @override
  String get notifications_tab_info =>
      'Μαζική ειδοποίηση από εφαρμογές και ορίστε προγράμματα όπως πρωί, μεσημέρι, βράδυ και νύχτα. Μείνετε ενημερωμένοι χωρίς συνεχείς διακοπές.';

  @override
  String get batched_apps_tile_title => 'Εφαρμογές σε παρτίδα';

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
  String get schedules_heading => 'Προγράμματα';

  @override
  String get new_schedule_fab_button => 'Νέο Πρόγραμμα';

  @override
  String get new_schedule_dialog_info =>
      'Εισήγαγε ένα όνομα για το πρόγραμα ειδοποιήσεων για να το αναγνωρίζεις εύκολα.';

  @override
  String get new_schedule_dialog_field_label => 'Όνομα προγράμματος';

  @override
  String get bedtime_tab_title => 'Ώρα για ύπνο';

  @override
  String get bedtime_tab_info =>
      'Ρύθμισε το πρόγραμμα ύπνου σου επιλέγοντας μια χρονική περίοδο και ημέρες της εβδομάδας. Επέλεξε ενοχλητικές εφαρμογές για αποκλεισμό και ενεργοποίηση λειτουργίας \"Μην ενοχλείτε\" (DND) για μια ήρεμη νύχτα.';

  @override
  String get schedule_tile_title => 'Πρόγραμμα';

  @override
  String get schedule_tile_subtitle =>
      'Ενεργοποίηση ή απενεργοποίηση ημερήσιου προγράμματος.';

  @override
  String get bedtime_no_days_selected_snack_alert =>
      'Επέλεξε τουλάχιστον μία ημέρα της εβδομάδας.';

  @override
  String get bedtime_minimum_duration_snack_alert =>
      'Η συνολική διάρκεια του ύπνου πρέπει να είναι τουλάχιστον 30 λεπτά.';

  @override
  String get distracting_apps_tile_title => 'Ενοχλητικές εφαρμογές';

  @override
  String get distracting_apps_tile_subtitle =>
      'Επέλεξε ποιες εφαρμογές σού αποσπούν την προσοχή από τη ρουτίνα ύπνου σου.';

  @override
  String get bedtime_distracting_apps_modify_snack_alert =>
      'Τροποποιήσεις στη λίστα των ενοχλητικών εφαρμογών δεν επιτρέπονται ενώ το χρονοδιάγραμμα ώρα για ύπνο είναι ενεργό.';

  @override
  String get parental_controls_tab_title => 'Γονικοί έλεγχοι';

  @override
  String get invincible_mode_heading => 'Άτρωτη λειτουργία';

  @override
  String get invincible_mode_tile_title => 'Ενεργοποίηση άτρωτης λειτουργίας';

  @override
  String get invincible_mode_info =>
      'Όταν η Άτρωτη Λειτουργία είναι ενεργή, δεν θα μπορείς να προσαρμόσεις τα επιλεγμένα όρια μετά την επίτευξη του ημερήσιου ορίου σου. Ωστόσο, μπορείς να κάνεις αλλαγές μέσα σε ένα επιλεγμένο άτρωτο παράθυρο 10 λεπτών.';

  @override
  String get invincible_mode_snack_alert =>
      'Λόγω της άτρωτης λειτουργίας, δεν επιτρέπονται τροποποιήσεις σε περιορισμούς.';

  @override
  String get invincible_mode_dialog_info =>
      'Σίγουρα ότι θες να ενεργοποιήσεις την Άτρωτη Λειτουργία; Αυτή η ενέργεια είναι μη αναστρέψιμη. Μόλις ενεργοποιηθεί η Άτρωτη λειτουργία, δεν μπορείς να την απενεργοποιήσεις για όσο διάστημα αυτή η εφαρμογή είναι εγκατεστημένη στη συσκευή σου.';

  @override
  String get invincible_mode_turn_off_snack_alert =>
      'Η Άτρωτη Λειτουργία δεν μπορεί να απενεργοποιηθεί για όσο διάστημα αυτή η εφαρμογή παραμένει εγκατεστημένη στη συσκευή σου.';

  @override
  String get invincible_mode_dialog_button_start_anyway =>
      'Εκκίνηση οπωσδήποτε';

  @override
  String get invincible_mode_include_timer_tile_title =>
      'Συμπερίληψη χρονομέτρου';

  @override
  String get invincible_mode_include_launch_limit_tile_title =>
      'Συμπερίληψη ορίου εκκίνησης';

  @override
  String get invincible_mode_include_active_period_tile_title =>
      'Συμπερίληψη ενεργής περιόδου';

  @override
  String get invincible_mode_app_restrictions_tile_title =>
      'Περιορισμοί εφαρμογών';

  @override
  String get invincible_mode_app_restrictions_tile_subtitle =>
      'Αποτροπή αλλαγών στους επιλεγμένους περιορισμούς της εφαρμογής μόλις ξεπεραστούν τα ημερήσια όρια.';

  @override
  String get invincible_mode_group_restrictions_tile_title =>
      'Ομαδοποίηση περιορισμών';

  @override
  String get invincible_mode_group_restrictions_tile_subtitle =>
      'Αποτροπή αλλαγών στους επιλεγμένους περιορισμούς της ομάδας μόλις ξεπεραστούν τα ημερήσια όρια.';

  @override
  String get invincible_mode_include_shorts_timer_tile_title =>
      'Συμπερίληψη χρονομέτρου shorts';

  @override
  String get invincible_mode_include_shorts_timer_tile_subtitle =>
      'Αποτρέπει τις αλλαγές μετά την επίτευξη του ημερήσιου ορίου shorts.';

  @override
  String get invincible_mode_include_bedtime_tile_title =>
      'Συμπερίληψη ώρας για ύπνο';

  @override
  String get invincible_mode_include_bedtime_tile_subtitle =>
      'Αποτρέπει τις αλλαγές κατά τη διάρκεια του ενεργού προγράμματος ώρας για ύπνο.';

  @override
  String get protected_access_tile_title => 'Προστατευμένη πρόσβαση';

  @override
  String get protected_access_tile_subtitle =>
      'Προστάτεψε το Mindful με το κλείδωμα της συσκευής σου.';

  @override
  String get protected_access_no_lock_snack_alert =>
      'Παρακαλώ ρύθμισε πρώτα ένα βιομετρικό κλείδωμα στη συσκευή σου για να ενεργοποιήσεις αυτήν τη λειτουργία.';

  @override
  String get protected_access_removed_lock_snack_alert =>
      'Το κλείδωμα της συσκευής σου έχει αφαιρεθεί. Για να συνεχίσεις, παρακαλώ ρύθμισε ένα νέο κλείδωμα.';

  @override
  String get protected_access_failed_lock_snack_alert =>
      'Η ταυτοποίηση απέτυχε. Πρέπει να επαληθεύσεις το κλείδωμα της συσκευής σου για να συνεχίσεις.';

  @override
  String get tamper_protection_tile_title => 'Προστασία παραβίασης';

  @override
  String get tamper_protection_tile_subtitle =>
      'Αποτροπή απεγκατάστασης και αναγκαστικής διακοπής της εφαρμογής.';

  @override
  String get tamper_protection_confirmation_dialog_info =>
      'Once enabled, you won\'t be able to uninstall, force stop, or clear Mindful\'s data, except during the selected uninstall window. There are no workarounds.\n\nProceed at your own risk.';

  @override
  String get uninstall_window_tile_title => 'Παράθυρο απεγκατάστασης';

  @override
  String get uninstall_window_tile_subtitle =>
      'Η προστασία παραβίασης μπορεί να απενεργοποιηθεί εντός 10 λεπτών από τον επιλεγμένο χρόνο.';

  @override
  String get invincible_window_tile_title => 'Παράθυρο άτρωτης';

  @override
  String get invincible_window_tile_subtitle =>
      'Τα επιλεγμένα όρια μπορούν να τροποποιηθούν μέσα σε 10 λεπτά από τον επιλεγμένο χρόνο.';

  @override
  String get shorts_blocking_tab_title => 'Φραγή shorts';

  @override
  String get shorts_blocking_tab_info =>
      'Έλεγξε πόσο χρόνο ξοδεύεις σε σύντομο περιεχόμενο σε πλατφόρμες όπως το Instagram, το YouTube, το Snapchat, και το Facebook, συμπεριλαμβανομένων των ιστοσελίδων τους.';

  @override
  String get short_content_heading => 'Σύντομο περιεχόμενο';

  @override
  String shorts_time_left_from(String timeShortString) {
    return 'Απομένουν από $timeShortString';
  }

  @override
  String get short_content_timer_picker_dialog_info =>
      'Όρισε ένα ημερήσιο χρονικό όριο για το σύντομο περιεχόμενο. Μόλις συμπληρωθεί το όριό σου, το σύντομο περιεχόμενο θα τεθεί σε παύση μέχρι τα μεσάνυχτα.';

  @override
  String get instagram_features_tile_title => 'Instagram';

  @override
  String get instagram_features_tile_subtitle =>
      'Περιορισμός χαρακτηριστικών στο instagram.';

  @override
  String get instagram_features_block_reels => 'Περιορισμός ενότητας reels.';

  @override
  String get instagram_features_block_explore =>
      'Περιορισμός ενότητας εξερεύνησης.';

  @override
  String get snapchat_features_tile_title => 'Snapchat';

  @override
  String get snapchat_features_tile_subtitle =>
      'Περιορισμός χαρακτηριστικών στο snapchat.';

  @override
  String get snapchat_features_block_spotlight =>
      'Περιορισμός ενότητας spotlight.';

  @override
  String get snapchat_features_block_discover =>
      'Περιορισμός ενότητας ανακάλυψης.';

  @override
  String get youtube_features_tile_title => 'Youtube';

  @override
  String get youtube_features_tile_subtitle =>
      'Περιορισμός των shorts στο youtube.';

  @override
  String get facebook_features_tile_title => 'Facebook';

  @override
  String get facebook_features_tile_subtitle =>
      'Περιορισμός των reels στο facebook.';

  @override
  String get reddit_features_tile_title => 'Reddit';

  @override
  String get reddit_features_tile_subtitle => 'Περιορισμός shorts στο reddit.';

  @override
  String get websites_blocking_tab_title => 'Αποκλεισμός ιστοσελίδων';

  @override
  String get websites_blocking_tab_info =>
      'Αποκλεισμός ιστοτόπων ενηλίκων και τυχόν προσαρμοσμένων ιστοτόπων που επιλέγεις για να δημιουργήσεις μια ασφαλέστερη και πιο εστιασμένη online εμπειρία. Πάρε τον έλεγχο της περιήγησής σου και ξέχνα τους περισπασμούς.';

  @override
  String get adult_content_heading => 'Περιεχόμενο ενηλίκων';

  @override
  String get block_nsfw_title => 'Αποκλεισμός Nsfw';

  @override
  String get block_nsfw_subtitle =>
      'Περιόρισε τους περιηγητές από το άνοιγμα ιστοσελίδων ενηλίκων και πορνό.';

  @override
  String get block_nsfw_dialog_info =>
      'Σίγουρα; Αυτή η ενέργεια είναι μη αναστρέψιμη. Μόλις ο αποκλεισμός ιστότοπων ενηλίκων είναι ενεργοποιημένος, δεν μπορείς να τον απενεργοποιήσεις για όσο διάστημα αυτή η εφαρμογή είναι εγκατεστημένη στη συσκευή σου.';

  @override
  String get block_nsfw_dialog_button_block_anyway =>
      'Αποκλεισμός ούτως ή άλλως';

  @override
  String get blocked_websites_heading => 'Αποκλεισμένες ιστοσελίδες';

  @override
  String get blocked_websites_empty_list_hint =>
      'Κάνε κλικ στο κουμπί «+ Προσθήκη Ιστοτόπου» για να προσθέσεις ενοχλητικές ιστοσελίδες που θες να μπλοκάρεις.';

  @override
  String get add_website_fab_button => 'Προσθήκη Ιστοτόπου';

  @override
  String get add_website_dialog_title => 'Ενοχλητική ιστοσελίδα';

  @override
  String get add_website_dialog_info =>
      'Εισήγαγε το url μιας ιστοσελίδας που θες να αποκλείσεις.';

  @override
  String get add_website_dialog_is_nsfw => 'Είναι nsfw ιστοσελίδα;';

  @override
  String get add_website_dialog_nsfw_warning =>
      'Προειδοποίηση: Οι ιστότοποι Nsfw δεν μπορούν να αφαιρεθούν μόλις προστεθούν.';

  @override
  String get add_website_dialog_button_block => 'Φραγή';

  @override
  String get add_website_already_exist_snack_alert =>
      'Το URL έχει ήδη προστεθεί στη λίστα αποκλεισμένων ιστοσελίδων.';

  @override
  String get add_website_invalid_url_snack_alert =>
      'Μη έγκυρο URL! Αδυναμία ανάλυσης του ονόματος του κεντρικού υπολογιστή.';

  @override
  String get remove_website_dialog_title => 'Αφαίρεση ιστοσελίδας';

  @override
  String remove_website_dialog_info(String websitehost) {
    return 'Σίγουρα; θες να αφαιρέσεις το «$websitehost από τις αποκλεισμένες ιστοσελίδες.';
  }

  @override
  String get focus_tab_title => 'Συγκέντρωση';

  @override
  String get focus_tab_info =>
      'Όταν χρειάζεσαι χρόνο για να εστιάσεις, ξεκίνα μια νέα συνεδρία επιλέγοντας τον τύπο, τις ενοχλητικές εφαρμογές προς παύση και ενεργοποίησε το «Μην ενοχλείτε» για αδιάλειπτη συγκέντρωση.';

  @override
  String get active_session_card_title => 'Ενεργή συνεδρία';

  @override
  String get active_session_card_info =>
      'Εκτελείται μια ενεργή συνεδρία συγκέντρωσης! Κάνε κλικ στην επιλογή «Προβολή» για να ελέγξεις την πρόοδό σου και να δεις πόσος χρόνος έχει παρέλθει.';

  @override
  String get active_session_card_view_button => 'Προβολή';

  @override
  String get focus_distracting_apps_removal_snack_alert =>
      'Η αφαίρεση εφαρμογών από τη λίστα ενοχλητικών εφαρμογών δεν επιτρέπεται όταν μια συνεδρία εστίασης είναι ενεργή. Ωστόσο, μπορείς να προσθέσεις πρόσθετες εφαρμογές στη λίστα κατά τη διάρκεια αυτής της περιόδου.';

  @override
  String get focus_profile_tile_title => 'Focus profile';

  @override
  String get focus_session_duration_tile_title => 'Διάρκεια συνεδρίας';

  @override
  String get focus_session_duration_tile_subtitle =>
      'Άπειρο (εκτός αν σταματήσεις)';

  @override
  String get focus_session_duration_dialog_info =>
      'Παρακαλώ επέλεξε την επιθυμητή διάρκεια για αυτή τη συνεδρία συγκέντρωσης, προσδιορίζοντας το χρονικό διάστημα που επιθυμείς να παραμείνεις σε συγκέντρωση και χωρίς περισπασμούς.';

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
  String get focus_session_start_fab_button => 'Έναρξη Συνεδρίας';

  @override
  String get focus_session_minimum_apps_snack_alert =>
      'Επέλεξε τουλάχιστον μία ενοχλητική εφαρμογή για να ξεκινήσει η συνεδρία εστίασης';

  @override
  String get focus_session_already_active_snack_alert =>
      'Έχεις ήδη μια ενεργή συνεδρία εστίασης. Παρακαλώ ολοκλήρωσε ή σταμάτα την τρέχουσα συνεδρία σου πριν ξεκίνα μια νέα.';

  @override
  String get focus_session_type_study => 'Μελέτη';

  @override
  String get focus_session_type_work => 'Εργασία';

  @override
  String get focus_session_type_exercise => 'Γυμναστική';

  @override
  String get focus_session_type_meditation => 'Διαλογισμός';

  @override
  String get focus_session_type_creativeWriting => 'Δημιουργική Γραφή';

  @override
  String get focus_session_type_reading => 'Ανάγνωση';

  @override
  String get focus_session_type_programming => 'Προγραμματισμός';

  @override
  String get focus_session_type_chores => 'Δουλειές σπιτιού';

  @override
  String get focus_session_type_projectPlanning => 'Σχεδιασμός Έργου';

  @override
  String get focus_session_type_artAndDesign => 'Τέχνη και Σχέδιο';

  @override
  String get focus_session_type_languageLearning => 'Εκμάθηση Γλώσσας';

  @override
  String get focus_session_type_musicPractice => 'Μουσική Εξάσκηση';

  @override
  String get focus_session_type_selfCare => 'Αυτοφροντίδα';

  @override
  String get focus_session_type_brainstorming => 'Γέννηση ιδεών';

  @override
  String get focus_session_type_skillDevelopment => 'Ανάπτυξη Δεξιότητας';

  @override
  String get focus_session_type_research => 'Έρευνα';

  @override
  String get focus_session_type_networking => 'Δικτύωση';

  @override
  String get focus_session_type_cooking => 'Μαγειρική';

  @override
  String get focus_session_type_sportsTraining => 'Αθλητική Εκπαίδευση';

  @override
  String get focus_session_type_restAndRelaxation => 'Ξεκούραση και χαλάρωση';

  @override
  String get focus_session_type_other => 'Άλλο';

  @override
  String get timeline_tab_title => 'Χρονολόγιο';

  @override
  String get focus_timeline_tab_info =>
      'Explore your focus journey by selecting a date from the calendar. Track your progress, revisit your successes, and learn from the challenges.';

  @override
  String selected_month_productive_time_snack_alert(String timeString) {
    return 'Ο συνολικός παραγωγικός χρόνος σου για τον επιλεγμένο μήνα είναι $timeString.';
  }

  @override
  String get selected_month_productive_days_label => 'Παραγωγικές ημέρες';

  @override
  String selected_month_productive_days_snack_alert(num daysCount) {
    return 'Συνολικά έχεις $daysCount παραγωγικές μέρες τον επιλεγμένο μήνα.';
  }

  @override
  String get selected_day_focused_time_label => 'Χρόνος εστίασης';

  @override
  String selected_day_focused_time_snack_alert(String timeString) {
    return 'Ο συνολικός εστιασμένος χρόνος σου για την επιλεγμένη ημέρα είναι $timeString.';
  }

  @override
  String get calender_heading => 'Ημερολόγιο';

  @override
  String get your_sessions_heading => 'Οι συνεδρίες σου';

  @override
  String get your_sessions_empty_list_hint =>
      'Δεν καταγράφηκαν συνεδρίες εστίασης για την επιλεγμένη ημέρα.';

  @override
  String get focus_session_tile_timestamp_label => 'Timestamp';

  @override
  String get focus_session_tile_duration_label => 'Διάρκεια';

  @override
  String get focus_session_tile_reflection_label => 'Reflection';

  @override
  String get focus_session_state_active => 'Ενεργή';

  @override
  String get focus_session_state_successful => 'Επιτυχής';

  @override
  String get focus_session_state_failed => 'Απέτυχε';

  @override
  String get active_session_tab_title => 'Συνεδρία';

  @override
  String get active_session_none_warning =>
      'Δεν βρέθηκε καμία ενεργή συνεδρία. Επιστροφή στην αρχική οθόνη.';

  @override
  String get active_session_dialog_button_keep_pushing =>
      'Συνέχισε να προσπαθείς';

  @override
  String get active_session_finish_dialog_title => 'Τέλος';

  @override
  String get active_session_finish_dialog_info =>
      'Κράτα γερά! Χτίζεις πολύτιμη συγκέντρωση. Σίγουρα θες να τερματίσεις αυτή τη συνεδρία εστίασης; Κάθε επιπλέον στιγμή μετράει προς τους στόχους σου.';

  @override
  String get active_session_giveup_dialog_title => 'Τα παρατάω';

  @override
  String get active_session_giveup_dialog_info =>
      'Κρατήσου! Σχεδόν τα κατάφερες, μη τα παρατάς τώρα! Σίγουρα θες να τερματίσεις αυτήν την συνεδρία εστίασης νωρίτερα; Η πρόοδος θα χαθεί.';

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
      'Τα παράτησες! Μην ανησυχείς, μπορείς να τα πας καλύτερα την επόμενη φορά. Κάθε προσπάθεια μετράει - απλά συνέχισε';

  @override
  String get active_session_quote_one =>
      'Κάθε βήμα μετράει, κράτα γερά και συνέχισε';

  @override
  String get active_session_quote_two =>
      'Μείνε σε συγκέντρωση! Κάνεις εκπληκτική πρόοδο';

  @override
  String get active_session_quote_three => 'Τα σπας! Κράτα την ορμή ζωντανή';

  @override
  String get active_session_quote_four =>
      'Λίγο ακόμα για να τα καταφέρεις, τα πας φανταστικά';

  @override
  String active_session_quote_five(String durationString) {
    return 'Συγχαρητήρια 🎉 \n Ολοκλήρωσες την συνεδρία εστίασης του $durationString.\n\nΕξαιρετικά, συνέχισε την καταπληκτική δουλειά';
  }

  @override
  String get restriction_groups_tab_title => 'Ομάδες περιορισμών';

  @override
  String get restriction_groups_tab_info =>
      'Όρισε ένα συνδυασμένο χρονικό όριο οθόνης για μια ομάδα εφαρμογών. Μόλις η συνολική χρήση φτάσει το όριό σου, όλες οι εφαρμογές της ομάδας θα διακοπούν για να διατηρήσουν την συγκέντρωση και την ισορροπία.';

  @override
  String get restriction_group_time_spent_label => 'Χρόνος που πέρασε σήμερα';

  @override
  String get restriction_group_time_left_label => 'Χρόνος που έμεινε σήμερα';

  @override
  String get restriction_group_name_tile_title => 'Όνομα ομάδας';

  @override
  String get restriction_group_name_picker_dialog_info =>
      'Εισήγαγε ένα όνομα για την ομάδα περιορισμών για να βοηθήσεις στον εντοπισμό και τη διαχείρισή του εύκολα.';

  @override
  String get restriction_group_timer_tile_title => 'Χρονόμετρο ομάδας';

  @override
  String get restriction_group_timer_picker_dialog_info =>
      'Όρισε ένα ημερήσιο χρονικό όριο για αυτήν την ομάδα. Μόλις συμπληρωθεί το όριό σου, όλες οι εφαρμογές αυτής της ομάδας θα διακοπούν μέχρι τα μεσάνυχτα.';

  @override
  String get restriction_group_active_period_tile_title =>
      'Ενεργή περίοδος ομάδας';

  @override
  String get remove_restriction_group_dialog_title => 'Αφαίρεση ομάδας';

  @override
  String remove_restriction_group_dialog_info(String groupName) {
    return 'Σίγουρα; θες να αφαιρέσεις το «$groupName» από τις ομάδες περιορισμού.';
  }

  @override
  String get restriction_group_invalid_limits_snack_alert =>
      'Όρισε είτε ένα χρονόμετρο είτε ένα όριο ενεργής περιόδου.';

  @override
  String get notifications_empty_list_hint =>
      'No notifications have been batched for the day.';

  @override
  String get conversations_label => 'Conversations';

  @override
  String get last_24_hours_heading => 'Τελευταίες 24 ώρες';

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
      'Δεν ήταν δυνατή η εύρεση της εφαρμογής για το συγκεκριμένο πακέτο. Επιστροφή στην αρχική οθόνη.';

  @override
  String get emergency_fab_button => 'Επείγον';

  @override
  String emergency_dialog_info(num leftPassesCount) {
    return 'Αυτή η ενέργεια θα διακόψει τον αποκλεισμό εφαρμογών για τα επόμενα 5 λεπτά. Έχεις ακόμη $leftPassesCount ευκαιρίες. Αφού τις χρησιμοποιήσεις όλες, η εφαρμογή θα παραμείνει αποκλεισμένη μέχρι τα μεσάνυχτα ή η ενεργή συνεδρία εστίασης θα τελειώσει.\n\nΘες ακόμα να συνεχίσεις;';
  }

  @override
  String get emergency_dialog_button_use_anyway => 'Χρήση ούτως ή άλλως';

  @override
  String get emergency_started_snack_alert =>
      'Ο αποκλεισμός εφαρμογών είναι σε παύση και θα συνεχίσει τον αποκλεισμό σε 5 λεπτά.';

  @override
  String get emergency_already_active_snack_alert =>
      'Ο αποκλεισμός εφαρμογών είναι προς το παρόν είτε σε παύση είτε ανενεργός. Αν οι ειδοποιήσεις είναι ενεργοποιημένες, θα λαμβάνεις ενημερώσεις σχετικά με το χρόνο που απομένει.';

  @override
  String get emergency_no_pass_left_snack_alert =>
      'Έχεις χρησιμοποιήσει όλες τις επείγουσες ευκαιρίες. Οι αποκλεισμένες εφαρμογές θα παραμείνουν αποκλεισμένες μέχρι τα μεσάνυχτα ή η ενεργή συνεδρία εστίασης θα τελειώσει.';

  @override
  String get app_limit_status_not_set => 'Δεν ορίστηκε';

  @override
  String get app_timer_tile_title => 'Χρονόμετρο εφαρμογής';

  @override
  String get app_timer_picker_dialog_info =>
      'Όρισε ένα ημερήσιο χρονικό όριο για αυτήν την εφαρμογή. Μόλις συμπληρωθεί το όριό σου, η εφαρμογή θα τεθεί σε παύση μέχρι τα μεσάνυχτα.';

  @override
  String get usage_reminders_tile_title => 'Usage reminders';

  @override
  String get usage_reminders_tile_subtitle =>
      'Gentle nudges when using timed apps.';

  @override
  String get app_launch_limit_tile_title => 'Όριο εκκίνησης';

  @override
  String app_launch_limit_tile_subtitle(num count) {
    return 'Άνοιξε $count φορές σήμερα.';
  }

  @override
  String get app_launch_limit_picker_dialog_info =>
      'Όρισε πόσες φορές μπορείς να ανοίξεις αυτήν την εφαρμογή κάθε μέρα. Μόλις συμπληρωθεί το όριο, θα τεθεί σε παύση μέχρι τα μεσάνυχτα.';

  @override
  String get app_active_period_tile_title => 'Ενεργός περίοδος';

  @override
  String app_active_period_tile_subtitle(String startTime, String endTime) {
    return 'Από $startTime έως $endTime';
  }

  @override
  String get internet_access_tile_title => 'Πρόσβαση στο διαδίκτυο';

  @override
  String get internet_access_tile_subtitle =>
      'Απενεργοποίησέ το για να αποκλείσεις το διαδίκτυο για την εφαρμογή.';

  @override
  String internet_access_blocked_snack_alert(String appName) {
    return 'Το διαδίκτυο για $appName είναι αποκλεισμένο.';
  }

  @override
  String internet_access_unblocked_snack_alert(String appName) {
    return 'Το διαδίκτυο για $appName δεν είναι αποκλεισμένο.';
  }

  @override
  String get launch_app_tile_title => 'Εκκίνηση εφαρμογής';

  @override
  String launch_app_tile_subtitle(String appName) {
    return 'Άνοιγμα $appName.';
  }

  @override
  String get go_to_app_settings_tile_title =>
      'Μετάβαση στις ρυθμίσεις εφαρμογής';

  @override
  String get go_to_app_settings_tile_subtitle =>
      'Διαχειρίσου τις ρυθμίσεις της εφαρμογής όπως ειδοποιήσεις, δικαιώματα, αποθήκευση και άλλα.';

  @override
  String get include_in_stats_tile_title => 'Συμπερίληψη στη χρήση οθόνης';

  @override
  String get include_in_stats_tile_subtitle =>
      'Απενεργοποίησέ το για να εξαιρέσεις αυτή την εφαρμογή από τη συνολική χρήση της οθόνης.';

  @override
  String app_excluded_from_stats_snack_alert(String appName) {
    return 'Η εφαρμογή $appName εξαιρείται από τη συνολική χρήση οθόνης.';
  }

  @override
  String app_include_to_stats_snack_alert(String appName) {
    return 'Η εφαρμογή $appName περιλαμβάνεται στη συνολική χρήση οθόνης.';
  }

  @override
  String get general_tab_title => 'Γενικά';

  @override
  String get appearance_heading => 'Εμφάνιση';

  @override
  String get theme_mode_tile_title => 'Θέμα';

  @override
  String get theme_mode_system_label => 'Σύστημα';

  @override
  String get theme_mode_light_label => 'Ανοιχτό';

  @override
  String get theme_mode_dark_label => 'Σκούρο';

  @override
  String get material_color_tile_title => 'Material χρώμα';

  @override
  String get amoled_dark_tile_title => 'AMOLED σκούρο';

  @override
  String get amoled_dark_tile_subtitle =>
      'Χρήση καθαρού μαύρου χρώματος για το σκούρο θέμα.';

  @override
  String get dynamic_colors_tile_title => 'Δυναμικά χρώματα';

  @override
  String get dynamic_colors_tile_subtitle =>
      'Χρήση χρωμάτων συσκευής εάν υποστηρίζεται.';

  @override
  String get defaults_heading => 'Προεπιλογές';

  @override
  String get app_language_tile_title => 'Γλώσσα εφαρμογής';

  @override
  String get default_home_tab_tile_title => 'Αρχική καρτέλα';

  @override
  String get usage_history_tile_title => 'Ιστορικό χρήσης';

  @override
  String get usage_history_15_days => '15 ημέρες';

  @override
  String get usage_history_1_month => '1 μήνας';

  @override
  String get usage_history_3_month => '3 μήνες';

  @override
  String get usage_history_6_month => '6 μήνες';

  @override
  String get usage_history_1_year => '1 έτος';

  @override
  String get service_heading => 'Υπηρεσία';

  @override
  String get service_stopping_warning =>
      'Αν το Mindful σταματήσει να λειτουργεί απροσδόκητα, παρακαλώ παραχώρησε την άδεια «Αγνόηση βελτιστοποίησης μπαταρίας» για να το διατηρήσεις σε λειτουργία στο παρασκήνιο. Εάν το θέμα συνεχιστεί, δοκίμασε να βάλεις το Mindful σε λίστα εξαιρέσεων για αδιάλειπτη απόδοση.';

  @override
  String get whitelist_app_tile_title => 'Προσθήκη Mindful σε λίστα εξαιρέσεων';

  @override
  String get whitelist_app_tile_subtitle =>
      'Επέτρεψε στο Mindful να ξεκινάει αυτόματα.';

  @override
  String get whitelist_app_unsupported_snack_alert =>
      'Αυτή η συσκευή δεν υποστηρίζει την αυτόματη διαχείριση εκκίνησης.';

  @override
  String get database_tab_title => 'Βάση δεδομένων';

  @override
  String get import_db_tile_title => 'Εισαγωγή βάσης δεδομένων';

  @override
  String get import_db_tile_subtitle =>
      'Εισαγωγή βάσης δεδομένων από ένα αρχείο.';

  @override
  String get export_db_tile_title => 'Εξαγωγή βάσης δεδομένων';

  @override
  String get export_db_tile_subtitle =>
      'Εξαγωγή βάσης δεδομένων σε ένα αρχείο.';

  @override
  String get crash_logs_heading => 'Καταγραφές σφαλμάτων';

  @override
  String get crash_logs_info =>
      'Αν αντιμετωπίσεις οποιοδήποτε πρόβλημα, μπορείς να το αναφέρεις στο GitHub μαζί με το αρχείο καταγραφής. Το αρχείο θα περιλαμβάνει λεπτομέρειες όπως τον κατασκευαστή της συσκευής σου, το μοντέλο, την έκδοση Android, την έκδοση SDK και τα αρχεία καταγραφής σφαλμάτων. Αυτές οι πληροφορίες θα μας βοηθήσουν να εντοπίσουμε και να επιλύσουμε το πρόβλημα πιο αποτελεσματικά.';

  @override
  String get crash_logs_export_tile_title => 'Εξαγωγή καταγραφών σφαλμάτων';

  @override
  String get crash_logs_export_tile_subtitle =>
      'Εξαγωγή αρχείων καταγραφής σφαλμάτων σε αρχείο json.';

  @override
  String get crash_logs_view_tile_title => 'Προβολή καταγραφών';

  @override
  String get crash_logs_view_tile_subtitle =>
      'Εξερεύνηση αποθηκευμένων καταγραφών σφαλμάτων.';

  @override
  String get crash_logs_empty_list_hint =>
      'Καμία κατάρρευση δεν καταγράφηκε μέχρι τώρα.';

  @override
  String get crash_logs_clear_tile_title => 'Εκκαθάριση καταγραφών';

  @override
  String get crash_logs_clear_tile_subtitle =>
      'Διαγραφή όλων των αρχείων καταγραφής κατάρρευσης από τη βάση δεδομένων.';

  @override
  String get crash_logs_clear_dialog_info =>
      'Σίγουρα θες να καθαρίσεις όλα τα αρχεία καταγραφής κατάρρευσης από τη βάση δεδομένων;';

  @override
  String get crash_logs_clear_dialog_button_clear_anyway =>
      'Εκκαθάριση ούτως ή άλλως';

  @override
  String get about_tab_title => 'Σχετικά';

  @override
  String get changelog_tile_title => 'Αρχείο αλλαγών';

  @override
  String get changelog_tile_subtitle => 'Δες τι άλλαξε.';

  @override
  String get full_changelog_tile_title => 'Πλήρες αρχείο αλλαγών';

  @override
  String get redirected_to_github_subtitle => 'Θα μεταφερθείς στο GitHub.';

  @override
  String get contribute_heading => 'Συνεισφορά';

  @override
  String get github_tile_title => 'GitHub';

  @override
  String get github_tile_subtitle => 'Δες τον πηγαίο κώδικα.';

  @override
  String get report_issue_tile_title => 'Αναφορά ζητήματος';

  @override
  String get suggest_idea_tile_title => 'Πρότεινε μια ιδέα';

  @override
  String get write_email_tile_title => 'Γράψε μας μέσω email';

  @override
  String get write_email_tile_subtitle => 'Θα μεταφερθείς στην εφαρμογή email.';

  @override
  String get privacy_policy_heading => 'Πολιτική απορρήτου';

  @override
  String get privacy_policy_info =>
      'Το Mindful έχει δεσμευτεί για την προστασία του απορρήτου σου. Δεν συλλέγουμε, αποθηκεύουμε ή μεταβιβάζουμε οποιοδήποτε είδος δεδομένων χρήστη. Η εφαρμογή λειτουργεί εξ\' ολοκλήρου εκτός σύνδεσης και δεν απαιτεί σύνδεση στο διαδίκτυο, εξασφαλίζοντας ότι τα προσωπικά σου στοιχεία παραμένουν ιδιωτικά και ασφαλή στη συσκευή σου. Ως εφαρμογή Ελεύθερου και Ανοιχτού Κώδικα (FOSS) το Mindful εγγυάται πλήρη διαφάνεια και έλεγχο των δεδομένων των χρηστών.';

  @override
  String get more_details_button => 'Περισσότερες λεπτομέρειες';
}
