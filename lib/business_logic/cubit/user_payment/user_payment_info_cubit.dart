import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/data/repository/user_payment_info_by_date_repository.dart';
import 'package:spotters_app_clone/data/repository/user_payment_info_repository.dart';
import 'package:spotters_app_clone/data/web_services/user_payment_web_services.dart';

part 'user_payment_info_state.dart';

class UserPaymentInfoCubit extends Cubit<UserPaymentInfoState> {
  UserPaymentInfoCubit(
      this.userPaymentInfoRepository, this.userPaymentInfoByDateRepository)
      : super(UserPaymentInfoInitial());

  final UserPaymentInfoRepository userPaymentInfoRepository;
  final UserPaymentInfoByDateRepository userPaymentInfoByDateRepository;

  void getUserPaymentsInfo() {
    emit(PaymentsLoading());

    userPaymentInfoRepository.getUserPaymentInfo().then((userInfo) {
      emit(PaymentSuccedded(userInfo));
    }).catchError((e) {
      emit(PaymentError());
    });
  }

  void getUserPaymentsInfoByDate(String fromDate, String toDate) {
    emit(PaymentsByDateLoading());

    userPaymentInfoByDateRepository
        .getUserPaymentInfoByDate(fromDate, toDate)
        .then((userInfoByDate) {
      emit(PaymentSuccedded(userInfoByDate));
    }).catchError((e) {
      emit(PaymentError());
    });
  }
}
