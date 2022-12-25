import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});
  static const routeName = '/clubsScreen';

  @override
  Widget build(BuildContext context) {
    // final student = ModalRoute.of(context)!.settings.arguments as Student;
    return Column(
      children: [
        const MyAppBar(title: 'Clubs'),
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return const Card(
                child: ListTile(
                  title: Text('Club name'),
                  subtitle: Text('Club description and Info'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
