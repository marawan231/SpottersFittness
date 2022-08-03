// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import 'package:spotters_app_clone/presentation/resources/routes_manager.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/my_custom_button.dart';

import '../../business_logic/cubit/login_cubit/login_cubit.dart';

import '../../helpers/shared_prefrences.dart';
import '../widgets/default_container.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _buildTitleText() {
    return Text(
      'SIGN IN',
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
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        DefaultContainer(
          child: TextFormField(
            //keyboardType: TextInputType.number,
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .025,
              ),
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: hintTextStyle,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: IconButton(
                  color: ColorManager.myIconGrey,
                  icon: BlocProvider.of<LoginCubit>(context).suffixIcon,
                  onPressed: () {
                    BlocProvider.of<LoginCubit>(context)
                        .tooglePasswordVisibilty();
                  },
                ),
              ),
            ),
            obscureText: BlocProvider.of<LoginCubit>(context).isPassowrdShown,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a validate password';
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
        if (state is LoginErorr) {
          showScaffold(
              text: state.errorText, context: context, color: Colors.red);
        }
        if (state is LoginSuccedded) {
          //   userPic = state.userInfo.trPic;
          setState(() {
            userEmail = state.userInfo.trEmail;
            userPic = state.userInfo.trPic;
            userId = state.userInfo.trID;
            firstName = state.userInfo.trFname!;
          });
          print(userPic.toString());
          print(userEmail);
          print(state.userInfo.trVerify);
          CacheHelper.saveData(
            key: 'userPic',
            value: userPic,
          );
          CacheHelper.saveData(
            key: 'userId',
            value: userId,
          );
          showScaffold(
              text: state.userInfo.error![0],
              context: context,
              color: Colors.green);

          print(state.userInfo.status);
          if (state.userInfo.trVerify == 'n') {
            Navigator.pushReplacementNamed(context, Routes.otbScreen,
                arguments: {
                  "email": userNameController.text,
                  'otpCode': state.userInfo.trOTP,
                });
          }
          if (state.userInfo.trVerify == 'y' &&
              state.userInfo.trProfile == 'n') {
            Navigator.pushReplacementNamed(
              context,
              Routes.personalInfo,
            );
          }

          if (state.userInfo.trVerify == 'y' &&
              state.userInfo.trProfile == 'y') {
            CacheHelper.saveData(
              key: 'goToHomePage',
              value: 'true',
            );
            Navigator.pushReplacementNamed(
              context,
              Routes.homePage,
            );
          }
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleText(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .12),
                      _buildTwoTextFields(context),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .05),
                          child: Text(
                            'Forgot Password?',
                            style: questionTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Center(
                        child: state is LoginLoding
                            ? const CircularProgressIndicator()
                            : MyCustomButton(
                                text: 'SIGN IN',
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginCubit>(context)
                                        .getUserInfo(
                                      email: userNameController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .08),
                      _buildBottomText(context),
                    ]),
              ),
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
    return Container(
      decoration: const BoxDecoration(
        gradient: ColorManager.gradientColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildBody(context),
      ),
    );
  }
}
