import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resultnomad/constants/sizes.dart';
import 'package:resultnomad/features/main_navigation/views/widgets/nav_tab.dart';
import 'package:resultnomad/features/posts/views/home_screen.dart';
import 'package:resultnomad/features/posts/views/write_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    const WriteScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: screens[0],
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.pen,
                selectedIcon: FontAwesomeIcons.pencil,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
