import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_club/models/student.dart';
import 'package:student_club/services/auth.dart';
import 'package:student_club/services/firestore_cloud.dart';

import '../models/student_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = '/registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final String signInText = 'Already have an account ? ';
  final String signUpText = 'No account ? ';

  bool isSigningIn = true;

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Image.asset('assets/images/cooperation2.png', height: 150),
                    const SizedBox(height: 10),
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
                        labelText: 'Enter Password',
                        labelStyle: headline3,
                      ),
                      obscureText: true,
                      controller: passwdController,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Password is required please enter';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Confirm Password',
                        labelStyle: headline3,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Conform password is required please enter';
                        }
                        if (value != passwdController.text) {
                          return 'Confirm password not matching';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        FireStoreCloud fireStoreCloud = FireStoreCloud();
                        if (isSigningIn) {
                          Auth().signIn(emailController.text.trim(),
                              passwdController.text.trim());
                        } else {
                          if (_formKey.currentState!.validate()) {
                            Auth().signUp(emailController.text.trim(),
                                passwdController.text.trim());

                            Student student = Student(
                                name: nameController.text.trim(),
                                email: emailController.text.trim());
                            studentProvider.addUser(student);
                            // studentProvider.updateStudent(student);
                          }
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
      ),
    );
  }

  // // TODO : Separate business logic from UI

  // Future? signUp() async {
  //   // showDialog(
  //   //   context: context,
  //   //   barrierDismissible: false,
  //   //   builder: (context) => const Center(
  //   //     child: CircularProgressIndicator(),
  //   //   ),
  //   // );
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwdController.text.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  //   // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }

  // Future? signIn() async {
  //   // showDialog(
  //   //   context: context,
  //   //   barrierDismissible: false,
  //   //   builder: (context) => const Center(
  //   //     child: CircularProgressIndicator(),
  //   //   ),
  //   // );
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwdController.text.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  //   // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }
}
