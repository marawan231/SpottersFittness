import 'package:spotters_app_clone/data/model/cities_model.dart';
import 'package:spotters_app_clone/data/web_services/specialist_web_services.dart';

class SpicialistRepository {
  final SpicialistWebServices spicialistWebServices;

  SpicialistRepository(this.spicialistWebServices);

  Future<List<String?>> getSpecialists() async {
    final List<dynamic> specialist =
        await spicialistWebServices.getSpecialist();

    final List<String?> listOfSpecialists = specialist
        .map((city) => Cities.fromJson(city))
        .toList()
        .map((e) => e.name)
        .toList();

    return listOfSpecialists;
  }
}
