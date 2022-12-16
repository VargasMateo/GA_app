import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/pagina_principal.dart';
import '../screens/hombre_vivo.dart';
import '../screens/novedades.dart';
import '../screens/detalles_objetivo.dart';
import '../nfc_manager.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => initialize());

      case '/pagina_principal':
        return MaterialPageRoute(builder: (_) => pagina_principal());

      case '/hombre_vivo':
        return MaterialPageRoute(builder: (_) => hombre_vivo());

      case '/novedades':
        return MaterialPageRoute(builder: (_) => novedades());

      case '/detalles_objetivo':
        return MaterialPageRoute(builder: (_) => detalles_objetivo());

      case '/nfc_manager':
        return MaterialPageRoute(builder: (_) => nfc_manager());
    }

    throw Exception("Error en 'route generator'");
  }
}
