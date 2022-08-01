import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class PrivacyWebServices {
  late Dio dio;

  PrivacyWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getPrivacy() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'pageList',
          'pageid': '2',
        },
      );
      print(response.data.toString());
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }
  }
}
