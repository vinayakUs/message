import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/getlocation.dart';
import 'package:message/models/user.dart';
import 'package:message/routes/friend_request.dart';
import 'package:message/routes/friendsSearch.dart';
import 'package:message/widget/addButton.dart';

class FindFriends extends StatefulWidget {
  static String id = "Find_Friends";
  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  String userDetail;
  Future<List<User>> getSearchUserList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      if (userDetail != "") {
                        setState(() {
                          getSearchUserList = _getSearchUser(userDetail);
                        });
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextField(
                        onChanged: (value) {
                          userDetail = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              RaisedButton(
                child: Text("check your request"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FriendRequest()));
                },
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FriendsSearch()));
                },
                child: Text("Friends"),
              ),
              FutureBuilder(
                future: getSearchUserList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError &&
                      snapshot.data != null) {
                    List<User> snapshotLocal = List<User>.from(snapshot.data);
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            SizedBox(height: 60),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
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
                                  AddButton(
                                    toUserID: snapshotLocal[index].userID,
                                    sendFriendRequest: () async {
                                      FirebaseUser _currentUserId =
                                          await FirebaseAuth.instance
                                              .currentUser();
                                      _sendFriendRequest(_currentUserId.uid,
                                          snapshotLocal[index].userID);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.active) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    return Text("no user found");
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${snapshot.error}"),
                        ],
                      ),
                    );
                  }

                  return Text("Search For your Friends");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<List<User>> _getSearchUser(String userdata) async {
    List<User> map = [];
    String currentUserID = await Auth.getCurrentFireBaseUser();
    try {
      await Auth.findFriends(userdata).then((value) {
        for (int i = 0; i < value.documents.length; i++) {
          if (value.documents[i].data['userID'].toString() != currentUserID) {
            map.add(User.fromUserMap(value.documents[i].data));
          }
        }
      });
    } catch (e) {
      map = null;
     debugPrint(e.toString().toString());
    }
    return map;
  }

  void _sendFriendRequest(String fromUid, String toUserID) async {
    try {
      await Auth.checkUserExist(toUserID, "people").then((value) async {
        if (!value) {
          Map<String, dynamic> map = {
            'request': [fromUid]
          };
          await Firestore.instance.document("people/$toUserID").setData(map);
        } else {
          await Auth.getDocumentData(path: "people/$toUserID")
              .then((searchUserData) async {
            List a = searchUserData["request"];
            List<dynamic> req = List<dynamic>.from(a);
            List b = [fromUid];
            if (!req.contains(b[0].toString())) {
              req = req + b;
            } else {
              req.remove(b[0].toString());
            }
            Auth.updateDataByUid(
                path: GetLocation.getPeople(toUserID), data: {'request': req});
            setState(() {
              getSearchUserList = _getSearchUser(userDetail);
            });
          });
        }
      });
    } catch (e) {
      debugPrint("error $e");
    }
  }
}
