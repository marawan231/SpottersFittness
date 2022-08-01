import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotters_app_clone/business_logic/cubit/chat_cubit/chat_cubit.dart';
import 'package:spotters_app_clone/data/model/chat_user_details.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/custom_button.dart';
import 'package:spotters_app_clone/presentation/widgets/my_custom_button.dart';

import '../resources/routes_manager.dart';
import '../widgets/custom_image.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  ChatUserDetails? chatUserDetails;
  _buildBodyOfDetailsScreen(context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is UsersDetailsLoaded) {
          chatUserDetails = state.chatUserDetails;
          print(chatUserDetails!.interests);
        }
      },
      builder: (context, state) {
        return state is UsersDetailsLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  buildFirstHalf(context),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * .02,
                  // ),
                  _buildSecondHalf(context),
                ],
              );
      },
    );
  }

  _buildSecondHalf(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.bagShopping,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .05,
                      ),
                      Text(
                        chatUserDetails!.job!,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.locationDot,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .05,
                      ),
                      Text(
                        '${chatUserDetails!.city} , ${chatUserDetails!.country}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.marsAndVenus,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .05,
                      ),
                      Text(
                        chatUserDetails!.gender!,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.a,
                        color: ColorManager.myPurble,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .05,
                      ),
                      Text(
                        chatUserDetails!.age!,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAboutText(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                _buildInterstsText(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                  text: 'CHAT NOW',
                  onTap: () {
                    Navigator.pushNamed(context, Routes.chat, arguments: {
                      'userToken': chatUserDetails!.token,
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _buildInterstsText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Intersets',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            style: const TextStyle(color: Colors.black54),
            '${chatUserDetails!.interests}',
          ),
        ),
      ],
    );
  }

  _buildAboutText(context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(
            'About',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Text(
            style: const TextStyle(color: Colors.black54),
            '${chatUserDetails!.abt}',
          ),
        ),
      ],
    );
  }

  buildFirstHalf(context) {
    return Expanded(
      flex: 1,
      child: Stack(
        fit: StackFit.loose,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                chatUserDetails!.pic!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * .04,
            left: MediaQuery.of(context).size.height * .04,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ${chatUserDetails!.fname} , ${chatUserDetails!.age}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${chatUserDetails!.city} , ${chatUserDetails!.country}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent.withOpacity(.0),
        title: const Text('Details'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.chat, arguments: {
                'userToken': chatUserDetails!.token,
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: ColorManager.myPurble,
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _buildBodyOfDetailsScreen(context),
    );
  }
}
