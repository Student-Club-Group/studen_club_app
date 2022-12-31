import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/student.dart';

class FireStoreCloud {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  addUser(Student student) async {
    try {
      final CollectionReference usersRef = instance.collection('users');
      await usersRef.add(student.toJson());
    } catch (e) {
      print(e);
    }
  }
}
