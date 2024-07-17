import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/states/providers/courts_providers.dart';
import 'package:tennis_court/app/data/states/providers/loading_provider.dart';
import 'package:tennis_court/app/data/states/providers/reservation_providers.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/court_info_container.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/position_app_bar.dart';
import 'package:tennis_court/core/utils/utils.dart';
import 'package:tennis_court/routes/app_routes.dart';

class CourtReservationSummary extends ConsumerWidget {
  CourtReservationSummary({super.key});

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    CourtModel selectedCourtModel = ref.watch(selectedCourtProvider)!;
    String? selectedInstructor = ref.watch(selectedInstructorProvider)!;
    DateTime? selectedDate = ref.watch(selectedDateProvider)!;
    int? startHour = ref.watch(selectedStartHourProvider);
    int? endHour = ref.watch(selectedEndHourProvider);
    bool isLoading = ref.watch(loadingProvider);
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              FutureBuilder(
                future: getFileFromUint8List(selectedCourtModel.picture),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.file(
                        snapshot.data!,
                        fit: BoxFit.fill,
                      ),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              const CourtInfoContainer(),
              Container(
                width: double.infinity,
                color: const Color(0xFFF4F7FC),
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resumen',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/svg/tennis.svg'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  'Cancha tipo ${selectedCourtModel.type.name.toUpperCase()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/svg/person.svg'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  'Instructor: $selectedInstructor',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/svg/calendar.svg'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  DateFormat('d \'de\' MMMM yyyy', 'es_ES')
                                      .format(selectedDate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/svg/clock.svg'),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  '${(endHour ?? 0) - (startHour ?? 0)} horas',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total a pagar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${(((endHour ?? 0) - (startHour ?? 0)) * selectedCourtModel.lendPrice)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF346BC3),
                              ),
                            ),
                            Text(
                                'Por ${(endHour ?? 0) - (startHour ?? 0)} horas')
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF346BC3),
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/calendar.svg',
                              width: 18,
                              height: 18,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFF346BC3),
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Reprogramar reserva',
                              style: TextStyle(
                                color: Color(0xFF346BC3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: FilledButton(
                        style:
                            Theme.of(context).filledButtonTheme.style?.copyWith(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                    vertical: 15,
                                  )),
                                ),
                        onPressed: () async {
                          await ref
                              .read(reservationsNotifierProvider.notifier)
                              .setReservation(
                                price: (((endHour ?? 0) - (startHour ?? 0)) *
                                    selectedCourtModel.lendPrice),
                              );
                          if (context.mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.home,
                              ModalRoute.withName(AppRoutes.home),
                            );
                          }
                        },
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                'Pagar',
                              ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextButton(
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                    vertical: 15,
                                  )),
                                ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.home,
                            ModalRoute.withName(AppRoutes.home),
                          );
                        },
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
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
