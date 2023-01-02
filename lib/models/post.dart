import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_club/models/post_state.dart';

class Post {
  String? id;
  String clubId;
  String clubName;
  String authorId;
  String title;
  String announcement;
  String authorName;
  int numberOfLikes = 0;
  int numberOfDislikes = 0;
  DateTime? dateTime;
  PostState state = PostState.neither; // regarding the current user

  Post({
    required this.clubId,
    required this.clubName,
    required this.authorId,
    required this.title,
    required this.announcement,
    required this.authorName,
    this.dateTime,
    this.id,
  });

  factory Post.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    Timestamp timestamp = data?['date'];
    DateTime dateTime = timestamp.toDate();
    return Post(
        clubId: data?['club'],
        authorId: data?['author'],
        clubName: data?['club_name'],
        authorName: data?['author_name'],
        title: data?['title'],
        announcement: data?['description'],
        dateTime: dateTime,
        id: snapshot.id);
  }

  Map<String, dynamic> toJson() {
    Timestamp postTimeStamp = Timestamp.fromDate(dateTime!);
    return {
      "title": title,
      "description": announcement,
      "author": authorId,
      "author_name": authorName,
      "club": clubId,
      "club_name": clubName,
      "date": postTimeStamp
    };
  }
}
