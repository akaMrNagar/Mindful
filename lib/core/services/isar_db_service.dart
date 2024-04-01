import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDbService {
  static final IsarDbService instance = IsarDbService._();
  IsarDbService._();

  /// Prefs instance
  late Isar isar;

  /// Method to initialize shared prefrences service.
  /// It should be called in main method
  Future<void> init() async {
    /// Get app's directory
    final appDirectory = await getApplicationDocumentsDirectory();

    /// initialize isar instance
    isar = await Isar.open(
      [],
      directory: appDirectory.path,
    );
  }
}
