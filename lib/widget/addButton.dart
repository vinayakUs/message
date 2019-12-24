import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/getlocation.dart';
import 'package:message/widget/builder.dart';

class AddButton extends StatefulWidget {
  final Function sendFriendRequest;
  final String toUserID;
  AddButton({this.sendFriendRequest, this.toUserID});
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _friend = false;
  bool _isPresent = false;
  @override
  void initState() {
    _checkButtonStatus();
    super.initState();
  }

  void _checkButtonStatus() async {
    await Auth.getCurrentFireBaseUser().then((_currentUser) async {
      await Auth.getDocumentData(path: GetLocation.getPeople(widget.toUserID))
          .then((value) async {
        if (value['request'].contains(_currentUser)) {
          setState(() {
            _isPresent = true;
          });
        } else {
          setState(() {
            _isPresent = false;
          });
        }
        if (value['friends'].contains(_currentUser)) {
          setState(() {
            _friend = true;
          });
        } else {
          setState(() {
            _friend = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidgetBuilder(
      builder: (context) {
        if (!_friend) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                child: FlatButton(
                  color: _isPresent ? Colors.grey : Colors.blue,
                  child: Icon(Icons.add),
                  onPressed: () {
                    widget.sendFriendRequest();
                  },
                ),
              );
            },
          );
        } else if (_friend) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                child: FlatButton(
                  child: Icon(Icons.report_problem),
                  onPressed: () {},
                ),
              );
            },
          );
        }
        return null;
      },
    );
  }
}
