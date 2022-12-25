import '../models/student.dart';

class Club {
  String name;
  String description;
  int numOfMembers;
  List<Student>? members;
  Club(
      {required this.name,
      required this.description,
      required this.numOfMembers,
      this.members});
}
