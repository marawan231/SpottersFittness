import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/data/web_services/user_payment_web_services.dart';

class UserPaymentInfoRepository {
  final UserPaymentsInfoWebServices userPaymentsInfoWebServices;

  UserPaymentInfoRepository(this.userPaymentsInfoWebServices);

  Future<List<UserPaymentInfo>> getUserPaymentInfo() async {
    List<dynamic> userPayment =
        await userPaymentsInfoWebServices.getUserPaymentsInfo();
    final List<UserPaymentInfo> listOfUserPayments = userPayment
        .map((userPayment) => UserPaymentInfo.fromJson(userPayment))
        .toList();
    print(listOfUserPayments[0].userID);

    return listOfUserPayments;
  }
}
