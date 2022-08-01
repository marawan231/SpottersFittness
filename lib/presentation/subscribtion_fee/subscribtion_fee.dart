import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotters_app_clone/business_logic/cubit/subscribtion_cubit/subscribtion_cubit.dart';
import 'package:spotters_app_clone/data/model/subscribtion_model.dart';
import 'package:spotters_app_clone/presentation/resources/color_manger.dart';
import 'package:spotters_app_clone/presentation/resources/routes_manager.dart';
import 'package:spotters_app_clone/presentation/resources/styles_manager.dart';
import 'package:spotters_app_clone/presentation/widgets/fee_text.dart';

class SubscribtionFeeView extends StatefulWidget {
  const SubscribtionFeeView({Key? key}) : super(key: key);

  @override
  State<SubscribtionFeeView> createState() => _SubscribtionFeeViewState();
}

class _SubscribtionFeeViewState extends State<SubscribtionFeeView> {
  SubscribtionModel? subsModel;
  _buildMainContainer(context, state) {
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
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
                    '\$${subsModel!.price}  ',
                    style: numberTextStyle,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    '${subsModel!.month} MONTHS',
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
                child: _buildBodyOfMainContainer(context, state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBodyOfMainContainer(context, state) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .02),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FeeText(feeString: '${subsModel!.detail}'
              // FeeText(feeString: 'this is a dummy text to tst this design '),
              // FeeText(feeString: 'this is a dummy text to tst this design '),
              // FeeText(feeString: 'this is a dummy text to tst this design '),
              // FeeText(feeString: 'this is a dummy text to tst this design '),
              // FeeText(feeString: 'this is a dummy text to tst this design '),
              // FeeText(feeString: 'this is a dummy text to tst this design '),
              )
        ],
      ),
    );
  }

  _buildButton(context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * .06,
        ),
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
          child: Text('BUY NOW', style: textInButtonStyle),
          onPressed: () {
            Navigator.pushNamed(context, Routes.paymentDetails, arguments: {
              'planPrice': subsModel!.price,
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<SubscribtionCubit>(context).getUserSubscribtion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscribtionCubit, SubscribtionState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        if (state is SubscribtionSuccedded) {
          subsModel = (state).subscribtionModel;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: ColorManager.appBarGradientColor,
                ),
              ),
              title: Text(
                state.subscribtionModel.pack!,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: Column(
              children: [
                _buildMainContainer(context, state),
                _buildButton(context),
              ],
            ),
          );
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
