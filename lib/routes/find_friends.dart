import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/models/user.dart';

class FindFriends extends StatefulWidget {
  static String id = "Find_Friends";
  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  String userdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
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
                      await Auth.findFriends(userdata).then((value) {
                        print("$value.");
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          onChanged: (value) {
                            userdata = value;
                          },
                        )),
                  ),
                ],
              ),
              FutureBuilder(
                future: Auth.findFriends(userdata),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError) {
                    return Text("found user");
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
                    return Text('null');
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

                  return Text("null found");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
