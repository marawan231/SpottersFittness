import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key, required this.text, required this.icon, required this.onTap})
      : super(key: key);
  final String text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: const BoxDecoration(
            color: ColorManager.myPink,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        width: MediaQuery.of(context).size.width * .07,
        height: MediaQuery.of(context).size.height * .03,
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
