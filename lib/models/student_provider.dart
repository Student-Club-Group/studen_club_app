import 'package:flutter/material.dart';
import 'student.dart';

class StudentProvider extends ChangeNotifier {
  Student? _student;

  updateStudent(Student student) {
    _student = student;
  }

  Student? get student => _student;
}
