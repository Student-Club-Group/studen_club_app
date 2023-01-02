import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'student.dart';

class StudentProvider extends ChangeNotifier {
  Student? _student;

  updateStudent(Student student) {
    _student = student;
  }

  Student? get student => _student;

  fetchStudent() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    final ref = FirebaseFirestore.instance.collection("users").withConverter(
          fromFirestore: Student.fromJson,
          toFirestore: (Student student, _) => student.toJson(),
        );
    final docSnap = await ref.where('email', isEqualTo: email).get();
    final student = docSnap; // Convert to City object
    print(email);
    print(student.docs[0].data());
    // TODO: add loading
    _student = student.docs[0].data();
    notifyListeners();

    // QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
    //     .instance
    //     .collection('users')
    //     .where("email", isEqualTo: email)
    //     .get();
    // print(snapshot);

    // if (snapshot.size > 0) {
    //   _student = Student.fromJson(snapshot.docs[0], SnapshotOptions());
    // }
  }

  getStudentId() {}
}
