import 'package:flutter/material.dart';
import 'package:green_armor_app/services/telegram.dart';

import 'package:location/location.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

const verde_oscuro = const Color(0xFF013c21);
const verde_medio = Color.fromARGB(255, 13, 124, 54);
const verde_claro = Color.fromARGB(255, 19, 192, 88);
const amarillo_oscuro = const Color(0xFFd8ad01);
const amarillo_medio = const Color(0xFFddbe43);
const amarillo_claro = const Color(0xFFedd273);
const blanco = const Color(0xFFffffff);
const negro = const Color(0xFF101010);
const gris = const Color(0xFF767676);
const rojo = const Color(0xFFe83845);

class pagina_principal extends StatefulWidget {
  pagina_principal({Key? key}) : super(key: key);
  @override
  State<pagina_principal> createState() => _pagina_principalState();
}

class _pagina_principalState extends State<pagina_principal> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                child: Image.asset('assets/GA_dorado.png'),
              ),
              const SizedBox(width: 5),
              const Text('GREEN',
                  style: TextStyle(color: blanco, fontWeight: FontWeight.bold)),
              const Text('ARMOR',
                  style: TextStyle(
                      color: amarillo_oscuro, fontWeight: FontWeight.bold)),
            ],
          ),
          backgroundColor: verde_oscuro,
        ),
        body: SafeArea(
          child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: [
                ALERTA(titulo: 'ALERTA', color: verde_oscuro),
                DETALLES_OBJETIVO(
                    titulo: 'DETALLES OBJETIVO',
                    color: amarillo_oscuro,
                    redireccion: '/detalles_objetivo'),
                NOVEDADES(
                    titulo: 'NOVEDADES',
                    color: verde_medio,
                    redireccion: '/novedades'),
                INICIAR_RONDA(
                    titulo: 'INICIAR RONDA',
                    color: amarillo_medio,
                    redireccion: '/nfc_manager'),
                CHECKPOINT(titulo: 'CHECKPOINT', color: verde_claro),
                HOMBRE_VIVO(
                  titulo: 'HOMBRE VIVO',
                  color: amarillo_claro,
                ),
              ]),
        ),
        drawer: DRAWER(usuario: 'Osvaldo Leites', rango: 'Empleado'),
      ),
    );
  }
}

class ALERTA extends StatefulWidget {
  final String titulo;
  final Color color;
  ALERTA({Key? key, required this.titulo, required this.color})
      : super(key: key);

  @override
  State<ALERTA> createState() => _ALERTAState();
}

