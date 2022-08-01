import 'package:flutter/material.dart';

class NotfitcationItem extends StatelessWidget {
  const NotfitcationItem({
    Key? key,
    this.color = Colors.pink,
    this.notfitcationCardColor = const Color(0xFFEFEFEF),
  }) : super(key: key);
  final Color color;
  final Color notfitcationCardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0.0,
        color: notfitcationCardColor,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .03),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              Text(
                  overflow: TextOverflow.clip,
                  'demo test  text demo test  ext demo tesext demo tesext demo tesext demo tesext demo testetesexttesextxt  '),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              const Text('09:49 AM '),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: CircleAvatar(
              radius: 8,
              backgroundColor: color,
            ),
          ),
        ),
      ),
    );
  }
}
