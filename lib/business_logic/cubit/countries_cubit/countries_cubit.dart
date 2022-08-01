// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/fetch_certifcate_model.dart';
import 'package:spotters_app_clone/data/model/sumbit_model.dart';
import 'package:spotters_app_clone/data/repository/certi_repository.dart';
import 'package:spotters_app_clone/data/repository/cites_repository.dart';
import 'package:spotters_app_clone/data/repository/countries_repoistory.dart';
import 'package:spotters_app_clone/data/repository/profile_pic_repository.dart';
import 'package:spotters_app_clone/data/repository/sumbit_repository.dart';

import '../../../data/model/profile_info.dart';
import '../../../data/model/upload_certi_model.dart';
import 'package:http/http.dart' as http;
import '../../../data/repository/profile_info_repository.dart';
import '../../../data/repository/spicialist_repository.dart';
import '../../../presentation/resources/constants_manager.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountriesRepoistory countriesRepoistory;
  final CitiesRepository citiesRepository;
  final SpicialistRepository spicialistRepository;
  final SumbitRepository sumbitRepository;
  final ProfilePicRepository profilePicRepository;
  final ProfileInfoRepository profileInfoRepository;
  final CertiRepository certiRepository;

  List<String> specialists = [];
  List<String> countriesName = [];
  List<String> citiesNames = [];
  List certificates = [];
  int countryCode = 1;

  CountriesCubit(
      this.countriesRepoistory,
      this.citiesRepository,
      this.spicialistRepository,
      this.sumbitRepository,
      this.profilePicRepository,
      this.profileInfoRepository,
      this.certiRepository)
      : super(CountriesInitial());

  void getUserPersonalData() {
    emit(ProfileInfoLoading());

    profileInfoRepository.getUserPersonalData().then((profiles) {
      emit(ProfileInfoLoaded(profiles[0]));
    }).catchError((e) {
      emit(ProfileInfoError());
    });
  }

  void clearCitiesMenu() {
    citiesNames = ['', ''];
  }

  List<String> getAllSpecialists() {
    spicialistRepository.getSpecialists().then((specialists) {
      categories = specialists;
      emit(SpicailstsLoaded(specialists));
      specialists = specialists;
    });
    return specialists;
  }

  List<String> getAllCountries() {
    countriesRepoistory.getCountries().then((countries) {
      emit(CountriesLoadded(countries));
      countries = countriesName;
    });
    return countriesName;
  }

  List<String> getAllCities() {
    citiesRepository.getCities(countryCode: countryCode).then((cities) {
      emit(CitiesLoaded(cities));
      cities = citiesNames;
    });
    return citiesNames;
  }

  void sumbitForm({
    required String country,
    required String gender,
    required String city,
    required String dateOfBirth,
    required String experince,
    required String specialicits,
    required String certificationText,
    required String aboutMeText,
  }) {
    emit(SumbitLoading());

    sumbitRepository
        .userSumbit(
      country,
      gender,
      city,
      dateOfBirth,
      experince,
      specialicits,
      certificationText,
      aboutMeText,
    )
        .then((sumbitData) {
      if (sumbitData.status == 'success') {
        emit(SumbitSuccedded(sumbitData));
      } else {
        emit(SumbitError());
      }
    }).catchError((e) {
      emit(SumbitError());
      print(e.toString());
    });
  }

  void saveProfilePic({required imagePath}) {
    profilePicRepository.saveProfilePic(imagePath).then((userInfo) {
      emit(ProfilePicSaved());
    }).catchError((e) {
      print(e.toString());
    });
  }

  void getCertis() {
    certiRepository.fetchCerti().then((certi) {
      emit(CertifcationFetchedSuccess(certi));
    }).catchError((e) {
      emit(CertificationUploadedError());
      print(e.toString());
    });
  }

  void deleteCerti(certiId) async {
    var headers = {'Cookie': 'PHPSESSID=34823a942d4c00609722edd41047fe8b'};
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://www.algowid.net/sf_api/index.php?act=certiDelete&user=$userId&cid=$certiId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
  }
}
