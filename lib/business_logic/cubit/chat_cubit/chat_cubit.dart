import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/chat_user_details.dart';
import 'package:spotters_app_clone/data/model/chat_users_model.dart';
import 'package:spotters_app_clone/data/repository/chat_repositroy.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepository) : super(ChatInitial());

  final ChatRepository chatRepository;

  List allUsers = [];

  void getAllChatUsers() {
    emit(UsersLoading());
    chatRepository.getUsers().then((users) {
      emit(UsersLoaded(users));
      allUsers = users;
    }).catchError((error) {
      emit(GetUsersError());
    });
  }

  void getUserDetails(userIndex) {
    emit(UsersDetailsLoading());
    chatRepository.getUserDetails(userIndex).then((userDetails) {
      emit(UsersDetailsLoaded(userDetails));
    }).catchError((error) {
      emit(UsersDetailsError());
    });
  }
}
