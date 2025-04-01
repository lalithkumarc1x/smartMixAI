import 'package:flutter/material.dart';
import 'package:sample/screens/auth/chat.dart';
import 'package:sample/screens/auth/suggestion.dart';
import 'package:sample/screens/auths/profile.dart';
import 'package:sample/screens/favorite/view.dart';
import 'package:sample/screens/home/view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          HomePage(),
          ChatScreen(),
          SuggestionScreen(),
          FavoritesScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getBottomNavigation('assets/btm-1.png', 0),
              _getBottomNavigation('assets/Group-321.png', 1),
              _getBottomNavigation('assets/btm-3.png', 2),
              _getBottomNavigation('assets/btm-4.png', 3),
              _getBottomNavigation('assets/btm-5.png', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBottomNavigation(String img, int index) {
    return InkWell(
      onTap: () {
        _onItemTapped(index);
      },
      child: Image.asset(img, height: 20, width: 20),
    );
  }
}
