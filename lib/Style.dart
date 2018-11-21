import 'package:flutter/material.dart';

class Style {
  TextStyle greenHeadingStyle() {
    return TextStyle(
      fontFamily: "Poppins-Bold",
      fontSize: 90.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF356859),
    );
  }

  TextStyle greyHeadingStyle() {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: 50.0,
      color: Color(0xFF8A9098),
    );
  }

  TextStyle greenSubHeadingStyle() {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: 20.0,
      color: Color(0xFF356859),
    );
  }

  TextStyle descriptionTextStyle() {
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: 17.0,
    );
  }
}
