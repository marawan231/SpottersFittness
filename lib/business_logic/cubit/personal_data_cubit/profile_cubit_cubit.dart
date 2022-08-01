import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/profile_info.dart';
import 'package:spotters_app_clone/data/repository/profile_info_repository.dart';

part 'profile_cubit_state.dart';

class ProfileInfoCubit extends Cubit<ProfileCubitState> {
  ProfileInfoCubit(this.profileInfoRepository) : super(ProfileCubitInitial());

  final ProfileInfoRepository profileInfoRepository;

  void getUserPersonalData() {
    emit(ProfileInfoLoading());

    profileInfoRepository.getUserPersonalData().then((profiles) {
      emit(ProfileInfoLoaded(profiles[0]));
    }).catchError((e) {
      emit(ProfileInfoError());
    });
  }
}
