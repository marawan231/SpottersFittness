import 'package:spotters_app_clone/data/model/terms_and_conditions.dart';
import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/data/web_services/privacy_web_services.dart';
import 'package:spotters_app_clone/data/web_services/terms_and_conditions.dart';
import 'package:spotters_app_clone/data/web_services/user_payment_web_services.dart';

class PrivacyRepositroy {
  final PrivacyWebServices privacyWebServices;

  PrivacyRepositroy(this.privacyWebServices);

  Future<TermsAndConditions> getPrivacy() async {
    final privacy = await privacyWebServices.getPrivacy();
    return TermsAndConditions.fromJson(privacy);
  }
}
