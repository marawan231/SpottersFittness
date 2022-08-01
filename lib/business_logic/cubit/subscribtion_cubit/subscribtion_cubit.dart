import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/data/model/subscribtion_model.dart';
import 'package:spotters_app_clone/data/repository/subscribtion_repoistory.dart';

part 'subscribtion_state.dart';

class SubscribtionCubit extends Cubit<SubscribtionState> {
  final SubscriptionRepoistory subscriptionRepoistory;
  SubscribtionCubit(this.subscriptionRepoistory) : super(SubscribtionInitial());

  void getUserSubscribtion() {
    emit(SubscribtionLoding());
    subscriptionRepoistory.userSubscribtion().then((userSubscribtion) {
      emit(SubscribtionSuccedded(userSubscribtion));
    }).catchError((e) {
      emit(SubscribtionErorr(e));
    });
  }
}
