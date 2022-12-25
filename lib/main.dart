import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/student_provider.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => StudentProvider()),
  ], child: const MyApp()));
}

//this is magdi from the other side
//this is magdi again
//third comment to pr 
// this is from joe

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Student Club',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 18.0),
          headline2: TextStyle(fontSize: 18.0),
          headline3: TextStyle(fontSize: 15.0),
          headline6: TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(fontSize: 13.0),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        // registerScreen: (context) => const RegisterScreen(),
        // ClubsScreen.routeName :(context) => const ClubsScreen(),
      },
      // home: const AuthScreen(),
    );
  }
}
