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
        Container(
          width: double.infinity,
          height: 60,
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                const Spacer(
                  flex: 4,
                ),
                Text(
                  'Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white),
                ),
                const Spacer(
                  flex: 3,
                ),
                TextButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green[50],
                radius: 40,
                child: Image.asset(
                  student.imageUrl ?? 'assets/images/man.png',
                  width: 60,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(student.name),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
            ],
          ),
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
        const SizedBox(
          height: 30,
        ),
        const Text('Posts'),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: ((context, index) {
              return const ListTile(
                title: Text('Post'),
                subtitle: Text(
                    'Magna exercitation sit exercitation culpa cupidatat est pariatur eiusmod. Eiusmod anim in Lorem ad et proident dolore duis.'),
              );
            }),
          ),
        ),
      ],
    );
  }
}
