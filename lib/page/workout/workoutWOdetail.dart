import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class woVidDetail extends StatefulWidget {
  const woVidDetail(
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
      Uri.parse('https://www.zeroone.co.id/bst/workout.php'),
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
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late VideoPlayerController _controller2;
  late Future<void> _initializeVideoPlayerFuture2;

  @override
  void initState() {
    // super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      // videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)
    );

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    _controller2 = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture2 = _controller2.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    _controller2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fetchWoVid(widget.woId);
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
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10),
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
                                Text(widget.day, style: GoogleFonts.openSans()),
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
                padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
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
            Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 100,
                      width: 150,
                      child: _controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: Stack(
                                children: <Widget>[
                                  VideoPlayer(_controller),
                                  ClosedCaption(text: null),
                                  // Here you can also add Overlay capacities
                                  Align(
                                    alignment: Alignment.center,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        // Wrap the play or pause in a call to `setState`. This ensures the
                                        // correct icon is shown.
                                        setState(() {
                                          // If the video is playing, pause it.
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                          } else {
                                            // If the video is paused, play it.
                                            _controller.play();
                                          }
                                        });
                                      },
                                      // Display the correct icon depending on the state of the player.
                                      child: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                      ),
                                      backgroundColor:
                                          Colors.blueGrey.withOpacity(0.0),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Container(
                                          width: 150,
                                          child:
                                              Text(woVidList[0]['VideoTitle'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                  )),
                                        ),
                                      )),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                      padding: EdgeInsets.all(3),
                                      colors: VideoProgressColors(
                                          playedColor:
                                              Colors.blueGrey.withOpacity(0.0)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: 250,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 100,
                      width: 150,
                      child: _controller2.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller2.value.aspectRatio,
                              child: Stack(
                                children: <Widget>[
                                  VideoPlayer(_controller2),
                                  ClosedCaption(text: null),
                                  // Here you can also add Overlay capacities
                                  Align(
                                    alignment: Alignment.center,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        // Wrap the play or pause in a call to `setState`. This ensures the
                                        // correct icon is shown.
                                        setState(() {
                                          // If the video is playing, pause it.
                                          if (_controller2.value.isPlaying) {
                                            _controller2.pause();
                                          } else {
                                            // If the video is paused, play it.
                                            _controller2.play();
                                          }
                                        });
                                      },
                                      // Display the correct icon depending on the state of the player.
                                      child: Icon(
                                        _controller2.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                      ),
                                      backgroundColor:
                                          Colors.blueGrey.withOpacity(0.0),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: VideoProgressIndicator(
                                      _controller2,
                                      allowScrubbing: true,
                                      padding: EdgeInsets.all(3),
                                      colors: VideoProgressColors(
                                          playedColor:
                                              Colors.blueGrey.withOpacity(0.0)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: 250,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    ),
                  )
                ],
              )
            ]),

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
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //   },
            // ),
          ])),
    );
  }
}
