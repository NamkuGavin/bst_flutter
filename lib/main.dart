import 'package:bst/firebase_config.dart';
import 'package:bst/notification_detail.dart';
import 'package:bst/view/notifikasi/NotifPage.dart';
import 'package:bst/route/PageRoute.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
      routes: {
        '/': (context) => PageRouteView(),
        '/message': (context) => MessageView(),
      },
    );
  }
}
