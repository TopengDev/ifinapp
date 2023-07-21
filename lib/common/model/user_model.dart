import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? email;
  final String? fullName;
  final String? username;
  final int? level;
  final int? segment;

  const UserModel({
    this.id,
    this.email,
    this.fullName,
    this.username,
    this.level,
    this.segment,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? username,
    int? level,
    int? segment,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      level: level ?? this.level,
      segment: segment ?? this.segment,
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      fullName: map['fullName'],
      username: map['username'],
      level: map['level'],
      segment: map['segment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'username': username,
      'level': level,
      'segment': segment,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        username,
        level,
        segment,
      ];
}
