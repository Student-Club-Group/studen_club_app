import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final String signInText = 'Already have an account ?';
  final String signUpText = 'Don\'t have an account ?';
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    String authSigningState = isSigningIn ? signInText : signUpText;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isSigningIn
                  ? const SizedBox()
                  : TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Input Your Name'),
                      controller: nameController,
                    ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Input Your Email'),
                controller: emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter A password'),
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
              Text(authSigningState),
              TextButton(
                onPressed: () {
                  setState(() {
                    isSigningIn = !isSigningIn;
                  });
                },
                child: Text(isSigningIn ? 'Register' : 'Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future? signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwdController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future? signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwdController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
