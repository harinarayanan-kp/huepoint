import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huepoint/components/post_card.dart';
import 'package:huepoint/components/profile_card.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7ED),
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/images/huepoint.svg',
          ),
        ),
        title: Text(
          'huepoint',
          style: GoogleFonts.righteous(
            fontSize: 24,
            color: Colors.black, // Ensure the text color contrasts with the background
          ),
          overflow: TextOverflow.ellipsis, // Handle text overflow
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/notification-new.svg',
              height: 30,
              width: 30,
            ), // Notification icon
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/comment-typing.svg',
              height: 30,
              width: 30,
            ), // Inbox icon
            onPressed: () {
              Navigator.pushNamed(context, '/inbox');
            },
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          children: [
            SizedBox(height: 20),
            Postcard(),
            Profilecard(),
          ],
        ),
      ),
    );
  }
}
