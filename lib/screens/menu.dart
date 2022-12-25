//TODO : To be removed

import 'package:flutter/material.dart';

import 'profile.dart';

class SlideMenu extends StatelessWidget {
  const SlideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
            Container(
              width: 0.75 * size.width,
              height: size.height,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/cooperation2.png',
                          height: 60,
                        ),
                        const Spacer(),
                        Text(
                          'Student Club',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Divider(),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).pushReplacement(PageRouteBuilder(
                        //   pageBuilder: (context, _, __) =>
                        //       ClubsScreen(),
                        // ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.home,
                            size: 50,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Clubs',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (context, _, __) => Profile(),
                        ));
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 50,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Profile',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.settings,
                            size: 50,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Settings',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
