import 'package:spotters_app_clone/data/model/terms_and_conditions.dart';
import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/data/web_services/terms_and_conditions.dart';
import 'package:spotters_app_clone/data/web_services/user_payment_web_services.dart';

class TermsAndConditionsReopsitory {
  final TermsAndConditionsWebServices termsAndConditionsWebServices;

  TermsAndConditionsReopsitory(this.termsAndConditionsWebServices);

  Future<TermsAndConditions> getTermsAndConditions() async {
    final termsAndConditions =
        await termsAndConditionsWebServices.getTermsAndConditions();
    return TermsAndConditions.fromJson(termsAndConditions);
  }
}
