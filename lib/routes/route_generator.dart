import 'package:flutter/material.dart';
import 'package:tennis_court/app/screens/authentication/login_page.dart';
import 'package:tennis_court/app/screens/authentication/sign_up_page.dart';
import 'package:tennis_court/app/screens/authentication/splash_page.dart';
import 'package:tennis_court/app/screens/court_reservation/court_reservation_summary.dart';
import 'package:tennis_court/app/screens/court_reservation/court_reservations_list.dart';
import 'package:tennis_court/app/screens/home/home_page.dart';
import 'package:tennis_court/routes/app_routes.dart';
import 'package:tennis_court/app/screens/authentication/auth_page.dart';
import 'package:tennis_court/app/screens/court_reservation/court_reservation_main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoutes.auth:
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.courtReservationMain:
        return MaterialPageRoute(builder: (_) => const CourtReservationMain());
      case AppRoutes.courtReservationSummary:
        return MaterialPageRoute(builder: (_) => CourtReservationSummary());
      case AppRoutes.courtReservationsList:
        return MaterialPageRoute(builder: (_) => const CourtReservationsList());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR: Ruta no encontrada'),
        ),
      );
    });
  }
}