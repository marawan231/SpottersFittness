import 'package:spotters_app_clone/data/model/countrioes_model.dart';
import 'package:spotters_app_clone/data/web_services/countries_web_services.dart';

import '../web_services/countries_web_services.dart';

class CountriesRepoistory {
  final CountriesWebServices countriesWebServices;

  CountriesRepoistory(this.countriesWebServices);

  Future<List<String?>> getCountries() async {
    final List<dynamic> countries = await countriesWebServices.getCountries();

    final List<String?> listOfCountris = countries
        .map((country) => Countries.fromJson(country))
        .toList()
        .map((e) => e.country)
        .toList();
    return listOfCountris;
  }
}
