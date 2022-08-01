import 'package:spotters_app_clone/data/model/subscribtion_model.dart';
import 'package:spotters_app_clone/data/web_services/subscribtion_web_services.dart';

class SubscriptionRepoistory {
  final SubscribtionWebServices subscribtionWebServices;

  SubscriptionRepoistory(this.subscribtionWebServices);

  Future<SubscribtionModel> userSubscribtion() async {
    final userSubscribtion = await subscribtionWebServices.userSubscribtion();
    return SubscribtionModel.fromJson(userSubscribtion);
  }
}
