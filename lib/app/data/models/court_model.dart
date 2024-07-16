import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court/core/enums/court_type.dart';

part 'court_model.g.dart';

@HiveType(typeId: 2)
class CourtModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  Uint8List picture;
  @HiveField(3)
  String address;
  @HiveField(4)
  int lendPrice;
  @HiveField(5)
  CourtType type;

  CourtModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.address,
    required this.lendPrice,
    required this.type,
  });
}
