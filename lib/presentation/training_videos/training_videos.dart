import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotters_app_clone/presentation/widgets/video_item_version_two.dart';
import 'package:spotters_app_clone/presentation/widgets/video_view_item.dart';
import 'package:video_player/video_player.dart';

class TrainingVideosView extends StatefulWidget {
  const TrainingVideosView({Key? key}) : super(key: key);

  @override
  State<TrainingVideosView> createState() => _TrainingVideosViewState();
}

class _TrainingVideosViewState extends State<TrainingVideosView> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _buildBody(context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        // fit: StackFit.loose,
        children: <Widget>[
          ListView(
            children: [
              VideoItemVersion2(
                initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
                controller: _controller,
                text:
                    'Random  Text Random Text Random Text Random Text Random Text Random Text Random Text ',
              ),
              VideoItemVersion2(
                initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
                controller: _controller,
                text:
                    'Random  Text Random Text Random Text Random Text Random Text Random Text Random Text ',
              ),
              VideoItemVersion2(
                initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
                controller: _controller,
                text:
                    'Random  Text Random Text Random Text Random Text Random Text Random Text ',
              ),
              VideoItemVersion2(
                initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
                controller: _controller,
                text:
                    'Random Text Random Text Random Text Random Text Random Text Random Text Random Text Random Text ',
              ),
            ],
          ),
          // _buildButton(context),
        ],
      ),
    );
  }

  // _buildButton(context) {
  //   return Positioned(
  //     bottom: 48.0,
  //     left: 10.0,
  //     right: 10.0,
  //     child: TextButton(
  //       style: TextButton.styleFrom(
  //         backgroundColor: Colors.pink,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 140,
  //           vertical: 18,
  //         ),
  //       ),
  //       onPressed: () {},
  //       child: const Text(
  //         'GET STARTED',
  //         style: TextStyle(
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB56DEB),
        title: const Text('Videos'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }
}
