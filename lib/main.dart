import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../app/app.dart';
import 'helpers/shared_prefrences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  runApp(MyApp());
}
