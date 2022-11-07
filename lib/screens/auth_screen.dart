import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_club/screens/profile.dart';

import '../models/student.dart';
import 'register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Student student = Student(
                    id: snapshot.data!.uid, name: snapshot.data!.email!);
                return Profile(student: student);
              } else {
                return const RegisterScreen();
              }
            }),
      ),
    );
  }
}
