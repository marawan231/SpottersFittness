import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/data/web_services/user_payment_web_services.dart';
import 'package:spotters_app_clone/data/web_services/user_payments_info_by_date_web_services.dart';

class UserPaymentInfoByDateRepository {
  final UserPaymentsInfoByDateWebServices userPaymentsInfoByDateWebServices;

  UserPaymentInfoByDateRepository(this.userPaymentsInfoByDateWebServices);

  Future<List<UserPaymentInfo>> getUserPaymentInfoByDate(
      String fromDate, String toDate) async {
    List<dynamic> userPayment = await userPaymentsInfoByDateWebServices
        .getUserPaymentsInfoByDate(fromDate, toDate);
    final List<UserPaymentInfo> listOfUserPayments = userPayment
        .map((userPayment) => UserPaymentInfo.fromJson(userPayment))
        .toList();

    return listOfUserPayments;
  }
}
