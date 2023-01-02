import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/club.dart';
import 'add_club_screen.dart';
import 'club_details.dart';
import '../widgets/my_app_bar.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({super.key});
  static const routeName = '/clubsScreen';

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CollectionReference<Club> clubsRef =
        FirebaseFirestore.instance.collection('clubs').withConverter(
              fromFirestore: Club.fromJson,
              toFirestore: (Club club, _) => club.toJson(),
            );
    // final student = ModalRoute.of(context)!.settings.arguments as Student;
    return Column(
      children: [
        MyAppBar(
          title: 'Clubs',
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => AddClubScreen(
                        clubRef: clubsRef,
                      )),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
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
        StreamBuilder(
          stream: clubsRef.snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Club club = snapshot.data!.docs[index].data();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ClubDetails(club: club);
                            },
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
                            title: Text(snapshot.data!.docs[index]["name"]),
                            subtitle: const Text('Establish Date : 2/1/2023'),
                            trailing: TextButton(
                                onPressed: () {}, child: const Text('Join')),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ],
    );
  }
}
