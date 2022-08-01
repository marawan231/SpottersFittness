import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotters_app_clone/business_logic/cubit/videos_cubit/videos_cubit.dart';
import 'package:spotters_app_clone/data/model/videos_model.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/routes_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/video_view_item.dart';
import 'package:video_player/video_player.dart';

import '../resources/constants_manager.dart';

class VideoView extends StatefulWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  _buildBody(context) {
    return BlocConsumer<VideosCubit, VideosState>(
      listener: (context, state) {
        if (state is VideoUploadedSuccess) {
          setState(() {});
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.builder(
                  itemCount:
                      BlocProvider.of<VideosCubit>(context).listVideos.length,
                  itemBuilder: (context, index) {
                    return VideoItem(
                      text: BlocProvider.of<VideosCubit>(context)
                          .listVideos[index]
                          .title!,
                      videoUrl: BlocProvider.of<VideosCubit>(context)
                          .listVideos[index]
                          .vidURL!,
                    );
                  },
                ),
              ),
              //  _buildButton(context),
            ],
          ),
        );
      },
    );
  }

  // _buildButton(context) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       bottom: MediaQuery.of(context).size.height * .02,
  //     ),
  //     child: Align(
  //       alignment: Alignment.bottomCenter,

  //       // bottom: MediaQuery.of(context).size.height * .02,
  //       // left: MediaQuery.of(context).size.width * .08,
  //       // right: MediaQuery.of(context).size.width * .02,
  //       child: GestureDetector(
  //         onTap: () {
  //           Navigator.pushReplacementNamed(context, Routes.homePage);
  //         },
  //         child: Container(
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //             color: ColorManager.myPink,
  //           ),
  //           width: MediaQuery.of(context).size.width * .8,
  //           height: MediaQuery.of(context).size.height * .08,
  //           child: const Center(
  //             child: Text(
  //               'GET STARTED',
  //               style: TextStyle(
  //                 letterSpacing: 2,
  //                 color: Colors.white,
  //                 fontFamily: 'Lato',
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listOfVideos = BlocProvider.of<VideosCubit>(context).getVideos();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB56DEB),
        title: const Text('Videos'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.uploadTrainngVideos);
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFFC484F1),
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: _buildBody(context),
    );
  }
}
