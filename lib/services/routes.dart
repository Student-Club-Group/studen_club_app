import 'package:flutter/material.dart';

import '../models/student.dart';
import '../screens/menu.dart';

class MyRoutes {
  Route createSlidingMenuRoute() {
    return PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, __) => SlideMenu(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
