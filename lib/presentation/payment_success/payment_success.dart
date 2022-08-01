import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/personal_info/personal_info.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';

import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';
import '../widgets/my_custom_button.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({Key? key}) : super(key: key);
  _buildImage(size) {
    return Expanded(
      child: Container(
        height: size.height * .3,
        width: size.width * .3,
        child: Image.asset(
          'assets/images/pay.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildSuccessText() {
    return Text(
      'PAYMENT COMPLETED\n SUCCESSFULLY',
      textAlign: TextAlign.center,
      style: headlineTextStyle.copyWith(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildSuccessSubText(size) {
    return Text(
      // maxLines: 3,
      'sentance for testing thats a default sentance for testing thats a default sentance for testingthats a default sentance for testing thats a default sentance for testing',
      style: questionTextStyle.copyWith(color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }

  _buildBody(size, context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildImage(size),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSuccessText(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                _buildSuccessSubText(size),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .05,
              ),
              child: MyCustomButton(
                  text: 'START',
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.personalInfo);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        // backgroundColor: const Color(0xFFC98CF3),
        title: const Text('Payment Success'),
        centerTitle: true,
      ),
      body: _buildBody(size, context),
    );
  }
}
