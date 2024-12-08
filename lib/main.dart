import 'package:flutter/material.dart';
import 'package:huepoint/screens/analyticsScreen.dart';
import 'package:huepoint/screens/createPostScreen.dart';
import 'package:huepoint/screens/homeScreen.dart';
import 'package:huepoint/screens/inboxScreen.dart';
import 'package:huepoint/screens/notificationScreen.dart';
import 'package:huepoint/screens/profileScreen.dart';
import 'package:huepoint/screens/settingsScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'huePoint',
        theme: ThemeData(
          fontFamily: 'Poppins',
          bottomAppBarTheme: const BottomAppBarTheme(
            elevation: 0,
            color: Colors.transparent,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // No radius, sharp corners
              ),
              elevation: 2, // Apply elevation for shadow effect
              shadowColor: const Color(0xFF000000),
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SafeArea(child: Homescreen()),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const Homescreen(),
          '/profile': (BuildContext context) => const Profilescreen(),
          '/settings': (BuildContext context) => const Settingsscreen(),
          '/createpost': (BuildContext context) => const Createpostscreen(),
          '/inbox': (BuildContext context) => const Inboxscreen(),
          '/notifications': (BuildContext context) => const Notificationscreen(),
          '/analytics': (BuildContext context) => const Analyticsscreen(),
        });
  }
}
