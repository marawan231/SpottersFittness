import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:spotters_app_clone/business_logic/cubit/videos_cubit/videos_cubit.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/my_custom_button.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;
import 'package:spotters_app_clone/business_logic/cubit/countries_cubit/countries_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';
import '../resources/styles_manager.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_textfield_personal.dart';

class UploadTrainingVideoView extends StatefulWidget {
  const UploadTrainingVideoView({Key? key}) : super(key: key);

  @override
  State<UploadTrainingVideoView> createState() =>
      _UploadTrainingVideoViewState();
}

class _UploadTrainingVideoViewState extends State<UploadTrainingVideoView> {
  String? selectedCategor;
  TextEditingController titleController = TextEditingController();
  TextEditingController addVideoController = TextEditingController();
  File? video;
  var videoName;
  PickedFile? _videoFile;
  final ImagePicker _picker = ImagePicker();
  bool update = false;
  int selectedCatId = 0;

  int chooseIdForSelectedCat(String selectedCat) {
    if (selectedCat == 'Aerobics') {
      return 1;
    }
    if (selectedCat == 'Running') {
      return 2;
    }
    if (selectedCat == 'Yoga') {
      return 3;
    } else {
      return 4;
    }
  }

  Future _pickVideoFromGallary() async {
    try {
      final pickedFile = await _picker.getVideo(source: ImageSource.gallery);
      setState(() {
        _videoFile = pickedFile;
        addVideoController.text = pickedFile!.path;
      });
    } catch (e) {
      //print("Image picker error ${e!}");
      print("Image picker error");
    }
  }

  //'https://www.algowid.net/sf_api/index.php?act=postVideo&user=9&title=$title&cat=$category'

  // Future uploadVideo(File videoFile, title, category) async {
  //   var uri = Uri.parse(
  //       'https://www.algowid.net/sf_api/index.php?act=postVideo&user=9&title=$title&cat=1');
  //   var request = MultipartRequest("POST", uri);

  //   var multipartFile = await MultipartFile.fromPath("vidfile", videoFile.path);
  //   request.files.add(multipartFile);
  //   StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print("Video uploaded");
  //   } else {
  //     print("Video upload failed");
  //   }
  // }

  _buildBody(context) {
    return BlocConsumer<VideosCubit, VideosState>(
      listener: (context, state) {
        if (state is VideoUploadError) {
          showScaffold(text: 'Error Uploading', context: context);
        }
        if (state is VideoUploadedSuccess) {
          titleController.clear();
          addVideoController.clear();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildUpperBody(context),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .18),
                child: state is VideoUploadLoading
                    ? const CircularProgressIndicator()
                    : MyCustomButton(
                        text: 'SUMBIT',
                        onTap: () {
                          BlocProvider.of<VideosCubit>(context).uploadVideo(
                            _videoFile!,
                            context,
                            titleController.text,
                            chooseIdForSelectedCat(selectedCategor!),
                          );

                          //   uploadVideo(_videoFile!);
                        }),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildUpperBody(context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildText1(),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          _buildText2(),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          _buildTextField(),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          _buildDropDown(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          _buildTextFieldAndButton(context),
        ],
      ),
    );
  }

  _buildText1() {
    return const Text(
      'Upload Training Video',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  _buildText2() {
    return const Text(
      'video content may  include an introduction or explaination of your Training methods and Training techniques',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    );
  }

  _buildTextField() {
    return PersonalTextField(
      controller: titleController,
      hintText: 'Add Text',
      widget: const Text(
        'Video Title ',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  _buildDropDown(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catogeries',
          style: personalInfoTextTopOfTextField,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: ColorManager.myWhite,
            border: Border.all(color: ColorManager.myPurble, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: categories
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
              isExpanded: true,
              iconSize: 36,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color.fromARGB(255, 185, 180, 180),
              ),
              onChanged: (value) {
                setState(() {
                  selectedCategor = value as String?;
                });
              },
              value: selectedCategor,
            ),
          ),
        ),
      ],
    );
  }

  _buildTextFieldAndButton(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal: MediaQuery.of(context).size.width * .05,
          vertical: MediaQuery.of(context).size.height * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: PersonalTextField(
              controller: addVideoController,
              hintText: 'Add File Video',
              widget: const Text(''),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .02,
          ),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                backgroundColor: ColorManager.myPurble,
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * .07,
                ),
              ),
              child: const Text(
                'choose video',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _pickVideoFromGallary();
                // Navigator.pushReplacementNamed(context, Routes.paymentSuccess);
              },
            ),
          ),
        ],
      ),
    );
  }

/*
*/

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VideosCubit>(context).uploadVideo;
    BlocProvider.of<CountriesCubit>(context).getAllSpecialists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        // backgroundColor: const Color(0xFFC98CF3),
        title: const Text('Upload Training Videos'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }
}
