import 'package:flutter/material.dart';
import 'package:message/widget/builder.dart';

class CustomListViewBuilder extends StatefulWidget {
  AsyncSnapshot snapshot;
  Widget body;
  CustomListViewBuilder({this.snapshot, this.body});
  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return CustomWidgetBuilder(builder: (context) {
      return ListView.builder(
        itemCount: widget.snapshot.data.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
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
                          "${widget.snapshot.data[index]["firstName"]}",
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          "${widget.snapshot.data[index]["username"]}",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),

                    // AddButton(
                    //   toUserID: snapshot.data[index]['userID'],
                    //   sendFriendRequest: () async {
                    //     FirebaseUser _currentUserId =
                    //         await FirebaseAuth.instance.currentUser();
                    //     _sendFriendRequest(_currentUserId.uid,
                    //         snapshot.data[index]['userID']);
                    //   },
                    // ),
                    widget.body,
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
