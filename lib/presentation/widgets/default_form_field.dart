import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final IconData? prefixcIcon;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isPassword;

  final TextEditingController controller;
  const DefaultFormField({
    Key? key,
    required this.controller,
    this.prefixcIcon,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.validator,
    required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixcIcon,
          color: Colors.red,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 30),
        labelStyle: const TextStyle(
          color: Colors.grey,
          letterSpacing: 2,
        ),
        labelText: labelText,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
