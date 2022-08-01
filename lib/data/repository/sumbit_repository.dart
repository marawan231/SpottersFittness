import 'package:spotters_app_clone/data/model/sumbit_model.dart';
import 'package:spotters_app_clone/data/web_services/sumbit_web_services.dart';

class SumbitRepository {
  final SumbitWebServices sumbitWebServices;

  SumbitRepository(this.sumbitWebServices);

  Future<Sumbit> userSumbit(
    String country,
    String gender,
    String city,
    String dateOfBirth,
    String experience,
    String specialicits,
    String certificationText,
    String aboutMeText,
  ) async {
    final sumbit = await sumbitWebServices.sumbitForm(
      country,
      gender,
      city,
      dateOfBirth,
      experience,
      specialicits,
      certificationText,
      aboutMeText,
    );
    return Sumbit.fromJson(sumbit);
  }
}
