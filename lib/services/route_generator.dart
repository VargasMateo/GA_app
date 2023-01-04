import 'package:flutter/material.dart';
import 'package:green_armor_app/services/email_sign_in.dart';
import '../screens/LogIn_screen.dart';
import '../screens/Home_screen.dart';
import '../screens/HombreVivo_screen.dart';
import '../screens/Novedades_screen.dart';
import '../screens/DetallesObjetivo_screen.dart';
import 'nfc_manager.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case '/SignedInOut':
        return MaterialPageRoute(builder: (_) => const SignedInOut());

      case '/':
        return MaterialPageRoute(builder: (_) => const LogIn());

      case '/Home':
        return MaterialPageRoute(builder: (_) => const Home());

      case '/HombreVivo':
        return MaterialPageRoute(builder: (_) => const HombreVivo());

      case '/Novedades':
        return MaterialPageRoute(builder: (_) => const Novedades());

      case '/DetallesObjetivo':
        return MaterialPageRoute(builder: (_) => const DetallesObjetivo());

      case '/nfc_manager':
        return MaterialPageRoute(builder: (_) => nfc_manager());
    }

    throw Exception("Error en 'route generator'");
  }
}
