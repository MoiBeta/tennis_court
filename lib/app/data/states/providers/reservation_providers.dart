import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court/app/data/datasources/local/reservations_local_datasource.dart';
import 'package:tennis_court/app/data/models/court_reservation_model.dart';
import 'package:tennis_court/app/data/repositories/reservations_repository.dart';
import 'package:tennis_court/app/data/states/providers/auth_providers.dart';
import 'package:tennis_court/app/data/states/providers/courts_providers.dart';
import 'package:tennis_court/app/data/states/providers/loading_provider.dart';
import 'package:uuid/v1.dart';

final reservationsBoxProvider = Provider<Box<CourtReservationModel>>((ref) {
  return Hive.box<CourtReservationModel>('reservationsBox');
});

final reservationsLocalDataSourceProvider = Provider<ReservationsLocalDataSource>((ref) {
  return ReservationsLocalDataSource(ref.watch(reservationsBoxProvider));
});

final reservationsRepositoryProvider = Provider<ReservationsRepository>((ref) {
  return ReservationsRepository(ref.watch(reservationsLocalDataSourceProvider));
});


final reservationsNotifierProvider =
StateNotifierProvider<ReservationNotifier, List<CourtReservationModel>>(
        (StateNotifierProviderRef<ReservationNotifier, List<CourtReservationModel>> ref) {
      return ReservationNotifier(ref);
    });

class ReservationNotifier extends StateNotifier<List<CourtReservationModel>> {
  ReservationNotifier(this.ref): super(<CourtReservationModel>[]);

  StateNotifierProviderRef<ReservationNotifier, List<CourtReservationModel>> ref;

  Future<List<CourtReservationModel>> getReservations() async {
    state = await ref.read(reservationsRepositoryProvider).getAllReservations()
        ?? <CourtReservationModel>[];
    return state;
  }

  Future<void> setReservation({
    required int price,
    String? comment,
}) async {
    ref.read(loadingProvider.notifier).state = true;
    CourtReservationModel? newReservation = await ref.read(reservationsRepositoryProvider).setReservation(
        id: const UuidV1().generate(),
        startingDateTime: DateTime(
            ref.read(selectedDateProvider)!.year,
            ref.read(selectedDateProvider)!.month,
            ref.read(selectedDateProvider)!.day,
          ref.read(selectedStartHourProvider)!
        ),
        endingDateTime: DateTime(
          ref.read(selectedDateProvider)!.year,
          ref.read(selectedDateProvider)!.month,
          ref.read(selectedDateProvider)!.day,
            ref.read(selectedEndHourProvider)!
        ),
        courtId: ref.read(selectedCourtProvider)!.id,
        usedId: ref.read(authNotifierProvider)!.id,
        comment: ref.read(reservationCommentProvider),
        price: price,
    );
    if(newReservation != null){
      state.add(newReservation);
    }
    ref.read(loadingProvider.notifier).state = false;
  }

}

FutureProvider<List<CourtReservationModel>> futureCourtReservationsListProvider = FutureProvider(
        (ref)=> ref.read(reservationsNotifierProvider.notifier).getReservations());

StateProvider<String?> selectedInstructorProvider = StateProvider<String?>((ref)=> null);

StateProvider<DateTime?> selectedDateProvider = StateProvider<DateTime?>((ref)=> null);
StateProvider<int?> selectedStartHourProvider = StateProvider<int?>((ref)=> null);
StateProvider<int?> selectedEndHourProvider = StateProvider<int?>((ref)=> null);
StateProvider<String> reservationCommentProvider = StateProvider<String>((ref)=> '');

