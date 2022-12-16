import 'pagina_principal.dart';
import 'package:green_armor_app/services/providers/countdown_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class hombre_vivo extends StatefulWidget {
  const hombre_vivo({Key? key}) : super(key: key);

  @override
  _hombre_vivoState createState() => _hombre_vivoState();
}

class _hombre_vivoState extends State<hombre_vivo> {
  @override
  Widget build(BuildContext context) {
    final countdownProvider = Provider.of<CountdownProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
              child: Image.asset('assets/GA_dorado.png'),
            ),
            const SizedBox(width: 5),
            const Text('HOMBRE',
                style: TextStyle(color: blanco, fontWeight: FontWeight.bold)),
            const Text('VIVO',
                style: TextStyle(
                    color: amarillo_oscuro, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: verde_oscuro,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  color: verde_oscuro,
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
                  style: const TextStyle(fontSize: 90, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(verde_oscuro)),
              onPressed: () {
                countdownProvider.startTimer();
              },
              child: const Text('INICIAR RONDA')),
          const SizedBox(height: 5),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(verde_oscuro)),
              onPressed: () {
                countdownProvider.stopTimer();
              },
              child: const Text('TERMINAR RONDA'))
        ],
      ),
    );
  }
}
