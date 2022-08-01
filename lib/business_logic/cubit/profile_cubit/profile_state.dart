part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileDataLoaded extends ProfileState {
  final FetchProfile profile;

  ProfileDataLoaded(this.profile);
}

class ProfileDataLoadeing extends ProfileState {}

class ProfileDataUpdated extends ProfileState {
  final UpdatedProfile updatedProfile;

  ProfileDataUpdated(this.updatedProfile);
}

class ProfilePicUpdatingLoading extends ProfileState {}

class ProfilePicUpdatingSuccess extends ProfileState {}

class ProfilePicUpdatingEroor extends ProfileState {}

class DeleteAccLoading extends ProfileState {}

class DeleteAccSuccess extends ProfileState {
  final DeleteAccount deleteAccount;

  DeleteAccSuccess(this.deleteAccount);
}

class DeleteAccEroor extends ProfileState {}

class UploadingImage extends ProfileState {}

class GalleryOptionSelected extends ProfileState {}
