import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/data/model/forgot_pass_model.dart';

import '../../../data/model/login_model.dart';
import '../../../data/repository/login_repoistry.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepoistry loginRepoistry;
  Icon suffixIcon = const Icon(Icons.visibility);
  bool isPassowrdShown = true;

  LoginCubit(this.loginRepoistry) : super(LoginInitial());

  void getUserInfo({required String email, required String password}) {
    emit(LoginLoding());

    loginRepoistry.getUserInfo(email, password).then((userInfo) {
      if (userInfo.status == 'error') {
        emit(LoginErorr(userInfo.error!.first));
      }
      if (userInfo.status == 'success') {
        emit(LoginSuccedded(userInfo));
      }
    }).catchError((e) {
      emit(LoginErorr(e));
    });
  }

  void retrievePass({
    required String email,
  }) {
    emit(ForgotPassLoading());

    loginRepoistry
        .retrievePass(
      email,
    )
        .then((result) {
      if (result.status == 'error') {
        emit(ForgotPassErorr(result.error!.first));
      }
      if (result.status == 'success') {
        emit(ForgotPassSuccedded(result));
      }
    }).catchError((e) {
      emit(ForgotPassErorr(e));
    });
  }

  void tooglePasswordVisibilty() {
    isPassowrdShown = !isPassowrdShown;
    suffixIcon = isPassowrdShown
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off_outlined);
    emit(LoginChangePasswordVisibiltyState());
  }
}
