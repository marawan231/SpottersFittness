part of 'specialist_cubit.dart';

@immutable
abstract class SpecialistState {}

class SpecialistInitial extends SpecialistState {}

class SpicailstsLoaded extends SpecialistState {
  final List<String?> allSpicialists;
  SpicailstsLoaded(this.allSpicialists);
}
