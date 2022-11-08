import 'package:flutter/material.dart';
import 'package:student_club/models/student.dart';

import '../services/routes.dart';

class ClubsScreen extends StatelessWidget {
  final Student student;
  const ClubsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MyRoutes().createSlidingMenuRoute(student));
                        },
                        icon: Icon(Icons.menu)),
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      'Clubs',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
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
        ),
      ),
    );
  }
}
