import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Welcome to huePoint',
      'description': 'Discover, create, and connect with artists from around the world.',
      'image': 'assets/images/welcome.svg',
    },
    {
      'title': 'Showcase Your Art',
      'description': 'Share your artwork with a global community of artists and enthusiasts.',
      'image': 'assets/images/showcase.svg',
    },
    {
      'title': 'Sell Your Creations',
      'description': 'List your artwork for sale, whether digital or physical, and reach a wider audience.',
      'image': 'assets/images/sell.svg',
    },
    {
      'title': 'Collaborate with Others',
      'description': 'Join groups, participate in challenges, and work on collaborative projects with fellow artists.',
      'image': 'assets/images/collaborate.svg',
    },
    {
      'title': 'Stay Connected',
      'description':
          'Engage with the community, follow your favorite artists, and stay updated with the latest trends.',
      'image': 'assets/images/connect.svg',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onDonePress() {
    Navigator.pushReplacementNamed(context, '/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7ED),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _slides.map((slide) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                SvgPicture.asset(
                  slide['image']!,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  slide['title']!,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  slide['description']!,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
      bottomSheet: _currentPage == _slides.length - 1
          ? Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 246, 65),
              ),
              padding: const EdgeInsets.all(25),
              child: TextButton(
                onPressed: _onDonePress,
                child: const Text('Get Started'),
              ),
            )
          : Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 246, 65),
              ),
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage == 0
                      ? const SizedBox(
                          width: 0,
                        )
                      : IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          },
                        ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
