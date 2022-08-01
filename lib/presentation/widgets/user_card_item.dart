import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/business_logic/cubit/chat_cubit/chat_cubit.dart';
import 'package:spotters_app_clone/data/model/chat_users_model.dart';
import 'package:spotters_app_clone/presentation/widgets/circle_container_with_green_on_top.dart';

import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';

class UserCard extends StatefulWidget {
  const UserCard({Key? key, required this.chatUser, required this.index})
      : super(key: key);
  final ChatUsers chatUser;
  final int index;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  _buildDetailsButton(context) {
    return Expanded(
      flex: 2,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: ColorManager.myPink,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        onPressed: () {
          BlocProvider.of<ChatCubit>(context).getUserDetails(widget.index + 1);
          Navigator.pushNamed(context, Routes.userDetails);
        },
        child: const FittedBox(
          child: Text(
            'DETAILS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  _buildChatIcon(context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.chatUser.isSelected = true;
          });
          Navigator.pushNamed(context, Routes.chat, arguments: {
            'userToken': widget.chatUser.usrToken,
          });
        },
        child: const CircleContainerWithGreenCircleOnTop(
          radius: 15,
          widget: Icon(
            size: 15,
            Icons.message,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _buildCircleAvatar() {
    return Expanded(
      flex: 1,
      child: CircleAvatar(
        radius: 25,
        child: ClipOval(
          child: Image.network(
            widget.chatUser.usrPic!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _buildUserNameAndAddress() {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              widget.chatUser.fname!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.place,
                color: ColorManager.myPurble,
              ),
              Text(
                widget.chatUser.city!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                // textAlign: TextAlign.center,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          height: 105,
          child: Card(
            //clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14))),
            elevation: 6.0,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 4,
                ),
                _buildCircleAvatar(),
                const SizedBox(
                  width: 4,
                ),
                _buildUserNameAndAddress(),
                _buildChatIcon(context),
                const SizedBox(
                  width: 8,
                ),
                _buildDetailsButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
