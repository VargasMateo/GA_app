import 'package:flutter/material.dart';
import 'package:green_armor_app/services/email_sign_in.dart';
import 'package:green_armor_app/services/telegram.dart';

import 'package:location/location.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../services/responsive.dart';
import '../services/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: appBarPersonalizado('GREEN', 'ARMOR'),
          backgroundColor: verdeOscuro,
        ),
        body: SafeArea(
          child: GridView.count(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.04,
                  vertical: SizeConfig.screenWidth * 0.04),
              crossAxisCount: 2,
              crossAxisSpacing: SizeConfig.screenWidth * 0.04,
              mainAxisSpacing: SizeConfig.screenWidth * 0.04,
              children: const [
                BotonAlerta(titulo: 'ALERTA', color: verdeOscuro),
                BotonDetallesObjetivo(
                    titulo: 'DETALLES OBJETIVO',
                    color: amarilloOscuro,
                    redireccion: '/DetallesObjetivo'),
                BotonNovedades(
                    titulo: 'NOVEDADES',
                    color: verdeMedio,
                    redireccion: '/Novedades'),
                BotonIniciarRonda(
                    titulo: 'INICIAR RONDA',
                    color: amarilloMedio,
                    redireccion: '/nfc_manager'),
                BotonCheckpoint(titulo: 'CHECKPOINT', color: verdeClaro),
                BotonHombreVivo(
                  titulo: 'HOMBRE VIVO',
                  color: amarilloClaro,
                ),
              ]),
        ),
        drawer: const DRAWER(usuario: 'Osvaldo Leites', rango: 'Empleado'),
      ),
    );
  }
}

class BotonAlerta extends StatefulWidget {
  final String titulo;
  final Color color;
  const BotonAlerta({Key? key, required this.titulo, required this.color})
      : super(key: key);

  @override
  State<BotonAlerta> createState() => _BotonAlertaState();
}

class _BotonAlertaState extends State<BotonAlerta> {
  Location location = new Location();
  bool alertaEnviada = false;
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.granted;
  LocationData _locationData = LocationData.fromMap({});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(widget.color)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            const IconData(0xe087, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: SizeConfig.screenWidth * 0.15,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Text(
            widget.titulo,
            style: TextStyle(
                fontSize: SizeConfig.screenWidth * 0.055, color: blanco),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0))),
            icon: Icon(Icons.warning_amber_outlined,
                size: SizeConfig.screenWidth * 0.18),
            title: Text(
              '¿Está seguro que desea enviar una alerta?',
              style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05),
              textAlign: TextAlign.center,
            ),
            elevation: 2,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeOscuro,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancelar',
                        style:
                            TextStyle(fontSize: SizeConfig.screenWidth * 0.04),
                      )),
                  SizedBox(width: SizeConfig.screenWidth * 0.05),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeOscuro,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        postDataTexto('UBICACION ALERTA.');
                        getLocation();
                        alertaEnviada = true;
                        Navigator.of(context).pop();
                      },
                      child: Text('Aceptar',
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.04))),
                ],
              ),
            ],
          ),
        );
      },
      onLongPress: () {
        if (alertaEnviada == true) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
              icon: Icon(Icons.cancel_outlined,
                  size: SizeConfig.screenWidth * 0.18),
              title: Text(
                '¿Desea cancelar la Alerta enviada?',
                style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05),
                textAlign: TextAlign.center,
              ),
              elevation: 2,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: verdeOscuro,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar',
                            style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.04))),
                    SizedBox(width: SizeConfig.screenWidth * 0.05),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: verdeOscuro,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          postDataTexto('ALERTA CANCELADA.');
                          //getLocation();
                          alertaEnviada = false;
                          //cancelarAlerta();
                          Navigator.of(context).pop();
                        },
                        child: Text('Aceptar',
                            style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.04))),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {});
    postAlerta(_locationData);
  }
}

class BotonDetallesObjetivo extends StatefulWidget {
  final String titulo;
  final Color color;
  final String redireccion;
  const BotonDetallesObjetivo(
      {Key? key,
      required this.titulo,
      required this.color,
      required this.redireccion})
      : super(key: key);

  @override
  State<BotonDetallesObjetivo> createState() => _BotonDetallesObjetivoState();
}

