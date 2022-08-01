import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/verify_otb.dart';
import 'package:spotters_app_clone/data/repository/verfying_repository.dart';

part 'verfiy_state.dart';

class VerfiyCubit extends Cubit<VerfiyState> {
  VerfiyCubit(this.verfyingRepoistry) : super(VerfiyInitial());
  final VerfyingRepoistry verfyingRepoistry;

  void verifyOtp({required String otp}) {
    emit(VerifyOtpLoading());

    verfyingRepoistry.verifyOtp(otp).then((result) {
      if (result.status == 'error') {
        emit(VerifyOtpError(result.error!.first));
      }
      if (result.status == 'success') {
        emit(VerifyOtpSuccedded(result));
      }
    }).catchError((e) {
      emit(VerifyOtpError(e));
    });
  }
}
