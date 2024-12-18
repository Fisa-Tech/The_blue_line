import 'package:flutter/material.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final List<String> sports = [
    "Course à pied",
    "Vélo",
    "Musculation",
    "Marche",
  ];
  final List<bool> selectedSports = [false, false, false, false];

  void _nextPage() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Dernière étape : Envoyer les données
      _submitData();
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitData() {
    // Action à réaliser pour envoyer les données à l'API
    print(
        "Données soumises : ${selectedSports.asMap().entries.map((e) => e.value ? sports[e.key] : null).where((sport) => sport != null).toList()}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil enregistré avec succès !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color dark = Color(0xFF262531);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: dark,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
              child: Row(
                children: [
                  IconButton(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (_currentStep + 1) / 3,
                      backgroundColor: Colors.grey[800],
                      color: const Color(0xFF546EFF),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Étape 1 : Sélection des sports favoris
                  _buildSportsStep(),
                  // Étape 2 : Exemple d'autre étape
                  _buildExampleStep("Dis-nous plus sur toi !",
                      "Ajoute une description ici..."),
                  // Étape 3 : Confirmation
                  _buildExampleStep(
                      "Tout est prêt !", "Prêt à commencer ton aventure."),
                ],
              ),
            ),
            // Bouton Continuer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF546EFF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _currentStep < 2 ? "Continuer" : "Confirmer",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSportsStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(
              Icons.directions_run,
              size: 100,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Quels sont tes sports favoris ?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...sports.asMap().entries.map((entry) {
            int index = entry.key;
            String sport = entry.value;
            return CheckboxListTile(
              value: selectedSports[index],
              onChanged: (value) {
                setState(() {
                  selectedSports[index] = value!;
                });
              },
              title: Text(
                sport,
                style: const TextStyle(color: Colors.white),
              ),
              activeColor: const Color(0xFF546EFF),
              checkColor: Colors.white,
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildExampleStep(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
