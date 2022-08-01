import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class UpdatedProfileInfoWebServices {
  late Dio dio;

  UpdatedProfileInfoWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> updatePersonalInfo() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'profileUpdate',
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
}