class _BotonDetallesObjetivoState extends State<BotonDetallesObjetivo> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(widget.color)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            const IconData(0xe0a5, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: SizeConfig.screenWidth * 0.15,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Text(
            widget.titulo,
            style: TextStyle(
                fontSize: SizeConfig.screenWidth * 0.055, color: blanco),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onPressed: () {
        setState(() {
          Navigator.of(context).pushNamed(widget.redireccion);
        });
      },
    );
  }
}

class BotonNovedades extends StatefulWidget {
  final String titulo;
  final Color color;
  final String redireccion;
  const BotonNovedades(
      {Key? key,
      required this.titulo,
      required this.color,
      required this.redireccion})
      : super(key: key);

  @override
  State<BotonNovedades> createState() => _BotonNovedadesState();
}

class _BotonNovedadesState extends State<BotonNovedades> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(widget.color)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            const IconData(0xf614, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: SizeConfig.screenWidth * 0.15,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Text(
            widget.titulo,
            style: TextStyle(
                fontSize: SizeConfig.screenWidth * 0.055, color: blanco),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onPressed: () {
        setState(() {
          Navigator.of(context).pushNamed(widget.redireccion);
        });
      },
    );
  }
}

class BotonIniciarRonda extends StatefulWidget {
  final String titulo;
  final Color color;
  final String redireccion;
  const BotonIniciarRonda(
      {Key? key,
      required this.titulo,
      required this.color,
      required this.redireccion})
      : super(key: key);

  @override
  State<BotonIniciarRonda> createState() => _BotonIniciarRondaState();
}

class _BotonIniciarRondaState extends State<BotonIniciarRonda> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(widget.color)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            const IconData(0xf04c5, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: SizeConfig.screenWidth * 0.15,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          Text(
            widget.titulo,
            style: TextStyle(
                fontSize: SizeConfig.screenWidth * 0.055, color: blanco),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      onPressed: () {
        setState(() {
          Navigator.of(context).pushNamed(widget.redireccion);
        });
      },
    );
  }
}

class BotonCheckpoint extends StatefulWidget {
  final String titulo;
  final Color color;
  const BotonCheckpoint({
    Key? key,
    required this.titulo,
    required this.color,
  }) : super(key: key);

  @override
  State<BotonCheckpoint> createState() => _BotonCheckpointState();
}

class _BotonCheckpointState extends State<BotonCheckpoint> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: NfcManager.instance.isAvailable(),
      builder: (context, ss) => ss.data != true
          ? ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(widget.color)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    const IconData(0xe7ab, fontFamily: 'MaterialIcons'),
                    color: blanco,
                    size: SizeConfig.screenWidth * 0.15,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    widget.titulo,
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.055,
                        color: blanco),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {
                _scanQR();
              },
            )
          : ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(widget.color)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    const IconData(0xe7ab, fontFamily: 'MaterialIcons'),
                    color: blanco,
                    size: SizeConfig.screenWidth * 0.15,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    widget.titulo,
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.055,
                        color: blanco),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0))),
                    backgroundColor: Colors.white,
                    title: Text(
                      '¿Qué desea escanear?',
                      style: TextStyle(fontSize: SizeConfig.screenWidth * 0.05),
                      textAlign: TextAlign.center,
                    ),
                    elevation: 2,
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: verdeOscuro,
                                alignment: Alignment.center,
                              ),
                              onPressed: () {
                                _scanQR();
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.qr_code),
                                  SizedBox(
                                      width: SizeConfig.screenWidth * 0.01),
                                  Text('QR',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.screenWidth * 0.04)),
                                ],
                              )),
                          SizedBox(width: SizeConfig.screenWidth * 0.05),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: verdeOscuro,
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              BottomDialog().showBottomDialog(context);
                              _scanNFC();
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.nfc),
                                SizedBox(width: SizeConfig.screenWidth * 0.01),
                                Text('NFC',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenWidth * 0.04)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  _scanQR() async {
    String data = '';
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancelar", true, ScanMode.QR)
        .then((value) => setState(() => data = value));
    if (data != '-1') postDataTexto('QR: ' + data);
    return data;
  }

  _scanNFC() async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
      postDataTexto(
          'NFC: ' + result.value.toString() + ' tag.handle: ' + tag.handle);
      Navigator.of(context).pop(); //PARA PROBAR SI SALE DE LA PANTALLA
      return result.value;
    });
  }
}

class BotonHombreVivo extends StatefulWidget {
  final String titulo;
  final Color color;
  const BotonHombreVivo({
    Key? key,
    required this.titulo,
    required this.color,
  }) : super(key: key);

  @override
  State<BotonHombreVivo> createState() => _BotonHombreVivoState();
}