class _ALERTAState extends State<ALERTA> {
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
          const Icon(
            IconData(0xe087, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            widget.titulo,
            style: const TextStyle(fontSize: 20, color: blanco),
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
            icon: const Icon(Icons.warning_amber_outlined, size: 60),
            title: const Text(
              '¿Está seguro que desea enviar una alerta?',
              textAlign: TextAlign.center,
            ),
            elevation: 2,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verde_oscuro,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar')),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verde_oscuro,
                        alignment: Alignment.center,
                      ),
                      onPressed: () {
                        postDataTexto('UBICACION ALERTA.');
                        getLocation();
                        alertaEnviada = true;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Aceptar')),
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
              icon: const Icon(Icons.cancel_outlined, size: 60),
              title: const Text(
                '¿Desea cancelar la Alerta enviada?',
                textAlign: TextAlign.center,
              ),
              elevation: 2,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: verde_oscuro,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar')),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: verde_oscuro,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          postDataTexto('ALERTA CANCELADA.');
                          //getLocation();
                          alertaEnviada = false;
                          //cancelarAlerta();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Aceptar')),
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

class DETALLES_OBJETIVO extends StatefulWidget {
  final String titulo;
  final Color color;
  final String redireccion;
  DETALLES_OBJETIVO(
      {Key? key,
      required this.titulo,
      required this.color,
      required this.redireccion})
      : super(key: key);

  @override
  State<DETALLES_OBJETIVO> createState() => _DETALLES_OBJETIVOState();
}

class _DETALLES_OBJETIVOState extends State<DETALLES_OBJETIVO> {
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
          const Icon(
            IconData(0xe0a5, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            widget.titulo,
            style: const TextStyle(fontSize: 20, color: blanco),
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

class NOVEDADES extends StatefulWidget {
  final String titulo;
  final Color color;
  final String redireccion;
  NOVEDADES(
      {Key? key,
      required this.titulo,
      required this.color,
      required this.redireccion})
      : super(key: key);

  @override
  State<NOVEDADES> createState() => _NOVEDADESState();
}

class _NOVEDADESState extends State<NOVEDADES> {
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
          const Icon(
            IconData(0xf614, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            widget.titulo,
            style: const TextStyle(fontSize: 20, color: blanco),
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

class INICIAR_RONDA extends StatefulWidget {
  final String titulo;
  final Color color;
  final String redireccion;
  INICIAR_RONDA(
      {Key? key,
      required this.titulo,
      required this.color,
      required this.redireccion})
      : super(key: key);

  @override
  State<INICIAR_RONDA> createState() => _INICIAR_RONDAState();
}

class _INICIAR_RONDAState extends State<INICIAR_RONDA> {
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
          const Icon(
            IconData(0xf04c5, fontFamily: 'MaterialIcons'),
            color: blanco,
            size: 50,
          ),
          const SizedBox(height: 10),
          Text(
            widget.titulo,
            style: const TextStyle(fontSize: 20, color: blanco),
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

class CHECKPOINT extends StatefulWidget {
  final String titulo;
  final Color color;
  CHECKPOINT({
    Key? key,
    required this.titulo,
    required this.color,
  }) : super(key: key);

  @override
  State<CHECKPOINT> createState() => _CHECKPOINTState();
}

class _CHECKPOINTState extends State<CHECKPOINT> {
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
                  const Icon(
                    IconData(0xe7ab, fontFamily: 'MaterialIcons'),
                    color: blanco,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.titulo,
                    style: const TextStyle(fontSize: 20, color: blanco),
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
                  const Icon(
                    IconData(0xe7ab, fontFamily: 'MaterialIcons'),
                    color: blanco,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.titulo,
                    style: const TextStyle(fontSize: 20, color: blanco),
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
                    title: const Text(
                      '¿Qué desea escanear?',
                      textAlign: TextAlign.center,
                    ),
                    elevation: 2,
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: verde_oscuro,
                                alignment: Alignment.center,
                              ),
                              onPressed: () {
                                _scanQR();
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.qr_code),
                                  SizedBox(width: 5),
                                  Text('QR'),
                                ],
                              )),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: verde_oscuro,
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              BottomDialog().showBottomDialog(context);
                              _scanNFC();
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.nfc),
                                SizedBox(width: 5),
                                Text('NFC'),
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

class HOMBRE_VIVO extends StatefulWidget {
  final String titulo;
  final Color color;
  HOMBRE_VIVO({
    Key? key,
    required this.titulo,
    required this.color,
  }) : super(key: key);

  @override
  State<HOMBRE_VIVO> createState() => _HOMBRE_VIVOState();
}

class _HOMBRE_VIVOState extends State<HOMBRE_VIVO> {
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
            const Icon(
              IconData(0xe187, fontFamily: 'MaterialIcons'),
              color: blanco,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              widget.titulo,
              style: const TextStyle(fontSize: 20, color: blanco),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            Navigator.of(context).pushNamed('/hombre_vivo');
          });
        });
  }
}

class DRAWER extends StatefulWidget {
  final String usuario;
  final String rango;
  DRAWER({Key? key, required this.usuario, required this.rango})
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
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
            child: Image.asset('assets/GA_logo_drawer.png'),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                widget.usuario,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: negro),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 20),
              Container(
                constraints: const BoxConstraints(maxHeight: 12, maxWidth: 12),
                child: Image.asset('assets/ic_status_success.png'),
              ),
              const SizedBox(width: 5),
              Text(
                widget.rango,
                style: const TextStyle(fontSize: 16, color: negro),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              SizedBox(width: 20),
              Text(
                'Identidad validada',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: negro),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(
            color: gris,
            thickness: 1,
          ),
          const SizedBox(height: 8),
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
              children: const [
                ListTile(
                  title: Text(
                    'Mis Datos',
                    style: TextStyle(fontSize: 18, color: gris),
                  ),
                  leading:
                      Icon(Icons.account_circle_rounded, color: gris, size: 30),
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
              children: const [
                ListTile(
                  title: Text(
                    'Mis Asignaciones',
                    style: TextStyle(fontSize: 18, color: gris),
                  ),
                  leading: Icon(Icons.hourglass_bottom_rounded,
                      color: gris, size: 30),
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
              children: const [
                ListTile(
                  title: Text(
                    'Acerca de esta aplicación',
                    style: TextStyle(fontSize: 18, color: gris),
                  ),
                  leading: Icon(Icons.info_outline, color: gris, size: 30),
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
              children: const [
                ListTile(
                  title: Text(
                    'Términos y condiciones',
                    style: TextStyle(fontSize: 18, color: gris),
                  ),
                  leading:
                      Icon(Icons.copyright_outlined, color: gris, size: 30),
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
              children: const [
                ListTile(
                  title: Text(
                    'Cerrar la sesión',
                    style: TextStyle(fontSize: 18, color: gris),
                  ),
                  leading: Icon(Icons.logout_sharp, color: gris, size: 30),
                ),
              ],
            ),
            onPressed: () {
              setState(() {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('email', '');
                  prefs.setString('password', '');
                });
                Navigator.of(context).pushNamed('/');
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
              const SizedBox(height: 20),
              _buildTitulo(),
              const SizedBox(height: 8),
              const Center(
                child: Image(
                  image: AssetImage('assets/scan_nfc.gif'),
                ),
              ),
              const SizedBox(height: 8),
              _buildDescripcion(),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: verde_oscuro,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 12)),
                  onPressed: () {
                    NfcManager.instance.stopSession();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitulo() {
    return const Text(
      'Listo para escanear',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDescripcion() {
    return const Text(
      'Acerque su celular al Tag NFC',
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }
}
