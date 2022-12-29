enum ClubType {
  academic,
  political,
  media,
  theatreAndArt,
  religiousAndCultural,
  sport,
  tech,
}

class Club {
  int id;
  String name;
  String description;

  ClubType? type;
  String? imageUrl;
  List<int>? members;

  Club(
      {required this.id,
      required this.name,
      required this.description,
      type,
      imageUrl,
      members});
}
