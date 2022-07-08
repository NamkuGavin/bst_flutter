import 'dart:convert';

import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/model/CategoryModel.dart';
import 'package:bst/model/FavoriteModel.dart';
import 'package:bst/model/TypeModel.dart';
import 'package:bst/page/list_makanan.dart';
import 'package:bst/page/social/social.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../reuse/MyRadioListTile.dart';

class SocialPage extends StatefulWidget {
  SocialPage({Key? key}) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  Widget mainPage() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => social()));
          });
        },
        child: Text('Social'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: HeaderNavigation(
            title: '',
          ),
        ),
        body: mainPage());
  }
}
