import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotters_app_clone/business_logic/cubit/videos_cubit/videos_cubit.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/profile_info_item.dart';

import '../../business_logic/cubit/profile_cubit/profile_cubit.dart';
import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? image;
  var imageName;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool update = false;

  Future _pickImageFromGallary() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
        regUserPic = _imageFile!.path;
      });
    } catch (e) {
      //print("Image picker error ${e!}");
      print("Image picker error");
    }
  }

  _buildBody(context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfilePicUpdatingSuccess) {
          setState(() {});
        }
        if (state is DeleteAccSuccess) {
          Navigator.pushNamed(context, Routes.loginRoute);
          showScaffold(
              text: state.deleteAccount.msg,
              context: context,
              color: Colors.green);
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * .1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAvatar(
                  context,
                  state,
                ),
                Builder(builder: (context) {
                  return ProfileInfoItem(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.editProfile);
                    },
                    title: 'Edit Profile',
                    leadingIcon: FontAwesomeIcons.person,
                  );
                }),
                ProfileInfoItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.editPersonalInfo);
                  },
                  title: 'Edit Your Personal Info',
                  leadingIcon: FontAwesomeIcons.info,
                ),
                ProfileInfoItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.trainingVideos);
                  },
                  title: 'Training Video',
                  leadingIcon: FontAwesomeIcons.video,
                  size: 22,
                ),
                ProfileInfoItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.subscribtionRenwal);
                  },
                  title: 'Subscribtion Renwal',
                  leadingIcon: FontAwesomeIcons.cube,
                ),
                ProfileInfoItem(
                  onTap: () {
                    BlocProvider.of<ProfileCubit>(context).deleteAcc(context);
                    //
                  },
                  title: 'Delete Account',
                  leadingIcon: FontAwesomeIcons.deleteLeft,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildAvatar(context, ProfileState state) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * .15,
            child: ClipOval(
              child: state is ProfileDataLoadeing
                  ? const CircularProgressIndicator()
                  : Image.network(
                      BlocProvider.of<ProfileCubit>(context).glopalUserPic!,
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        // Positioned(
        //   right: 0,
        //   top: 90,
        //   child: Container(
        //     padding: const EdgeInsets.all(8.0),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20.0),
        //       color: ColorManager.myPink,
        //     ),
        //     constraints: const BoxConstraints(
        //       minWidth: 16,
        //       minHeight: 16,
        //     ),
        //     child: update
        //         ? GestureDetector(
        //             child: Icon(
        //               Icons.add_task_rounded,
        //               color: Colors.white,
        //               size: MediaQuery.of(context).size.width * .06,
        //             ),
        //             onTap: () {
        //               uploadImage(_imageFile!.path);
        //               setState(() {
        //                 update = false;
        //               });
        //             },
        //           )
        //         : GestureDetector(
        //             child: Icon(
        //               FontAwesomeIcons.pen,
        //               color: Colors.white,
        //               size: MediaQuery.of(context).size.width * .04,
        //             ),
        //             onTap: () {
        //               _pickImageFromGallary();
        //               setState(() {
        //                 update = true;
        //               });
        //             },
        //           ),
        //   ),
        // ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).getProfileData();

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
