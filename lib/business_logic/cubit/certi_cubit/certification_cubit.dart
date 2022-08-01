import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/upload_certi_model.dart';

part 'certification_state.dart';

class CertificationCubit extends Cubit<CertificationState> {
  CertificationCubit() : super(CertificationInitial());
}
