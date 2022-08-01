import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  final Widget? child;

  const DefaultContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      width: size.width * 0.9,
      height: size.height * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
