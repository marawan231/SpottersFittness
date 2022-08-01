part of 'subscribtion_cubit.dart';

@immutable
abstract class SubscribtionState {}

class SubscribtionInitial extends SubscribtionState {}

class SubscribtionSuccedded extends SubscribtionState {
  final SubscribtionModel subscribtionModel;

  SubscribtionSuccedded(this.subscribtionModel);
}

class SubscribtionLoding extends SubscribtionState {}

class SubscribtionErorr extends SubscribtionState {
  final String errorText;

  SubscribtionErorr(this.errorText);
}
