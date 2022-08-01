import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class ChatWebServices {
  late Dio dio;

  ChatWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getUsers() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'userList',
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

  Future<List<dynamic>> getUserDetails(userIndex) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'viewUserProfile',
          'userid': userIndex,
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
}
