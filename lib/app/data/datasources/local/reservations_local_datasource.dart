import 'package:hive/hive.dart';
import 'package:tennis_court/app/data/models/court_reservation_model.dart';

class ReservationsLocalDataSource {
  final Box<CourtReservationModel> reservationBox;

  ReservationsLocalDataSource(this.reservationBox);

  List<CourtReservationModel> getAllReservations() {
    return reservationBox.values.toList();
  }

  Future<void> saveReservation(CourtReservationModel reservation) async {
    await reservationBox.put(reservation.id, reservation);
  }
}
