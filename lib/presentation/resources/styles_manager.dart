import 'package:flutter/material.dart';

import 'color_manger.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamilyLato,
      color: color,
      fontWeight: fontWeight);
}

TextStyle questionTextStyle = TextStyle(
  color: ColorManager.myWhite,
  fontFamily: 'Lato',
  fontSize: 16,
  fontWeight: FontWeightManager.regular,
);
TextStyle headlineTextStyle = TextStyle(
  fontFamily: 'Lato',
  fontSize: 22,
  fontWeight: FontWeightManager.bold,
  //letterSpacing: 1,
  color: ColorManager.myWhite,
);

TextStyle numberTextStyle = TextStyle(
  color: ColorManager.myWhite,
  fontFamily: 'Poppins',
  fontSize: 41,
  fontWeight: FontWeightManager.medium,
);

TextStyle durationTextStyle = TextStyle(
  color: ColorManager.myWhite,
  fontFamily: 'Poppins',
  fontSize: 16,
  fontWeight: FontWeightManager.regular,
);
TextStyle simbleSentenceTextStyle = TextStyle(
  color: ColorManager.myGrey,
  fontFamily: 'Poppins',
  fontSize: 13,
  fontWeight: FontWeightManager.semiBold,
  fontStyle: FontStyle.italic,
);

TextStyle personalInfoTextTopOfTextField = const TextStyle(
  color: Colors.black,
  fontFamily: 'Poppins',
  fontSize: 16,
  fontWeight: FontWeightManager.medium,
  // fontStyle: FontStyle.normal,
);
//
//
//// TextStyle hintTextStyle = TextStyle(
//   color: ColorManager.myGrey,
//   fontFamily: 'Lato',
//   fontSize: 14,
// );// TextStyle hintTextStyle = TextStyle(
//   color: ColorManager.myGrey,
//   fontFamily: 'Lato',
//   fontSize: 14,
// );
TextStyle hintTextStyle = TextStyle(
  color: ColorManager.myGrey,
  fontFamily: 'Lato',
  fontSize: 14,
);

final textInButtonStyle = TextStyle(
  color: ColorManager.myWhite,
  fontFamily: 'Poppins',
  fontSize: 18,
  fontWeight: FontWeightManager.semiBold,
  letterSpacing: 1,
);

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// medium style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// bold style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your Value.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
