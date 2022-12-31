import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/my_app_bar.dart';

class AddClubScreen extends StatefulWidget {
  const AddClubScreen({super.key});

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
      value: 'Theatre And Art',
      child: Text('Theatre And Art'),
    ),
    DropdownMenuItem(
      value: 'Religious And Cultural',
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
  File? _clubImage;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _clubImage = img;
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            )),
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
                        onChanged: (value) {},
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
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
                        // style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(
                        //         Colors.blueGrey.shade600)),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.create),
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
