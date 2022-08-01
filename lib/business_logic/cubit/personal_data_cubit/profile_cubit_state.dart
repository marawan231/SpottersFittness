part of 'profile_cubit_cubit.dart';

@immutable
abstract class ProfileCubitState {}

class ProfileCubitInitial extends ProfileCubitState {}

class ProfileInfoLoaded extends ProfileCubitState {
  final ProfileInfo profileInfo;

  ProfileInfoLoaded(this.profileInfo);
}

class ProfileInfoLoading extends ProfileCubitState {}

class ProfileInfoError extends ProfileCubitState {}
