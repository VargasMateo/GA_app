import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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