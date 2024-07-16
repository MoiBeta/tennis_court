import 'package:hive_flutter/hive_flutter.dart';

part 'court_reservation_model.g.dart';

@HiveType(typeId: 3)
class CourtReservationModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime startingDateTime;
  @HiveField(2)
  DateTime endingDateTime;
  @HiveField(3)
  String courtId;
  @HiveField(4)
  String usedId;
  @HiveField(5)
  String comment;
  @HiveField(6)
  int price;

  CourtReservationModel({
    required this.id,
    required this.startingDateTime,
    required this.endingDateTime,
    required this.courtId,
    required this.usedId,
    required this.comment,
    required this.price,
});

}