part of 'terms_privacy_cubit.dart';

@immutable
abstract class TermsPrivacyState {}

class TermsPrivacyInitial extends TermsPrivacyState {}

class TermsLoaded extends TermsPrivacyState {
  final TermsAndConditions termsAndConditions;

  TermsLoaded(this.termsAndConditions);
}

class TermsLoading extends TermsPrivacyState {}

class PrivacyLoaded extends TermsPrivacyState {
  final TermsAndConditions privacy;

  PrivacyLoaded(this.privacy);
}

class PrivacyLoading extends TermsPrivacyState {}
