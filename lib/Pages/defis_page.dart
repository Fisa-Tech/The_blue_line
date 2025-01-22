import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';
import 'defi_dto.dart';
import 'defi_service.dart';

class DefisPage extends StatelessWidget {
  const DefisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,  // Le nombre de tabs
      child: MainFrame(
        leftIcon: Icons.notifications_outlined,
        onLeftIconPressed: () {},
        title: 'Défis',
        currentIndex: 0,
        onTabSelected: (int value) {},
        bottom: const TabBar(
          indicatorColor: AppColors.textPrimary,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.lightGrey,
          dividerColor: AppColors.lightGrey,
          tabs: [
            Tab(text: "A relever"),
            Tab(text: "En cours"),
            Tab(text: "Terminés"),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TabBarView(
            children: [
              _buildDefisTab('A relever'),
              _buildDefisTab('En cours'),
              _buildDefisTab('Terminés'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefisTab(String etat) {
    return FutureBuilder<List<Defi>>(
      future: DefiService.fetchDefisByEtat(etat),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucun défi trouvé'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final defi = snapshot.data![index];
              return Card(
                color: AppColors.lightDark,
                child: ListTile(
                  leading: const Icon(Icons.directions_run, color: AppColors.textPrimary),
                  title: Text(
                    defi.titre,
                    style: AppTextStyles.bodyText1,
                  ),
                  subtitle: Text(
                    defi.description,
                    style: AppTextStyles.bodyText2,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/defis_details', arguments: defi.id);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
