import 'package:spotters_app_clone/data/model/cities_model.dart';
import 'package:spotters_app_clone/data/model/countrioes_model.dart';
import 'package:spotters_app_clone/data/web_services/cities_web_services.dart';
import 'package:spotters_app_clone/data/web_services/countries_web_services.dart';

import '../web_services/countries_web_services.dart';

class CitiesRepository {
  final CitiesWebServices citiesWebServices;

  CitiesRepository(this.citiesWebServices);

  Future<List<String?>> getCities({
    required int countryCode,
  }) async {
    final List<dynamic> cities =
        await citiesWebServices.getCities(countryCode: countryCode);

    final List<String?> listOfCities = cities
        .map((city) => Cities.fromJson(city))
        .toList()
        .map((e) => e.name)
        .toList();
    return listOfCities;
  }
}
