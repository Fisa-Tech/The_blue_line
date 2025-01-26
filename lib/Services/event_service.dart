import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myapp/user_state.dart';
import '../Models/event_dto.dart';
import 'package:provider/provider.dart';


class EventService {
  static const String baseUrl = 'https://blue-line-preprod.fisadle.fr';

  Future<List<EventDTO>> fetchEvents(BuildContext context) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
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

  Future<List<EventDTO>> fetchRecentEvents(BuildContext context) async {
    List<EventDTO> allEvents = await fetchEvents(context);
    allEvents.sort((a, b) => b.startDate.compareTo(a.startDate)); // Assuming EventDTO has a 'date' field
    return allEvents.take(3).toList();
  }

  Future<EventDTO> joinEvent(BuildContext context, int eventId) async {
  final userState = Provider.of<UserState>(context, listen: false);
  final token = userState.token;
  final response = await http.post(
    Uri.parse('$baseUrl/api/events/$eventId/join'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    EventDTO event = EventDTO.fromJson(body); // Passe directement l'objet JSON
    return event;
  } else {
    throw Exception('Failed to join event');
  }
}


  Future<EventDTO> leaveEvent(BuildContext context, int eventId) async {
    final userState = Provider.of<UserState>(context, listen: false);
    final token = userState.token;
    final response = await http.delete(Uri.parse('$baseUrl/api/events/$eventId/leave'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      EventDTO event = EventDTO.fromJson(body);
      return event;
    } else {
      throw Exception('Failed to leave event');
    }
  }

  String formatEventDates(DateTime start, DateTime end) {
    if (start.hour == 0 && start.minute == 0 && end.hour == 0 && end.minute == 0) {
      // Journées entières
      if (start.isAtSameMomentAs(end)) {
        return DateFormat('dd/MM/yyyy').format(start);
      } else {
        return 'du ${DateFormat('dd/MM/yyyy').format(start)} au ${DateFormat('dd/MM/yyyy').format(end)}';
      }
    } else if (start.isAtSameMomentAs(end)) {
      // Même jour et même heure
      return '${DateFormat('dd/MM/yyyy à HH:mm').format(start)}';
    } else if (start.year == end.year && start.month == end.month && start.day == end.day) {
      // Même jour avec heures différentes
      return '${DateFormat('dd/MM/yyyy').format(start)} de ${DateFormat('HH:mm').format(start)} à ${DateFormat('HH:mm').format(end)}';
    } else {
      // Différents jours avec heures
      return 'du ${DateFormat('dd/MM/yyyy à HH:mm').format(start)} au ${DateFormat('dd/MM/yyyy à HH:mm').format(end)}';
    }
  }
}
