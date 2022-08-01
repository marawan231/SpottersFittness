import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class EditProfileWebServices {
  late Dio dio;

  EditProfileWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> editProfile(
      firstName, email, phone, pass, confirmPass) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'profileEdit',
          'user': userId,
          'fname': firstName,
          'email': email,
          'phone': phone,
          'pass': pass,
          'repass': confirmPass,
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

  Future<Map<String, dynamic>> deleteAcc() async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'delAccount',
          'userid': userId,
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
