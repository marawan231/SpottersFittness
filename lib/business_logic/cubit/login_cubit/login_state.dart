part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccedded extends LoginState {
  final LoginModel userInfo;

  LoginSuccedded(this.userInfo);
}

class LoginLoding extends LoginState {}

class LoginErorr extends LoginState {
  final String errorText;

  LoginErorr(this.errorText);
}

class ForgotPassSuccedded extends LoginState {
  final ForgotPassModel result;

  ForgotPassSuccedded(this.result);
}

class ForgotPassLoading extends LoginState {}

class ForgotPassErorr extends LoginState {
  final String errorText;

  ForgotPassErorr(this.errorText);
}

class LoginChangePasswordVisibiltyState extends LoginState {}
