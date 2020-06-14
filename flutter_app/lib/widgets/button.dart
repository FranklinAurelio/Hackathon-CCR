import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  const ButtonWidget({
    Key key,
    @required this.onPressed,
    this.child,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      color: color,
      child: MaterialButton(
        height: 60.0,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
