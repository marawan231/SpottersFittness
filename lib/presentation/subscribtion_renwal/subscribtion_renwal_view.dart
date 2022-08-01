import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/routes_manager.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/fee_text.dart';

class SubscribtionRenewalView extends StatelessWidget {
  const SubscribtionRenewalView({Key? key}) : super(key: key);
  _buildMainContainer(context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .05,
          right: MediaQuery.of(context).size.width * .05,
          top: MediaQuery.of(context).size.height * .05,
          bottom: MediaQuery.of(context).size.height * .05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: ColorManager.myPurble,
              ),
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$ 120 ',
                    style: numberTextStyle,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '1 MONTH',
                    style: durationTextStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: ColorManager.myLightGrey,
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: _buildBodyOfMainContainer(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBodyOfMainContainer(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .02),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          FeeText(feeString: 'this is a dummy text to tst this design '),
          FeeText(feeString: 'this is a dummy text to tst this design '),
          FeeText(feeString: 'this is a dummy text to tst this design '),
          FeeText(feeString: 'this is a dummy text to tst this design '),
          FeeText(feeString: 'this is a dummy text to tst this design '),
          FeeText(feeString: 'this is a dummy text to tst this design '),
          FeeText(feeString: 'this is a dummy text to tst this design '),
        ],
      ),
    );
  }

  _buildButton(context, text, onTap) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * .02,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,

        // bottom: MediaQuery.of(context).size.height * .02,
        // left: MediaQuery.of(context).size.width * .08,
        // right: MediaQuery.of(context).size.width * .02,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: ColorManager.myPink,
            ),
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .08,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  letterSpacing: 1,
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorManager.appBarGradientColor,
          ),
        ),
        title: const Text(
          'Subscribtion Renwal',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildMainContainer(context),
          _buildButton(
            context,
            'RENEW NOW',
            () {
              Navigator.pushNamed(context, Routes.paymentDetails);
            },
          ),
          _buildButton(
            context,
            'CANCEL MEMBERSHIB',
            () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
