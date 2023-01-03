import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_club/models/student_provider.dart';

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
    final StudentProvider studentProvider =
        Provider.of<StudentProvider>(context);

    if (studentProvider.student == null) {
      studentProvider.fetchStudent();
    }

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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        //   child: TextField(
        //     onChanged: (value) {},
        //     controller: editingController,
        //     decoration: const InputDecoration(
        //       labelText: "Search",
        //       hintText: "Search",
        //       prefixIcon: Icon(Icons.search),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(30.0),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        StreamBuilder(
          stream: clubsRef.snapshots(),
          builder: ((context, snapshot) {
            if (studentProvider.student == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Widget trailing = TextButton(
                        onPressed: () async {
                          Club club = snapshot.data!.docs[index].data();
                          club.addMember(studentProvider.student!.id!);
                          await clubsRef.doc(club.id).update(club.toJson());
                          await studentProvider.updateStudentClubs(club.id!);
                        },
                        child: const Text('Join'),
                      );
                      bool isOwner = snapshot.data!.docs[index]
                          .data()
                          .isOwner(studentProvider.student!.id!);
                      bool isMember = snapshot.data!.docs[index]
                          .data()
                          .isMember(studentProvider.student!.id!);

                      if (isOwner) {
                        trailing = Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            'Owner',
                            style: TextStyle(color: Colors.yellow.shade800),
                          ),
                        );
                      } else if (isMember) {
                        trailing = TextButton(
                          onPressed: () async {
                            Club club = snapshot.data!.docs[index].data();
                            club.removeMember(studentProvider.student!.id!);
                            await clubsRef.doc(club.id).update(club.toJson());
                            await studentProvider.removeStudentClub(club.id!);
                          },
                          child: const Text(
                            'Leave',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }

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
                              subtitle: const Text('Establish Date : 3/1/2023'),
                              trailing: trailing,
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
            }
          }),
        ),
      ],
    );
  }
}
