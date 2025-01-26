import 'package:flutter/material.dart';
import 'skillpage.dart';
import 'explorepage.dart';
import 'help_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  int _creditPoints = 0; // Initial credit points

  void _updateCreditPoints(int points) {
    setState(() {
      _creditPoints += points;
    });
  }

  static List<Widget> _pages(int creditPoints, Function(int) updateCreditPoints) => <Widget>[
    SkillPage(creditPoints: creditPoints, updateCreditPoints: updateCreditPoints),
    ExplorePage(creditPoints: creditPoints, updateCreditPoints: updateCreditPoints),
    HelpPage(creditPoints: creditPoints, updateCreditPoints: updateCreditPoints),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages(_creditPoints, _updateCreditPoints)[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
