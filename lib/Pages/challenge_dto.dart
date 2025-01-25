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
  final int? eventid;

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
    this.eventid,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      titre: json['name'],
      description: json['description'],
      etat: json['status'],
      distance: json['distanceGoal'],
      time: json['timeGoal'],
      deadline: DateTime(
        json['endDate'][0],
        json['endDate'][1],
        json['endDate'][2],
        json['endDate'][3],
        json['endDate'][4],
        json['endDate'][5],
        json['endDate'][6],
      ), // Conversion de la liste en DateTime
      beginDate: DateTime(
        json['startDate'][0],
        json['startDate'][1],
        json['startDate'][2],
        json['startDate'][3],
        json['startDate'][4],
        json['startDate'][5],
        json['startDate'][6],
      ), // Conversion de la liste en DateTime
      type: json['type'],
      eventid: json['eventId'],
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

