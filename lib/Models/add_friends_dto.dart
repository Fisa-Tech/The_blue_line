class AddFriendsDto {
  final int id;
  final String idAsker;
  final String idReceiver;
  final String status;

  AddFriendsDto({
    required this.id,
    required this.idAsker,
    required this.idReceiver,
    required this.status,
  });

  // Factory pour créer un UserDto à partir d'un JSON
  factory AddFriendsDto.fromJson(Map<String, dynamic> json) {
    return AddFriendsDto(
      id: json['id'],
      idAsker: json['idAsker'],
      idReceiver: json['idReceiver'],
      status: json['status'],
    );
  }

  // Méthode pour convertir un UserDto en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idAsker': idAsker,
      'idReceiver': idReceiver,
      'status': status,
    };
  }
}