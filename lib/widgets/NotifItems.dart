import 'package:bst/model/NotifModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifItems extends StatelessWidget {
  final NotifModel model;

  const NotifItems({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (model.getType) {
          case 0:
            print('kasdsdwqr');
            break;
          case 1:
            print('1');
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 14),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.getTime,
                  style: GoogleFonts.openSans(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  model.getName,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: model.getStatus ? Colors.green : Colors.grey,
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              model.getdesc,
              style: GoogleFonts.openSans(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 1,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
