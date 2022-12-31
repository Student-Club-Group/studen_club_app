import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'register_screen.dart';
import 'home_page.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // StudentProvider provider =
    //     Provider.of<StudentProvider>(context, listen: false);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Student student = Student(name: snapshot.data!.email!);
            // provider.updateStudent(student);

            return const HomePage();
          } else {
            return const RegisterScreen();
          }
        });
  }
}
