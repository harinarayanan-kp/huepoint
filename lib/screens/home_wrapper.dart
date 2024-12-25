import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:huepoint/screens/market_screen.dart';
import 'package:huepoint/screens/explore_screen.dart';
import 'package:huepoint/screens/home_screen.dart';
import 'package:huepoint/screens/profile_screen.dart';
import 'package:huepoint/screens/search_screen.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Homescreen(),
    Explorescreen(),
    MarketScreen(),
    Searchscreen(),
    Profilescreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getIconAsset(int index) {
    switch (index) {
      case 0:
        return _selectedIndex == 0 ? 'assets/images/home_solid.svg' : 'assets/images/home_outline.svg';
      case 1:
        return _selectedIndex == 1 ? 'assets/images/compass_solid.svg' : 'assets/images/compass_outline.svg';
      case 2:
        return _selectedIndex == 2 ? 'assets/images/market_solid.svg' : 'assets/images/market_outline.svg';
      case 3:
        return _selectedIndex == 3 ? 'assets/images/users_solid.svg' : 'assets/images/users_outline.svg';
      case 4:
        return _selectedIndex == 4 ? 'assets/images/user_solid.svg' : 'assets/images/user_outline.svg';
      default:
        return 'assets/images/home_outline.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7ED),
        body: Center(
          child: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                selectedItemColor: Colors.black,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: List.generate(5, (index) {
                  return BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      _getIconAsset(index),
                      height: 30,
                      width: 30,
                    ),
                    label: _getLabel(index),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Explore';
      case 2:
        return 'Market';
      case 3:
        return 'Community';
      case 4:
        return 'Profile';
      default:
        return '';
    }
  }
}
