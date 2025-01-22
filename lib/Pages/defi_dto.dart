class Defi {
  final int id;
  final String titre;
  final String description;
  final String etat;
  final String imageUrl;
  final int participants;
  final String deadline;
  final String type;

  Defi({
    required this.id,
    required this.titre,
    required this.description,
    required this.etat,
    required this.imageUrl,
    required this.participants,
    required this.deadline,
    required this.type,
  });

  factory Defi.fromJson(Map<String, dynamic> json) {
    return Defi(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      etat: json['etat'],
      imageUrl: json['imageUrl'],
      participants: json['participants'],
      deadline: json['deadline'],
      type: json['type'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'etat': etat,
      'imageUrl': imageUrl,
      'participants': participants,
      'deadline': deadline,
      'type': type,
    };
  }
}

