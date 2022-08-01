import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';

class DefaultContainerForPay extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;
  final Color borderColor;

  const DefaultContainerForPay({
    Key? key,
    this.child,
    this.width = 0.9,
    this.height = .08,
    this.borderColor = ColorManager.myPink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      width: size.width * width,
      height: size.height * height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
