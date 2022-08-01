import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/business_logic/cubit/register_cubit/register_cubit.dart';

import '../../presentation/resources/constants_manager.dart';

class SumbitWebServices {
  late Dio dio;

  SumbitWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>> sumbitForm(
    String country,
    String gender,
    String city,
    dateOfBirth,
    String exp,
    String specialicits,
    String certificationText,
    String aboutMeText,
  ) async {
    try {
      Response response = await dio.post(
        '',
        queryParameters: {
          'act': 'profileUpdate',
          'user': userId.toString(),
          'country': country,
          'city': city,
          'gender': gender,
          'dob': dateOfBirth,
          'exp': exp,
          'spe': specialicits,
          'certi': certificationText,
          'abt': aboutMeText,
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
