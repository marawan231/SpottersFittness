import 'package:spotters_app_clone/data/model/fetch_certifcate_model.dart';
import 'package:spotters_app_clone/data/web_services/certi_web_services.dart';

class CertiRepository {
  final CertiWebServices certiWebServices;

  CertiRepository(this.certiWebServices);

  Future<List<FetchCertifcateModel>> fetchCerti() async {
    List<dynamic> certis = await certiWebServices.fetchCerti();
    final List<FetchCertifcateModel> listOfCerties =
        certis.map((cert) => FetchCertifcateModel.fromJson(cert)).toList();

    return listOfCerties;
  }
}
