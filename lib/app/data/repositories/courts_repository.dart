import 'package:tennis_court/app/data/datasources/local/courts_local_datasource.dart';
import 'package:tennis_court/app/data/models/court_model.dart';

class CourtsRepository {
  final CourtsLocalDatasource localDataSource;

  CourtsRepository(this.localDataSource);

  Future<List<CourtModel>?> getAllCourts() async {
    return localDataSource.getAllCourts();
  }
}
