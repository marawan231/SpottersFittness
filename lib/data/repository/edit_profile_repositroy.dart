import 'dart:math';

import 'package:spotters_app_clone/data/model/delete_acc_model.dart';
import 'package:spotters_app_clone/data/model/update_profile.dart';
import 'package:spotters_app_clone/data/web_services/edit_profile_web_services.dart';

import '../model/login_model.dart';
import '../web_services/login_web_services.dart';

class EditProfileRepository {
  final EditProfileWebServices editProfileWebServices;

  EditProfileRepository(this.editProfileWebServices);

  Future<UpdatedProfile> updatedProfile(
      firstName, email, phone, pass, confirmPass) async {
    final updatedProfile = await editProfileWebServices.editProfile(
        firstName, email, phone, pass, confirmPass);
    return UpdatedProfile.fromJson(updatedProfile);
  }

  Future<DeleteAccount> deleteAcc() async {
    final result = await editProfileWebServices.deleteAcc();
    return DeleteAccount.fromJson(result);
  }
}
