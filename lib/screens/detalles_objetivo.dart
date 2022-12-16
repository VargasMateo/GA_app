import 'package:flutter/material.dart';
import 'pagina_principal.dart';

import 'package:url_launcher/url_launcher.dart';

class detalles_objetivo extends StatefulWidget {
  detalles_objetivo({Key? key}) : super(key: key);

  @override
  State<detalles_objetivo> createState() => _detalles_objetivoState();
}

class _detalles_objetivoState extends State<detalles_objetivo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
              child: Image.asset('assets/GA_dorado.png'),
            ),
            const SizedBox(width: 5),
            const Text('DETALLES',
                style: TextStyle(color: blanco, fontWeight: FontWeight.bold)),
            const Text('OBJETIVO',
                style: TextStyle(
                    color: amarillo_oscuro, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: verde_oscuro,
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
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxHeight: 150, maxWidth: 150),
          child: Image.asset('assets/background.jpg'),
        ),
        Column(
          children: [
            Text(
              nombre_objetivo,
              style: const TextStyle(fontSize: 16),
            ),
            Text(descripcion_objetivo),
          ],
        ),
      ],
    ),
  );
}

Widget _Info_extra(
    String direccion, String cp, String provincia, String celular) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: const [
            SizedBox(width: 10),
            Icon(Icons.directions, size: 20),
            SizedBox(width: 4),
            Text(
              'Dirección',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 10),
            Text(direccion),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const SizedBox(width: 10),
            Text(cp),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const SizedBox(width: 10),
            Text(provincia),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            SizedBox(width: 10),
            Icon(Icons.phone, size: 20),
            SizedBox(width: 4),
            Text(
              'Contacto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            const Text('Celular: '),
            TextButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(verde_oscuro)),
              onPressed: () {
                launch('tel://$celular');
              },
              child: Text(
                celular,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
      ],
    ),
  );
}

Widget _Observaciones(String observaciones) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: const [
            SizedBox(width: 10),
            Icon(Icons.app_registration, size: 20),
            SizedBox(width: 4),
            Text(
              'Observaciones',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 10),
            Text(observaciones),
          ],
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}

Widget _Supervisores(String nombre) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: const [
            SizedBox(width: 10),
            Icon(Icons.supervisor_account, size: 20),
            SizedBox(width: 4),
            Text(
              'Supervisores',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 10),
            Text(nombre),
          ],
        ),
        const SizedBox(height: 12),
      ],
    ),
  );
}
