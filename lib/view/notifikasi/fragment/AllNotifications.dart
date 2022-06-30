import 'package:bst/model/NotifModel.dart';
import 'package:bst/notification_detail.dart';
import 'package:bst/notification_list.dart';
import 'package:bst/reuse/NotifItems.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  _AllNotificationsState createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade100,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            child: Column(
              children: [
                Text(
                  'Hari ini Kamu belum memasukkan informasi ukuran dan berat badan. ',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'UPDATE MEASUREMENT',
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          MessageList(),
        ],
      ),
    );
  }
}
