part of 'message_cubit.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}

class MessageSent extends MessageState {
  final ContactModel contact;

  MessageSent(this.contact);
}

class MessageError extends MessageState {}
