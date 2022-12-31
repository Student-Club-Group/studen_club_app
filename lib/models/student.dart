import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? imageUrl;
  late String name;
  late String email;
  List<String>? clubs = [];
  List<String>? likedPosts = [];

  set setImageUrl(String url) {
    imageUrl = url;
  }

  Student(
      {required this.name,
      required this.email,
      this.imageUrl,
      this.clubs,
      this.likedPosts});

  factory Student.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Student(
      name: data?['name'],
      email: data?['email'],
      // clubs: data?['clubs'] as List<String>,
      // likedPosts: data?['liked_posts'] as List<String>,
    );
    // name = json['name'] as String;
    // email = json['email'] as String;
    // clubs = json['clubs'] as List<String>;
    // likedPosts = json['liked_posts'] as List<String>;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "clubs": clubs,
      "liked_posts": likedPosts,
    };
  }
}
