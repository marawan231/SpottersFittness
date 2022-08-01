import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum FilterOptions {
  EDIT,
  DELETE,
}

class VideoItemVersion2 extends StatefulWidget {
  const VideoItemVersion2(
      {Key? key,
      required this.initializeVideoPlayerFuture,
      required this.controller,
      required this.text})
      : super(key: key);
  final initializeVideoPlayerFuture;
  final VideoPlayerController controller;
  final String text;

  @override
  State<VideoItemVersion2> createState() => _VideoItemVersion2State();
}

class _VideoItemVersion2State extends State<VideoItemVersion2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  overflow: TextOverflow.visible,
                  widget.text,
                  textAlign: TextAlign.center,
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: FilterOptions.EDIT,
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.DELETE,
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  future: widget.initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        height: MediaQuery.of(context).size.height * .21,
                        child: AspectRatio(
                          aspectRatio: widget.controller.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: VideoPlayer(widget.controller),
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
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .4,
                top: MediaQuery.of(context).size.height * .08,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      // Wrap the play or pause in a call to `setState`. This ensures the
                      // correct icon is shown.
                      setState(() {
                        // If the video is playing, pause it.
                        if (widget.controller.value.isPlaying) {
                          widget.controller.pause();
                        } else {
                          // If the video is paused, play it.
                          widget.controller.play();
                        }
                      });
                    },
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.pink,
                      size: 30,
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
