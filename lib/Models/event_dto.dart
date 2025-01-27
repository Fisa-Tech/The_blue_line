class EventDTO {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String status;
  final int organizerId;
  final String location;
  final List<int> participantIds;

  EventDTO({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.status,
    required this.organizerId,
    required this.location,
    required this.participantIds,
  });

  factory EventDTO.fromJson(Map<String, dynamic> json) {

    return EventDTO(
      id: json['id'],
      name: json['name'],
      startDate: DateTime(json['startDate'][0], json['startDate'][1], json['startDate'][2], json['startDate'][3], json['startDate'][4], json['startDate'][5]),
      endDate: DateTime(json['endDate'][0], json['endDate'][1], json['endDate'][2], json['endDate'][3], json['endDate'][4], json['endDate'][5]),
      description: json['description'],
      status: json['status'],
      organizerId: json['organizerId'],
      location: json['location'],
      participantIds: List<int>.from(json['participantIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'description': description,
      'status': status,
      'organizerId': organizerId,
      'location': location,
      'participantIds': participantIds,
    };
  }
}