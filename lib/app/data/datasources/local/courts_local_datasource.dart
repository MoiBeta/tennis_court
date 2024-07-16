import 'package:hive/hive.dart';
import 'package:tennis_court/app/data/models/court_model.dart';

class CourtsLocalDatasource {
  final Box<CourtModel> courtsBox;

  CourtsLocalDatasource(this.courtsBox);

 List<CourtModel> getAllCourts() {
    return courtsBox.values.toList();
  }

}
