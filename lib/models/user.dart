class User {
  final String userID;
  final String firstName;
  final String email;
  final String profilePictureURL;
  final String username;
  User(
      {this.userID,
      this.firstName,
      this.email,
      this.profilePictureURL,
      this.username});
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
