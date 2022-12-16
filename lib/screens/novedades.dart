import 'pagina_principal.dart';
import 'package:green_armor_app/services/telegram.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class novedades extends StatefulWidget {
  const novedades({Key? key}) : super(key: key);

  @override
  State<novedades> createState() => _novedadesState();
}

class _novedadesState extends State<novedades> {
  TextEditingController mensajeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  List<XFile?> listado = [];

  void _sacarFoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) listado.add(image);
    });
  }

  void _seleccionarFoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) listado.add(image);
    });
  }

  void _seleccionarFotos() async {
    final List<XFile?> images = await _picker.pickMultiImage();

    setState(() {
      for (int i = 0; i < images.length; i++) {
        XFile? image = images[i];
        if (image != null) listado.add(image);
      }
    });
  }

  void _grabarVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    setState(() {
      if (video != null) listado.add(video);
    });
  }

  void _seleccionarVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      if (video != null) listado.add(video);
    });
  }

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
            const Text('NOVEDADES',
                style: TextStyle(color: blanco, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: verde_oscuro,
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: const [
                    SizedBox(width: 10),
                    Text(
                      'Se enviará un mensaje para el Objetivo',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    SizedBox(width: 10),
                    Text('Escriba su mensaje a continuación',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: mensajeController,
                    cursorColor: verde_oscuro,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Escriba aquí...',
                      hoverColor: verde_oscuro,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: verde_oscuro)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: verde_oscuro)),
                    ),
                    minLines: 1,
                    maxLines: 100,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FloatingActionButton(
                        backgroundColor: verde_oscuro,
                        onPressed: () {
                          _seleccionarFotos();
                        },
                        heroTag: 'image1',
                        tooltip: 'Pick Multiple Image from gallery',
                        child: const Icon(Icons.photo_library),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FloatingActionButton(
                        backgroundColor: verde_medio,
                        onPressed: () {
                          _sacarFoto();
                        },
                        heroTag: 'image2',
                        tooltip: 'Take a Photo',
                        child: const Icon(Icons.camera_alt),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FloatingActionButton(
                        backgroundColor: amarillo_oscuro,
                        onPressed: () {
                          _seleccionarVideo();
                        },
                        heroTag: 'video0',
                        tooltip: 'Pick Video from gallery',
                        child: const Icon(Icons.video_library),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FloatingActionButton(
                        backgroundColor: amarillo_medio,
                        onPressed: () {
                          _grabarVideo();
                        },
                        heroTag: 'video1',
                        tooltip: 'Take a Video',
                        child: const Icon(Icons.videocam),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: listado.isEmpty
                      ? const Text('Seleccione o tome un archivo multimedia')
                      : Text('Archivos seleccionados ' +
                          listado.length.toString()),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: verde_oscuro,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          setState(() {
                            //print(mensajeController.text);
                            //print(listado[0]!.path);
                            postDataTexto(mensajeController.text);
                            print('1');
                            postDataImagen(listado[0]);
                            print('2');
                          });
                        },
                        child: const Text('Enviar Mensaje')),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
