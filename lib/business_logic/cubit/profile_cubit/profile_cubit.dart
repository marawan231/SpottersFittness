// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/delete_acc_model.dart';
import 'package:spotters_app_clone/data/model/fetch_profile.dart';
import 'package:spotters_app_clone/data/model/update_profile.dart';
import 'package:spotters_app_clone/data/repository/edit_profile_repositroy.dart';
import 'package:spotters_app_clone/data/repository/fetch_profile_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../../presentation/resources/constants_manager.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.fetchProfileRepository, this.editProfileRepository)
      : super(ProfileInitial());
  final FetchProfileRepository fetchProfileRepository;
  final EditProfileRepository editProfileRepository;
  String? glopalUserPic;

  File? image;
  var imageName;
  PickedFile? _imageFile;

  final ImagePicker _picker = ImagePicker();
  var source;
  Widget _buildSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            print('object 1');

            source = ImageSource.camera;
          },
          child: const Text('camera'),
        ),
        TextButton(
          onPressed: () {
            print('object 2');

            source = ImageSource.gallery;
            emit(GalleryOptionSelected());
          },
          child: const Text('gallery'),
        ),
      ],
    );
  }

  Future pickImageFromGallary(context) async {
    await showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => _buildSheet());
    print(source.toString());
    try {
      final pickedFile = await _picker.getImage(source: source);
      emit(ProfilePicUpdatingLoading());
      uploadImage(pickedFile!.path);
    } catch (e) {
      //print("Image picker error ${e!}");
      print("Image picker error + ${e.toString()}");
    }
  }

  void getProfileData() {
    emit(ProfileDataLoadeing());
    fetchProfileRepository.getProfileData().then((profiles) {
      emit(ProfileDataLoaded(profiles[0]));
      glopalUserPic = profiles[0].pic;
    }).catchError((e) {
      print(e);
    });
  }

  void deleteAcc(context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      emit(DeleteAccLoading());
                      editProfileRepository.deleteAcc().then((result) {
                        if (result.status == 'success') {
                          emit(DeleteAccSuccess(result));
                        } else {
                          emit(DeleteAccEroor());
                        }
                      }).catchError((e) {
                        emit(DeleteAccEroor());
                        print(e);
                      });

                      Navigator.of(context).pop(true);
                    },
                    child: const Text("DELETE")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ]);
          /* */
        });
  }

  void editProfile(firstName, email, phone, pass, confirmPass) {
    editProfileRepository
        .updatedProfile(firstName, email, phone, pass, confirmPass)
        .then((updadetdProfile) {
      print(updadetdProfile.status);
      emit(ProfileDataUpdated(updadetdProfile));
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  Future<String?> uploadImage(filepath) async {
    emit(UploadingImage());
    print(filepath);

    var request = http.MultipartRequest('POST',
        Uri.parse('https://www.algowid.net/sf_api/index.php?act=proPicUpdate'));
    request.fields['user'] = userId.toString();
    request.files.add(await http.MultipartFile.fromPath('image', filepath,
        contentType: MediaType('image', 'jpg')));
    var res = await request.send();
    print(res.toString());
    final respStr = await res.stream.bytesToString();

    print(respStr.toString());
    emit(ProfilePicUpdatingSuccess());

    //return res.reasonPhrase;
    print(res.reasonPhrase.toString());

    return res.reasonPhrase;
  }
}
