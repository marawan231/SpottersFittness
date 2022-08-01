import 'dart:io';

import 'package:dio/dio.dart';
import 'package:spotters_app_clone/presentation/edit_personal_info/edit_personal_info.dart';

import '../../presentation/resources/constants_manager.dart';

class VideosWebServices {
  late Dio dio;
  VideosWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        }
        // headers: {"Content-Type": "application/json"},
        );
    dio = Dio(options);
  }

  Future<List<dynamic>> getVideos() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'videoList',
          'user': userId,
        },
      );
      print(response.data.toString());

      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>> uploadVideos({
    required video,
  }) async {
    FormData formData = FormData.fromMap({
      "vidfile": File(video),
    });
    try {
      Response response = await dio.post(
        data: formData,
        '',
        queryParameters: {
          'act': 'postVideo',
          'user': userId,
          'title': 'demo title',
          'cat': 1,
        },
      );
      print(video);
      print(response.data.toString());

      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }
  }
}
