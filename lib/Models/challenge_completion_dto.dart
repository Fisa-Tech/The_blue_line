class ChallengeCompletion {
  final int id;
  final DateTime completionDate;
  final double distanceAchieved;
  final int timeAchieved;
  final int challengeId;
  final int userId;

  ChallengeCompletion({
    required this.id,
    required this.completionDate,
    required this.distanceAchieved,
    required this.timeAchieved,
    required this.challengeId,   
    required this.userId,
  });

  factory ChallengeCompletion.fromJson(Map<String, dynamic> json) {
    return ChallengeCompletion(
      id: json['id'],
      completionDate: json['completionDate'],
      distanceAchieved: json['distanceAchieved'],
      timeAchieved: json['timeAchieved'],
      challengeId: json['challengeId'],
      userId: json['userId'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'completionDate': completionDate,
      'distanceAchieved': distanceAchieved,
      'timeAchieved': timeAchieved,
      'challengeId': challengeId,
      'userId': userId,
    };
  }
}

