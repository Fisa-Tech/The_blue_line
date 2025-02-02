import 'dart:convert';

enum UserSex { MALE, FEMALE, OTHER }

enum UserStatus { LYCEE, COLLEGE, ETUDIANT, PERSONNEL, AUTRES }

class UserDto {
  final int? id; // Champ read-only
  final String? firstname;
  final String? lastname;
  final String? friendId;
  final String email;
  final UserSex? gender;
  final String? avatar;
  final UserStatus? status;

  UserDto({
    this.id,
    this.firstname,
    this.lastname,
    this.friendId,
    required this.email,
    this.gender,
    this.avatar,
    this.status,
  });

  // Factory pour créer un UserDto à partir d'un JSON
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      friendId: json['friendId'] as String?,
      email: json['email'] as String,
      gender:
          json['gender'] != null ? UserSex.values.byName(json['gender']) : null,
      avatar: json['avatar'] as String?,
      status: json['status'] != null
          ? UserStatus.values.byName(json['status'])
          : null,
    );
  }

  // Méthode pour convertir un UserDto en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'friendId': friendId,
      'email': email,
      'gender': gender?.name,
      'avatar': avatar,
      'status': status?.name,
    };
  }

  bool profilCompleted() {
    return firstname != null &&
        lastname != null &&
        gender != null &&
        status != null;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
