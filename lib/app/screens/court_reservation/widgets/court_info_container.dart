import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/states/providers/courts_providers.dart';

class CourtInfoContainer extends ConsumerWidget {
  const CourtInfoContainer({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    CourtModel selectedCourtModel = ref.watch(selectedCourtProvider)!;
    return
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.20,
        padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCourtModel.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${selectedCourtModel.lendPrice}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF346BC3),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Cancha tipo ${selectedCourtModel.type.name.toUpperCase()}'),
                const Text('Por hora'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Disponible',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      WidgetSpan(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF346BC3),
                          ),
                          width: 10,
                          height: 10,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 17,
                          height: 15,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svg/clock.svg',
                              width: 13,
                              height: 13,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: '7:00 am a 4:00 pm',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/weather.svg',
                      colorFilter: const ColorFilter.mode(
                          Color(0xFF346BC3), BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('30%'),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/location.svg',
                  colorFilter: const ColorFilter.mode(
                      Colors.black, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text('Vía Av. Caracas y Av. P.° Caroní'),
              ],
            ),
          ],
        ),
      );
  }
}
