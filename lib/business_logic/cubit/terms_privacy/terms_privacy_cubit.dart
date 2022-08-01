import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/terms_and_conditions.dart';
import 'package:spotters_app_clone/data/repository/privacy_repository.dart';
import 'package:spotters_app_clone/data/repository/terms_conditions_repository.dart';

part 'terms_privacy_state.dart';

class TermsPrivacyCubit extends Cubit<TermsPrivacyState> {
  final TermsAndConditionsReopsitory termsAndConditionsReopsitory;
  final PrivacyRepositroy privacyRepositroy;

  TermsPrivacyCubit(this.termsAndConditionsReopsitory, this.privacyRepositroy)
      : super(TermsPrivacyInitial());

  void getTermsAndConditions() {
    emit(TermsLoading());

    termsAndConditionsReopsitory.getTermsAndConditions().then((terms) {
      emit(TermsLoaded(terms));
    }).catchError((e) {
      print(e.toString());
    });
  }

  void getPrivacy() {
    emit(PrivacyLoading());

    privacyRepositroy.getPrivacy().then((privacy) {
      emit(PrivacyLoaded(privacy));
    }).catchError((e) {
      print(e.toString());
    });
  }
}
