import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_armor_app/services/route_generator.dart';
import 'services/notifications.dart';
import 'package:provider/provider.dart';

import 'package:green_armor_app/services/providers/countdown_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  await Firebase.initializeApp();
  runApp(const AppGreenArmor());
}

class AppGreenArmor extends StatelessWidget {
  const AppGreenArmor({Key? key}) : super(key: key);

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
        initialRoute: '/SignedInOut',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
