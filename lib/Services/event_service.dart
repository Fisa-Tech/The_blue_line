import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/Helpers/auth_helper.dart';
import '../Models/event_dto.dart';

class EventService {
  static const String baseUrl = 'https://blue-line-preprod.fisadle.fr';

  Future<List<EventDTO>> fetchEvents() async {
    final token = await AuthHelper.getToken();
    final response = await http.get(Uri.parse('$baseUrl/api/events'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<EventDTO> events = body.map((dynamic item) => EventDTO.fromJson(item)).toList();
      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<List<EventDTO>> fetchRecentEvents() async {
    List<EventDTO> allEvents = await fetchEvents();
    allEvents.sort((a, b) => b.startDate.compareTo(a.startDate)); // Assuming EventDTO has a 'date' field
    return allEvents.take(3).toList();
  }
}
