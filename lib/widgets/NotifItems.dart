import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifItems extends StatelessWidget {
  final String name;
  final String time;
  final String desc;

  const NotifItems({Key? key, required this.name, required this.time, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 14),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '05:45',
                style: GoogleFonts.openSans(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                'Lindsey Vaccaro',
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
                color: Colors.green,
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vel metus ligula. Duis quis congue ex. Integer placerat arcu ac odio ullamcorper, ut pharetra orci scelerisque.',
            style: GoogleFonts.openSans(fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 12,),
          Divider(height: 1, thickness: 1,)
        ],
      ),
    );
  }
}

