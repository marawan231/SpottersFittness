import 'package:spotters_app_clone/data/model/contact.dart';
import 'package:spotters_app_clone/data/web_services/contact_web_services.dart';

class ContactRepository {
  final ContactWebServices contactWebServices;

  ContactRepository(this.contactWebServices);

  Future<ContactModel> sendContactMessage(phoneNumber, email, message) async {
    final messageJson = await contactWebServices.sendContactMessage(
        phoneNumber, email, message);
    return ContactModel.fromJson(messageJson);
  }
}
