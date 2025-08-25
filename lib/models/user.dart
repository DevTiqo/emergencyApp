import 'dart:convert';

import 'package:flutter/foundation.dart';

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

  User(
    this.userName,
    this.userId,
    this.userCampId,
    this.email,
    this.image,
    this.password,
    this.pin,
    this.associations,
    this.trends,
    this.accountBalance,
    this.createdAt,
    this.updatedAt,
    this.isAvailable,
  );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'userId': userId});
    result.addAll({'userCampId': userCampId});
    result.addAll({'email': email});
    result.addAll({'image': image});
    result.addAll({'password': password});
    result.addAll({'pin': pin});
    result.addAll({'associations': associations});
    result.addAll({'trends': trends});
    result.addAll({'accountBalance': accountBalance});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'updatedAt': updatedAt.millisecondsSinceEpoch});
    result.addAll({'isAvailable': isAvailable});

    return result;
  }

  User copyWith({
    String? userName,
    String? userId,
    String? userCampId,
    String? email,
    String? image,
    String? password,
    int? pin,
    List? associations,
    List? trends,
    double? accountBalance,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isAvailable,
  }) {
    return User(
      userName ?? this.userName,
      userId ?? this.userId,
      userCampId ?? this.userCampId,
      email ?? this.email,
      image ?? this.image,
      password ?? this.password,
      pin ?? this.pin,
      associations ?? this.associations,
      trends ?? this.trends,
      accountBalance ?? this.accountBalance,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
      isAvailable ?? this.isAvailable,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['userName'] ?? '',
      map['userId'] ?? '',
      map['userCampId'] ?? '',
      map['email'] ?? '',
      map['image'] ?? '',
      map['password'] ?? '',
      map['pin']?.toInt() ?? 0,
      List.from(map['associations']),
      List.from(map['trends']),
      map['accountBalance']?.toDouble() ?? 0.0,
      DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      map['isAvailable'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userName: $userName, userId: $userId, userCampId: $userCampId, email: $email, image: $image, password: $password, pin: $pin, associations: $associations, trends: $trends, accountBalance: $accountBalance, createdAt: $createdAt, updatedAt: $updatedAt, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.userName == userName &&
        other.userId == userId &&
        other.userCampId == userCampId &&
        other.email == email &&
        other.image == image &&
        other.password == password &&
        other.pin == pin &&
        listEquals(other.associations, associations) &&
        listEquals(other.trends, trends) &&
        other.accountBalance == accountBalance &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        userId.hashCode ^
        userCampId.hashCode ^
        email.hashCode ^
        image.hashCode ^
        password.hashCode ^
        pin.hashCode ^
        associations.hashCode ^
        trends.hashCode ^
        accountBalance.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isAvailable.hashCode;
  }
}
