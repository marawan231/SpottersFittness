import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class RegisterWebServices {
  late Dio dio;
  RegisterWebServices() {
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

  Future<Map<String, dynamic>> userRegister(
      firstName, email, phone, password, confirmPassword) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'register',
          'fname': firstName,
          'email': email,
          'phone': phone,
          'pass': password,
          'cpass': confirmPassword,
        },
      );

      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }
  }

  Future<Map<String, dynamic>> resendOtb() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'resendOTP',
          'user': userId,
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
