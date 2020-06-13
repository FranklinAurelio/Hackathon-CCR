import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoWidget({Key key, this.width = 140, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: width,
      height: height,
    );
  }
}
