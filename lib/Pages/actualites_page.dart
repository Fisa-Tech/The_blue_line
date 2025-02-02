import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import 'package:strava_client/strava_client.dart';

import '../Components/actu_card.dart';
import '../Components/main_frame.dart';
import '../Models/event_dto.dart';
import '../Services/event_service.dart';
import '../Services/strava_service.dart';
import '../Theme/app_colors.dart';
import '../secret.dart';
import '../user_state.dart';

class FeedItem {
  final DateTime date;
  final bool isStravaActivity;
  final EventDTO? event;
  final SummaryActivity? activity;

  FeedItem({
    required this.date,
    this.event,
    this.activity,
    this.isStravaActivity = false,
  });
}

class ActualitesPage extends StatefulWidget {
  const ActualitesPage({Key? key}) : super(key: key);

  @override
  _ActualitesPageState createState() => _ActualitesPageState();
}

class _ActualitesPageState extends State<ActualitesPage> {
  List<FeedItem> _feedItems = [];

  final ScrollController _scrollController = ScrollController();

  int _currentStravaPage = 1;
  bool _isLoadingMore = false;
  bool _hasMoreStrava = true;

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  @override
  void initState() {
    super.initState();
    _loadFeed(initialLoad: true);

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      _loadMoreStravaActivities();
    }
  }

  Future<void> _loadFeed({bool initialLoad = false}) async {
    setState(() => _isLoadingMore = true);

    try {
      final events = await EventService().fetchEvents(context);

      List<SummaryActivity> activities = [];
      final isConnected = await StravaService().hasSavedToken();
      if (isConnected) {
        if (initialLoad) {
          _currentStravaPage = 1;
          _hasMoreStrava = true; // On reset
          activities = await StravaService().getActivities(
            page: _currentStravaPage,
            perPage: 10,
            daysBefore: 60,
          );
        }
      }

      final eventItems = events.map((ev) {
        return FeedItem(
          date: ev.startDate,
          event: ev,
          isStravaActivity: false,
        );
      }).toList();

      final activityItems = activities.map((act) {
        final dateTime = DateTime.parse(act.startDateLocal!).toLocal();
        return FeedItem(
          date: dateTime,
          activity: act,
          isStravaActivity: true,
        );
      }).toList();

      final combined = [...eventItems, ...activityItems];
      combined.sort((a, b) => b.date.compareTo(a.date));

      setState(() {
        _feedItems = combined;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() => _isLoadingMore = false);
      debugPrint("Erreur loadFeed: $e");
    }
  }

  Future<void> _loadMoreStravaActivities() async {
    if (_isLoadingMore || !_hasMoreStrava) return;

    final isConnected = await StravaService().hasSavedToken();
    if (!isConnected) return;

    setState(() => _isLoadingMore = true);

    try {
      _currentStravaPage++;
      final newActivities = await StravaService().getActivities(
        page: _currentStravaPage,
        perPage: 10,
        daysBefore: 60,
      );
      if (newActivities.isEmpty) {
        _hasMoreStrava = false;
      }

      final newActivityItems = newActivities.map((act) {
        final dateTime = DateTime.parse(act.startDateLocal!).toLocal();
        return FeedItem(
          date: dateTime,
          activity: act,
          isStravaActivity: true,
        );
      }).toList();

      final combined = [..._feedItems, ...newActivityItems];
      combined.sort((a, b) => b.date.compareTo(a.date));

      setState(() {
        _feedItems = combined;
        _isLoadingMore = false;
      });
    } catch (e) {
      debugPrint("Erreur loadMoreStravaActivities: $e");
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _refreshAll() async {
    setState(() {
      _feedItems.clear();
      _currentStravaPage = 1;
      _hasMoreStrava = true;
    });
    await _loadFeed(initialLoad: true);
  }

  @override
  Widget build(BuildContext context) {
    final userId =
        Provider.of<UserState>(context, listen: false).currentUser?.id ?? 0;

    return MainFrame(
      appBarVariant: AppBarVariant.notifAndProfile,
      title: 'Actualités',
      currentIndex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Text(
                    'Rafraîchir les actualités',
                    style: AppTextStyles.bodyText1,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: AppColors.textPrimary),
                    onPressed: _refreshAll,
                  )
                ],
              ),
            ),
            Expanded(
              child: _feedItems.isEmpty
                  ? const Center(child: Text('Aucune donnée', style: AppTextStyles.hintText))
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _feedItems.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _feedItems.length) {
                          if (_isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }

                        final item = _feedItems[index];
                        if (!item.isStravaActivity) {
                          final ev = item.event!;
                          return ActuCard(
                            event: ev,
                            userId: userId,
                            challenge: true,
                          );
                        } else {
                          final act = item.activity!;
                          return _buildActivityCard(act);
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(SummaryActivity act) {
    final dateTime = DateTime.parse(act.startDateLocal!).toLocal();
    final dateStr = _dateFormat.format(dateTime);
    final distanceKm = ((act.distance ?? 0) / 1000.0).toStringAsFixed(2);
    final polyline = act.map?.summaryPolyline;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            act.name ?? 'Activité sans nom',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Date : $dateStr',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
          Text(
            'Distance : $distanceKm km',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          if (polyline != null && polyline.isNotEmpty)
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.dark,
              child: Image.network(
                buildStaticMapUrl(polyline),
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, stack) => const Center(
                  child: Text(
                    'Impossible de charger la carte',
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String buildStaticMapUrl(String encodedPolyline) {
    const apiKey = googleMapsKey;
    final params = {
      'size': '600x300',
      'path': 'enc:$encodedPolyline',
      'key': apiKey,
    };
    final uri = Uri.https('maps.googleapis.com', '/maps/api/staticmap', params);
    return uri.toString();
  }
}
