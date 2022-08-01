part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccedded extends RegisterState {
  final RegisterModel userInfo;

  RegisterSuccedded(this.userInfo);
}

class RegisterLoding extends RegisterState {}

class RegisterErorr extends RegisterState {
  final errorText;

  RegisterErorr(this.errorText);
}

class ResendOtbSuccedded extends RegisterState {
  final ResendOtbModel result;

  ResendOtbSuccedded(this.result);
}

class ResendOtbLoding extends RegisterState {}

class ResendOtbErorr extends RegisterState {
  final errorText;

  ResendOtbErorr(this.errorText);
}

class RegisterChangePasswordVisibiltyState extends RegisterState {}

class RegisterChangeConfirmPasswordVisibiltyState extends RegisterState {}

class AgreeTermsAndConditions extends RegisterState {}

class NotAgreeTermsAndConditions extends RegisterState {}

class VerifyOtpLoading extends RegisterState {}

class VerifyOtpSuccedded extends RegisterState {
  final VerifyOtb result;

  VerifyOtpSuccedded(this.result);
}

class VerifyOtpError extends RegisterState {
  final String errorText;

  VerifyOtpError(this.errorText);
}
