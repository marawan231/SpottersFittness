import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import '../../../data/model/register_model.dart';
import '../../../data/model/resend_otp_model.dart';
import '../../../data/model/verify_otb.dart';
import '../../../data/repository/register_repoistry.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepoistry registerRepoistry;
  RegisterCubit(this.registerRepoistry) : super(RegisterInitial());

  Icon confirmSuffixIcon = const Icon(Icons.visibility);

  Icon createPasswordSuffixIcon = const Icon(Icons.visibility);
  bool isPassowrdShown = true;
  bool isConfirmPassowrdShown = true;
  bool isAgree = false;

  void verifyOtp({required String otp}) {
    emit(VerifyOtpLoading());

    registerRepoistry.verifyOtp(otp).then((result) {
      if (result.status == 'error') {
        emit(VerifyOtpError(result.error!.first));
      }
      if (result.status == 'success') {
        emit(VerifyOtpSuccedded(result));
      }
    }).catchError((e) {
      emit(VerifyOtpError(e));
    });
  }

  void getUserInfo({
    required String firstName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) {
    emit(RegisterLoding());
    registerRepoistry
        .userRegister(firstName, email, phone, password, confirmPassword)
        .then((userInfo) {
      if (userInfo.status == 'error') {
        emit(RegisterErorr(userInfo.error!.first));
      }
      if (userInfo.status == 'success') {
        userId = userInfo.usrid!;

        emit(RegisterSuccedded(userInfo));
      }
    }).catchError((e) {
      emit(RegisterErorr(e));
    });
  }

  void resendOtb() {
    emit(ResendOtbLoding());
    registerRepoistry.resendOtb().then((result) {
      if (result.status == 'error') {
        emit(RegisterErorr(result.error!.first));
      }
      if (result.status == 'success') {
        emit(ResendOtbSuccedded(result));
      }
    }).catchError((e) {
      emit(ResendOtbErorr(e));
    });
  }

  void tooglePasswordVisibilty() {
    isPassowrdShown = !isPassowrdShown;
    createPasswordSuffixIcon = isPassowrdShown
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off_outlined);
    emit(RegisterChangePasswordVisibiltyState());
  }

  void toogleConfirmPasswordVisibilty() {
    isConfirmPassowrdShown = !isConfirmPassowrdShown;
    confirmSuffixIcon = isConfirmPassowrdShown
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off_outlined);
    emit(RegisterChangeConfirmPasswordVisibiltyState());
  }

  void changeCheckBoxValue(value) {
    isAgree = value;
    isAgree
        ? emit(AgreeTermsAndConditions())
        : emit(NotAgreeTermsAndConditions());
  }
}
