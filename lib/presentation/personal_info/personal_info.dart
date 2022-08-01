// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;
import 'package:spotters_app_clone/business_logic/cubit/countries_cubit/countries_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:spotters_app_clone/business_logic/cubit/profile_cubit/profile_cubit.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/custom_drop_down.dart';
import 'package:spotters_app_clone/presentation/widgets/custom_textfield_personal.dart';
import 'package:spotters_app_clone/presentation/widgets/icon_container.dart';
import 'package:spotters_app_clone/presentation/widgets/my_custom_button.dart';

import '../../data/model/fetch_certifcate_model.dart';
import '../../helpers/shared_prefrences.dart';
import '../resources/routes_manager.dart';
import '../widgets/default_container_for_pay.dart';

DateTime date = DateTime(2022, 7, 1);

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController certificationController = TextEditingController();
  TextEditingController uploadCertificationController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController dofController = TextEditingController();

  List<String?> allCountries = [];
  List<String?> specialest = [];
  List<String?> cities = [];
  List<FetchCertifcateModel> allCerties = [];

  final gender = ['Male', 'Female', 'Other'];
  final List<String> cameraChoices = ['camera', 'gallery'];
  var source;
  String? selectedGender;
  String? selectedCountry;
  String? selectedCity;
  String? selectedSpecialist;
  File? image;
  var imageName;
  PickedFile? _imageFile;
  PickedFile? certiFile;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future<String?> uploadCerti(PickedFile imageFile) async {
    setState(() {
      isLoading = true;
    });
    cert.add(certiFile!);
    var uri = Uri.parse(
        'https://www.algowid.net/sf_api/index.php?act=certiUpload&user=$userId');
    final mimeTypeData =
        lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])!.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', uri);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('cpic', imageFile.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);

    // add headers if needed
    //imageUploadRequest.headers.addAll(<some-headers>);

    try {
      final streamedResponse = await imageUploadRequest.send();
      print(streamedResponse.reasonPhrase.toString());
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body.toString());
      Map mapRes = json.decode(response.body);
      if (mapRes['status'] == 'success') {
        setState(() {
          certiFile = null;
          isLoading = false;
        });
        showScaffold(
          text: 'certifcated Uploaded',
          context: context,
          color: Colors.green,
        );
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future _pickCertiFromGallary() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        certiFile = pickedFile;
        //     uploadCerti(pickedFile!);
      });
    } catch (e) {
      //print("Image picker error ${e!}");
      print("Image picker error");
    }
  }

  Widget _buildSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            print('object 1');
            setState(() {
              source = ImageSource.camera;
            });
            Navigator.pop(context);
          },
          child: const Text('CAMERA'),
        ),
        TextButton(
          onPressed: () {
            print('object 2');
            setState(() {
              source = ImageSource.gallery;
            });
            Navigator.pop(context);
          },
          child: const Text('GALLERY'),
        ),
      ],
    );
  }

  Future _pickImageFromGallary() async {
    await showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => _buildSheet());
    print(source.toString());
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
        regUserPic = _imageFile!.path;
      });
    } catch (e) {
      //print("Image picker error ${e!}");
      print("Image picker error + ${e.toString()}");
    }
  }

  // Future<File> saveImgPermanantly(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);

  //   final image = File('${directory.path}/$name');
  //   return File(imagePath).copy(image.path);
  // }

  _buildImageContainer(context) {
    BlocProvider.of<ProfileCubit>(context).uploadImage(_imageFile!.path);
    return Stack(
      children: [
        ClipOval(
          child: Image.file(
            File(_imageFile!.path),
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 0,
          top: 80,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: ColorManager.myPink,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: GestureDetector(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * .06,
              ),
              onTap: () {
                _pickImageFromGallary();
              },
            ),
          ),
        )
      ],
    );
  }

  _buildCameraButtonAndText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _imageFile != null
            ? _buildImageContainer(context)
            : IconContainer(
                widget: GestureDetector(
                  onTap: () => _pickImageFromGallary(),
                  child: Icon(
                    Icons.camera_enhance_outlined,
                    color: ColorManager.myPurble,
                    size: MediaQuery.of(context).size.width * .12,
                  ),
                ),
                size: 20,
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .06,
        ),
        Text(
          image != null ? ' Profile Picture' : 'add your profile picture',
          style: questionTextStyle.copyWith(
              color: ColorManager.myGrey, fontFamily: 'Poppins'),
        ),
      ],
    );
  }

  _buildCountryDropDownMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          style: personalInfoTextTopOfTextField,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.myPurble, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              // value: selectedCountry ?? '',
              items: allCountries
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
                  selectedCountry = value as String?;
                });

                if (selectedCountry == 'United States') {
                  selectedCity = null;
                  BlocProvider.of<CountriesCubit>(context).countryCode = 2;

                  BlocProvider.of<CountriesCubit>(context).getAllCities();
                  setState(() {
                    selectedCountry = value as String?;
                  });
                }
                if (value == 'Canada') {
                  selectedCity = null;
                  BlocProvider.of<CountriesCubit>(context).countryCode = 1;
                  // BlocProvider.of<CountriesCubit>(context).clearCitiesMenu();
                  BlocProvider.of<CountriesCubit>(context).getAllCities();
                  setState(() {
                    selectedCountry = value as String?;
                  });
                }
              },
              value: selectedCountry,
            ),
          ),
        ),
      ],
    );
  }

  _buildGenderDropDownMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: personalInfoTextTopOfTextField,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.myPurble, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: gender
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
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
                  selectedGender = value as String?;
                });
              },
              value: selectedGender,
            ),
          ),
        ),
      ],
    );
  }
  //   return CustomDropDown(
  //     selectedItem: selectedGender,
  //     dropDownList: gender,
  //     dropDownText: 'Gender',
  //   );
  // }

  _buildCityDropDownMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City',
          style: personalInfoTextTopOfTextField,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.myPurble, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: cities
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
                  selectedCity = value as String?;
                });
              },
              value: selectedCity,
            ),
          ),
        ),
      ],
    );
  }

  _buildBody(context) {
    return BlocConsumer<CountriesCubit, CountriesState>(
      listener: (context, state) {
        print(state.toString());
        if (state is CountriesLoadded) {
          print('this is data from api ' + state.allCountries.toString());
          allCountries = state.allCountries;
          print('this is all countries data ' + allCountries.toString());
        } else if (state is CitiesLoaded) {
          print('this is data from api ' + state.allCites.toString());
          cities = state.allCites;
          print('this is all countries data ' + cities.toString());
        } else if (state is SpicailstsLoaded) {
          print('this is data from api ' + state.allSpicialists.toString());
          specialest = state.allSpicialists;
          print('this is all countries data ' + cities.toString());
        } else if (state is CertifcationFetchedSuccess) {
          allCerties = state.listOfCerties;
          print(state.listOfCerties);
        } else if (state is SumbitSuccedded) {
          CacheHelper.saveData(
            key: 'goToHomePage',
            value: state.sumbit.usrID,
          );
          showScaffold(
            text: 'Profile Created Successfull',
            context: context,
            color: Colors.green,
          );
          Navigator.pushNamed(context, Routes.homePage);
        } else if (state is SumbitError) {
          print('error');
          showScaffold(text: 'error', context: context);
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  left: MediaQuery.of(context).size.width * .05,
                ),
                child: Column(
                  children: [
                    _buildCameraButtonAndText(context),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  left: MediaQuery.of(context).size.width * .05,
                  right: MediaQuery.of(context).size.width * .05,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCountryDropDownMenu(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildCityDropDownMenu(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildGenderDropDownMenu(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildDateOfBirthTxtField(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildYearsOfTrainingTxtField(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildSpecialestDropDownButton(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildCertificationTextField(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allCerties.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return _buildCertifcateItem(
                                    allCerties[index], index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildUploadCirtificationTextField(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildDescTextField(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    _buildSumbitButton(state),
                  ],
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * .02,
              // ),
            ],
          ),
        );
      },
    );
  }

  _buildDateOfBirthTxtField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Of Birth',
          style: personalInfoTextTopOfTextField,
        ),
        DefaultContainerForPay(
          borderColor: ColorManager.myPurble,
          width: 0.92,
          height: 0.075,
          child: TextFormField(
            textAlign: TextAlign.left,
            controller: dofController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 17),
              border: InputBorder.none,
              hintText: 'DD       MM       YYYY',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.pink,
                ),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1940),
                    lastDate: DateTime(2030),
                  );

                  setState(() {
                    dofController.clear();
                    dofController.text =
                        '${newDate!.year}/${newDate.month}/${newDate.day}';
                  });

                  if (newDate == null) {
                    return showScaffold(
                      text: 'chosse birthday correct',
                      context: context,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildYearsOfTrainingTxtField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            'how many years have you been training ?',
            style: personalInfoTextTopOfTextField,
          ),
        ),
        DefaultContainerForPay(
          borderColor: ColorManager.myPurble,
          width: 0.92,
          height: 0.075,
          child: TextFormField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            controller: yearsController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 17),
              border: InputBorder.none,
              hintText: '   00   ',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
            ),
          ),
        ),
      ],
    );
  }

  _buildSpecialestDropDownButton(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specialist',
          style: personalInfoTextTopOfTextField,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.myPurble, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: specialest
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
                  selectedSpecialist = value as String?;
                });
              },
              value: selectedSpecialist,
            ),
          ),
        ),
      ],
    );
  }

  _buildSumbitButton(CountriesState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: state is SumbitLoading
          ? CircularProgressIndicator()
          : MyCustomButton(
              text: 'SUMBIT',
              onTap: () {
                if (selectedSpecialist == null ||
                    dofController.text.isEmpty ||
                    selectedGender == null ||
                    selectedCountry == null ||
                    selectedCity == null ||
                    aboutMeController.text.isEmpty ||
                    certificationController.text.isEmpty) {
                  showScaffold(
                    text: 'please complete informations',
                    context: context,
                    color: Colors.red,
                  );
                } else {
                  BlocProvider.of<CountriesCubit>(context).sumbitForm(
                    country: selectedCountry!,
                    gender: selectedGender!,
                    city: selectedCity!,
                    dateOfBirth: dofController.text,
                    experince: yearsController.text,
                    specialicits: selectedSpecialist!,
                    certificationText: certificationController.text,
                    aboutMeText: aboutMeController.text,
                  );
                }

                //
              }),
    );
  }

  _buildDescTextField(context) {
    return PersonalTextField(
      controller: aboutMeController,
      height: .18,
      hintText: 'please right a short description of yourself',
      widget: const Text(
        'About Myself',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildCertifcateItem(FetchCertifcateModel certifcateModel, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        // fit: StackFit.passthrough,
        // alignment: Alignment.topRight,
        children: [
          Container(
            width: 160,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Image.network(certifcateModel.cpic!, fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.purple,
              child: Center(
                child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 10,
                    ),
                    onPressed: () {
                      setState(() {
                        BlocProvider.of<CountriesCubit>(context)
                            .deleteCerti(certifcateModel.cid);
                      });
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCertifcateItem(PickedFile imageFile, index) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //     child: Stack(
  //       // fit: StackFit.passthrough,
  //       // alignment: Alignment.topRight,
  //       children: [
  //         Container(
  //           width: 160,
  //           height: 100,
  //           decoration: BoxDecoration(
  //             color: Colors.transparent,
  //             border: Border.all(
  //               color: Colors.black,
  //             ),
  //           ),
  //           child: Image.file(File(imageFile.path), fit: BoxFit.cover),
  //         ),
  //         Positioned(
  //           top: 0,
  //           right: 0,
  //           child: CircleAvatar(
  //             radius: 12,
  //             backgroundColor: Colors.purple,
  //             child: Center(
  //               child: IconButton(
  //                   icon: Icon(
  //                     Icons.close,
  //                     color: Colors.white,
  //                     size: 10,
  //                   ),
  //                   onPressed: () {
  //                     setState(() {
  //                       certifcates.removeAt(index);
  //                     });
  //                   }),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _buildUploadCirtificationTextField(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .05,
        //vertical: MediaQuery.of(context).size.height * .02
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: _pickCertiFromGallary,
              child: Container(
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.purple,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    certiFile == null
                        ? 'Upload Certificatin by clicking here'
                        : certiFile!.path.split('/').last,
                    style: TextStyle(
                      color: ColorManager.myGrey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .02,
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      backgroundColor: Colors.purple.shade900,
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * .07,
                      ),
                    ),
                    child: const Text(
                      'UPLOAD',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      uploadCerti(certiFile!);
                      setState(() {});
                      // Navigator.pushReplacementNamed(context, Routes.paymentSuccess);
                    },
                  ),
                )
        ],
      ),
    );
  }

  _buildCertificationTextField(context) {
    return PersonalTextField(
      controller: certificationController,
      height: .15,
      hintText: 'Add Text',
      widget: const Text(
        'Certification',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<CountriesCubit>(context).getAllCountries();
    BlocProvider.of<CountriesCubit>(context).getAllSpecialists();
    BlocProvider.of<CountriesCubit>(context).getAllCities();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CountriesCubit>(context).getCertis();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.myPurble,
        title: const Text('Add Your Personal Info'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    ));
  }
}
