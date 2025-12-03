import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../common/gradiant_background.dart';
import '../home/home_view.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  int _selectedIndex = 0;

  final children = [HomeView(), Placeholder(), Placeholder(), Placeholder()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customGradientBackgroundWithSvg(child: children[_selectedIndex]),

      bottomNavigationBar: Container(
        color: const Color(0xff7F4DA3),
        padding: EdgeInsets.all(defaultPadding),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          activeColor: customDarkPurple,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[100]!,
          color: customWhite,
          tabs: [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.explore, text: 'Explore'),
            GButton(icon: Icons.menu_book_sharp, text: 'Journal'),
            GButton(icon: Icons.settings, text: 'Settings'),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
