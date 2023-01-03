import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_club/models/post_provider.dart';
import 'package:student_club/models/student_provider.dart';
import 'package:student_club/widgets/post_widget.dart';

import '../models/club.dart';

import '../widgets/my_app_bar.dart';

class TimeLineScreen extends StatelessWidget {
  TimeLineScreen({super.key});

  final clubsRef = FirebaseFirestore.instance.collection("clubs").withConverter(
        fromFirestore: Club.fromJson,
        toFirestore: (Club club, _) => club.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider = Provider.of<StudentProvider>(context);
    PostProvider postProvider = Provider.of<PostProvider>(context);

    if (studentProvider.student == null) {
      studentProvider.fetchStudent();
    } else {
      List<String> myClubs = studentProvider.student!.clubs!;
      print('list of clubs: $myClubs');
      if (postProvider.state == StatusOfPosts.notFetched) {
        postProvider.fetchPosts(myClubs);
      }
    }
    Widget getBody() {
      if (studentProvider.student == null ||
          postProvider.state == StatusOfPosts.loading) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (postProvider.state == StatusOfPosts.fetched &&
          postProvider.posts!.isEmpty) {
        return const Expanded(
          child: Center(
            child: Text('No Posts Yet !!'),
          ),
        );
      } else {
        return Expanded(
          child: ListView(
            children: postsList(postProvider),
          ),
        );
      }
    }

    return Column(
      children: [
        MyAppBar(
          title: 'Time Line',
          trailing: IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              List<String> myClubs = studentProvider.student!.clubs!;
              print('list of clubs: $myClubs');
              postProvider.state = StatusOfPosts.notFetched;
              postProvider.fetchPosts(myClubs);
            },
          ),
        ),
        getBody(),
      ],
    );
  }

  List<Widget> postsList(PostProvider postProvider) {
    return postProvider.posts!.map((post) {
      return PostWidget(
        title: post.title,
        announcement: post.announcement,
        clubName: post.clubName,
        author: post.authorName,
        dateTime: post.dateTime!,
        postState: post.state,
      );
    }).toList();
  }
}
