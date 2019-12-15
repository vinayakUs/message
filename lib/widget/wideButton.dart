import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final Key buttonKey;
  final Color shadowColor;
  final Widget child;
  final EdgeInsets paddingTweak;
  final bool enabled;
  final Color background;
  final VoidCallback onPressed;
  WideButton({
    this.shadowColor,
    this.buttonKey,
    this.background,
    this.enabled,
    this.onPressed,
    this.paddingTweak=const EdgeInsets.all(0),
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(minWidth: double.infinity),
        decoration: shadowColor != null
            ? BoxDecoration(boxShadow: [
                BoxShadow(
                    color: shadowColor, offset: Offset(0, 10), blurRadius: 10),
              ])
            : null,
        child: FlatButton(
          key: buttonKey,
          padding: EdgeInsets.only(
              left: paddingTweak.left + 20,
              right: 20 + paddingTweak.right,
              top: paddingTweak.top + 11,
              bottom: paddingTweak.bottom + 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: enabled ? onPressed : null,
          color: background,
          child: child,
        ));
  }
}
