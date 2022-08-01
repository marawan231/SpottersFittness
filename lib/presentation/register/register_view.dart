// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';

import 'package:spotters_app_clone/presentation/resources/routes_manager.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/my_custom_button.dart';

import '../../business_logic/cubit/register_cubit/register_cubit.dart';

import '../widgets/default_container.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool? isChecked;

  @override
  void dispose() {
    firstNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  _buildTextFields(context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DefaultContainer(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.left,
            controller: firstNameController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .02,
              ),
              border: InputBorder.none,
              hintText: 'First Name',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid Name';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        DefaultContainer(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.left,
            controller: emailController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .02,
              ),
              border: InputBorder.none,
              hintText: 'E-mail Address',
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
          height: MediaQuery.of(context).size.height * .01,
        ),
        DefaultContainer(
          child: TextFormField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            controller: phoneController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .02,
              ),
              border: InputBorder.none,
              hintText: 'Phone Number',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid phone';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        DefaultContainer(
          child: TextFormField(
            obscureText:
                BlocProvider.of<RegisterCubit>(context).isPassowrdShown,
            //keyboardType: TextInputType.numberWithOptions(),
            textAlign: TextAlign.left,
            controller: passwordController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .02,
              ),
              border: InputBorder.none,
              hintText: 'Create Password',
              hintStyle: hintTextStyle,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: IconButton(
                  color: ColorManager.myIconGrey,
                  icon: BlocProvider.of<RegisterCubit>(context)
                      .createPasswordSuffixIcon,
                  onPressed: () {
                    BlocProvider.of<RegisterCubit>(context)
                        .tooglePasswordVisibilty();
                  },
                ),
              ),
              alignLabelWithHint: false,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        DefaultContainer(
          child: TextFormField(
            // keyboardType: TextInputType.number,
            controller: confirmPasswordController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .025,
              ),
              border: InputBorder.none,
              hintText: 'Confirm Password',
              hintStyle: hintTextStyle,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: IconButton(
                  color: ColorManager.myIconGrey,
                  icon:
                      BlocProvider.of<RegisterCubit>(context).confirmSuffixIcon,
                  onPressed: () {
                    BlocProvider.of<RegisterCubit>(context)
                        .toogleConfirmPasswordVisibilty();
                  },
                ),
              ),
            ),
            obscureText:
                BlocProvider.of<RegisterCubit>(context).isConfirmPassowrdShown,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value != passwordController.text) {
                return 'Please enter a validate password';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        _buildAgreeConditionPart(),
      ],
    );
  }

  _buildAgreeConditionPart() {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * .05,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            width: 20,
            height: 20,
            child: Checkbox(
                side: const BorderSide(color: Colors.white),
                activeColor: ColorManager.myPurble,
                checkColor: Colors.white,
                value: BlocProvider.of<RegisterCubit>(context).isAgree,
                onChanged: (value) {
                  setState(() {
                    BlocProvider.of<RegisterCubit>(context).isAgree = value!;
                    BlocProvider.of<RegisterCubit>(context)
                        .changeCheckBoxValue(value);
                  });
                }),
          ),
          TextButton(
            onPressed: () {
              print('pressed');
              Navigator.pushNamed(context, Routes.terms);
            },
            child: RichText(
                text: TextSpan(
              children: [
                TextSpan(
                  text: 'I agree to the  ',
                  style: questionTextStyle,
                ),
                TextSpan(
                  text: 'Terms and Condition',
                  style: questionTextStyle.copyWith(
                      decoration: TextDecoration.underline),
                ),
              ],
            )),
            // child: Text(
            //   'I agree to the  Terms and Condition?',
            //   style: questionTextStyle,
            // ),
          ),
        ],
      ),
    );
  }

  _buildButtonAndText(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                print(state.toString());
              },
              builder: (context, state) {
                if (state is RegisterLoding) {
                  return const CircularProgressIndicator();
                } else {
                  return MyCustomButton(
                    text: 'SIGN UP',
                    onTap: () {
                      if (_formKey.currentState!.validate() &&
                          state is AgreeTermsAndConditions) {
                        BlocProvider.of<RegisterCubit>(context).getUserInfo(
                            firstName: firstNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text);

                        // BlocProvider.of<SubscribtionCubit>(context).getUserSubscribtion();
                      }
                      if (!_formKey.currentState!.validate() &&
                          state is AgreeTermsAndConditions) {
                        showScaffold(
                            text: 'Please Complete Form Data ',
                            context: context);
                      } else if (BlocProvider.of<RegisterCubit>(context)
                                  .isAgree ==
                              false &&
                          _formKey.currentState!.validate()) {
                        showScaffold(
                          text: 'Please Agree Terms And Conditions',
                          context: context,
                          color: Colors.red,
                        );
                      }

                      // Navigator.pushReplacementNamed(context, Routes.otbScreen);
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account ?',
                style: questionTextStyle,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginRoute);
                },

                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Sign in',
                      style: questionTextStyle.copyWith(
                        decoration: TextDecoration.underline,
                      )),
                  TextSpan(text: ' Now!', style: questionTextStyle),
                ])),
                // child: Text(
                //   'Sign in Now!',
                //   style: questionTextStyle,
                // ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildTitleText(context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .04,
        left: MediaQuery.of(context).size.width * .05,
      ),
      child: Text(
        'SIGN UP',
        style: headlineTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          print(state.toString());

          if (state is RegisterSuccedded) {
            print(state.userInfo.status);
            if (state.userInfo.status == 'success') {
              firstName = firstNameController.text;
              showScaffold(
                  text: 'Registered Suceess',
                  context: context,
                  color: Colors.green);
              Navigator.pushReplacementNamed(context, Routes.otbScreen,
                  arguments: {
                    "email": emailController.text,
                    'otpCode': state.userInfo.otp,
                  });
            }
            print(state.userInfo.usrid);
            print(state.userInfo.otp);
          } else if (state is RegisterErorr) {
            showScaffold(
                text: state.errorText, context: context, color: Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorManager.myPurble,
              elevation: 0.0,
            ),
            backgroundColor: ColorManager.myPurble,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleText(context),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      _buildTextFields(context),
                      _buildButtonAndText(context),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
