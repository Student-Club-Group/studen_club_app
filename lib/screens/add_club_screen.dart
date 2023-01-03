import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_club/models/club.dart';
import 'package:student_club/models/student_provider.dart';

import '../widgets/my_app_bar.dart';

enum ImageStatus {
  uploading,
  uploaded,
  notSelected,
  selected,
  failed,
}

class AddClubScreen extends StatefulWidget {
  final CollectionReference<Club> clubRef;
  const AddClubScreen({super.key, required this.clubRef});

  static List<DropdownMenuItem> catagories = const [
    DropdownMenuItem(
      value: 'Academic',
      child: Text('Academic'),
    ),
    DropdownMenuItem(
      value: 'Political',
      child: Text('Political'),
    ),
    DropdownMenuItem(
      value: 'Media',
      child: Text('Media'),
    ),
    DropdownMenuItem(
      value: 'TheatreAndArt',
      child: Text('Theatre And Art'),
    ),
    DropdownMenuItem(
      value: 'ReligiousAndCultural',
      child: Text('Religious And Cultural'),
    ),
    DropdownMenuItem(
      value: 'Sports',
      child: Text('Sports'),
    ),
    DropdownMenuItem(
      value: 'Tech',
      child: Text('Tech'),
    ),
  ];

  @override
  State<AddClubScreen> createState() => _AddClubScreenState();
}

class _AddClubScreenState extends State<AddClubScreen> {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _clubImage;
  ImageStatus imageStatus = ImageStatus.notSelected;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);

      setState(() {
        _clubImage = img;
        imageStatus = ImageStatus.selected;
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  uploadImage(String fileName) async {
    setState(() {
      imageStatus = ImageStatus.uploading;
    });

    if (_clubImage != null) {
      print('entered');
      print(fileName);
      try {
        await storage.ref().child('clubs/$fileName').putFile(_clubImage!,
            firebase_storage.SettableMetadata(contentType: "image/png"));
        setState(() {
          imageStatus = ImageStatus.uploaded;
        });
      } catch (e) {
        setState(() {
          imageStatus = ImageStatus.failed;
        });
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider = Provider.of<StudentProvider>(context);
    if (studentProvider.student == null) {
      studentProvider.fetchStudent();
    }
    TextEditingController clubNameController = TextEditingController();
    TextEditingController clubDescriptionController = TextEditingController();
    String clubType = '';

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar(
                title: 'Create a New Club',
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Center(
                    child: _clubImage == null
                        ? Text(
                            'No Image selected',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.black),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(_clubImage!),
                            radius: 200.0,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image),
                    Text(
                      'Pick an Image',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.blueGrey.shade400),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: clubNameController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter The Club Name',
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      DropdownButtonFormField(
                        hint: const Text('Select Category'),
                        items: AddClubScreen.catagories,
                        onChanged: (value) {
                          clubType = value;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: clubDescriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Description',
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      TextButton(
                        onPressed: () async {
                          if (clubNameController.text.isNotEmpty &&
                              clubDescriptionController.text.isNotEmpty) {
                            Club newClub = Club(
                              name: clubNameController.text,
                              description: clubDescriptionController.text,
                              type: ClubType.values.firstWhere((type) =>
                                  type.name.toString() ==
                                  clubType.toLowerCase()),
                              owners: [studentProvider.student!.id!],
                              members: [],
                              posts: [],
                            );

                            try {
                              var result = await widget.clubRef.add(newClub);
                              studentProvider.student!.addClub(result.id);
                              await studentProvider.updateStudent();
                              uploadImage(result.id);
                            } catch (e) {
                              print(e);
                            }
                          }
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            imageStatus == ImageStatus.uploading
                                ? const Icon(Icons.circle_outlined)
                                : const Icon(Icons.create),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Create Club',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.blueGrey.shade400),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
