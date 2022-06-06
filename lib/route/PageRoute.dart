import 'package:bst/view/MainPage.dart';

import 'package:bst/view/notifikasi/NotifPage.dart';
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
  List<Widget> _widgetOptions = <Widget>[
    Text('Index 1: Article', style: optionStyle,),
    NotifPage(),
    Text(
      'Index 3: Sports',
      style: optionStyle,
    ),
    MainPage(),
    Text(
      'Index 5: Meteran',
      style: optionStyle,
    ),
    Text(
      'Index 6: Catalog',
      style: optionStyle,
    ),
    Text(
      'Index 7: Help',
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
            icon: Image.asset('assets/images/article.png',width: 24,height: 24,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/chat.png',width: 24,height: 24,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/barbel.png',width: 24,height: 24,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/mainicon.png',width: 27,height: 38,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/meteran.png',width: 24,height: 24,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/catalog.png',width: 24,height: 24,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/help.png',width: 24,height: 24,),
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