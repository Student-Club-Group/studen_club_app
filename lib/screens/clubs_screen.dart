import 'package:flutter/material.dart';
import 'package:student_club/models/club.dart';
import 'package:student_club/screens/club_details.dart';

import '../widgets/my_app_bar.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({super.key});
  static const routeName = '/clubsScreen';

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  TextEditingController editingController = TextEditingController();
  static List<Club> clubs = [
    Club(
      id: 0,
      name: 'Chess club',
      description: 'in this club we are what we pla pla pla ',
    ),
    Club(
      id: 1,
      name: 'Football club',
      description: 'in this club we are what we pla pla pla ',
    ),
    Club(
      id: 2,
      name: 'Poem club',
      description: 'in this club we are what we pla pla pla ',
    )
  ];

  @override
  Widget build(BuildContext context) {
    // final student = ModalRoute.of(context)!.settings.arguments as Student;
    return Column(
      children: [
        const MyAppBar(title: 'Clubs'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: TextField(
            onChanged: (value) {},
            controller: editingController,
            decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)))),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: clubs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClubDetails(club: clubs[index]),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.group_sharp),
                      ),
                      title: Text(clubs[index].name),
                      subtitle: Text(clubs[index].description),
                      trailing: TextButton(
                          onPressed: () {}, child: const Text('Join')),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
