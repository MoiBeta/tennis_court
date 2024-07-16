import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/models/court_reservation_model.dart';
import 'package:tennis_court/app/data/models/user_model.dart';
import 'package:tennis_court/core/enums/court_type.dart';
import 'package:tennis_court/core/enums/user_type.dart';
import 'package:tennis_court/core/utils/utils.dart';
import 'package:uuid/v1.dart';

class HiveDatabase {
  static Future<void> init() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserTypeAdapter());
    Hive.registerAdapter(CourtModelAdapter());
    Hive.registerAdapter(CourtReservationModelAdapter());
    Hive.registerAdapter(CourtTypeAdapter());
    await Hive.openBox<UserModel>('userBox');
    Box<CourtModel> courtBox = await Hive.openBox<CourtModel>('courtBox');
    await Hive.openBox<CourtReservationModel>('reservationsBox');

    if (courtBox.values.isEmpty) {
      String courtAId = const UuidV1().generate();
      Uint8List courtABytes = await loadAssetImage('assets/images/court_a.png');
      await courtBox.put(
        courtAId,
        CourtModel(
          id: courtAId,
          name: 'Epic Box',
          picture: courtABytes,
          address: 'Vía Av. Caracas y Av. P.º Caroni',
          lendPrice: 25,
          type: CourtType.a,
        ),
      );
      String courtBId = const UuidV1().generate();
      Uint8List courtBBytes = await loadAssetImage('assets/images/court_b.png');
      await courtBox.put(
        courtBId,
        CourtModel(
          id: courtBId,
          name: 'Sport Box',
          picture: courtBBytes,
          address: 'Vía Av. Caracas y Av. P.º Caroni',
          lendPrice: 20,
          type: CourtType.b,
        ),
      );
      String courtCId = const UuidV1().generate();
      Uint8List courtCBytes = await loadAssetImage('assets/images/court_c.jpg');
      await courtBox.put(
        courtCId,
        CourtModel(
          id: courtCId,
          name: 'Cancha múltiple',
          picture: courtCBytes,
          address: 'Vía Av. Caracas y Av. P.º Caroni',
          lendPrice: 30,
          type: CourtType.c,
        ),
      );
    }
  }
}
