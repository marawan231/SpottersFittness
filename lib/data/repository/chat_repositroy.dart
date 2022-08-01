import 'package:spotters_app_clone/data/model/chat_user_details.dart';
import 'package:spotters_app_clone/data/model/chat_users_model.dart';
import 'package:spotters_app_clone/data/model/fetch_certifcate_model.dart';
import 'package:spotters_app_clone/data/web_services/certi_web_services.dart';
import 'package:spotters_app_clone/data/web_services/chat_web_services.dart';

class ChatRepository {
  final ChatWebServices chatWebServices;

  ChatRepository(this.chatWebServices);

  Future<List<ChatUsers>> getUsers() async {
    List<dynamic> usersList = await chatWebServices.getUsers();
    final List<ChatUsers> listOfUsers =
        usersList.map((user) => ChatUsers.fromJson(user)).toList();

    return listOfUsers;
  }

  Future<ChatUserDetails> getUserDetails(userIndex) async {
    List<dynamic> usersDetailsList =
        await chatWebServices.getUserDetails(userIndex);
    final List<ChatUserDetails> listOfUsersDetails =
        usersDetailsList.map((user) => ChatUserDetails.fromJson(user)).toList();

    return listOfUsersDetails[0];
  }
}
