import 'package:tennis_court/core/shared/enums/court_type.dart';

class CourtModel {
  String id;
  String name;
  List<String> pictures;
  CourtType courtType;
  String address;
  int lendPrice;

  CourtModel({
    required this.id,
    required this.name,
    required this.pictures,
    required this.courtType,
    required this.address,
    required this.lendPrice,
  });
}
