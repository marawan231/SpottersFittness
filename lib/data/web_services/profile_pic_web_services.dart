// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class ProfilePicWebServices {
  late Dio dio;

  ProfilePicWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> saveProfilePic(imagePath) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'proPicUpdate',
        },
        data: {
          'user': userId,
          'image': imagePath,
        },
      );
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
