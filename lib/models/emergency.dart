import 'package:emergencyApp/models/user.dart';

class Emergency {
  String id;
  String type;
  String category;
  String description;
  String senderId;
  String status;
  User user;
  DateTime createdAt;

  Emergency();

  Emergency.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    type = data['type'];
    category = data['category'];
    description = data['description'];
    senderId = data['senderId'];
    status = data['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "description": description,
      "category": category,
      "status": status,
      "createdAt": createdAt,
      "senderId": senderId,
    };
  }
}
