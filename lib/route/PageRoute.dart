import 'package:bst/view/fragment/AllNotifications.dart';
import 'package:bst/view/NotifPage.dart';
import 'package:flutter/material.dart';

class PageRouteView extends StatefulWidget {
  const PageRouteView({Key? key}) : super(key: key);

  @override
  _PageRouteViewState createState() => _PageRouteViewState();
}

class _PageRouteViewState extends State<PageRouteView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    NotifPage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/catalog.png',width: 30,height: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/catalog.png',width: 30,height: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/catalog.png',width: 30,height: 30,),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
