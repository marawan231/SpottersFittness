part of 'verfiy_cubit.dart';

@immutable
abstract class VerfiyState {}

class VerfiyInitial extends VerfiyState {}

class VerifyOtpLoading extends VerfiyState {}

class VerifyOtpSuccedded extends VerfiyState {
  final VerifyOtb result;

  VerifyOtpSuccedded(this.result);
}

class VerifyOtpError extends VerfiyState {
  final String errorText;

  VerifyOtpError(this.errorText);
}
