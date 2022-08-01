import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class ProfileInfoWebServices {
  late Dio dio;

  ProfileInfoWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getUserPersonalData() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'fetchProfileInfo',
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
