import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Models/event_dto.dart';
import 'package:myapp/Services/event_service.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:myapp/user_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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
    final userState = Provider.of<UserState>(context);
    final firstName = userState.currentUser?.firstname ?? 'toi';

    return MainFrame(
      title: 'Accueil',
      appBarVariant: AppBarVariant.notifAndProfile,
      currentIndex: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salut ${utf8.decode(firstName.runes.toList())} 👋',
                style: AppTextStyles.headline1,
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 150,
                child: Center(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Rayon des coins
                  child: Image.network(
                    'https://static.vecteezy.com/system/resources/thumbnails/022/966/737/small_2x/urban-city-map-town-streets-gps-navigation-downtown-map-with-roads-parks-and-river-abstract-roadmap-navigations-scheme-illustration-vector.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )),
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
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
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
                              color:
                                  Colors.grey.shade600, // Ligne de séparation
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.lightDark, // Couleur de fond
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: true),
                              titlesData: FlTitlesData(
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: false, reservedSize: 40),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: false, reservedSize: 40),
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: false, reservedSize: 40),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      List<String> jours = [
                                        "Lun",
                                        "Mar",
                                        "Mer",
                                        "Jeu",
                                        "Ven",
                                        "Sam",
                                        "Dim"
                                      ];
                                      return SideTitleWidget(
                                        meta: meta,
                                        child:
                                            Text(jours[value.toInt()], // Jours
                                                style: AppTextStyles.hintText),
                                      );
                                    },
                                    reservedSize: 30,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    const FlSpot(0, 3.2), // Lundi : 3.2 km
                                    const FlSpot(1, 5.1), // Mardi : 5.1 km
                                    const FlSpot(2, 2.8), // Mercredi : 2.8 km
                                    const FlSpot(3, 6.0), // Jeudi : 6.0 km
                                    const FlSpot(4, 4.2), // Vendredi : 4.2 km
                                    const FlSpot(5, 7.3), // Samedi : 7.3 km
                                    const FlSpot(6, 5.8), // Dimanche : 5.8 km
                                  ],
                                  isCurved: true,
                                  color: Colors.blueAccent,
                                  barWidth: 4,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.blueAccent.withOpacity(0.3),
                                  ),
                                  dotData: const FlDotData(show: true),
                                ),
                              ],
                            ),
                          ),
                        )),
                      ),
                    ],
                  )),
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
                              EventService().formatEventDates(
                                  event.startDate, event.endDate),
                              style: AppTextStyles.hintText,
                            ),
                            leading: CircleAvatar(
                              backgroundColor:
                                  AppColors.primary.withOpacity(0.2),
                              child: const Icon(Icons.event,
                                  color: AppColors.primary),
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
