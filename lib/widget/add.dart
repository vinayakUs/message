import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/getlocation.dart';
import 'package:message/widget/builder.dart';

class AddButton extends StatefulWidget {
  Function sendFriendRequest;
  String toUserID;
  AddButton({this.sendFriendRequest, this.toUserID});
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _notFriend = true;
  bool _isPresent = false;
  @override
  void initState() {
    _checkButtonStatus();
    super.initState();
  }

  void _checkFriend() async {}
  void _checkButtonStatus() async {
    String loc = GetLocation.getPeople(widget.toUserID);
    await Auth.getCurrentFireBaseUser().then((currentuser) async {
      await Auth.getDocumentData(path: loc).then((value) async {
        for (int i = 0; i < value['request'].length; i++) {
          if (value['request'][i] == currentuser) {
            setState(() {
              _isPresent = true;
            });
          } else {
            setState(() {
              _isPresent = false;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidgetBuilder(
      builder: (context) {
        print("state recreate");
        if (_notFriend) {
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
        } else if (!_notFriend) {
          return LayoutBuilder();
        }
      },
    );
  }
}
