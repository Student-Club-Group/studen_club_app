import 'package:flutter/material.dart';

import 'register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Club'),
      ),
      body: RegisterScreen(),
    );
  }
}
