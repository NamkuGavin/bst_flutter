import 'package:bst/main.dart';
import 'package:bst/page/SocialPage.dart';
import 'package:bst/page/chat/chat_daftar.dart';
import 'package:bst/page/social/social.dart';
import 'package:bst/page/workout/workout.dart';
import 'package:bst/view/MainPage.dart';
import 'package:bst/view/notifikasi/NotifPage.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget? _child;
    if (widget.tabItem == "Page1")
      _child = MainPage();
    else if (widget.tabItem == "Page2")
      _child = NotifPage();
    else if (widget.tabItem == "Page3")
      _child = workout();
    else if (widget.tabItem == "Page4")
      _child = SocialPage();
    else if (widget.tabItem == "Page5") _child = ChatDaftar();

    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => _child!);
      },
    );
  }
}
