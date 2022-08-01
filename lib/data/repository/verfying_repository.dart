import 'package:spotters_app_clone/data/model/verify_otb.dart';
import 'package:spotters_app_clone/data/web_services/verify_otb_web_services.dart';

class VerfyingRepoistry {
  final VerfyingWebServices verfyingWebServices;

  VerfyingRepoistry(this.verfyingWebServices);

  Future<VerifyOtb> verifyOtp(String otp) async {
    final result = await verfyingWebServices.verifyOtp(otp);
    return VerifyOtb.fromJson(result);
  }
}
