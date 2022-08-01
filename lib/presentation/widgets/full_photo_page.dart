import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;

  const FullPhotoPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.myPink,
      ),
      body: SizedBox(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
