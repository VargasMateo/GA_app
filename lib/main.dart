import 'package:flutter/material.dart';
import 'package:green_armor_app/services/route_generator.dart';
import 'services/notifications.dart';
import 'package:provider/provider.dart';

import 'package:green_armor_app/services/providers/countdown_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(AppGreenArmor());
}

class AppGreenArmor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => CountdownProvider())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //saca la banda roja de debug
        title: 'GREEN ARMOR',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
