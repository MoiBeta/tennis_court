import 'package:tennis_court/app/data/datasources/local/reservations_local_datasource.dart';
import 'package:tennis_court/app/data/models/court_reservation_model.dart';

class ReservationsRepository {
  ReservationsLocalDataSource localDataSource;

  ReservationsRepository(this.localDataSource);

  Future<List<CourtReservationModel>?> getAllReservations() async {
    return localDataSource.getAllReservations();
  }

  Future<CourtReservationModel?> setReservation({
    required String id,
    required DateTime startingDateTime,
    required DateTime endingDateTime,
    required String courtId,
    required String usedId,
    required String comment,
    required int price,
}) async {
    try {
      CourtReservationModel courtReservation = CourtReservationModel(
        id: id,
        startingDateTime: startingDateTime,
        endingDateTime: endingDateTime,
        courtId: courtId,
        usedId: usedId,
        comment: comment,
        price: price,
      );
      localDataSource.saveReservation(courtReservation);
      return courtReservation;
    } catch(_){
      return null;
    }
  }
}
