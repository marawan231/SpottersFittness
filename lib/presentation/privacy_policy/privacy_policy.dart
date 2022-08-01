import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotters_app_clone/data/model/terms_and_conditions.dart';

import '../../business_logic/cubit/terms_privacy/terms_privacy_cubit.dart';
import '../resources/color_manger.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  dynamic privacy;
  @override
  void initState() {
    BlocProvider.of<TermsPrivacyCubit>(context).getPrivacy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TermsPrivacyCubit, TermsPrivacyState>(
      listener: (context, state) {
        if (state is PrivacyLoaded) {
          privacy = state.privacy;
        }
      },
      builder: (context, state) {
        return state is PrivacyLoaded
            ? Scaffold(
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: ColorManager.appBarGradientColor,
                    ),
                  ),
                  // backgroundColor: const Color(0xFFC88AF3),
                  title: Text(privacy.pgTitle!),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          privacy!.pgTxt!,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
