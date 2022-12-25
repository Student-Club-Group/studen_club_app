import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MyAppBar(
          title: 'TimeLine',
        ),
        Expanded(
          child: Center(
              child: Icon(
            Icons.home,
            size: 90,
          )),
        ),
      ],
    );
  }
}
