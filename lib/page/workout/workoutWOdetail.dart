import 'dart:convert';

import 'package:bst/header/HeaderNavigation.dart';
import 'package:bst/page/workout/videoPlay.dart';
import 'package:bst/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class woVidDetail extends StatefulWidget {
  woVidDetail(
      {Key? key,
      required this.woId,
      required this.name,
      required this.day,
      required this.shortNotes})
      : super(key: key);
  final int woId;
  final String name;
  final String day;
  final String shortNotes;

  @override
  _woVidDetailState createState() => _woVidDetailState();
}

var encoded1 = "";
List woVidList = [];
Future<Null> fetchWoVid(int id) async {
  if (id == 1) {
    Map<String, dynamic> wobody = {
      "apikey": "bstapp2022",
      "action": "workout_detail",
      "WorkoutHeaderID": 1,
    };
    encoded1 = base64.encode(utf8.encode(json.encode(wobody)));
  } else {
    Map<String, dynamic> wobody = {
      "apikey": "bstapp2022",
      "action": "workout_detail",
      "WorkoutHeaderID": 2,
    };
    encoded1 = base64.encode(utf8.encode(json.encode(wobody)));
  }
  final dbwo = await http.post(
      Uri.parse(ServerConfig.newUrl + 'workout.php'),
      body: {"data": encoded1});
  if (dbwo.statusCode == 200) {
    Map<String, dynamic> dbworesponse = json.decode(dbwo.body);
    print(dbworesponse);
    woVidList = dbworesponse['Data'];
    // workout = jsonDecode(dbwo.body) as List;
    print(woVidList);
  } else {
    throw Exception('Failed to load workout video');
  }
}

class _woVidDetailState extends State<woVidDetail> {
  List<String> paths = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  ];

  @override
  Widget build(BuildContext context) {
    fetchWoVid(widget.woId);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: HeaderNavigation(
              title: '',
            ),
          ),
          body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 120,
                    width: 350,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            SvgPicture.asset('assets/icons/barbel.svg',
                                height: 30),
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
                                  Text(widget.day,
                                      style: GoogleFonts.openSans()),
                                ])
                          ]),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFC4C4C4), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topCenter,
                // child: Container(
                //   height: 120,
                //   width: 350,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                  child: Text(widget.shortNotes,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ))),
                ),
                // ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: paths.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VideoPlay(
                      pathh: paths[index],
                    );
                  },
                ),
              ),

              // FutureBuilder(
              //   future: _initializeVideoPlayerFuture,
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       // If the VideoPlayerController has finished initialization, use
              //       // the data it provides to limit the aspect ratio of the video.
              //       return AspectRatio(
              //         aspectRatio: _controller.value.aspectRatio,
              //         // Use the VideoPlayer widget to display the video.
              //         child: VideoPlayer(_controller),
              //       );
              //     } else {
              //       // If the VideoPlayerController is still initializing, show a
              //       // loading spinner.
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //   },
              // ),
            ]),
      )),
    );
  }
}
