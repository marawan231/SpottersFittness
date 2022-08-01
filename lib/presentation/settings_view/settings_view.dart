import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/widgets/custom_switch_button.dart';

import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';
import '../widgets/profile_info_item.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _enable = false;

  _buildBody() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          ProfileInfoItem(
              title: 'Terms and Conditions',
              leadingIcon: Icons.book,
              onTap: () {
                Navigator.pushNamed(context, Routes.terms);
              }),
          ProfileInfoItem(
            onTap: () {
              Navigator.pushNamed(context, Routes.privacyPolicy);
            },
            title: 'Privacy Policy',
            leadingIcon: Icons.lock,
          ),
          ProfileInfoItem(
            title: 'Notification',
            leadingIcon: Icons.notifications_off,
            size: 22,
            widget: CustomSwitch(
              value: _enable,
              onChanged: (bool val) {
                setState(() {
                  _enable = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        //backgroundColor: const Color(0xFFCE94F5),
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }
}
