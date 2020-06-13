import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleChildScrollable extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SingleChildScrollable({
    Key key,
    @required this.child,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, view) => CupertinoScrollbar(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: view.maxHeight,
              minWidth: view.maxWidth,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
