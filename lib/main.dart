import 'package:flutter/material.dart';
import 'package:huepoint/screens/analytics_screen.dart';
import 'package:huepoint/screens/market_screen.dart';
import 'package:huepoint/screens/home_wrapper.dart';
import 'package:huepoint/screens/inbox_screen.dart';
import 'package:huepoint/screens/login_screen.dart';
import 'package:huepoint/screens/notification_screen.dart';

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
              elevation: 2, // Apply elevation for shadow effect
              shadowColor: const Color(0xFF000000),
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SafeArea(child: LoginScreen()),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const HomeWrapper(),
          '/createpost': (BuildContext context) => const MarketScreen(),
          '/inbox': (BuildContext context) => const Inboxscreen(),
          '/notifications': (BuildContext context) => const Notificationscreen(),
          '/analytics': (BuildContext context) => const Analyticsscreen(),
        });
  }
}
