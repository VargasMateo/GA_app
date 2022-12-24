import 'package:green_armor_app/services/providers/countdown_provider.dart';

import 'package:flutter/material.dart';
import 'package:green_armor_app/services/responsive.dart';
import 'package:provider/provider.dart';
import '../services/widgets.dart';

class HombreVivo extends StatefulWidget {
  const HombreVivo({Key? key}) : super(key: key);

  @override
  _HombreVivoState createState() => _HombreVivoState();
}

class _HombreVivoState extends State<HombreVivo> {
  @override
  Widget build(BuildContext context) {
    final countdownProvider = Provider.of<CountdownProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: appBarPersonalizado('HOMBRE', 'VIVO'),
        backgroundColor: verdeOscuro,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.08, horizontal: SizeConfig.screenWidth * 0.04),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: SizeConfig.screenWidth * 0.8,
                height: SizeConfig.screenWidth * 0.8,
                child: CircularProgressIndicator(
                  color: verdeOscuro,
                  backgroundColor: gris,
                  value: countdownProvider.progress,
                  strokeWidth: 9,
                ),
              ),
              TextButton(
                onPressed: () {
                  countdownProvider.restartTimer();
                },
                child: Text(
                  context.select((CountdownProvider countdown) =>
                      countdown.timeLeftString),
                  style: TextStyle(fontSize: SizeConfig.screenWidth * 0.25, color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(SizeConfig.screenHeight * 0.023),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(verdeOscuro),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ), //const EdgeInsets.all(20),
                  ),
              onPressed: () {
                countdownProvider.startTimer();
              },
              child: Text(
                      'Iniciar ronda',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.screenWidth * 0.04,
                      ),
                    ),),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(SizeConfig.screenHeight * 0.023),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(verdeOscuro),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ), //const EdgeInsets.all(20),
                  ),
              onPressed: () {
                countdownProvider.stopTimer();
              },
              child: Text(
                      'Terminar ronda',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.screenWidth * 0.04,
                      ),
                    ),)
        ],
      ),
    );
  }
}
