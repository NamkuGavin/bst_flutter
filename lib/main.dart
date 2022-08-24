import 'dart:convert';

import 'package:bst/firebase_config.dart';
import 'package:bst/notification_detail.dart';
import 'package:bst/page/forgotPassword.dart';
import 'package:bst/page/intro.dart';
import 'package:bst/page/login.dart';
import 'package:bst/page/onboarding.dart';
import 'package:bst/page/register_done.dart';
import 'package:bst/page/register_stepper.dart';
import 'package:bst/view/notifikasi/NotifPage.dart';
import 'package:bst/route/PageRoute.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCr49htP1iG3QG1RqFdjeXI7rs0NuhCBO0",
          appId: "1:122036145228:android:1bd6e30d10f891639778e9",
          messagingSenderId: "122036145228",
          projectId: "bst-notification"));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

int idUser = -1;
String name = "Unknown";

String encoded1 = "";
List postListdb = [];
Future<Null> fetchPost(int id) async {
  Map<String, dynamic> socbody = {
    "apikey": "bstapp2022",
    "action": "check_post",
    "UserId": id,
  };
  encoded1 = base64.encode(utf8.encode(json.encode(socbody)));
  final dbsoc = await http.post(
      Uri.parse('https://www.zeroone.co.id/bst/social.php'),
      body: {"data": encoded1});
  if (dbsoc.statusCode == 200) {
    Map<String, dynamic> dbsocresponse = json.decode(dbsoc.body);
    // print(dbsocresponse);
    postListdb = dbsocresponse['Data'];

    // workout = jsonDecode(dbwo.body) as List;
    print(postListdb);
  } else {
    throw Exception('Failed to load social post');
  }
}

Future<void> postfrDB() async {
  await fetchPost(1);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Intro(),
      routes: {
        '/intro': (context) => Intro(),
        '/onboarding': (context) => OnboardingPage(),
        '/register': (context) => RegisterPage(),
        '/registersuccess': (context) => RegisterSuccessPage(),
        '/login': (context) => LoginPage(),
        '/forgotpass': (context) => ForgotPassPage(),
        '/pagerouteview': (context) => PageRouteView(),
        '/message': (context) => MessageView(),
      },
    );
  }
}
