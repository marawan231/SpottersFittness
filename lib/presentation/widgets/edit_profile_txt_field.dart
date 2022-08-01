import 'package:flutter/material.dart';

import 'default_container_for_pay.dart';

class EditProfileTxtField extends StatelessWidget {
  const EditProfileTxtField(
      {Key? key,
      this.hintText = '',
      this.suffixIcon,
      this.controller,
      required this.widget,
      this.width = 0.92,
      this.height = 0.075,
      this.borderColore = Colors.purple})
      : super(key: key);
  final double height;
  final double width;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Widget widget;
  final Color borderColore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget,
        DefaultContainerForPay(
          borderColor: Colors.white,
          width: width,
          height: height,
          child: TextFormField(
            textAlign: TextAlign.left,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 17),
              border: InputBorder.none,
              hintText: hintText,
              alignLabelWithHint: false,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
