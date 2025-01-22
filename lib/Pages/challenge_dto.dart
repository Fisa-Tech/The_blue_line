class Challenge {
  final int id;
  final String titre;
  final String description;
  final String etat;
  final double distance;
  final int time;
  final DateTime deadline;
  final DateTime beginDate;
  final String type;
  final int eventid;

  Challenge({
    required this.id,
    required this.titre,
    required this.description,
    required this.etat,
    required this.distance,
    required this.time,
    required this.deadline,
    required this.beginDate,
    required this.type,
    required this.eventid,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      etat: json['etat'],
      distance: json['distance'],
      time: json['time'],
      deadline: json['deadline'],
      beginDate: json['beginDate'],
      type: json['type'],
      eventid: json['eventid'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'etat': etat,
      'distance': distance,
      'time': time,
      'deadline': deadline,
      'beginDate': beginDate,
      'type': type,
      'eventid': eventid,
    };
  }
}

