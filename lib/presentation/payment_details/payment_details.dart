import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/default_container_for_pay.dart';

import '../resources/color_manger.dart';
import '../resources/routes_manager.dart';
// import '../widgets/default_container.dart';

class PaymentDetailsView extends StatefulWidget {
  const PaymentDetailsView({Key? key, required this.planPrice})
      : super(key: key);
  final String planPrice;

  @override
  State<PaymentDetailsView> createState() => _PaymentDetailsViewState();
}

class _PaymentDetailsViewState extends State<PaymentDetailsView> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  _buildBody(size) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleText(),
              SizedBox(
                height: size.height * .02,
              ),
              _buildPriceText(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardDetailsText(),
              SizedBox(
                height: size.height * .02,
              ),
              _builTaskDetailsForm(size),
            ],
          ),
          _buildButton(),
        ],
      ),
    );
  }

  _buildTitleText() {
    return const Text(
      'Total amount',
      style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
    );
  }

  _buildPriceText() {
    return Text(
      '\$ ${widget.planPrice}',
      style: numberTextStyle.copyWith(
          color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  _buildCardDetailsText() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        'Enter Card Details',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }

  _builTaskDetailsForm(size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DefaultContainerForPay(
          child: TextFormField(
            textAlign: TextAlign.left,
            //controller: userNameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 15),
              border: InputBorder.none,
              hintText: 'Name on Card ',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
            ),
          ),
        ),
        DefaultContainerForPay(
          child: TextFormField(
            textAlign: TextAlign.left,
            //controller: userNameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 15),
              border: InputBorder.none,
              hintText: 'Card Number',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .01),
          child: Row(
            children: [
              Expanded(
                child: DefaultContainerForPay(
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    //controller: userNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15, top: 15),
                      border: InputBorder.none,
                      hintText: 'Card Expiry',
                      hintStyle: hintTextStyle,
                      alignLabelWithHint: false,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .05,
              ),
              Expanded(
                child: DefaultContainerForPay(
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    //controller: userNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15, top: 15),
                      border: InputBorder.none,
                      hintText: 'CVV',
                      hintStyle: hintTextStyle,
                      alignLabelWithHint: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DefaultContainerForPay(
          child: TextFormField(
            textAlign: TextAlign.left,
            //controller: userNameController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 15),
              border: InputBorder.none,
              hintText: 'Zip / Postal code',
              hintStyle: hintTextStyle,
              alignLabelWithHint: false,
            ),
          ),
        ),
      ],
    );
  }

  _buildButton() {
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
        child: Text('PAY NOW', style: textInButtonStyle),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.paymentSuccess);
        },
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
        //    backgroundColor: const Color(0xFFC98CF3),
        title: const Text('Payment Details'),
        centerTitle: true,
      ),
      body: _buildBody(size),
    );
  }
}
