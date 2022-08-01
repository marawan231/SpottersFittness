import 'package:dio/dio.dart';

import '../../presentation/resources/constants_manager.dart';

class ContactWebServices {
  late Dio dio;

  ContactWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> sendContactMessage(
    phoneNumber,
    email,
    message,
  ) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'postMsg',
          'user': userId,
          'email': email,
          'phone': phoneNumber,
          'txt': message,
          'type': 't',
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
