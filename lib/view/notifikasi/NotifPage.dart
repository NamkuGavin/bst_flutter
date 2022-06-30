import 'package:bst/view/notifikasi/fragment/AllNotifications.dart';
import 'package:flutter/material.dart';

import '../../header/HeaderNavigation.dart';
import 'fragment/UnreadNotifications.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  final List<Widget> myTabs = <Widget>[
    Tab(text: 'Tampilkan Semua'),
    Tab(text: 'Belum Dibaca'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: HeaderNavigation(title: "Notifikasi"),
          bottom: TabBar(
            indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
            indicatorColor: Colors.green,
            labelColor: Colors.black,
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AllNotifications(),
            UnreadNotifications(),
          ],
        ),
      ),
    );
  }
}
