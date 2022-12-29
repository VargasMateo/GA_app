import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FirebaseApp> initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

Future<User?> loginUsingEmailPassword(
    {required String email,
    required String password,
    required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print('not user found for the email');
    }
  }
  return user;
}

Future<void> iniciarSesionEmail(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {

  await initializeFirebase();
  User? user = await loginUsingEmailPassword(
    email: emailController.text,
    password: passwordController.text,
    context: context);

  if (user != null) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      });
        Navigator.of(context).pushNamed('/Home');
  }
}

void cerrarSesionEmail(BuildContext context) {

  SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('email', '');
                  prefs.setString('password', '');
                });
                Navigator.of(context).pushNamed('/');
}

// class initialize extends StatefulWidget {
//   initialize({Key? key}) : super(key: key);

//   @override
//   State<initialize> createState() => _initializeState();
// }

// class _initializeState extends State<initialize> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: initializeFirebase(),
//         builder: ((context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return const LoginScreen();
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }),
//       ),
//     );
//   }
// }