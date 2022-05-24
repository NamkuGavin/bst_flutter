import 'package:bst/model/NotifModel.dart';
import 'package:bst/widgets/NotifItems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AllNotifications extends StatefulWidget {
  const AllNotifications({Key? key}) : super(key: key);

  @override
  _AllNotificationsState createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  List<NotifModel> items = [
    NotifModel(
        'Lindsey Vaccaro',
        '05:45',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.',
        true,
        1),
    NotifModel(
        'Lindsey Vaccaro',
        '05:45',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.',
        false,
        1),
    NotifModel(
        'Lindsey Vaccaro',
        '05:45',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.',
        true,
        0),
    NotifModel(
        'Lindsey Vaccaro',
        '05:45',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.',
        true,
        0),
    NotifModel(
        'Lindsey Vaccaro',
        '05:45',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.',
        true,
        1),
    NotifModel(
        'Lindsey Vaccaro',
        '05:45',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam cursus sed sodales.',
        true,
        0)
  ];

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
                      fontWeight: FontWeight.w600, fontSize: 12,),
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
                  return NotifItems(model: items[index]);
                }),
          )
        ],
      ),
    );
  }
}
