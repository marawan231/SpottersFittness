import 'package:flutter/material.dart';

import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.dropDownText,
    required this.child,
  }) : super(key: key);

  final String dropDownText;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dropDownText,
          style: personalInfoTextTopOfTextField,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        child,
      ],
    );
  }
}
