import 'package:spotters_app_clone/data/model/upload_video_model.dart';
import 'package:spotters_app_clone/data/model/videos_model.dart';

import '../web_services/videos_web_services.dart';

class VidoesRepository {
  final VideosWebServices videosWebServices;

  VidoesRepository(this.videosWebServices);

  Future<List<VideosList>> getVideos() async {
    final List<dynamic> videos = await videosWebServices.getVideos();

    final List<VideosList> listOfVidoes =
        videos.map((city) => VideosList.fromJson(city)).toList();

    return listOfVidoes;
  }

  Future<UploadVideoModel> uploadVideo({
    required video,
  }) async {
    final videoResponse = await videosWebServices.uploadVideos(
      video: video,
    );
    return UploadVideoModel.fromJson(videoResponse);
  }
}
