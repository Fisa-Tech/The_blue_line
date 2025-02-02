import 'package:myapp/Models/user_dto.dart';

class AddFriendsDto {
  final int id;
  final UserDto userAsker;
  final UserDto userReceiver;
  final String requestStatus;

  AddFriendsDto({
    required this.id,
    required this.userAsker,
    required this.userReceiver,
    required this.requestStatus,
  });

  // Factory pour créer un UserDto à partir d'un JSON
  factory AddFriendsDto.fromJson(Map<String, dynamic> json) {
    return AddFriendsDto(
      id: json['id'],
      userAsker: UserDto.fromJson(json['userAsker']),
      userReceiver: UserDto.fromJson(json['userReceiver']),
      requestStatus: json['requestStatus'],
    );
  }

  // Méthode pour convertir un UserDto en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userAsker': userAsker,
      'userReceiver': userReceiver,
      'requestStatus': requestStatus,
    };
  }
}
