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

Future<bool> loginUsingEmailPassword({
  required String email,
  required String password,
}) async {
  bool logged = false;
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
  return logged;
}

void logoutUsingEmailPassword(BuildContext context) {
  FirebaseAuth.instance.signOut();
}

Future<bool> createAccount({
  required String email,
  required String password,
}) async {
  bool created = false;
  await initializeFirebase();
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;
    updateAccount(user);
    created = true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      created = false;
      print('creating a new user was not possible');
    }
  }
  return created;
}

Future<void> updateAccount(User? user) async {
  String? email = user!.email;
  if (email != null) {
    int index = email.indexOf('@');
    String displayName = email!.substring(0, index);
    await user.updateDisplayName(displayName);
  }
  await user.updatePhotoURL(
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png');
}
