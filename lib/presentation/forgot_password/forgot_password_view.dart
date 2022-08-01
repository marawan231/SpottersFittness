// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import 'package:spotters_app_clone/presentation/resources/routes_manager.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/custom_button.dart';
import 'package:spotters_app_clone/presentation/widgets/my_custom_button.dart';

import '../../business_logic/cubit/login_cubit/login_cubit.dart';

import '../../helpers/shared_prefrences.dart';
import '../widgets/default_container.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();

    super.dispose();
  }

  _buildTitleText() {
    return Text(
      'FORGOT PASSWORD',
      style: headlineTextStyle,
    );
  }

  _buildTwoTextFields(context) {
    return Column(
      children: [
        DefaultContainer(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            //textAlign: TextAlign.justify,
            controller: userNameController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .015,
              ),
              border: InputBorder.none,
              hintText: 'E-mail',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
            ),
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  _buildBody(context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is ForgotPassErorr) {
          showScaffold(
              text: state.errorText, context: context, color: Colors.red);
        }
        if (state is ForgotPassSuccedded) {
          //   userPic = state.userInfo.trPic;

          showScaffold(
              text: state.result.error![0],
              context: context,
              color: Colors.green);

          print(state.result.status);

          Navigator.pop(
            context,
          );
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTitleText(),
                        ],
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height * .12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTwoTextFields(context),
                          Center(
                              child: state is ForgotPassLoading
                                  ? const CircularProgressIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: CustomButton(
                                        text: 'SEND PASSWORD',
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<LoginCubit>(context)
                                                .retrievePass(
                                              email: userNameController.text,
                                            );
                                          }
                                        },
                                      ),
                                    )),
                          // SizedBox(
                          //     height: MediaQuery.of(context).size.height * .08),
                          _buildBottomText(context),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }

  _buildBottomText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: questionTextStyle,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.registerRoute);
          },
          child: Text(
            'Sign up',
            style: questionTextStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.myPurble,
      body: _buildBody(context),
    );
  }
}
