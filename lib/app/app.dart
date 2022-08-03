import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import '../helpers/shared_prefrences.dart';
import '../presentation/resources/routes_manager.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // named constructor

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  var userIdFromDatabase = CacheHelper.getData(key: 'userId');
  var userPicFromDatabase = CacheHelper.getData(key: 'userPic');
  var userGoToHomePage = CacheHelper.getData(key: 'goToHomePage');
  var userGoToProfileInfoScren =
      CacheHelper.getData(key: 'profieNotComletedYet');

  String getInitialScreen(onBoarding) {
    if (onBoarding != null) {
      if (userGoToHomePage != null) {
        userId = userIdFromDatabase;
        userPic = userPicFromDatabase;
        return Routes.homePage;
      } else {
        return userGoToProfileInfoScren != null
            ? Routes.personalInfo
            : Routes.loginRoute;
      }
    } else {
      return Routes.splashRoute;
    }
  }

  RouteGenerator routeGenerator = RouteGenerator();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routeGenerator.getRoute,
      initialRoute: getInitialScreen(onBoarding),
    );
  }
}
