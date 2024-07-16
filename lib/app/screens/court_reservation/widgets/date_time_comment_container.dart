import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court/app/data/states/providers/reservation_providers.dart';
import 'package:tennis_court/app/screens/court_reservation/widgets/hour_picker.dart';

class DateTimeCommentContainer extends ConsumerWidget {
  DateTimeCommentContainer({super.key});

  final ExpansionTileController calendarTileController =
      ExpansionTileController();

  final ExpansionTileController startTimeTileController =
      ExpansionTileController();

  final ExpansionTileController endTimeTileController =
      ExpansionTileController();


  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    DateTime? selectedDate = ref.watch(selectedDateProvider);
    int? selectedStartHour = ref.watch(selectedStartHourProvider);
    int? selectedEndHour = ref.watch(selectedEndHourProvider);
    return Container(
      width: double.infinity,
      color: const Color(0xFFF4F7FC),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Establecer fecha y hora',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: ExpansionTile(
              controller: calendarTileController,
              collapsedBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: const Text('Fecha'),
              subtitle: selectedDate == null
                  ? const Text('Seleccionar una fecha')
                  : Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
              children: [
                SizedBox(
                  width: 300,
                  height: 400,
                  child: DatePicker(
                    minDate: DateTime.now(),
                    maxDate: DateTime.now().add(const Duration(days:  5)),
                    onDateSelected: (value) async {
                      ref.read(selectedDateProvider.notifier).state = value;
                      await Future.delayed(const Duration(milliseconds: 500));
                      calendarTileController.collapse();
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: ExpansionTile(
                    collapsedBackgroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    controller: startTimeTileController,
                    title: const Text(
                      'Hora de inicio',
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: selectedStartHour == null
                        ? const Text('00:00')
                        : Text('$selectedStartHour:00'),
                    children: [
                      HourPicker(
                        onTap: (int pickedHour) {
                          ref.read(selectedStartHourProvider.notifier).state = pickedHour;
                          startTimeTileController.collapse();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  child: ExpansionTile(
                    collapsedBackgroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    controller: endTimeTileController,
                    title: const Text(
                      'Hora de fin',
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: selectedEndHour == null
                        ? const Text('00:00')
                        : Text('$selectedEndHour:00'),

                    children: [
                      HourPicker(
                        onTap: (int pickedHour) {
                          ref.read(selectedEndHourProvider.notifier).state = pickedHour;
                          endTimeTileController.collapse();
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Text(
              'Agregar un comentario',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Agregar un comentario...',
                border: InputBorder.none,
              ),
              onChanged: (String value){
                ref.read(reservationCommentProvider.notifier).state = value;
              },
            ),
          )
        ],
      ),
    );
  }
}
