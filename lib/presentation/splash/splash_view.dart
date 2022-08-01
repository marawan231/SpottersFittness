import 'dart:async';

import 'package:flutter/material.dart';

import '../../helpers/shared_prefrences.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  void _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  void _goNext() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    });
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.myGrey,
      body: const Center(
        child: Image(
          image: AssetImage(
            ImageAssets.splashLogo,
          ),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
