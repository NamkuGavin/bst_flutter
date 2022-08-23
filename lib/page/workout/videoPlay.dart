import 'package:bst/page/workout/workoutWOdetail.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  String? pathh;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  VideoPlay({
    Key? key,
    this.pathh, // Video from assets folder
  }) : super(key: key);
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.network(widget.pathh!);

    futureController = controller!.initialize();
  }

  @override
  void initState() {
    initVideo();
    controller!.addListener(() {
      if (controller!.value.isInitialized) {
        currentPosition.value = controller!.value;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 250,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: Stack(children: [
                VideoPlayer(controller!),
                ClosedCaption(text: null),
                Align(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if (controller!.value.isPlaying) {
                          controller!.pause();
                        } else {
                          controller!.play();
                        }
                      });
                    },
                    child: Icon(
                      controller!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    backgroundColor: Colors.blueGrey.withOpacity(0.0),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        width: 150,
                        child: Text(woVidList[0]['VideoTitle'],
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
                    controller!,
                    allowScrubbing: true,
                    padding: EdgeInsets.all(3),
                    colors: VideoProgressColors(
                        playedColor: Colors.blueGrey.withOpacity(0.0)),
                  ),
                ),
              ]));
        }
      },
    );
  }
}