class _BotonHombreVivoState extends State<BotonHombreVivo> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(widget.color)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              const IconData(0xe187, fontFamily: 'MaterialIcons'),
              color: blanco,
              size: SizeConfig.screenWidth * 0.15,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Text(
              widget.titulo,
              style: TextStyle(
                  fontSize: SizeConfig.screenWidth * 0.055, color: blanco),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            Navigator.of(context).pushNamed('/HombreVivo');
          });
        });
  }
}

class DRAWER extends StatefulWidget {
  final String usuario;
  final String rango;
  const DRAWER({Key? key, required this.usuario, required this.rango})
      : super(key: key);

  @override
  State<DRAWER> createState() => _DRAWERState();
}

class _DRAWERState extends State<DRAWER> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Container(
            constraints: BoxConstraints(
                maxHeight: SizeConfig.screenWidth * 0.30,
                maxWidth: SizeConfig.screenWidth * 0.30),
            child: Image.asset('assets/GA_logo_drawer.png'),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Row(
            children: [
              SizedBox(width: SizeConfig.screenWidth * 0.06),
              Text(
                widget.usuario,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.screenWidth * 0.045,
                    color: negro),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Row(
            children: [
              SizedBox(width: SizeConfig.screenWidth * 0.06),
              Container(
                constraints: BoxConstraints(
                    maxHeight: SizeConfig.screenWidth * 0.03,
                    maxWidth: SizeConfig.screenWidth * 0.03),
                child: Image.asset('assets/ic_status_success.png'),
              ),
              SizedBox(width: SizeConfig.screenWidth * 0.01),
              Text(
                widget.rango,
                style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.045, color: negro),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Row(
            children: [
              SizedBox(width: SizeConfig.screenWidth * 0.06),
              Text(
                'Identidad validada',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.screenWidth * 0.045,
                    color: negro),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          const Divider(
            color: gris,
            thickness: 1,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 250, 250, 250)),
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(1, 0, 1, 0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Mis Datos',
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.045, color: gris),
                  ),
                  leading: Icon(Icons.account_circle_rounded,
                      color: gris, size: SizeConfig.screenWidth * 0.08),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).pushNamed('/Cargando');
              });
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 250, 250, 250)),
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(1, 0, 1, 0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Mis Asignaciones',
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.045, color: gris),
                  ),
                  leading: Icon(Icons.hourglass_bottom_rounded,
                      color: gris, size: SizeConfig.screenWidth * 0.08),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).pushNamed('/Cargando');
              });
            },
          ),
          const Divider(
            color: gris,
            thickness: 1,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 250, 250, 250)),
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(1, 0, 1, 0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Acerca de esta aplicación',
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.045, color: gris),
                  ),
                  leading: Icon(Icons.info_outline,
                      color: gris, size: SizeConfig.screenWidth * 0.08),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).pushNamed('/Cargando');
              });
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 250, 250, 250)),
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(1, 0, 1, 0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Términos y condiciones',
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.045, color: gris),
                  ),
                  leading: Icon(Icons.copyright_outlined,
                      color: gris, size: SizeConfig.screenWidth * 0.08),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                Navigator.of(context).pushNamed('/Cargando');
              });
            },
          ),
          const Divider(
            color: gris,
            thickness: 1,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 250, 250, 250)),
                elevation: MaterialStateProperty.all<double>(0),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(1, 0, 1, 0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    'Cerrar la sesión',
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.045, color: gris),
                  ),
                  leading: Icon(Icons.logout_sharp,
                      color: gris, size: SizeConfig.screenWidth * 0.08),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                cerrarSesionEmail(context);
              });
            },
          ),
        ],
      ),
    );
  }
}

class BottomDialog {
  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        height: 320,
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Material(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              _buildTitulo(),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              const Center(
                child: Image(
                  image: AssetImage('assets/scan_nfc.gif'),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              _buildDescripcion(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.03),
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(SizeConfig.screenHeight * 0.023),
                    ),
                    backgroundColor: MaterialStateProperty.all(verdeOscuro),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ), //const EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    NfcManager.instance.stopSession();
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitulo() {
    return Text(
      'Listo para escanear',
      style: TextStyle(
        fontSize: SizeConfig.screenWidth * 0.06,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDescripcion() {
    return Text(
      'Acerque su celular al Tag NFC',
      style: TextStyle(
        fontSize: SizeConfig.screenWidth * 0.05,
      ),
    );
  }
}
