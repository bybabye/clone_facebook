import 'package:clone_facebook/day1/stf/home.dart';
import 'package:clone_facebook/day1/stf/menu.dart';
import 'package:clone_facebook/provider/auth_provider.dart';
import 'package:clone_facebook/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthencationProvider _auth;
  int _selectedIndex = 0;

  List<Widget> items = [
    const Home(),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.black,
    ),
    const Menu(),
  ];

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthencationProvider>(context);

    return Scaffold(
      body: items[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.firstMainColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
