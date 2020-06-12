import 'package:flutter/material.dart';

class Defaults {

  static const Color primary = const Color(0xffff6238);
  static const Color dark = const Color(0xff333333);
  static const Color light = const Color(0xffcccccc);
  static const Color pruple = const Color(0xff2239E8);
  static const Color red = const Color(0xffF40202);
  static const Color orange = const Color(0xffFF7F00);
  static const Color green = const Color(0xff0EB200);
  static const Color yellow = const Color(0xffFFC400);

  static InputDecoration defaultInputStyle ({String hint}) {
    return InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: 18.0
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.0)
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.0)
      ),
    );
  }

}