import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_club/services/firestore_cloud.dart';

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
  // static List<Club> clubs = [
  //   Club(
  //     name: 'Chess club',
  //     description: 'in this club we are what we pla pla pla ',
  //   ),
  //   Club(
  //     name: 'Football club',
  //     description: 'in this club we are what we pla pla pla ',
  //   ),
  //   Club(
  //     name: 'Poem club',
  //     description: 'in this club we are what we pla pla pla ',
  //   )
  // ];

  @override
  Widget build(BuildContext context) {
    final CollectionReference _clubsRef =
        FirebaseFirestore.instance.collection('clubs');
    // final student = ModalRoute.of(context)!.settings.arguments as Student;
    return Column(
      children: [
        MyAppBar(
          title: 'Clubs',
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AddClubScreen())));
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
        Expanded(
          child: StreamBuilder(
            stream: _clubsRef.snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(snapshot.data!.docs[index]);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       Club club =
                        //           Club.fromJson(snapshot.data!.docs[index]);
                        //       return ClubDetails(club: club);
                        //     },
                        //   ),
                        // );
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
                            subtitle:
                                Text(snapshot.data!.docs[index]["description"]),
                            trailing: TextButton(
                                onPressed: () {}, child: const Text('Join')),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
          ),
          // child: ListView.builder(
          //   itemCount: clubs.length,
          //   itemBuilder: (context, index) {
          //     return InkWell(
          //       onTap: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => ClubDetails(club: clubs[index]),
          //           ),
          //         );
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(
          //             horizontal: 8.0, vertical: 4.0),
          //         child: Card(
          //           child: ListTile(
          //             leading: const CircleAvatar(
          //               child: Icon(Icons.group_sharp),
          //             ),
          //             title: Text(clubs[index].name),
          //             subtitle: Text(clubs[index].description),
          //             trailing: TextButton(
          //                 onPressed: () {}, child: const Text('Join')),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ),
      ],
    );
  }
}
