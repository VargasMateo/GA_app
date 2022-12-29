import 'package:flutter/material.dart';
import 'package:green_armor_app/services/email_sign_in.dart';
import 'package:green_armor_app/services/responsive.dart';
import '../services/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');

      if (email != null && password != null) {
        iniciarSesionEmail(context, emailController, passwordController);
      }
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.015),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: SizeConfig.screenHeight * 0.8,
                        maxWidth: SizeConfig.screenWidth * 0.8),
                    child: Image.asset('assets/GA_logo_drawer.png'),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  Text(
                    'Sign in',
                    style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.015),
                  textFiled('Email', emailController, false),
                  SizedBox(height: SizeConfig.screenHeight * 0.015),
                  textFiled('Contraseña', passwordController, true),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(verdeOscuro)),
                    onPressed: () {
                      //forgot password screen
                    },
                    child: Text('¿Olvidó su contraseña?',
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.038)),
                  ),
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
                        iniciarSesionEmail(
                            context, emailController, passwordController);
                      },
                      child: Center(
                        child: Text(
                          'Iniciar sesión',
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
        ),
      ),
    );
  }
}
