import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  VideoItem({Key? key, required this.text, required this.videoUrl})
      : super(key: key);

  final String videoUrl;

  final String text;

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;
  bool isPlaying = true;
  bool show = true;

  initVideo() {
    controller = VideoPlayerController.network(widget.videoUrl);

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
    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * .02,
        right: MediaQuery.of(context).size.width * .02,
        bottom: MediaQuery.of(context).size.height * .01,
      ),
      child: Column(
        children: [
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black87,
                // fontFamily: 'Poppins',
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Stack(
            children: [
              FutureBuilder(
                future: futureController,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return InkWell(
                      onTap: () {
                        setState(() {
                          show = true;
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height * .21,
                        child: AspectRatio(
                          aspectRatio: controller!.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: VideoPlayer(controller!),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .4,
                top: MediaQuery.of(context).size.height * .08,
                child: Center(
                  child: Visibility(
                    visible: show,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            // If the video is playing, pause it.
                            if (controller!.value.isPlaying) {
                              controller!.pause();
                            } else {
                              // If the video is paused, play it.
                              controller!.play();
                              show = false;
                            }
                          });
                        },
                        icon: Icon(
                          controller!.value.isPlaying == true
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 26,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
/* Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    ),
                                    Center(
                                      child: _controller.value.isPlaying == true
                                          ? Visibility(
                                              visible: false,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white60,
                                                child: Icon(
                                                    _controller.value
                                                                .isPlaying ==
                                                            true
                                                        ? Icons.pause
                                                        : Icons.play_arrow,
                                                    size: 26,
                                                    color: Colors.blue),
                                              ),
                                            )
                                          : Visibility(
                                              visible: true,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white60,
                                                child: Icon(
                                                    _controller.value
                                                                .isPlaying ==
                                                            true
                                                        ? Icons.pause
                                                        : Icons.play_arrow,
                                                    size: 26,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                    ),
                                  ],
                                ), */