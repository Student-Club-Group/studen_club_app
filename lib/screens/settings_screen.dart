import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MyAppBar(
          title: 'Settings',
        ),
        Expanded(
          child: Center(
              child: Icon(
            Icons.settings,
            size: 90,
          )),
        ),
      ],
    );
  }
}
