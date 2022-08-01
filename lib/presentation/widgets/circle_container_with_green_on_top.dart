import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';

class CircleContainerWithGreenCircleOnTop extends StatelessWidget {
  const CircleContainerWithGreenCircleOnTop(
      {Key? key, required this.widget, this.radius})
      : super(key: key);
  final Widget widget;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.passthrough,
      alignment: Alignment.topRight,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: ColorManager.myPurble,
          child: widget,
        ),
        Positioned(
          // right: 0,
          // top: 0,
          child: Container(
            width: 8,
            height: 8,
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xFF5EF831),
            ),
            // constraints: const BoxConstraints(
            //   minWidth: 8,
            //   minHeight: 8,
            // ),
            child: Container(),
          ),
        )
      ],
    );
  }
}
