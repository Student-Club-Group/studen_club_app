import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final String signInText = 'Already have an account ? ';
  final String signUpText = 'No account ? ';

  bool isSigningIn = true;

  @override
  Widget build(BuildContext context) {
    final TextStyle headline3 = Theme.of(context)
        .textTheme
        .headline3!
        .copyWith(color: Colors.grey[700]);

    String authSigningState = isSigningIn ? signUpText : signInText;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/images/cooperation2.png', height: 150),
                  const SizedBox(height: 15),
                  Text(
                    'Student Club',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.blueGrey[600]),
                  ),
                  const SizedBox(height: 50),
                  isSigningIn
                      ? const SizedBox()
                      : TextFormField(
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Enter your name',
                            labelStyle: headline3,
                          ),
                          controller: nameController,
                        ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Input Your E-mail',
                      labelStyle: headline3,
                    ),
                    controller: emailController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Enter A password',
                      labelStyle: headline3,
                    ),
                    controller: passwdController,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () {
                      if (isSigningIn) {
                        signIn();
                      } else {
                        signUp();
                      }
                    },
                    child: Text(isSigningIn ? 'Sign In' : 'Sign Up'),
                  ),
                  const SizedBox(height: 20),
                  // Text(authSigningState),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: authSigningState),
                        TextSpan(
                            text: isSigningIn ? ' Sign Up' : ' Log In',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isSigningIn = !isSigningIn;
                                });
                              }),
                      ],
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

  // TODO : Separate business logic from UI

  Future? signUp() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwdController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future? signIn() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwdController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
