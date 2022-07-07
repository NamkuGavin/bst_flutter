import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/page/workout/component/woDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeWO extends StatefulWidget {
  const homeWO({Key? key, required this.homeDetail}) : super(key: key);
  final List homeDetail;

  @override
  _homeWOState createState() => _homeWOState();
}

class _homeWOState extends State<homeWO> {
  @override
  Widget build(BuildContext context) {
    print(widget.homeDetail);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: HeaderNavigation(
          title: '',
        ),
      ),
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return workout();
                        //     },
                        //   ),
                        //   // );
                        // ).then((_) => setState(() {}));
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(
                          'assets/images/homeWO.png',
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
                      itemCount: widget.homeDetail.length,
                      itemBuilder: (BuildContext context, index) {
                        return woDetail(
                          id: int.parse(widget.homeDetail[index]['id_header']),
                          name: widget.homeDetail[index]['WorkoutName'],
                          day: widget.homeDetail[index]['DayNotes'],
                          shortNotes: widget.homeDetail[index]['ShortNotes'],
                        );
                      })),
            ),
          ])),
    );
  }
}
