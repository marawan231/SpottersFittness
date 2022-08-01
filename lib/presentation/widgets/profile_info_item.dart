import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';

class ProfileInfoItem extends StatelessWidget {
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final String title;
  final GestureTapCallback? onTap;
  final double size;
  final Widget widget;
  const ProfileInfoItem({
    Key? key,
    required this.title,
    this.onTap,
    this.leadingIcon,
    this.leadingIconColor = Colors.white,
    this.size = 24,
    this.widget = const Icon(
      Icons.arrow_forward_ios,
      color: Color(0xFF8A8989),
      size: 14,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.only(
          left: 15,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black26),
          ),
          color: Colors.white,
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: leadingIcon != null
                ? [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: ColorManager.myPurble,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        leadingIcon,
                        size: size,
                        color: leadingIconColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    widget,
                  ]
                : [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF8A8989),
                      size: 14,
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
