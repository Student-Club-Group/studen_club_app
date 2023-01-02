import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? imageUrl;
  late String name;
  late String email;
  String? id;
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
      this.likedPosts,
      this.id});

  addClub(String clubId) {
    if (clubs == null) {
      clubs = [clubId];
    } else {
      clubs!.add(clubId);
    }
  }

  removeClub(String clubId) {
    if (clubs == null) {
      print('Error : you are trying Club with ID : $clubId but clubs are null');
    } else if (clubs!.isEmpty) {
      print(
          'Error : you are trying Club with ID : $clubId but clubs are Empty');
    } else {
      clubs!.remove(clubId);
    }
  }

  factory Student.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Student(
        name: data?['name'],
        email: data?['email'],
        clubs: data?['clubs'] is Iterable
            ? List<String>.from(data?['clubs'])
            : null,
        likedPosts: data?['liked_posts'] is Iterable
            ? List<String>.from(data?['liked_posts'])
            : null,
        id: snapshot.id
        // likedPosts: data?['liked_posts'] as List<String>,
        );
    // name = json['name'] as String;
    // email = json['email'] as String;
    // clubs = json['clubs'] as List<String>;
    // likedPosts = json['liked_posts'] as List<String>;
  }

  Map<String, dynamic> toJson() {
    clubs ??= [];
    likedPosts ??= [];
    return {
      "name": name,
      "email": email,
      "clubs": clubs,
      "liked_posts": likedPosts,
    };
  }
}
