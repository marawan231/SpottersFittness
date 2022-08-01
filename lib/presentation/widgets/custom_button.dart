import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';

import '../resources/color_manger.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      this.backgroundColor = ColorManager.myPink,
      required this.onTap})
      : super(key: key);
  final String text;
  final Color backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .075,
        child: Center(
          child: Text(
            text,
            style: textInButtonStyle,
          ),
        ),
      ),
    );
  }
}
