import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message/widget/builder.dart';
import 'package:provider/provider.dart';
import 'temp_state.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
  final BuildContext context;

  First(this.context);
}

class _FirstState extends State<First> {
  VoidCallback _onbackpressed;

  @override
  void initState() {
    super.initState();
    _onbackpressed = () {
      Navigator.pop(widget.context);
    };
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidgetBuilder(
      builder: (context) {
        return WillPopScope(
          onWillPop: _onbackpressed,
          child: Column(
            children: <Widget>[
              Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(hintText: "email"),
                    onChanged: (value) {
                      Provider.of<TempState>(context, listen: false)
                          .updateemail(value);
                    },
                  )),
              Container(
                  width: 300,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Password"),
                    onChanged: (value) {
                      Provider.of<TempState>(context, listen: false)
                          .updatepassword(value.toString().trim());
                    },
                    obscureText: true,
                  )),
            ],
          ),
        );
      },
    );
  }
}
