import 'package:hive_flutter/hive_flutter.dart';

part 'court_type.g.dart';

@HiveType(typeId: 4)
enum CourtType {
  @HiveField(0)
  a,
  @HiveField(1)
  b,
  @HiveField(2)
  c,
}