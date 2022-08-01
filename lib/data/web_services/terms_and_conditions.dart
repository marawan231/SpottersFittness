import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class TermsAndConditionsWebServices {
  late Dio dio;

  TermsAndConditionsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> getTermsAndConditions() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'pageList',
          'pageid': '1',
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
