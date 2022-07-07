import 'dart:convert';

import 'package:bst/main.dart';
import 'package:bst/notification_detail.dart';
import 'package:bst/page/chat/chat_daftar.dart';
import 'package:bst/page/social/social.dart';
import 'package:bst/page/workout/workout.dart';
import 'package:bst/route/tab_navigator.dart';
import 'package:bst/view/MainPage.dart';

import 'package:bst/view/notifikasi/NotifPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class PageRouteView extends StatefulWidget {
  const PageRouteView({Key? key}) : super(key: key);

  @override
  _PageRouteViewState createState() => _PageRouteViewState();
}

class _PageRouteViewState extends State<PageRouteView> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void getToken() async {
    final token =
        _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  @override
  void initState() {
    super.initState();
    getToken();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(
          context,
          '/message',
          arguments: MessageArguments(message, true),
        );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        '/message',
        arguments: MessageArguments(message, true),
      );
    });
  }

  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // List<Widget> _widgetOptions = <Widget>[
  //   MainPage(),
  //   NotifPage(),
  //   workout(),
  //   social(),
  //   ChatDaftar(),
  // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    postfrDB();
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator("Page1"),
          _buildOffstageNavigator("Page2"),
          _buildOffstageNavigator("Page3"),
          _buildOffstageNavigator("Page4"),
          _buildOffstageNavigator("Page5"),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/mainicon.png',
                    height: 30,
                  ),
                  Text("Dashboard",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/meteran.png',
                    height: 30,
                  ),
                  Text("Measurement",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/barbel.png',
                    height: 30,
                  ),
                  Text("Workout",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/article.png',
                    height: 30,
                  ),
                  Text("Social Page",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Image.asset(
                    'assets/images/chat.png',
                    height: 30,
                  ),
                  Text("Chat",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
              label: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: _widgetOptions.elementAt(_selectedIndex),
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     showSelectedLabels: false,
    //     showUnselectedLabels: false,
    //     items: <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Column(
    //           children: [
    //             Image.asset(
    //               'assets/images/mainicon.png',
    //               width: 27,
    //               height: 38,
    //             ),
    //             Text("Dashboard",
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
    //           ],
    //         ),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Column(
    //           children: [
    //             Image.asset(
    //               'assets/images/meteran.png',
    //               width: 24,
    //               height: 24,
    //             ),
    //             Text("Measurement",
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
    //           ],
    //         ),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Column(
    //           children: [
    //             Image.asset(
    //               'assets/images/barbel.png',
    //               width: 24,
    //               height: 24,
    //             ),
    //             Text("Workout",
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
    //           ],
    //         ),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Column(
    //           children: [
    //             Image.asset(
    //               'assets/images/article.png',
    //               width: 24,
    //               height: 24,
    //             ),
    //             Text("Social Page",
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
    //           ],
    //         ),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Column(
    //           children: [
    //             Image.asset(
    //               'assets/images/chat.png',
    //               width: 24,
    //               height: 24,
    //             ),
    //             Text("Chat",
    //                 style:
    //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
    //           ],
    //         ),
    //         label: '',
    //       ),
    //     ],
    //     currentIndex: _selectedIndex,
    //     // selectedItemColor: Colors.amber[800],
    //     onTap: _onItemTapped,
    //   ),
    // );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
