import 'package:flutter/material.dart';
import 'package:student_club/widgets/post_widget.dart';

import '../models/post.dart';
import '../widgets/my_app_bar.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({super.key});

  static List<Post> posts = [
    Post(
      title: 'Chess Tournament',
      announcement:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui. Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Diam vel quam elementum pulvinar etiam non quam lacus suspendisse.',
      authorId: '0',
      clubId: '0',
      clubName: 'Club Name',
      authorName: 'Youssef Darahem',
      dateTime: DateTime.now(),
    ),
    Post(
      title: 'Football Match',
      announcement:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui. Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Diam vel quam elementum pulvinar etiam non quam lacus suspendisse.',
      authorId: '0',
      clubId: '0',
      clubName: 'Club Name',
      authorName: 'Youssef Darahem',
      dateTime: DateTime.now(),
    ),
    Post(
      title: 'Poem Concert',
      announcement:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui. Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla. Diam vel quam elementum pulvinar etiam non quam lacus suspendisse.',
      authorId: '0',
      clubId: '0',
      clubName: 'Club Name',
      authorName: 'Youssef Darahem',
      dateTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyAppBar(
          title: 'Time Line',
        ),
        Expanded(
            child: ListView(
          children: postsList(),
        )),
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

    // return ListView.builder(
    //     itemCount: posts.length, itemBuilder: ((context, index) {}));
  }
}
