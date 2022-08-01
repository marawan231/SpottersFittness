import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotters_app_clone/business_logic/cubit/profile_cubit/profile_cubit.dart';
import 'package:spotters_app_clone/data/model/fetch_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:spotters_app_clone/data/model/update_profile.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/edit_profile_txt_field.dart';

import '../widgets/my_custom_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController changePasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FetchProfile? profileData;
  UpdatedProfile? updatedProfile;
  File? image;
  var imageName;
  PickedFile? _imageFile;

  final ImagePicker _picker = ImagePicker();
  var source;
  bool uploading = false;

  _buildBody(context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileDataLoaded) {
          profileData = state.profile;

          nameController.text = profileData!.fname!;
          emailController.text = profileData!.email!;
          mobileNumberController.text = profileData!.phone!;
        }
        if (state is ProfileDataUpdated) {
          updatedProfile = state.updatedProfile;

          if (updatedProfile!.status == 'success') {
            showScaffold(
              text: 'Profile Updated Successfull',
              context: context,
              color: Colors.green,
            );

            Navigator.pop(context);
          } else {
            showScaffold(text: updatedProfile!.error![0], context: context);
          }
        }

        if (state is ProfilePicUpdatingSuccess) {
          setState(() {});
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAvatar(context, state),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                EditProfileTxtField(
                  controller: nameController,
                  widget: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .06),
                    child: const Text(
                      'Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                EditProfileTxtField(
                  controller: emailController,
                  widget: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .06),
                    child: const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                EditProfileTxtField(
                  controller: mobileNumberController,
                  widget: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .06),
                    child: const Text(
                      'Mobile Number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                EditProfileTxtField(
                  controller: changePasswordController,
                  widget: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .06),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                EditProfileTxtField(
                  controller: confirmPasswordController,
                  widget: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .06),
                    child: const Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                _buildButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildButton(context) {
    return Center(
      child: MyCustomButton(
        onTap: () {
          BlocProvider.of<ProfileCubit>(context).editProfile(
            nameController.text,
            emailController.text,
            mobileNumberController.text,
            changePasswordController.text,
            confirmPasswordController.text,
          );
        },
        text: 'SUMBIT',
      ),
    );
  }

  Widget _buildSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            print('object 1');
            setState(() {
              source = ImageSource.camera;
            });
            Navigator.pop(context);
          },
          child: const Text('CAMERA'),
        ),
        TextButton(
          onPressed: () {
            print('object 2');
            setState(() {
              source = ImageSource.gallery;
            });
            Navigator.pop(context);
          },
          child: const Text('GALLERY'),
        ),
      ],
    );
  }

  Future _pickImageFromGallary() async {
    await showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => _buildSheet());
    print(source.toString());
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      // ignore: use_build_context_synchronously
      BlocProvider.of<ProfileCubit>(context).uploadImage(pickedFile!.path);

      // ignore: use_build_context_synchronously
      setState(() {
        _imageFile = pickedFile;
        regUserPic = _imageFile!.path;
      });
    } catch (e) {
      //print("Image picker error ${e!}");
      print("Image picker error + ${e.toString()}");
    }
  }

  _buildAvatar(context, ProfileState state) {
    //BlocProvider.of<ProfileCubit>(context).uploadImage(_imageFile!.path);
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * .17,
            child: state is UploadingImage
                ? const CircularProgressIndicator()
                : ClipOval(
                    child: Image.network(
                      BlocProvider.of<ProfileCubit>(context).glopalUserPic!,
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        Positioned(
          right: 0,
          top: 90,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: ColorManager.myPink,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: GestureDetector(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * .06,
              ),
              onTap: () {
                _pickImageFromGallary();
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProfileCubit>(context).getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        //backgroundColor: const Color(0xFFCC90F4),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }
}
