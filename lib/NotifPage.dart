import 'package:bst/AllNotifications.dart';
import 'package:bst/UnreadNotifications.dart';
import 'package:flutter/material.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Tampilkan Semua'),
    Tab(text: 'Belum Dibaca'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Notifikasi")),
          bottom: TabBar(
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
