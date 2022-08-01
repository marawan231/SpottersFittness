import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class SubscribtionWebServices {
  late Dio dio;
  SubscribtionWebServices() {
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

  Future<Map<String, dynamic>> userSubscribtion() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'packList',
        },
      );
      print(response.data[0].toString());

      return response.data[0];
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }
  }
}
