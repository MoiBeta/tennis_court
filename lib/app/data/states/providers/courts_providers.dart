import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tennis_court/app/data/datasources/local/courts_local_datasource.dart';
import 'package:tennis_court/app/data/repositories/courts_repository.dart';
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/states/providers/loading_provider.dart';

final courtsBoxProvider = Provider<Box<CourtModel>>((ref) {
  return Hive.box<CourtModel>('courtBox');
});

final courtsLocalDataSourceProvider = Provider<CourtsLocalDatasource>((ref) {
  return CourtsLocalDatasource(ref.watch(courtsBoxProvider));
});

final courtsRepositoryProvider = Provider<CourtsRepository>((ref) {
  return CourtsRepository(ref.watch(courtsLocalDataSourceProvider));
});

final courtsNotifierProvider =
StateNotifierProvider<CourtsNotifier, List<CourtModel>>(
        (StateNotifierProviderRef<CourtsNotifier, List<CourtModel>> ref) {
  return CourtsNotifier(ref);
});

class CourtsNotifier extends StateNotifier<List<CourtModel>> {
  CourtsNotifier(this.ref): super(<CourtModel>[]);

  StateNotifierProviderRef<CourtsNotifier, List<CourtModel>> ref;

  Future<List<CourtModel>> getCourts() async {
    state = await ref.read(courtsRepositoryProvider).getAllCourts() ?? <CourtModel>[];
    return state;
  }

}

FutureProvider<List<CourtModel>> futureCourtListProvider = FutureProvider(
        (ref)=> ref.read(courtsNotifierProvider.notifier).getCourts());

StateProvider<CourtModel?> selectedCourtProvider = StateProvider<CourtModel?>(
    (ref) => null);