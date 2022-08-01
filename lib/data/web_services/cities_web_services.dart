import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class CitiesWebServices {
  late Dio dio;
  CitiesWebServices() {
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

  Future<List<dynamic>> getCities({required int countryCode}) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'cityList',
          'country': countryCode,
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
