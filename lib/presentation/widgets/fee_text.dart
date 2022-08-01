import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';

class FeeText extends StatelessWidget {
  const FeeText({Key? key, required this.feeString}) : super(key: key);
  final String? feeString;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.check,
          color: ColorManager.myPink,
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            overflow: TextOverflow.visible,
            feeString!,
            style: simbleSentenceTextStyle,
          ),
        ),
      ],
    );
  }
}
