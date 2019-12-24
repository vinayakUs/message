class User {
  String userID;
  String firstName;
  String email;
  String profilePictureURL;
  String username;
  User(
      {this.userID,
      this.firstName,
      this.email,
      this.profilePictureURL,
      this.username});
  User.fromUserMap(Map<String, dynamic> map) {
    userID = map['userID'];
    firstName = map['firstName'];
    profilePictureURL=map['profilePictureURL'];
    email = map['email'];
    username = map['username'];
  }

  Map<String, Object> toUserMap() {
    return {
      'userID': userID,
      'firstName': firstName,
      'email': email,
      'profilePictureURL': profilePictureURL,
      'username': username,
    };
  }
}
