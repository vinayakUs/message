import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/getlocation.dart';
import 'package:message/models/user.dart';
import 'package:message/widget/builder.dart';

class FriendRequest extends StatefulWidget {
  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            FutureBuilder(
              future: _getFriendRequest(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError &&
                    snapshot.hasData) {
                  List<User> snapshotLocal = List<User>.from(snapshot.data);
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 60),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "${snapshotLocal[index].firstName}",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    "${snapshotLocal[index].username}",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                              AcceptRejectRequestButton(
                                  snapshotLocal[index].userID),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<User>> _getFriendRequest() async {
    List<User> map = [];
    String _currentUser = await Auth.getCurrentFireBaseUser();

    await Auth.getDocumentData(path: GetLocation.getPeople(_currentUser))
        .then((userdata) async {
      List<String> requestID = new List<String>.from(userdata['request']);
      for (int i = 0; i < requestID.length; i++) {
        await Auth.getDocumentData(
                path: GetLocation.getUserMap(requestID[i].toString()))
            .then((user) async {
          map.add(User.fromUserMap(user));
        });
      }
    });
    return map;
  }
}

//accept reject button
class AcceptRejectRequestButton extends StatefulWidget {
  final String pendingRequestUserID;
  AcceptRejectRequestButton(this.pendingRequestUserID);
  @override
  _AcceptRejectRequestButtonState createState() =>
      _AcceptRejectRequestButtonState();
}

class _AcceptRejectRequestButtonState extends State<AcceptRejectRequestButton> {
  bool _isClicked = false;
  bool _isAccept = false;
  bool _isReject = false;

  @override
  Widget build(BuildContext context) {
    return CustomWidgetBuilder(
      builder: (context) {
        return Container(
          child: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("accept"),
                onPressed: _isAccept
                    ? null
                    : () async {
                        await _accept(widget.pendingRequestUserID)
                            .then((value) {
                          if (value) {
                            setState(() {
                              _isReject = value;
                            });
                          }
                        });
                      },
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                child: Text("reject"),
                onPressed: _isReject
                    ? null
                    : () async {
                        await _reject(widget.pendingRequestUserID)
                            .then((value) {
                          if (value) {
                            setState(() {
                              _isAccept = value;
                            });
                          }
                        });
                      },
              )
            ],
          ),
        );
      },
    );
  }

  Future<bool> _accept(String pendingRequestUserID) async {
    bool returnValue = false;
    if (!_isClicked) {
      _isClicked = true;
      print("accept called");
      String _currentUserID = await Auth.getCurrentFireBaseUser();
      await Firestore.instance
          .document(GetLocation.getPeople(pendingRequestUserID))
          .get()
          .then(
        (value) async {
          final friends = List<String>.from(value.data['friends']);

          if (!friends.contains(_currentUserID)) {
            friends.add(_currentUserID);
            Auth.updateDataByUid(
                path: GetLocation.getPeople(pendingRequestUserID),
                data: {
                  'friends': friends,
                });
          }
          returnValue = true;
        },
      );
      //
      try {
        await Firestore.instance
            .document(GetLocation.getPeople(_currentUserID))
            .get()
            .then((value) async {
          List a = value.data['friends'];
          List b = value.data['request'];

          final friends = List<String>.from(a);
          final request = List<String>.from(b);

          if (!friends.contains(pendingRequestUserID) &&
              request.contains(pendingRequestUserID)) {
            friends.add(pendingRequestUserID);
            request.remove(pendingRequestUserID);
            Auth.updateDataByUid(
                path: GetLocation.getPeople(_currentUserID),
                data: {
                  'request': request,
                  'friends': friends,
                });
          }
        });
      } catch (e) {
        returnValue = false;
      }
    }

    return returnValue;
  }

  Future _reject(String pendingRequestUserID) async {
    bool returnValue = false;
    if (!_isClicked) {
      _isClicked = true;
      String _currentUserID = await Auth.getCurrentFireBaseUser();
      await Firestore.instance
          .document(GetLocation.getPeople(_currentUserID))
          .get()
          .then((value) async {
        List a = value.data['request'];

        final request = List<String>.from(a);

        if (request.contains(pendingRequestUserID)) {
          request.remove(pendingRequestUserID);
          Auth.updateDataByUid(
              path: GetLocation.getPeople(_currentUserID),
              data: {
                'request': request,
              });
        }
        returnValue = true;
      });
    }

    return returnValue;
  }
}
