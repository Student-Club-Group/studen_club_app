import 'package:flutter/material.dart';

import 'clubs_screen.dart';
import 'profile.dart';
import 'settings_screen.dart';
import 'timeline_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO : make it more readable
  int _selectedIndex = 0;
  static final List<Widget> _pages = [
    TimeLineScreen(),
    const ClubsScreen(),
    const Profile(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    // final student = ModalRoute.of(context)!.settings.arguments as Student;
    return SafeArea(
      child: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.groups_rounded),
              label: 'Clubs',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
