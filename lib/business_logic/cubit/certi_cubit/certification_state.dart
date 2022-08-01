part of 'certification_cubit.dart';

@immutable
abstract class CertificationState {}

class CertificationInitial extends CertificationState {}

class CertificationUploadedSucessfully extends CertificationState {
  final UploadVCertiModel uploadVCertiModel;

  CertificationUploadedSucessfully(this.uploadVCertiModel);
}

class CertificationUploading extends CertificationState {}

class CertificationUploadedError extends CertificationState {}
