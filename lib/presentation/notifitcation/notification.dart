import 'package:flutter/material.dart';
import 'package:spotters_app_clone/presentation/widgets/notfitcation_item.dart';

import '../resources/color_manger.dart';

class NotftcationView extends StatelessWidget {
  const NotftcationView({Key? key}) : super(key: key);
  _buildBody(context) {
    return ListView(
      children: const [
        NotfitcationItem(
          color: Color(0xFFC98CF3),
        ),
        NotfitcationItem(
          color: Color(0xFFC98CF3),
        ),
        NotfitcationItem(
          notfitcationCardColor: Colors.white,
        ),
        NotfitcationItem(
          notfitcationCardColor: Colors.white,
        ),
//NotfitcationItem(notfitcationCardColor: Colors.white)
      ],
    );
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
        //  backgroundColor: const Color(0xFFC98CF3),
        title: const Text(' Notiftcation'),
      ),
      body: _buildBody(context),
    );
  }
}
