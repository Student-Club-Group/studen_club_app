import 'package:student_club/models/post_state.dart';

class Post {
  int clubId;
  int authorId;
  String title;
  String announcement;
  int numberOfLikes = 0;
  int numberOfDislikes = 0;
  DateTime dateTime;
  PostState state = PostState.neither;
  Post(
      {required this.clubId,
      required this.authorId,
      required this.title,
      required this.announcement,
      required this.dateTime});
}
