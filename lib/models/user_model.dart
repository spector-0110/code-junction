import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String email;
  final String name;
  final String bio;
  final String id;
  final String profilePic;
  const UserModel({
    required this.email,
    required this.name,
    required this.bio,
    required this.id,
    required this.profilePic,
  });

  // copywith function is needed because all fields are final

  UserModel copyWith({
    String? email,
    String? name,
    String? bio,
    String? id,
    String? profilePic,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      id: id ?? this.id,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'bio': bio});
    result.addAll({'profilePic': profilePic});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      id: map['\$id'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, bio: $bio, id: $id, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.name == name &&
        other.bio == bio &&
        other.id == id &&
        other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        name.hashCode ^
        bio.hashCode ^
        id.hashCode ^
        profilePic.hashCode;
  }
}
