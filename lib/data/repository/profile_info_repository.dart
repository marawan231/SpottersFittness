import 'package:spotters_app_clone/data/model/profile_info.dart';
import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/data/web_services/profile_info_web_services.dart';

class ProfileInfoRepository {
  final ProfileInfoWebServices profileInfoWebServices;

  ProfileInfoRepository(this.profileInfoWebServices);

  Future<List<ProfileInfo>> getUserPersonalData() async {
    List<dynamic> profiles = await profileInfoWebServices.getUserPersonalData();
    final List<ProfileInfo> listOfProfiles =
        profiles.map((profile) => ProfileInfo.fromJson(profile)).toList();

    return listOfProfiles;
  }
}
