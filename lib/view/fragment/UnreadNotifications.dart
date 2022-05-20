import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/NotifModel.dart';
import '../../widgets/NotifItems.dart';

class UnreadNotifications extends StatefulWidget {
  const UnreadNotifications({Key? key}) : super(key: key);

  @override
  _UnreadNotificationsState createState() => _UnreadNotificationsState();
}

class _UnreadNotificationsState extends State<UnreadNotifications> {
  List<NotifModel> items = [
    NotifModel('Lindsey Vaccaro', '05:45', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.', false, 1),
    NotifModel('Lindsey Vaccaro', '05:45', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.', true, 0),
    NotifModel('Lindsey Vaccaro', '05:45', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.', false, 1),
    NotifModel('Lindsey Vaccaro', '05:45', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.', false, 0),
    NotifModel('Lindsey Vaccaro', '05:45', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.', true, 1),
    NotifModel('Lindsey Vaccaro', '05:45', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.', false, 0)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 14,
          ),
          Container(
            color: Color(0xF6F6F6),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Text(
                  'Hari ini Kamu belum memasukkan informasi ukuran dan berat badan. ',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 12),
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
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return NotifItems(model: items[index],);
                } ),
          )
        ],
      ),
    );
  }
}
