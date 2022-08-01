part of 'countries_cubit.dart';

@immutable
abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoadded extends CountriesState {
  final List<String?> allCountries;
  CountriesLoadded(this.allCountries);
}

class CitiesLoaded extends CountriesState {
  final List<String?> allCites;
  CitiesLoaded(this.allCites);
}

class SpicailstsLoaded extends CountriesState {
  final List<String?> allSpicialists;
  SpicailstsLoaded(this.allSpicialists);
}

class SumbitLoading extends CountriesState {}

class SumbitSuccedded extends CountriesState {
  final Sumbit sumbit;

  SumbitSuccedded(this.sumbit);
}

class SumbitError extends CountriesState {}

class ProfilePicSaved extends CountriesState {}

class ProfileInfoLoaded extends CountriesState {
  final ProfileInfo profileInfo;

  ProfileInfoLoaded(this.profileInfo);
}

class ProfileInfoLoading extends CountriesState {}

class ProfileInfoError extends CountriesState {}

class CertifcationFetchedSuccess extends CountriesState {
  final List<FetchCertifcateModel> listOfCerties;

  CertifcationFetchedSuccess(this.listOfCerties);
}

class CertificationUploading extends CountriesState {}

class CertificationUploadedError extends CountriesState {}
