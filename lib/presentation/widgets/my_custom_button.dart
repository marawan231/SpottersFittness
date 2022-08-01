import 'package:flutter/material.dart';

import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          backgroundColor: ColorManager.myPink,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .31,
            vertical: MediaQuery.of(context).size.height * .02,
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: textInButtonStyle,
        ),
      ),
    );
  }
}
