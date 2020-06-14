import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget();

  @override
  Widget build(BuildContext context) {
    return  SizedBox.expand(
      child: Opacity(
        opacity: 0.3,
        child: Image.asset(
          "assets/images/fundo.png",
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
