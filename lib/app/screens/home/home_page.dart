import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tennis_court/app/data/models/court_model.dart';
import 'package:tennis_court/app/data/models/court_reservation_model.dart';
import 'package:tennis_court/app/data/models/user_model.dart';
import 'package:tennis_court/app/data/states/providers/auth_providers.dart';
import 'package:tennis_court/app/data/states/providers/courts_providers.dart';
import 'package:tennis_court/app/data/states/providers/reservation_providers.dart';
import 'package:tennis_court/core/utils/utils.dart';
import 'package:tennis_court/routes/app_routes.dart';
import 'package:tennis_court/app/screens/home/widgets/home_drawer.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.listen<UserModel?>(authNotifierProvider, (prev, state) {
      if (state == null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.auth,
          (Route<dynamic> route) => false,
        );
      }
    });
    AsyncValue<List<CourtModel>> courtList = ref.watch(futureCourtListProvider);
    AsyncValue<List<CourtReservationModel>> courtReservations =
        ref.watch(futureCourtReservationsListProvider);

    return Scaffold(
      key: _key,
      drawer: const HomeDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient:  LinearGradient(
                  colors: [
                    Color(0xFF072146),
                    Color(0xFF82BC00),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              leadingWidth: MediaQuery.of(context).size.width / 2.5,
              leading: const Center(
                child: Text(
                    'Tennis court',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              actions: [
                FutureBuilder(
                    future:
                    getFileFromUint8List(ref.watch(authNotifierProvider)!.picture),
                    builder:
                        (BuildContext context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: Image.file(
                              snapshot.data!,
                              width: 25,
                              height: 25,
                            ).image,
                            ),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child:
                          CircularProgressIndicator(),
                        ),
                      );
                    }),

                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/notifications.svg',
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _key.currentState?.openDrawer();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 25
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/menu.svg',
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),

      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 8,
            ),
            child: Text(
              'Hola ${ref.read(authNotifierProvider)?.name}!',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 5,
            ),
            child: Text(
              'Canchas',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: courtList.when(
              data: (List<CourtModel> courtList) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...courtList.map(
                      (CourtModel court) => FutureBuilder(
                        future: getFileFromUint8List(court.picture),
                        builder: (ctx, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              height: MediaQuery.of(ctx).size.height * 0.5,
                              width: MediaQuery.of(ctx).size.width * 0.65,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(court.name),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/weather.svg',
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                            Color(0xFF346BC3),
                                                            BlendMode.srcIn),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Text('30%'),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                              'Cancha tipo ${court.type.name.toUpperCase()}'),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/calendar.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color(0xFF346BC3),
                                                        BlendMode.srcIn),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text('9 de julio 2024'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text('Disponible'),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 8,
                                                width: 8,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFF346BC3),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SvgPicture.asset(
                                                'assets/svg/clock.svg',
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Color(0xFF346BC3),
                                                        BlendMode.srcIn),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Text('7:00 am a 4:00 pm'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: FilledButton(
                                            onPressed: () {
                                              ref.read(selectedCourtProvider.notifier).state = court;
                                              Navigator.of(context).pushNamed(AppRoutes.courtReservationMain);
                                            },
                                            child: const Text('Reservar'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              error: (error, stack) => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 8,
            ),
            child: Text(
              'Reservas programadas',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          courtReservations.when(
              data: (reservationList) => reservationList.isEmpty
                  ? const SizedBox(
                width: double.infinity,
                    height: 200,
                    child: Column(
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied_rounded,
                          size: 100,
                        ),
                        Center(
                            child: Text('No tienes reservaciones'),
                          ),
                      ],
                    ),
                  )
                  : Column(
                      children: [
                        ...reservationList
                            .map((CourtReservationModel reservation) {
                          CourtModel court = ref
                              .read(courtsNotifierProvider)
                              .firstWhere(
                                  (court) => court.id == reservation.courtId);
                          UserModel user = ref
                              .read(userListProvider)
                              .firstWhere(
                                  (user) => user.id == reservation.usedId);
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: ListTile(
                              isThreeLine: true,
                              tileColor: const Color(0xFFF4F7FC),
                              leading: FutureBuilder(
                                  future: getFileFromUint8List(court.picture),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                            snapshot.data!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    }
                                    return const SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }),
                              title: Text(
                                  court.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                        SvgPicture.asset(
                                          'assets/svg/calendar.svg',
                                          width: 15,
                                          height: 15,
                                        ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          DateFormat('d \'de\' MMMM yyyy', 'es_ES').format(reservation.startingDateTime),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Reservado por: ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: [
                                        WidgetSpan(
                                          child: FutureBuilder(
                                              future:
                                                  getFileFromUint8List(user.picture),
                                              builder:
                                                  (BuildContext context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(image: Image.file(
                                                        snapshot.data!,
                                                        width: 25,
                                                        height: 25,
                                                      ).image,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return const Center(
                                                  child: SizedBox(
                                                    width: 10,
                                                    height: 10,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              }),
                                        ),
                                        TextSpan(
                                          text: ' ${user.name}\n\n',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: SvgPicture.asset(
                                            'assets/svg/clock.svg',
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                        TextSpan(
                                            text: ' ${reservation.endingDateTime.difference(reservation.startingDateTime).inHours} horas | \$${reservation.price}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    ),
              error: (error, trace) => Center(child: Text(error.toString()),),
              loading: () => const CircularProgressIndicator()),
        ],
      ),
    );
  }
}
