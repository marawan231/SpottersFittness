import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class LoginWebServices {
  late Dio dio;

  LoginWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getUserInfo(
      String email, String password) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'login',
          'user': email,
          'pass': password,
        },
      );
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }
  }

  Future<Map<String, dynamic>> retrievePassword(
    String email,
  ) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'forgotPass',
          'email': email,
        },
      );
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }
  }
}
