import 'package:flutter/material.dart';
import 'pagina_principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class initialize extends StatefulWidget {
  initialize({Key? key}) : super(key: key);

  @override
  State<initialize> createState() => _initializeState();
}

class _initializeState extends State<initialize> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return log_in();
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: gris,
              color: verde_oscuro,
            ),
          );
        }),
      ),
    );
  }
}

class log_in extends StatefulWidget {
  log_in({Key? key}) : super(key: key);

  @override
  State<log_in> createState() => _log_inState();
}

class _log_inState extends State<log_in> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');

      if (email != null && password != null) {
        setState(() async {
          User? user = await loginUsingEmailPassword(
              email: email, password: password, context: context);

          if (user != null) {
            Navigator.of(context).pushNamed('/pagina_principal');
          }
        });
      }
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 300, maxWidth: 300),
                      child: Image.asset('assets/GA_logo_drawer.png'),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                        cursorColor: verde_oscuro,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          hoverColor: verde_oscuro,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: verde_oscuro)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: verde_oscuro)),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        cursorColor: verde_oscuro,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Contraseña',
                            hoverColor: verde_oscuro,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: verde_oscuro)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: verde_oscuro))),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(verde_oscuro)),
                      onPressed: () {
                        //forgot password screen
                      },
                      child: const Text(
                        '¿Olvidó su contraseña?',
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(verde_oscuro)),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          setState(() async {
                            User? user = await loginUsingEmailPassword(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context);

                            if (user != null) {
                              SharedPreferences.getInstance().then((prefs) {
                                prefs.setString('email', emailController.text);
                                prefs.setString(
                                    'password', passwordController.text);
                              });
                              Navigator.of(context)
                                  .pushNamed('/pagina_principal');
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: 250,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                amarillo_medio)),
                        child: const Text(
                          'Crear cuenta',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          //Post_login(nameController.text, passwordController.text);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
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
