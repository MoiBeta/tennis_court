import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/app/data/states/providers/reservation_providers.dart';

class InstructorSelector extends ConsumerWidget {
  const InstructorSelector({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 25,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                value: ref.watch(selectedInstructorProvider),
                hint: const Text('Agregar instructor'),
                items: const [
                  DropdownMenuItem(
                    value: 'Mark Gonzalez',
                    child: Text('Mark Gonzalez'),
                  ),
                  DropdownMenuItem(
                    value: 'Luís Gómez',
                    child: Text(
                      'Luís Gómez',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Carmen López',
                    child: Text(
                      'Carmen López',
                    ),
                  ),
                ],
                onChanged: (String? value) {
                  ref.read(selectedInstructorProvider.notifier).state = value;
                },
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
