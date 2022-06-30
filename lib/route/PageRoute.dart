import 'package:bst/notification_detail.dart';
import 'package:bst/view/MainPage.dart';
import 'package:bst/view/chat/chat_daftar.dart';

import 'package:bst/view/notifikasi/NotifPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    Text(
      'Index 2: Measurement',
      style: optionStyle,
    ),
    Text(
      'Index 3: Sport',
      style: optionStyle,
    ),
    NotifPage(),
    ChatDaftar(),
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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Image.asset(
                  'assets/images/mainicon.png',
                  width: 27,
                  height: 38,
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
                  width: 24,
                  height: 24,
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
                  width: 24,
                  height: 24,
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
                  width: 24,
                  height: 24,
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
                  width: 24,
                  height: 24,
                ),
                Text("Chat",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              ],
            ),
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
