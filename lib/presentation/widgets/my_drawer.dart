import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotters_app_clone/business_logic/cubit/profile_cubit/profile_cubit.dart';
import 'package:spotters_app_clone/presentation/home_page/home_page.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import '../../data/model/fetch_profile.dart';
import '../../helpers/shared_prefrences.dart';
import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';
import 'drawer_item.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  FetchProfile? profileData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFC98BF3),
      child: Container(
        decoration: const BoxDecoration(
          gradient: ColorManager.appBarGradientColor,
        ),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .1,
            top: MediaQuery.of(context).size.width * .07,
          ),
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  // padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * .13,
                    child: ClipOval(
                      child: Image.network(
                        BlocProvider.of<ProfileCubit>(context).glopalUserPic!,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .03,
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    firstName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            DrawerItem(
              onTap: () {
                Navigator.pop(context);
              },
              text: 'Home',
              icon: Icons.home,
            ),
            DrawerItem(
              text: 'Users',
              icon: FontAwesomeIcons.user,
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.users);
              },
            ),
            DrawerItem(
              text: 'Chat',
              icon: Icons.chat,
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.chat);
              },
            ),
            DrawerItem(
              text: 'User Payments',
              icon: FontAwesomeIcons.paypal,
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.userPyments);
              },
            ),
            DrawerItem(
              text: 'Notifications',
              icon: FontAwesomeIcons.bell,
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.notiftcation);
              },
            ),
            DrawerItem(
              text: 'Settings',
              icon: Icons.settings,
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.settings);
              },
            ),
            DrawerItem(
              text: 'My Profile',
              icon: FontAwesomeIcons.user,
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.profile);
              },
            ),
            DrawerItem(
              text: 'Contact Us',
              icon: Icons.phone,
              onTap: () {
                Navigator.popAndPushNamed(context, Routes.contactUs);
              },
            ),
            DrawerItem(
              text: 'Log Out',
              icon: Icons.logout,
              onTap: () {
                CacheHelper.removeData(key: 'userId');
                CacheHelper.removeData(key: 'userPic');
                CacheHelper.removeData(key: 'goToHomePage');

                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
