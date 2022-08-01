import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';

import 'default_container_for_pay.dart';

class PersonalTextField extends StatelessWidget {
  const PersonalTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    this.controller,
    required this.widget,
    this.width = 0.92,
    this.height = 0.075,
    this.borderColore = ColorManager.myPurble,
    this.validator,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);
  final double height;
  final double width;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Widget widget;
  final String? Function(String?)? validator;
  final Color borderColore;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  // final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget,
        DefaultContainerForPay(
          borderColor: borderColore,
          width: width,
          height: height,
          child: TextFormField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            validator: validator,
            textAlign: TextAlign.left,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 17),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
