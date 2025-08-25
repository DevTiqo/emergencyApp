import 'dart:convert';

import 'package:emergencyApp/models/user.dart';

class Emergency {
  String id;
  String type;
  String category;
  String description;
  String senderId;
  String status;
  User? user;
  DateTime createdAt;

  Emergency(
    this.id,
    this.type,
    this.category,
    this.description,
    this.senderId,
    this.status,
    this.user,
    this.createdAt,
  );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'type': type});
    result.addAll({'category': category});
    result.addAll({'description': description});
    result.addAll({'senderId': senderId});
    result.addAll({'status': status});
    result.addAll({'user': user?.toMap()});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});

    return result;
  }

  Emergency copyWith({
    String? id,
    String? type,
    String? category,
    String? description,
    String? senderId,
    String? status,
    User? user,
    DateTime? createdAt,
  }) {
    return Emergency(
      id ?? this.id,
      type ?? this.type,
      category ?? this.category,
      description ?? this.description,
      senderId ?? this.senderId,
      status ?? this.status,
      user ?? this.user,
      createdAt ?? this.createdAt,
    );
  }

  factory Emergency.fromMap(Map<String, dynamic> map) {
    return Emergency(
      map['id'] ?? '',
      map['type'] ?? '',
      map['category'] ?? '',
      map['description'] ?? '',
      map['senderId'] ?? '',
      map['status'] ?? '',
      User.fromMap(map['user']),
      DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Emergency.fromJson(String source) =>
      Emergency.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Emergency(id: $id, type: $type, category: $category, description: $description, senderId: $senderId, status: $status, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Emergency &&
        other.id == id &&
        other.type == type &&
        other.category == category &&
        other.description == description &&
        other.senderId == senderId &&
        other.status == status &&
        other.user == user &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        category.hashCode ^
        description.hashCode ^
        senderId.hashCode ^
        status.hashCode ^
        user.hashCode ^
        createdAt.hashCode;
  }
}
