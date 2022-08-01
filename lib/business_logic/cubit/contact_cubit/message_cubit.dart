import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotters_app_clone/data/model/contact.dart';
import 'package:spotters_app_clone/data/repository/contact_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.contactRepository) : super(MessageInitial());
  final ContactRepository contactRepository;

  void sendContactMessage({phoneNumber, email, message}) {
    contactRepository
        .sendContactMessage(phoneNumber, email, message)
        .then((messageResponse) {
      if (messageResponse.status == 'error') {
        emit(MessageError());
      }
      if (messageResponse.status == 'success') {
        print('success');
        emit(MessageSent(messageResponse));
      }
    }).catchError((e) {
      emit(MessageError());
    });
  }
}
