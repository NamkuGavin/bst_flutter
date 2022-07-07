import 'package:bst/page/workout/workoutWOdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class woDetail extends StatefulWidget {
  const woDetail(
      {Key? key,
      required this.id,
      required this.name,
      required this.day,
      required this.shortNotes})
      : super(key: key);
  final int id;
  final String name;
  final String day;
  final String shortNotes;

  @override
  State<woDetail> createState() => _woDetailState();
}

class _woDetailState extends State<woDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return woVidDetail(
                        woId: widget.id,
                        day: widget.day,
                        name: widget.name,
                        shortNotes: widget.shortNotes,
                      );
                    },
                  ),
                ).then((_) => setState(() {}));
              },
              child: Container(
                height: 120,
                width: 350,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                        ),
                        SvgPicture.asset('assets/icons/barbel.svg', height: 30),
                        SizedBox(width: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.name,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 21))),
                              SizedBox(height: 5),
                              Text(widget.day, style: GoogleFonts.openSans()),
                            ])
                      ]),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFC4C4C4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
