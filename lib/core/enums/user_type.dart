import 'package:hive_flutter/hive_flutter.dart';

part 'user_type.g.dart';

@HiveType(typeId: 1)
enum UserType{
  @HiveField(0)
  customer,
  @HiveField(1)
  instructor,
}