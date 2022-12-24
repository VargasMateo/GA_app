import 'package:flutter/material.dart';
import 'package:green_armor_app/services/responsive.dart';
import '../services/widgets.dart';

import 'package:url_launcher/url_launcher.dart';

class DetallesObjetivo extends StatefulWidget {
  const DetallesObjetivo({Key? key}) : super(key: key);

  @override
  State<DetallesObjetivo> createState() => _DetallesObjetivoState();
}

class _DetallesObjetivoState extends State<DetallesObjetivo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarPersonalizado('DETALLES', 'OBJETIVO'),
        backgroundColor: verdeOscuro,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _Objetivo(
                'Los Patricios - Sucursal Unica', 'Fideicomiso Los Patricios'),
            _Info_extra('Capitan Juan de San Martín 1391', 'Boulogne CP 1609',
                'Buenos Aires', '1570048067'),
            _Observaciones('------'),
            _Supervisores('Ruben Villar')
          ],
        ),
      ),
    );
  }
}

Widget _Objetivo(String nombre_objetivo, String descripcion_objetivo) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01, horizontal: SizeConfig.screenWidth * 0.03),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: BoxConstraints(maxHeight: SizeConfig.screenWidth * 0.4, maxWidth: SizeConfig.screenWidth * 0.4),
          child: Image.asset('assets/background.jpg'),
        ),
        Column(
          children: [
            Text(
              nombre_objetivo,
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04),
            ),
            Text(descripcion_objetivo,
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.03)),
          ],
        ),
      ],
    ),
  );
}

Widget _Info_extra(
    String direccion, String cp, String provincia, String celular) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01, horizontal: SizeConfig.screenWidth * 0.03),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Icon(Icons.directions, size: SizeConfig.screenWidth * 0.065),
            SizedBox(width: SizeConfig.screenWidth * 0.01),
            Text(
              'Dirección',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.screenWidth * 0.045),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Text(direccion,
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.005),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Text(cp,
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.005),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Text(provincia,
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Icon(Icons.phone, size: SizeConfig.screenWidth * 0.065),
            SizedBox(width: SizeConfig.screenWidth * 0.01),
            Text(
              'Contacto',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.screenWidth * 0.045),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
             Text('Celular: ',
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
            TextButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(verdeOscuro)),
              onPressed: () {
                launch('tel://$celular');
              },
              child: Text(
                celular,
              ),
            ),
          ],
        ),
        SizedBox(width: SizeConfig.screenWidth * 0.01),
      ],
    ),
  );
}

Widget _Observaciones(String observaciones) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01, horizontal: SizeConfig.screenWidth * 0.03),
    child: Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Icon(Icons.app_registration, size: SizeConfig.screenWidth * 0.065),
            SizedBox(width: SizeConfig.screenWidth * 0.01),
            Text(
              'Observaciones',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.screenWidth * 0.045),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Text(observaciones,
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
      ],
    ),
  );
}

Widget _Supervisores(String nombre) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01, horizontal: SizeConfig.screenWidth * 0.03),
    child: Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Icon(Icons.supervisor_account, size: SizeConfig.screenWidth * 0.065),
            SizedBox(width: SizeConfig.screenWidth * 0.01),
            Text(
              'Supervisores',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.screenWidth * 0.045)
            ),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Row(
          children: [
            SizedBox(width: SizeConfig.screenWidth * 0.025),
            Text(nombre,
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
          ],
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
      ],
    ),
  );
}
