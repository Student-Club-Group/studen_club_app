import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_club/models/post_state.dart';

import 'package:student_club/models/student_provider.dart';
import 'package:student_club/widgets/my_app_bar.dart';
import 'package:student_club/widgets/post_widget.dart';

import '../models/club.dart';
import '../models/post.dart';

class ClubDetails extends StatefulWidget {
  final Club club;

  const ClubDetails({Key? key, required this.club}) : super(key: key);

  @override
  State<ClubDetails> createState() => _ClubDetailsState();
}

class _ClubDetailsState extends State<ClubDetails> {
  bool isOwner = false;
  bool isMember = false;
  final postsRef = FirebaseFirestore.instance.collection('posts').withConverter(
        fromFirestore: Post.fromJson,
        toFirestore: (Post post, _) => post.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    final clubRef =
        FirebaseFirestore.instance.collection('clubs').doc(widget.club.id);
    String joinLeaveOrOwner = 'Request Join';
    Color textColor = Colors.blueGrey;

    StudentProvider studentProvider = Provider.of<StudentProvider>(context);
    if (studentProvider.student == null) {
      studentProvider.fetchStudent();
    } else {
      if (widget.club.owners!
          .contains(studentProvider.student!.id.toString())) {
        setState(() {
          joinLeaveOrOwner = 'Owner';
          textColor = Colors.yellow.shade700;
          isOwner = true;
        });
      } else if (widget.club.members!.contains(studentProvider.student!.id)) {
        setState(() {
          joinLeaveOrOwner = 'Leave';
          textColor = Colors.red.shade400;
          isMember = true;
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(
                title: 'Details',
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 50, child: Text('No Image')),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.club.name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          '1/1/2023',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () async {
                          if (!isMember && !isOwner) {
                            widget.club.addMember(studentProvider.student!.id!);
                            await clubRef.update(widget.club.toJson());
                            await studentProvider
                                .updateStudentClubs(widget.club.id!);
                            setState(() {
                              isMember = true;
                            });
                          } else if (isMember) {
                            widget.club
                                .removeMember(studentProvider.student!.id!);
                            await clubRef.update(widget.club.toJson());
                            await studentProvider
                                .removeStudentClub(widget.club.id!);

                            setState(() {
                              isMember = false;
                            });
                          }
                        },
                        child: Text(
                          joinLeaveOrOwner,
                          style: TextStyle(color: textColor),
                        )),
                  ],
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Posts',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      StreamBuilder(
                        stream: clubRef.snapshots(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> posts =
                                List<String>.from(snapshot.data!.get("posts"));

                            return Text(posts.length.toString());
                          } else {
                            return const Text('Loading');
                          }
                        }),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        'Members',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        widget.club.members!.length.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text('Who Are We :',
                      style: Theme.of(context).textTheme.headline2),
                  collapsed: Text(
                    widget.club.description,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    widget.club.description,
                    softWrap: true,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text('Posts : ',
                      style: Theme.of(context).textTheme.headline2),
                  collapsed: Container(),
                  expanded: !isOwner && !isMember
                      ? const Center(
                          child: Text('Only for Members'),
                        )
                      : SizedBox(
                          height: 400,
                          child: StreamBuilder(
                            stream: postsRef.snapshots(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                var posts = snapshot.data!.docs
                                    .where((element) =>
                                        element.data().clubId == widget.club.id)
                                    .toList();

                                return ListView.builder(
                                  itemCount: posts.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: PostWidget(
                                        clubName: widget.club.name,
                                        announcement:
                                            posts[index].data().announcement,
                                        author: posts[index].data().authorName,
                                        dateTime: posts[index].data().dateTime!,
                                        postState: PostState.neither,
                                        title: posts[index].data().title,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: isOwner
            ? FloatingActionButton(
                onPressed: () async {
                  final List<String>? result = await createPost(context);
                  if (result != null &&
                      result.isNotEmpty &&
                      studentProvider.student != null) {
                    Post newPost = Post(
                      clubId: widget.club.id!,
                      clubName: widget.club.name,
                      authorName: studentProvider.student!.name,
                      authorId: studentProvider.student!.id!,
                      title: result[0],
                      announcement: result[1],
                      dateTime: DateTime.now(),
                    );
                    try {
                      var result = await postsRef.add(newPost);
                      widget.club.addPost(result.id);

                      await clubRef.update(widget.club.toJson());
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: const Icon(Icons.add),
              )
            : Container(),
      ),
    );
  }

  Future<List<String>?> createPost(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'New Post',
            style: Theme.of(context).textTheme.headline2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              TextField(
                controller: contentController,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(hintText: 'Content'),
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.create),
              label: const Text('Create'),
              onPressed: () {
                if (contentController.text.isNotEmpty &&
                    titleController.text.isNotEmpty) {
                  List<String> result = [
                    titleController.text,
                    contentController.text
                  ];
                  Navigator.of(context).pop(result);
                }
              },
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      },
    );
  }
}
