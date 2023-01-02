import 'package:cloud_firestore/cloud_firestore.dart';

enum ClubType {
  academic,
  political,
  media,
  theatreAndArt,
  religiousAndCultural,
  sports,
  tech,
}

class Club {
  late String name;
  late String description;
  List<String>? owners =
      []; // list of student id's whom are considered owners of this club.
  List<String>? posts = []; // list of post id's
  List<String>? members = [];
  String? id;

  ClubType? type;
  String? imageUrl;

  Club(
      {required this.name,
      required this.description,
      this.type,
      this.imageUrl,
      this.owners,
      this.posts,
      this.members,
      this.id});

  Club copyWith({
    String? name,
    String? description,
    ClubType? type,
    List<String>? owners,
    List<String>? posts,
    List<String>? members,
    String? id,
    String? imageUrl,
  }) {
    return Club(
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      id: id ?? this.id,
      owners: owners ?? this.owners,
      posts: posts ?? this.posts,
      members: members ?? this.members,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  addPost(String postId) {
    posts!.add(postId);
  }

  factory Club.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Club(
        name: data?['name'],
        description: data?['description'],
        owners: data?['owners'] is Iterable
            ? List<String>.from(data?['owners'])
            : null,
        members: data?['members'] is Iterable
            ? List<String>.from(data?['members'])
            : null,
        posts: data?['posts'] is Iterable
            ? List<String>.from(data?['posts'])
            : null,
        type: ClubType.values
            .firstWhere((e) => e.name.toString() == data?['type']),
        id: snapshot.id);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      if (owners != null) "owners": owners,
      if (posts != null) "posts": posts,
      if (members != null) "members": members,
      "type": type!.name.toString(),
    };
  }
}
