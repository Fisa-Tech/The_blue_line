import 'dart:convert';

enum UserSex { MALE, FEMALE, OTHER }

enum UserStatus { LYCEE, COLLEGE, ETUDIANT, PERSONNEL, AUTRES }

class UserDto {
  final int? id; // Champ read-only
  final String firstname;
  final String lastname;
  final String? email;
  final UserSex? sex;
  final String? avatar;
  final UserStatus? status;

  UserDto({
    this.id,
    required this.firstname,
    required this.lastname,
    this.email,
    this.sex,
    this.avatar,
    this.status,
  });

  // Factory pour créer un UserDto à partir d'un JSON
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int?,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String?,
      sex: json['sex'] != null ? UserSex.values.byName(json['sex']) : null,
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
      'email': email,
      'sex': sex?.name,
      'avatar': avatar,
      'status': status?.name,
    };
  }

  bool profilCompleted() {
    return firstname.isNotEmpty &&
        lastname.isNotEmpty &&
        sex != null &&
        status != null;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
