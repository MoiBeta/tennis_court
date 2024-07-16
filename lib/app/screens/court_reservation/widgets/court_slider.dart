import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/states/providers/courts_providers.dart';
import 'package:tennis_court/core/utils/utils.dart';

class CourtSlider extends ConsumerWidget {
  const CourtSlider({required this.courtList, super.key});

  final List<CourtModel> courtList;

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    return  CarouselSlider(
      items: [
        ...courtList.map(
              (court) => FutureBuilder(
            future: getFileFromUint8List(court.picture),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: double.infinity,
                  height:
                  MediaQuery.of(context).size.height * 0.3,
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
        ),
      ],
      options: CarouselOptions(
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          onPageChanged:
              (int index, CarouselPageChangedReason reason) {
            ref.read(selectedCourtProvider.notifier).state =
            courtList[index];
          }),
    );
  }
}
