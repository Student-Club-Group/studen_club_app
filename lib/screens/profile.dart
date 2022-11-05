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
                student.imageUrl!,
              ),
            ),
            Text(student.name),
          ],
        ),
        Row(
          children: [
            Column(
              children: const [
                Text('Clubs'),
                Text('15'),
              ],
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
