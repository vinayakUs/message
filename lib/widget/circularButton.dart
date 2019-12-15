import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Color shadowColor;

  final EdgeInsets paddingtewak;
  final VoidCallback onPressed;
  final Key buttonKey;
  final bool enabled;
  final Widget child;
  final double radius;
  CircularButton(
      {this.radius,
      this.enabled,
      this.paddingtewak = const EdgeInsets.all(0),
      this.buttonKey,
      this.shadowColor,
      this.child,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(


      decoration: shadowColor != null
          ? BoxDecoration(
              boxShadow: [BoxShadow(offset: Offset(0, 10), blurRadius: 10)])
          : null,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        key: buttonKey,
        shape: radius != null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))
            : null,
        onPressed: enabled ? onPressed : null,
        child: child,
      ),
    );
  }
}
