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
  List<String> owners =
      []; // list of student id's whom are considered owners of this club.

  List<String> posts = []; // list of post id's
  List<String> members = [];

  ClubType? type;
  String? imageUrl;

  Club(
      {required this.name, required this.description, type, imageUrl, members});

  Club.fromJson(Map json) {
    name = json["name"] as String;
    description = json["description"] as String;
    owners = json["owners"] as List<String>;
    posts = json["posts"] as List<String>;
    members = json["members"] as List<String>;
    type = ClubType.values
        .firstWhere((element) => element.toString() == ["type"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "owners": owners,
      "posts": posts,
      "members": members,
      "type": type.toString(),
    };
  }
}
