part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class UsersLoading extends ChatState {}

class UsersLoaded extends ChatState {
  final List<ChatUsers> chatUsers;

  UsersLoaded(this.chatUsers);
}

class GetUsersError extends ChatState {}

class UsersDetailsLoading extends ChatState {}

class UsersDetailsLoaded extends ChatState {
  final ChatUserDetails chatUserDetails;

  UsersDetailsLoaded(this.chatUserDetails);
}

class UsersDetailsError extends ChatState {}
