import 'package:flutter/material.dart';

class CustomWidgetBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
  ) builder;
  const CustomWidgetBuilder({this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return builder(context);
    });
  }
}
