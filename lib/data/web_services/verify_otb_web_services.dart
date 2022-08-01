import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class VerfyingWebServices {
  late Dio dio;

  VerfyingWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> verifyOtp(String otp) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'otpVerify',
          'user': userId,
          'otp': otp,
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
