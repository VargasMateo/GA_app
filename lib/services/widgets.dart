import 'package:flutter/material.dart';
import 'responsive.dart';

// COLORES

const verdeOscuro = Color(0xFF013c21);
const verdeMedio = Color.fromARGB(255, 13, 124, 54);
const verdeClaro = Color.fromARGB(255, 19, 192, 88);
const amarilloOscuro = Color(0xFFd8ad01);
const amarilloMedio = Color(0xFFddbe43);
const amarilloClaro = Color(0xFFedd273);
const blanco = Color(0xFFffffff);
const negro = Color(0xFF101010);
const gris = Color(0xFF767676);
const rojo = Color(0xFFe83845);

// ERRORES

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor, ingresá tu email";
const String kInvalidEmailError = "Por favor, ingresá un email válido";
const String kPassNullError = "Por favor, ingresá tu contraseña";
const String kShortPassError = "La contraseña es demasiado corta";
const String kWrongEmailPassword = "El email y/o la contraseña son incorrectos";

// LOGIN_SCREEN

Widget textFiled(
    String texto, TextEditingController controller, bool oscurecer) {
  return Padding(
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
          controller: controller,
          cursorColor: verdeOscuro,
          obscureText: oscurecer,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: texto,
          ),
          style: TextStyle(fontSize: SizeConfig.screenWidth * 0.041),
        ),
      ),
    ),
  );
}

//HOME_SCREEN

Widget appBarPersonalizado(String texto1, String texto2) {
  return Row(
    children: [
      Container(
        constraints: BoxConstraints(
            maxHeight: SizeConfig.screenHeight * 0.08,
            maxWidth: SizeConfig.screenWidth * 0.08),
        child: Image.asset('assets/GA_dorado.png'),
      ),
      SizedBox(width: SizeConfig.screenWidth * 0.02),
      Text(texto1,
          style: TextStyle(
              color: blanco,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.screenWidth * 0.055)),
      Text(texto2,
          style: TextStyle(
              color: amarilloOscuro,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.screenWidth * 0.055)),
    ],
  );
}
