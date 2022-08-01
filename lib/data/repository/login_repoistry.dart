import 'package:spotters_app_clone/data/model/forgot_pass_model.dart';

import '../model/login_model.dart';
import '../web_services/login_web_services.dart';

class LoginRepoistry {
  final LoginWebServices loginWebServices;

  LoginRepoistry(this.loginWebServices);

  Future<LoginModel> getUserInfo(String email, String password) async {
    final user = await loginWebServices.getUserInfo(email, password);
    return LoginModel.fromJson(user);
  }

  Future<ForgotPassModel> retrievePass(
    String email,
  ) async {
    final user = await loginWebServices.retrievePassword(email);
    return ForgotPassModel.fromJson(user);
  }
}
