import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/getlocation.dart';
import 'package:message/widget/builder.dart';

class FriendRequest extends StatefulWidget {
  @override
  _FriendRequestState createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  Widget a = Text("");
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
                  // return CustomListViewBuilder(
                  //   snapshot: snapshot,
                  // );
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
                                    "${snapshot.data[index]["firstName"]}",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    "${snapshot.data[index]["username"]}",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                              AcceptRejectRequestButton(
                                  snapshot.data[index]['userID']),
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

  Future<List<Map<String, dynamic>>> _getFriendRequest() async {
    List<String> requestID;
    List<Map<String, dynamic>> map = [];
    String _currentuser = await Auth.getCurrentFireBaseUser();

    await Auth.getDocumentData(path: GetLocation.getPeople(_currentuser))
        .then((userdata) async {
      requestID = new List<String>.from(userdata['request']);

      for (int i = 0; i < requestID.length; i++) {
        await Auth.getDocumentData(
                path: GetLocation.getUserMap(requestID[i].toString()))
            .then((user) async {
          map.add(user);
        });
      }
    });
    final data = new List<Map<String, dynamic>>.from(map);
    print("map $map");
    return data;
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
  bool _isAccept = false;
  bool _isreject = false;

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
                        print(widget.pendingRequestUserID);
                        await _accept(widget.pendingRequestUserID)
                            .then((value) {
                          setState(() {
                            _isreject = value;
                          });
                        });
                      },
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                child: Text("reject"),
                onPressed: _isreject
                    ? null
                    : () async {
                        print(widget.pendingRequestUserID);
                        await _reject(widget.pendingRequestUserID)
                            .then((value) {
                          setState(() {
                            _isreject = value;
                          });
                        });
                      },
              )
            ],
          ),
        );
      },
    );
  }

  Future _accept(String pendingRequestUserID) async {
    bool returnValue = false;
    String _currentUserID = await Auth.getCurrentFireBaseUser();
    await Firestore.instance
        .document(GetLocation.getPeople(pendingRequestUserID))
        .get()
        .then((value) async {
      List a = value.data['friends'];

      final friends = List<String>.from(a);

      if (!friends.contains(_currentUserID)) {
        friends.add(_currentUserID);
        Auth.updateDataByUid(
            path: GetLocation.getPeople(pendingRequestUserID),
            data: {
              'friends': friends,
            });
      }
      returnValue = true;
    });
    //
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
      returnValue = true;
    });
    return returnValue;
  }

  Future _reject(String pendingRequestUserID) async {
    bool returnValue = false;
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
    return returnValue;
  }
}
