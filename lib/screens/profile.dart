import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/student.dart';

class Profile extends StatelessWidget {
  final Student student;
  const Profile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Image.network(
                student.imageUrl ??
                    'https://media.istockphoto.com/id/1300845620/es/vector/icono-de-usuario-plano-aislado-sobre-fondo-blanco-s%C3%ADmbolo-de-usuario-ilustraci%C3%B3n-vectorial.jpg?s=612x612&w=is&k=20&c=zPM_oUwye9se11xNJdiJtq6iCxZ97z7Lpa2GUf1p8GU=',
              ),
            ),
            Text(student.name),
            const Spacer(),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Sign Out'))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: const [
                Text('Clubs'),
                Text('15'),
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              children: const [
                Text('Posts'),
                Text('30'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
