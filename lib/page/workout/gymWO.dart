import 'package:bst/page/workout/component/woDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class gymWO extends StatefulWidget {
  const gymWO({Key? key, required this.gymList}) : super(key: key);
  final List gymList;

  @override
  _gymWOState createState() => _gymWOState();
}

class _gymWOState extends State<gymWO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 120,
                    width: 350,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(
                          'assets/images/gymWO.png',
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFF99CB57),
                        elevation: 5,
                      ),
                    ))),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                  width: double.infinity,
                  height: 450,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      // itemCount: books.length,
                      itemCount: widget.gymList.length,
                      itemBuilder: (BuildContext context, index) {
                        return woDetail(
                          id: int.parse(widget.gymList[index]['id_header']),
                          name: widget.gymList[index]['WorkoutName'],
                          day: widget.gymList[index]['DayNotes'],
                          shortNotes: widget.gymList[index]['ShortNotes'],
                        );
                      })),
            ),
          ])),
    );
  }
}
