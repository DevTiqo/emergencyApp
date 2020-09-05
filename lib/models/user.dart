

class User {
  String userName;
  String userId;
  String userCampId;
  String email;
  String image;
  String password;
  int pin;
  List associations;
  List trends;
  double accountBalance;
  DateTime createdAt;
  DateTime updatedAt;
  bool isAvailable;

  User();

  User.fromMap(Map<String, dynamic> data) {
    userId = data['userId'];
    userCampId = data['userCampId'];
    userName = data['userName'];
    email = data['email'];
    pin = data['pin'];
    image = data['image'];
    associations = data['associations'];
    trends = data['trends'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    accountBalance = data['accountBalance'];
    isAvailable = data['isAvailable'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userCampId': userCampId,
      'userName': userName,
      'email': email,
      'pin': pin,
      'image': image,
      'associations': associations,
      'trends': trends,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'accountBalance': accountBalance,
      'isAvailable': isAvailable,
    };
  }
}
