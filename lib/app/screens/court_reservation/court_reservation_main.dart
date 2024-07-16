import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/states/providers/courts_providers.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/court_info_container.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/court_slider.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/date_time_comment_container.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/instructor_selector.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/position_app_bar.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/selected_points_row.dart';
import 'package:tennis_court/routes/app_routes.dart';

class CourtReservationMain extends ConsumerStatefulWidget {
  const CourtReservationMain({super.key});

  @override
  ConsumerState<CourtReservationMain> createState() =>
      _CourtReservationMainState();
}

class _CourtReservationMainState extends ConsumerState<CourtReservationMain> {
  List<CourtModel> courtList = [];

  @override
  void initState() {
    CourtModel initialSelectedCourtModel = ref.read(selectedCourtProvider)!;
    List<CourtModel> otherCourts = ref
        .read(courtsNotifierProvider)
        .where((court) => court.id != ref.read(selectedCourtProvider)!.id)
        .toList();
    courtList = [
      initialSelectedCourtModel,
      ...otherCourts,
    ];
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  CourtSlider(
                    courtList: courtList,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      child: SelectedPointsRow(
                        courtList: courtList,
                      ),
                    ),
                  ),
                ],
              ),
              const CourtInfoContainer(),
              const InstructorSelector(),
              DateTimeCommentContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25,
                ),
                child: FilledButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(AppRoutes.courtReservationSummary);
                    },
                    child: const Text('Reservar'),
                ),
              ),
            ],
          ),
          const PositionAppBar(),
        ],
      ),
    );
  }
}
