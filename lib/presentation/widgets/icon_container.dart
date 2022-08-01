import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';

class IconContainer extends StatelessWidget {
  const IconContainer(
      {Key? key,
      required this.widget,
      this.size = 8.0,
      this.borderColor = ColorManager.myPink})
      : super(key: key);
  final Widget widget;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                )
              ],
            ),
            padding: EdgeInsets.all(size),
            child: widget,
          ),
        ],
      ),
    );
  }
}
