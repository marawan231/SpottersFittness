import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:spotters_app_clone/presentation/resources/assets_manager.dart';

import '../../data/model/videos_model.dart';

List<PickedFile> cert = [];

List<String?> categories = [];
const String baseUrl = 'https://www.algowid.net/sf_api/index.php';
String? userPic;
List<VideosList>? listOfVideos = [];
String? regUserPic;
String? userEmail;
var userId;
String? profilePic;
String firstName = '';

List<PickedFile> certifcates = [];
showScaffold({required var text, required context, Color? color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text.toString(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    ),
  );
}
