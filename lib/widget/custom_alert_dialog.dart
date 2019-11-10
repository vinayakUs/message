import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  CustomAlertDialog({this.title, this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
//      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Text(
        title,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: "OpenSans",
        ),
      ),
      content: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              content,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                decoration: TextDecoration.none,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontFamily: "OpenSans",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  onPressed();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
