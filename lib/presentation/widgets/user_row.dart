import 'package:flutter/material.dart';

class UserRaw extends StatelessWidget {
  const UserRaw(
      {Key? key,
      required this.userName,
      required this.orderId,
      required this.date,
      required this.amount})
      : super(key: key);

  final userName;
  final orderId;
  final date;
  final amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .06,
            color: const Color(0xFFFFECF9),
            child: Center(child: Text('$userName')),
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .06,
            color: const Color(0xFFF9F9F9),
            child: Center(child: Text('$orderId')),
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .06,
            color: const Color(0xFFFFECF9),
            child: Center(child: Text('$date')),
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * .06,
            color: const Color(0xFFF9F9F9),
            child: Center(child: Text('$amount')),
          ),
        ),
      ],
    );
  }
}
