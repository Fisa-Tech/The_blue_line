import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static late BuildContext
      _navigatorContext; // Stocker le contexte pour la navigation

  // Initialisation des notifications
  static Future<void> initialize(BuildContext context) async {
    _navigatorContext = context; // Stocker le contexte fourni

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('image_cloche');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    bool? initialized = await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        await onSelectNotification(notificationResponse.payload);
      },
    );

    if (!initialized!) {
      throw Exception('Notification initialization failed!');
    }
  }

  // Méthode pour afficher différents types de notifications
  static Future<void> showNotificationType({
    required NotificationType type,
    required int id,
    String? customTitle,
    String? customBody,
  }) async {
    final notificationDetails = _getNotificationDetails(type);

    final title = customTitle ?? type.defaultTitle;
    final body = customBody ?? type.defaultBody;

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: type.payload,
    );
  }

  // Configuration des types de notifications
  static NotificationDetails _getNotificationDetails(NotificationType type) {
    switch (type) {
      case NotificationType.info:
        return const NotificationDetails(
          android: AndroidNotificationDetails(
            'info_channel_id',
            'Info Notifications',
            channelDescription: 'Notifications informatives',
            importance: Importance.high,
            priority: Priority.high,
            icon: 'image_cloche',
          ),
        );
      case NotificationType.warning:
        return const NotificationDetails(
          android: AndroidNotificationDetails(
            'warning_channel_id',
            'Warning Notifications',
            channelDescription: 'Notifications d\'avertissement',
            importance: Importance.high,
            priority: Priority.high,
            icon: 'image_cloche',
          ),
        );
      case NotificationType.success:
        return const NotificationDetails(
          android: AndroidNotificationDetails(
            'success_channel_id',
            'Success Notifications',
            channelDescription: 'Notifications de succès',
            importance: Importance.high,
            priority: Priority.high,
            icon: 'image_cloche',
          ),
        );
      case NotificationType.error:
        return const NotificationDetails(
          android: AndroidNotificationDetails(
            'error_channel_id',
            'Error Notifications',
            channelDescription: 'Notifications d\'erreur',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'image_cloche',
          ),
        );
      default:
        throw Exception('Type de notification inconnu');
    }
  }

  // Gestion de la sélection d'une notification
  static Future<void> onSelectNotification(String? payload) async {
    print('Notification sélectionnée : $payload');

    if (payload != null) {
      switch (payload) {
        case 'info_payload':
          // Navigator.push(
          //   _navigatorContext,
          //   MaterialPageRoute(builder: (context) => const InfoPage()),
          // );
          break;
        case 'success_payload':
          // Navigator.push(
          //   _navigatorContext,
          //   MaterialPageRoute(builder: (context) => const SuccessPage()),
          // );
          break;
        case 'error_payload':
          // Navigator.push(
          //   _navigatorContext,
          //   MaterialPageRoute(builder: (context) => const ErrorPage()),
          // );
          break;
        default:
        // Navigator.push(
        //   _navigatorContext,
        //   MaterialPageRoute(builder: (context) => const DefaultPage()),
        // );
      }
    }
  }
}

// Enum pour les types de notifications
enum NotificationType {
  info('Information', 'Voici une notification informative.', 'info_payload'),
  warning(
      'Avertissement', 'Attention, une action est requise.', 'warning_payload'),
  success('Succès', 'Action effectuée avec succès.', 'success_payload'),
  error('Erreur', 'Une erreur est survenue.', 'error_payload');

  final String defaultTitle;
  final String defaultBody;
  final String payload;

  const NotificationType(this.defaultTitle, this.defaultBody, this.payload);
}
