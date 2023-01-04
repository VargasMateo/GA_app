import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/LogIn_screen.dart';
import '../screens/Home_screen.dart';

class SignedInOut extends StatelessWidget {
  const SignedInOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home();
          } else {
            return const LogIn();
          }
        },
      ),
    );
  }
}

Future<FirebaseApp> initializeFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();
  return firebaseApp;
}

Future<void> loginUsingEmailPassword({
  required String email,
  required String password,
  required bool logged,
}) async {
  await initializeFirebase();
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    logged = true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      logged = false;
      print('not user found for the email');
    }
  }
}

void logoutUsingEmailPassword(BuildContext context) {
  FirebaseAuth.instance.signOut();
}
