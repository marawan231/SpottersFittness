part of 'user_payment_info_cubit.dart';

@immutable
abstract class UserPaymentInfoState {}

class UserPaymentInfoInitial extends UserPaymentInfoState {}

class PaymentsLoading extends UserPaymentInfoState {}

class PaymentSuccedded extends UserPaymentInfoState {
  final List<UserPaymentInfo> userPaymentInfo;

  PaymentSuccedded(this.userPaymentInfo);
}

class PaymentError extends UserPaymentInfoState {}

class PaymentsByDateLoading extends UserPaymentInfoState {}

class PaymentByDateLoaded extends UserPaymentInfoState {
  final List<UserPaymentInfo> userPaymentInfoDate;

  PaymentByDateLoaded(this.userPaymentInfoDate);
}
