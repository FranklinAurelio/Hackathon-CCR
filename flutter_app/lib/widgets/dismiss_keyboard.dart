import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return GestureDetector(
      onTap: () => focus.unfocus(),
      child: child,
    );
  }
}
