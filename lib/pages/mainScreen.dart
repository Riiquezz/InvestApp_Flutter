import 'package:InvestFlutter/pages/home_page.dart';
import 'package:InvestFlutter/pages/mobx.dart';
import 'package:InvestFlutter/pages/platformChannel.dart';
import 'package:InvestFlutter/utils/constants.dart';
import 'package:InvestFlutter/widgets/custom_topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'market_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PlatformChannel(),
    MobxTest(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: SECONDARY_DARK,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Feather.home, color: Colors.grey),
            title: Text('HOME'),
            activeIcon: Icon(Feather.home, color: Colors.purple),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome.arrow_circle_right,
              color: Colors.grey,
            ),
            title: Text('Platform Channel'),
            activeIcon:
                Icon(FontAwesome.arrow_circle_right, color: Colors.purple),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvilIcons.bell,
              color: Colors.grey,
              size: 36,
            ),
            title: Text('MOBX'),
            activeIcon: Icon(
              EvilIcons.bell,
              color: Colors.purple,
              size: 36,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
