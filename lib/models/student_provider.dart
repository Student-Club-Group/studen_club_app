import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'student.dart';

class StudentProvider extends ChangeNotifier {
  Student? _student;
  String email = FirebaseAuth.instance.currentUser!.email!;
  final ref = FirebaseFirestore.instance.collection("users").withConverter(
        fromFirestore: Student.fromJson,
        toFirestore: (Student student, _) => student.toJson(),
      );

  addUser(Student student) async {
    if (_student == null) {
      return;
    }
    try {
      _student = student;
      await ref.add(student);
    } catch (e) {
      print(e);
    }
  }

  updateStudentClubs(String clubId) async {
    _student!.addClub(clubId);
    await ref.doc(_student!.id).update(_student!.toJson());
    notifyListeners();
  }

  removeStudentClub(String clubId) async {
    _student!.removeClub(clubId);
    await ref.doc(_student!.id).update(_student!.toJson());
    notifyListeners();
  }

  updateStudent() async {
    print('updateing');
    print(_student!.id);
    print(_student!.clubs);
    await ref.doc(_student!.id).update(_student!.toJson());
    notifyListeners();
  }

  Student? get student => _student;

  fetchStudent() async {
    final docSnap = await ref.where('email', isEqualTo: email).get();
    final student = docSnap; // Convert to City object

    _student = student.docs[0].data();
    notifyListeners();
  }
}
