import 'package:flutter/material.dart';
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
      case '/':
        return MaterialPageRoute(builder: (_) => LogIn());

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
