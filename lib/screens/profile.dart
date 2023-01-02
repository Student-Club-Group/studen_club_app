import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../widgets/my_app_bar.dart';
import '../models/student_provider.dart';
import '../widgets/post_widget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static List<Post> posts = [
    Post(
      title: 'Chess Tournament',
      announcement:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui. Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Diam vel quam elementum pulvinar etiam non quam lacus suspendisse.',
      authorId: '0',
      clubName: 'Club Name',
      authorName: 'Youssef Darahem',
      clubId: '0',
      dateTime: DateTime.now(),
    ),
    Post(
      title: 'Football Match',
      announcement:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui. Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Diam vel quam elementum pulvinar etiam non quam lacus suspendisse.',
      authorId: '0',
      clubName: 'Club Name',
      authorName: 'Youssef Darahem',
      clubId: '0',
      dateTime: DateTime.now(),
    ),
    Post(
      title: 'Poem Concert',
      announcement:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui. Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Diam vel quam elementum pulvinar etiam non quam lacus suspendisse.',
      authorId: '0',
      clubName: 'Club Name',
      authorName: 'Youssef Darahem',
      clubId: '0',
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO : seperate to loading and data widgets

    StudentProvider studentProvider = Provider.of<StudentProvider>(context);

    if (studentProvider.student == null) {
      studentProvider.fetchStudent();
    }

    return studentProvider.student == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
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
                      backgroundImage: AssetImage(
                        studentProvider.student!.imageUrl ??
                            'assets/images/man.png',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentProvider.student!.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.blueGrey[700]),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          studentProvider.student!.email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: Colors.blueGrey[700],
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        color: Colors.red.shade400,
                      ),
                    ),
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
                        studentProvider.student!.clubs!.length.toString(),
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
                        'Liked Posts',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        studentProvider.student!.likedPosts!.length.toString(),
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
                'Liked Posts',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(children: postsList()),
              ),
            ],
          );
  }

  List<Widget> postsList() {
    return posts.map((post) {
      return PostWidget(
        title: post.title,
        announcement: post.announcement,
        clubName: 'Club Name',
        author: 'Youssef Darahem',
        dateTime: post.dateTime!,
        postState: post.state,
      );
    }).toList();
  }
}
