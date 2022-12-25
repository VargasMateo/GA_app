import 'dart:async';
import 'package:flutter/material.dart';
import 'package:green_armor_app/services/telegram.dart';

import 'package:green_armor_app/services/notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class CountdownProvider extends ChangeNotifier {
  Duration duration = const Duration(seconds: 1800);
  bool isRunning = false;
  double progress = 1800;

  StreamSubscription<int>? _tickSubscription;

  void _startTimer(int seconds) {
    _tickSubscription?.cancel();
    _tickSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (sec) => seconds - sec - 1)
        .take(seconds)
        .listen((timeLeftInSeconds) {
      duration = Duration(seconds: timeLeftInSeconds);
      progress = timeLeftInSeconds.toDouble() / 1800;
      advertencia_prueba();
      advertencia_1();
      advertencia_2();
      enviar_alarma();
      postDataTexto('hombre vivo: ' + duration.toString());
      notifyListeners();
    });
  }

  void startTimer() {
    if (isRunning == false) {
      startBackgroundService();
      _startTimer(duration.inSeconds);
      isRunning = true;
      postDataTexto('Se inició hombre vivo.');
      notifyListeners();
    }
  }

  void restartTimer() {
    if (isRunning) {
      Duration aux = const Duration(seconds: 1800);
      progress = 1800;
      _startTimer(aux.inSeconds);
      notifyListeners();
    }
  }

  void stopTimer() {
    if (isRunning) {
      duration = const Duration(seconds: 1800);
      _tickSubscription?.cancel();
      isRunning = false;
      progress = 1800;
      postDataTexto('Se terminó hombre vivo.');
      notifyListeners();
    }
  }

  String get timeLeftString {
    final minutes =
        ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        (duration.inSeconds % 60).floor().toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  void advertencia_prueba() {
    if (timeLeftString == '29:56') {
      FlutterRingtonePlayer.playNotification();
      mostrarNotificacion();
    }
  }

  void advertencia_1() {
    if (timeLeftString == '05:00') {
      FlutterRingtonePlayer.playNotification();
      mostrarNotificacion();
    }
  }

  void advertencia_2() {
    if (timeLeftString == '01:00') {
      FlutterRingtonePlayer.playAlarm();
      mostrarNotificacion();
    }
  }

  void enviar_alarma() {
    if (timeLeftString == '00:00') {
      //ENVIAR ALARMA
      postDataTexto('HOMBRE VIVO se quedó sin tiempo. Enviando alarma');
      //FALTARIA MANDAR UBICACION
    }
  }

  void startBackgroundService() {
    final service = FlutterBackgroundService();
    service.startService();
  }
}
