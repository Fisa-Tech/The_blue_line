import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Models/event_dto.dart';
import 'package:myapp/Services/event_service.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<EventDTO>> _futureEvents;

  @override
  void initState() {
    super.initState();
    _futureEvents = EventService().fetchRecentEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      title: '',
      currentIndex: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              const Text(
                'Salut Username 👋',
                style: AppTextStyles.headline1,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 150,
                child: const Center(
                  child: Text(
                    'Ici map',
                    style: AppTextStyles.hintText,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Performances',
                style: AppTextStyles.headline2,
              ),
              const Text(
                'Janvier 2025',
                style: AppTextStyles.hintText,
              ),
              const SizedBox(height: 16.0),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.lightDark, // Couleur de fond
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatItem(
                            icon: Icons.timer_outlined,
                            value: '3h34',
                            label: 'Temps passé',
                            iconColor: AppColors.primary,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.shade600, // Ligne de séparation
                          ),
                          _buildStatItem(
                            icon: Icons.local_fire_department_outlined,
                            value: '857',
                            label: 'Calories totales',
                            iconColor: AppColors.danger,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.lightDark, // Couleur de fond
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Ici graphique',
                          style: AppTextStyles.hintText,
                        ),
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dernières actualités',
                    style: AppTextStyles.headline2,
                  ),
                  TextButton(
                    onPressed: () { 
                      Navigator.pushNamed(context, '/news');
                    },
                    child: const Text(
                      'Voir tout',
                      style: AppTextStyles.hintText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<List<EventDTO>>(
                future: _futureEvents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading events'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No recent events'));
                  } else {
                    return Column(
                      children: snapshot.data!.map((event) {
                        return Card(
                          color: AppColors.lightDark,
                          child: ListTile(
                            title: Text(
                              utf8.decode(event.name.runes.toList()),
                              style: AppTextStyles.bodyText1,
                            ),
                            subtitle: Text(
                              EventService().formatEventDates(event.startDate, event.endDate),                          
                              style: AppTextStyles.hintText,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primary.withOpacity(0.2),
                              child: const Icon(Icons.event, color: AppColors.primary),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 4.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}