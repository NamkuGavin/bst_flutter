import 'dart:convert';

import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/main.dart';
import 'package:bst/page/social/components/socialPost.dart';
import 'package:bst/page/social/components/userPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class social extends StatefulWidget {
  const social({Key? key}) : super(key: key);

  @override
  _socialState createState() => _socialState();
}

class _socialState extends State<social> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFECECEC).withOpacity(1),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: HeaderNavigation(
            title: '',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            userPost(),
            Padding(padding: const EdgeInsets.all(15), child: socialPost())
          ])),
        ));
  }
}
