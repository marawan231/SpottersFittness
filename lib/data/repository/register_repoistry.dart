import 'package:spotters_app_clone/data/model/resend_otp_model.dart';

import '../model/register_model.dart';
import '../model/verify_otb.dart';
import '../web_services/register_web_services.dart';

class RegisterRepoistry {
  final RegisterWebServices registerWebServices;

  RegisterRepoistry(this.registerWebServices);

  Future<RegisterModel> userRegister(
      firstName, email, phone, password, confirmPassword) async {
    final user = await registerWebServices.userRegister(
        firstName, email, phone, password, confirmPassword);
    return RegisterModel.fromJson(user);
  }

  Future<VerifyOtb> verifyOtp(String otp) async {
    final result = await registerWebServices.verifyOtp(otp);
    return VerifyOtb.fromJson(result);
  }

  Future<ResendOtbModel> resendOtb() async {
    final user = await registerWebServices.resendOtb();
    return ResendOtbModel.fromJson(user);
  }
}
