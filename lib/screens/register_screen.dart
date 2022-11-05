import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(hintText: 'Input Your Name'),
              controller: nameController),
          TextFormField(
              decoration: const InputDecoration(hintText: 'Input Your Email'),
              controller: emailController),
          TextFormField(
              decoration: const InputDecoration(hintText: 'Enter A password'),
              controller: passwdController),
          const TextButton(
            onPressed: null,
            child: Text('Sign Up'),
          ),
          const TextButton(
            onPressed: null,
            child: Text('Already have an account ? \n Sign in'),
          ),
        ],
      ),
    );
  }
}
