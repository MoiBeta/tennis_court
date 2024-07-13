import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:tennis_court/core/shared/enums/user_type.dart';
import 'package:tennis_court/core/shared/models/user_model.dart';

class HiveDatabase {
  static Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserTypeAdapter());
    await Hive.openBox<UserModel>('userBox');
  }
}
