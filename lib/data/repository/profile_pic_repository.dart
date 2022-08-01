import 'package:spotters_app_clone/data/model/profile_picture_model.dart';
import 'package:spotters_app_clone/data/web_services/profile_pic_web_services.dart';

class ProfilePicRepository {
  final ProfilePicWebServices profilePicWebServices;

  ProfilePicRepository(this.profilePicWebServices);

  Future<ProfilePicture> saveProfilePic(imagePath) async {
    final profilePic = await profilePicWebServices.saveProfilePic(imagePath);
    return ProfilePicture.fromJson(profilePic);
  }
}
