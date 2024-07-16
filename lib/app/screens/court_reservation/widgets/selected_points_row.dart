import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/states/providers/courts_providers.dart';

class SelectedPointsRow extends ConsumerWidget {
  const SelectedPointsRow({required this.courtList, super.key});

  final List<CourtModel> courtList;

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    CourtModel selectedCourtModel = ref.watch(selectedCourtProvider)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          courtList.length,
              (int i) => Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 10,
            ),
            width: courtList[i].id == selectedCourtModel.id
                ? 10
                : 16,
            height: courtList[i].id == selectedCourtModel.id
                ? 10
                : 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: courtList[i].id == selectedCourtModel.id
                  ? Colors.green
                  : Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

