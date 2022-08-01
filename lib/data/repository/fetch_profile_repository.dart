import 'package:spotters_app_clone/data/model/fetch_profile.dart';
import 'package:spotters_app_clone/data/model/profile_info.dart';
import 'package:spotters_app_clone/data/model/user_payment_model.dart';
import 'package:spotters_app_clone/data/web_services/profile_info_web_services.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import '../web_services/fetch_profile_web_services.dart';

class FetchProfileRepository {
  final FetchProfileWebServices fetchProfileWebServices;

  FetchProfileRepository(this.fetchProfileWebServices);

  Future<List<FetchProfile>> getProfileData() async {
    List<dynamic> profiles = await fetchProfileWebServices.getProfileData();
    final List<FetchProfile> listOfProfiles =
        profiles.map((profile) => FetchProfile.fromJson(profile)).toList();

    profilePic = listOfProfiles[0].pic;

    return listOfProfiles;
  }
}
