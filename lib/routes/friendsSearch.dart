import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/getlocation.dart';
import 'package:message/routes/chatScreen.dart';

class FriendsSearch extends StatefulWidget {
  @override
  _FriendsSearchState createState() => _FriendsSearchState();
}

class _FriendsSearchState extends State<FriendsSearch> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            FutureBuilder(
              future: _getFriendsList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatScreen()));
                    },
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                SizedBox(height: 60),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                          itemCount: snapshot.data.length));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getFriendsList() async {
    List<Map<String, dynamic>> map = [];
    await Auth.getCurrentFireBaseUser().then((_currentUser) async {
      await Auth.getDocumentData(path: GetLocation.getPeople(_currentUser))
          .then((value) async {
        List<String> friends = List<String>.from(value['friends']);
        for (String i in friends) {
          await Auth.getDocumentData(path: GetLocation.getUserMap(i))
              .then((friendMap) {
            map.add(friendMap);
          });
        }
      });
    });
    return map;
  }
}
