import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/business_logic/cubit/contact_cubit/message_cubit.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/custom_textfield_personal.dart';

import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';

class ContacUsView extends StatefulWidget {
  const ContacUsView({Key? key}) : super(key: key);

  @override
  State<ContacUsView> createState() => _ContacUsViewState();
}

class _ContacUsViewState extends State<ContacUsView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  _buildButton(context, {required String text}) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is MessageSent) {
          emailController.clear();
          phoneController.clear();
          messageController.clear();
          showScaffold(
              text: 'Message Sent Than You',
              context: context,
              color: Colors.green);
        } else if (state is MessageError) {
          showScaffold(
              text: 'Error Sending', context: context, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Center(
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorManager.myPink,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * .06,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<MessageCubit>(context).sendContactMessage(
                  email: emailController.text,
                  message: messageController.text,
                  phoneNumber: phoneController.text,
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<MessageCubit>(context).sendContactMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFC98CF3),
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PersonalTextField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      controller: emailController,
                      hintText: 'Add Email',
                      widget: const Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      height: .1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    PersonalTextField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Phone Number';
                        }
                        return null;
                      },
                      controller: phoneController,
                      hintText: 'Add Your Phone Number',
                      widget: const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      height: .1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    PersonalTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid message';
                        }
                        return null;
                      },
                      controller: messageController,
                      hintText: 'Add Message ',
                      widget: const Text(
                        'Message',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      height: .18,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            _buildButton(context, text: 'SUMBIT')
          ],
        ),
      ),
    );
  }
}
