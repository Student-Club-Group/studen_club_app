import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/my_app_bar.dart';
import '../models/student_provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider = Provider.of<StudentProvider>(context);

    return Column(
      children: [
        const MyAppBar(
          title: 'Profile',
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green[50],
                radius: 40,
                child: Image.asset(
                  studentProvider.student!.imageUrl ?? 'assets/images/man.png',
                  width: 60,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(studentProvider.student!.name),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout_rounded))
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Clubs',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  '15',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              children: [
                Text(
                  'Posts',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  '30',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Posts',
          style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 22),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: ((context, index) {
              return const Card(
                child: ListTile(
                  title: Text('Post'),
                  subtitle: Text(
                      'Magna exercitation sit exercitation culpa cupidatat est pariatur eiusmod. Eiusmod anim in Lorem ad et proident dolore duis.'),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
