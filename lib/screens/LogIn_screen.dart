import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_armor_app/services/email_sign_in.dart';
import 'package:green_armor_app/services/responsive.dart';
import '../services/widgets.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final List<String?> errors = [];
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
                    'Log in',
                    style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.015),
                  textFiled('Email', emailController, false),
                  SizedBox(height: SizeConfig.screenHeight * 0.015),
                  textFiled('Contraseña', passwordController, true),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  FormError(errors: errors),
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
                      onPressed: () async {
                        bool logged = await loginUsingEmailPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        setState(() {
                          validadorErrores(errors, emailController.text,
                              passwordController.text, logged);
                        });
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

class FormError extends StatelessWidget {
  List<String?> errors;
  FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        errors.length,
        (index) => formErrorText(
          error: errors[index],
        ),
      ),
    );
  }

  Padding formErrorText({String? error}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/svg/Error.svg",
            height: SizeConfig.screenHeight * 0.015,
            width: SizeConfig.screenWidth * 0.015,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.01,
          ),
          Text(error!),
        ],
      ),
    );
  }
}

List<String?> validadorErrores(
    List<String?> errors, String email, String password, bool logged) {
  if (email == '') {
    if (!errors.contains(kEmailNullError)) {
      errors.add(kEmailNullError);
    }
  } else {
    errors.remove(kEmailNullError);
    if (!emailValidatorRegExp.hasMatch(email)) {
      if (!errors.contains(kInvalidEmailError)) {
        errors.add(kInvalidEmailError);
      }
    } else {
      errors.remove(kInvalidEmailError);
    }
  }

  if (password == '') {
    if (!errors.contains(kPassNullError)) {
      errors.add(kPassNullError);
    }
  } else {
    errors.remove(kPassNullError);
    if (password.length < 6) {
      if (!errors.contains(kShortPassError)) {
        errors.add(kShortPassError);
      }
    } else {
      errors.remove(kShortPassError);
    }
  }

  if (logged == false) {
    if (!errors.contains(kWrongEmailPassword)) {
      if (!errors.contains(kEmailNullError) &&
          (!errors.contains(kInvalidEmailError))) {
        if (!errors.contains(kPassNullError) &&
            (!errors.contains(kShortPassError))) {
          errors.add(kWrongEmailPassword);
        }
      }
    }
  } else {
    errors.remove(kWrongEmailPassword);
  }

  return errors;
}
