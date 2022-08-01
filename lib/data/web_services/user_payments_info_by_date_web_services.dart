import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../presentation/resources/constants_manager.dart';

class UserPaymentsInfoByDateWebServices {
  late Dio dio;

  UserPaymentsInfoByDateWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getUserPaymentsInfoByDate(
      String fromDate, String toDate) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'paymentList',
          'user': userId,
          'from': fromDate,
          'to': toDate,
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
