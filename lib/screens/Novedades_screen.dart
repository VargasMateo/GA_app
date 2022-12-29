import 'package:green_armor_app/services/responsive.dart';

import '../services/widgets.dart';
import 'package:green_armor_app/services/telegram.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class Novedades extends StatefulWidget {
  const Novedades({Key? key}) : super(key: key);

  @override
  State<Novedades> createState() => _NovedadesState();
}

class _NovedadesState extends State<Novedades> {
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
        title: appBarPersonalizado('NOVEDADES', ''),
        backgroundColor: verdeOscuro,
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01, horizontal: SizeConfig.screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Row(
                  children: [
                    SizedBox(width: SizeConfig.screenWidth * 0.025),
                    Text(
                      'Se enviará un mensaje para el Objetivo',
                      style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Row(
                  children: [
                    SizedBox(width: SizeConfig.screenWidth * 0.025),
                    Text('Escriba su mensaje a continuación',
                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05)),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: verdeOscuro),
          borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * 0.05,
        ),
        child: TextField(
          controller: mensajeController,
          cursorColor: verdeOscuro,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Escriba aquí...',
          ),
          style: TextStyle(fontSize: SizeConfig.screenWidth * 0.041),
          minLines: 1,
                    maxLines: 100,
        ),
      ),
    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.03),
                      child: FloatingActionButton(
                        backgroundColor: verdeOscuro,
                        onPressed: () {
                          _seleccionarFotos();
                        },
                        heroTag: 'image1',
                        tooltip: 'Pick Multiple Image from gallery',
                        child: Icon(Icons.photo_library, size: SizeConfig.screenWidth * 0.07),
                      ),
                    ),
                     SizedBox(width: SizeConfig.screenWidth * 0.02),
                    Padding(
                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.03),
                      child: FloatingActionButton(
                        backgroundColor: verdeMedio,
                        onPressed: () {
                          _sacarFoto();
                        },
                        heroTag: 'image2',
                        tooltip: 'Take a Photo',
                        child: Icon(Icons.camera_alt, size: SizeConfig.screenWidth * 0.07),
                      ),
                    ),
                     SizedBox(width: SizeConfig.screenWidth * 0.025),
                    Padding(
                      padding:  EdgeInsets.only(top: SizeConfig.screenHeight * 0.03),
                      child: FloatingActionButton(
                        backgroundColor: amarilloOscuro,
                        onPressed: () {
                          _seleccionarVideo();
                        },
                        heroTag: 'video0',
                        tooltip: 'Pick Video from gallery',
                        child: Icon(Icons.video_library, size: SizeConfig.screenWidth * 0.07),
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth * 0.025),
                    Padding(
                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.03),
                      child: FloatingActionButton(
                        backgroundColor: amarilloMedio,
                        onPressed: () {
                          _grabarVideo();
                        },
                        heroTag: 'video1',
                        tooltip: 'Take a Video',
                        child: Icon(Icons.videocam, size: SizeConfig.screenWidth * 0.07),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Center(
                  child: listado.isEmpty
                      ? Text('Seleccione o tome un archivo multimedia', style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04))
                      : Text('Archivos seleccionados ' +
                          listado.length.toString(), style: TextStyle(fontSize: SizeConfig.screenWidth * 0.04)),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.03),
                child: ElevatedButton(
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
                    setState(() {
                        //print(mensajeController.text);
                        //print(listado[0]!.path);
                        postDataTexto(mensajeController.text);
                        print('1');
                        postDataImagen(listado[0]);
                        print('2');
                      });
                        },
                  child: Center(
                    child: Text(
                      'Enviar novedad',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
                SizedBox(height: SizeConfig.screenHeight * 0.025),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
