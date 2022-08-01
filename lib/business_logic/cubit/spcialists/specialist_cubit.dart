import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import '../../../data/repository/spicialist_repository.dart';

part 'specialist_state.dart';

class SpecialistCubit extends Cubit<SpecialistState> {
  SpecialistCubit(this.spicialistRepository) : super(SpecialistInitial());

  final SpicialistRepository spicialistRepository;

  List<String> specialists = [];

  List<String> getAllSpecialists() {
    spicialistRepository.getSpecialists().then((specialists) {
      emit(SpicailstsLoaded(specialists));

      specialists = specialists;
      categories = specialists;
    });
    return specialists;
  }
}
