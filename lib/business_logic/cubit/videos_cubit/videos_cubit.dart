import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart';
import 'package:spotters_app_clone/data/model/upload_video_model.dart';
import 'package:spotters_app_clone/data/model/videos_model.dart';
import 'package:spotters_app_clone/data/repository/videos_repository.dart';

import '../../../presentation/resources/constants_manager.dart';
import 'package:path/path.dart' show basename;
import 'package:spotters_app_clone/business_logic/cubit/countries_cubit/countries_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  VideosCubit(this.vidoesRepository) : super(VideosInitial());
  final VidoesRepository vidoesRepository;
  List<VideosList> listVideos = [];

  List<VideosList> getVideos() {
    emit(VideosListLoading());
    vidoesRepository.getVideos().then((videos) {
      emit(VideosListLoaded(videos));
      listVideos = videos;
    }).catchError((error) {
      emit(VideosListError(error));
    });
    return listVideos;
  }

  void uploadVideorr({required video}) {
    emit(VideoUploadLoading());
    vidoesRepository
        .uploadVideo(
      video: video,
    )
        .then((videos) {
      emit(VideoUploadedSuccess());
    }).catchError((error) {
      emit(VideoUploadError());
    });
  }

  Future<String?> uploadVideo(
      PickedFile videoFile, context, titleText, selectedCategor) async {
    emit(VideoUploadLoading());

    var uri = Uri.parse(
        'https://www.algowid.net/sf_api/index.php?act=postVideo&user=$userId&title=$titleText&cat=$selectedCategor');
    final mimeTypeData =
        lookupMimeType(videoFile.path, headerBytes: [0xFF, 0xD8])!.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', uri);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('vidfile', videoFile.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);

    // add headers if needed
    //imageUploadRequest.headers.addAll(<some-headers>);

    try {
      final streamedResponse = await imageUploadRequest.send();
      print(streamedResponse.reasonPhrase.toString());
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body.toString());
      Map mapRes = json.decode(response.body);

      if (mapRes['status'] == 'success') {
        emit(VideoUploadedSuccess());
        showScaffold(
            text: mapRes['error'][0], context: context, color: Colors.green);
        // titleController.clear();
        // addVideoController.clear();
      }
    } catch (e) {
      emit(VideoUploadError());
      print(e);
      return null;
    }
    return null;
  }
}
