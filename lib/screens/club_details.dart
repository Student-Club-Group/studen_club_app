import 'package:flutter/material.dart';

import '../models/club.dart';

class ClubDetails extends StatelessWidget {
  final Club club;

  const ClubDetails({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(club.name),
    ));
  }
}
