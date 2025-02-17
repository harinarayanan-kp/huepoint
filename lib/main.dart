import 'package:flutter/material.dart';
import 'package:huepoint/screens/express_screen.dart';
import 'package:huepoint/screens/feed_screen.dart';
import 'package:huepoint/screens/market_screen.dart';
import 'package:huepoint/screens/home_wrapper.dart';
import 'package:huepoint/screens/inbox_screen.dart';
import 'package:huepoint/screens/login_screen.dart';
import 'package:huepoint/screens/notification_screen.dart';
import 'package:huepoint/screens/onboarding_screen.dart';
import 'package:huepoint/screens/post_screen.dart';
import 'package:huepoint/screens/profile_info_screen.dart';
import 'package:huepoint/screens/signup_screen.dart';
import 'package:huepoint/services/auth_service.dart';

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
      home: const InitialScreen(),
      routes: <String, WidgetBuilder>{
        '/signup': (context) => SignupScreen(),
        '/login': (context) => LoginScreen(),
        '/profile-info': (context) => ProfileInfoScreen(),
        '/post': (context) => CreatePostScreen(),
        '/feed': (context) => FeedScreen(),
        '/home': (context) => const HomeWrapper(),
        '/create': (context) => const CreateScreen(),
        '/read': (context) => const ReadScreen(),
        '/update': (context) => const UpdateScreen(),
        '/delete': (context) => const DeleteScreen(),
        '/createpost': (context) => const MarketScreen(),
        '/inbox': (context) => const InboxScreen(),
        '/notifications': (context) => const NotificationScreen(),
      },
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    return FutureBuilder(
      future: authService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return snapshot.data != null ? const HomeWrapper() : const OnboardingScreen();
        }
      },
    );
  }
}
