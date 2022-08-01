import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/widgets/badge.dart';
import 'package:spotters_app_clone/presentation/widgets/drawer_item.dart';
import 'package:spotters_app_clone/presentation/widgets/icon_container.dart';
import 'package:spotters_app_clone/presentation/widgets/my_drawer.dart';

import '../../business_logic/cubit/chat_cubit/chat_cubit.dart';
import '../../business_logic/cubit/countries_cubit/countries_cubit.dart';
import '../../business_logic/cubit/profile_cubit/profile_cubit.dart';
import '../../data/model/fetch_profile.dart';
import '../resources/constants_manager.dart';
import '../resources/routes_manager.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  FetchProfile? profileData;
  _buildBody(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.users);
                },
                child: IconContainer(
                  borderColor: ColorManager.myPurble,
                  widget: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.peopleGroup,
                        size: 50,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const Text(
                        'Users     ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.myPurble,
                        ),
                      )
                    ],
                  ),
                  size: MediaQuery.of(context).size.height * .05,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.chat, arguments: {
                    'usersToken': null,
                  });
                },
                child: IconContainer(
                  borderColor: ColorManager.myPurble,
                  widget: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.message,
                        size: 50,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const Text(
                        'Messages',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.myPurble,
                        ),
                      )
                    ],
                  ),
                  size: MediaQuery.of(context).size.height * .05,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.userPyments);
                },
                child: IconContainer(
                  borderColor: ColorManager.myPurble,
                  widget: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.paypal,
                        size: 50,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const Text(
                        'payments',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.myPurble,
                        ),
                      )
                    ],
                  ),
                  size: MediaQuery.of(context).size.height * .05,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.profile);
                },
                child: IconContainer(
                  borderColor: ColorManager.myPurble,
                  widget: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.person,
                        size: 50,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const Text(
                        'Profile    ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.myPurble,
                        ),
                      )
                    ],
                  ),
                  size: MediaQuery.of(context).size.height * .05,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfileData();
    BlocProvider.of<ChatCubit>(context).getAllChatUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileDataLoaded) {
            profileData = state.profile;

            firstName = state.profile.fname!;
          }
        },
        builder: (context, state) {
          return (state is ProfileDataLoadeing || profileData == null)
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  drawer: const MyDrawer(),
                  key: scaffoldKey,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(150.0),
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * .07),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.notiftcation);
                            },
                            child: const Badge(
                              value: 0,
                              child: FaIcon(FontAwesomeIcons.bell),
                            ),
                          ),
                        )
                      ],
                      bottom: PreferredSize(
                        preferredSize: Size.infinite,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * .52,
                            bottom: MediaQuery.of(context).size.height * .03,
                          ),
                          child: Text(
                            "Hello,\n${profileData!.fname}!",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            // textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      leading: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      title: const Text('Home'),
                      centerTitle: true,
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.07),
                                BlendMode.dstATop),
                            fit: BoxFit.cover,
                            image: const AssetImage('assets/images/jog.jpg'),
                          ),
                        ),
                      ),
                      backgroundColor: ColorManager.myPurble,
                    ),
                  ),
                  body: _buildBody(context),
                );
        },
      ),
    );
  }
}
