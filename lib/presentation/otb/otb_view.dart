import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spotters_app_clone/business_logic/cubit/register_cubit/register_cubit.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/constants_manager.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';

import '../resources/routes_manager.dart';

class OtbView extends StatefulWidget {
  const OtbView({Key? key, required this.email, required this.otpCode})
      : super(key: key);
  final email;
  final String otpCode;

  @override
  State<OtbView> createState() => _OtbViewState();
}

class _OtbViewState extends State<OtbView> {
  String? enteredOtpCode;
  _buildTitle() {
    return Text('VERIFICATION', style: headlineTextStyle);
  }

  _buildSubTitle() {
    return Text(
      'Verification code sent to your email',
      style: questionTextStyle,
    );
  }

  _buildPhoneNumber() {
    return Text(
      widget.email,
      style: headlineTextStyle,
    );
  }

  _buildPinCodeFieldsPhrase() {
    return Text(
      'Enter your OTP code here',
      style: questionTextStyle,
    );
  }

  _buildPinCodeFields(context) {
    return Container(
      child: PinCodeTextField(
        keyboardType: TextInputType.number,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12),
          fieldHeight: 65,
          fieldWidth: 65,
          disabledColor: Colors.white,
          activeColor: Colors.white,
          activeFillColor: Colors.white,
          selectedFillColor: Colors.white,
          inactiveColor: Colors.white,
          inactiveFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        onCompleted: (v) {
          enteredOtpCode = v;
        },
        onChanged: (value) {},
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
        appContext: context,
      ),
    );
  }

  _buildButton(context, RegisterState state) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          backgroundColor: ColorManager.myPink,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .32,
            vertical: MediaQuery.of(context).size.height * .02,
          ),
        ),
        child: state is VerifyOtpLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(
                'VERIFY',
                style: textInButtonStyle,
              ),
        onPressed: () {
          BlocProvider.of<RegisterCubit>(context)
              .verifyOtp(otp: enteredOtpCode!);
        },
      ),
    );
  }

  _buildFooterPhrase() {
    return Center(
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<RegisterCubit>(context).resendOtb();
        },
        child: RichText(
            text: TextSpan(
          children: [
            TextSpan(
                text: 'Didn\'t recieve the code? ', style: questionTextStyle),
            TextSpan(
              text: 'Resend Code',
              style: questionTextStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: ColorManager.gradientColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          backgroundColor: Colors.transparent,
          body: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is ResendOtbSuccedded) {
                print(state.result.otp);
                showScaffold(
                  text: state.result.error,
                  context: context,
                  color: Colors.green,
                );
              }

              if (state is VerifyOtpSuccedded) {
                Navigator.pushReplacementNamed(context, Routes.subscribtionFee);
                showScaffold(
                  text: state.result.error![0],
                  context: context,
                  color: Colors.red,
                );
              }
              if (state is VerifyOtpError) {
                showScaffold(
                  text: state.errorText,
                  context: context,
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTitle(),
                          _buildSubTitle(),
                          _buildPhoneNumber(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * .05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildPinCodeFieldsPhrase(),
                            _buildPinCodeFields(context),
                            _buildButton(context, state),
                            _buildFooterPhrase(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
