import 'package:flutter/material.dart';
import 'package:myapp/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilpage extends StatefulWidget {
  @override
  State<Profilpage> createState() => _ProfilpageState();
}

class _ProfilpageState extends State<Profilpage> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _gender;
  String? _status;
  final apiService = ApiService(); // Crée une instance de la classe ApiService

  // Créer une variable pour stocker les données de profil
  Map<String, dynamic>? _profileData;

  Future<Map<String, dynamic>> fetchData() async {
    final token = await _getToken();
    print("token 2");
    print(token);
    try {
      print("1");
      final profil = await ApiService().get("api/users/me", headers: {
        "Authorization": "Bearer $token"
      }); // Simule un délai pour l'API
      print("2");
      setState(() {
        _profileData = profil; // Stocker les données du profil
        _lastName = profil['lastname'];
        _firstName = profil['firstname'];
        _email = profil['email'];
        _gender = profil['sex'];
        _status = profil['status'];
      });
      return profil;
    } catch (e) {
      // Navigator.pushNamed(context, '/login');
      print(e);
      throw Exception(
          'Erreur lors de la récupération des données de profil $e');
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    print("Token sauvegardé dans SharedPreferences : $token");
    return token;
  }

  Future<void> _updateAccount(snapshotData) async {
    print("snapshot data");
    print(snapshotData);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("auth_token");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Préparer les données utilisateur
        final userData = {
          'lastname': _lastName,
          'firstname': _firstName,
          'email': _email,
          'sex': _gender,
          'status': _status,
          'avatar': "TODO",
        };

        print(userData);
        if (_email != null) {
          final url = 'api/users/me';
          final response = await apiService
              .put(url, userData, headers: {"Authorization": "Bearer $token"});
        }

        // Envoyer les données à l'API avec la valeur password dans le corps de la requête
      } catch (e) {
        print("Erreur PUT : $e");
        throw ("Erreur lors de la mise à jour du profil");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mon profil'),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future:
              _profileData == null ? fetchData() : Future.value(_profileData),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Erreur: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              _profileData =
                  snapshot.data; // Sauvegarde des données dans la variable
              print("_profileData");
              print(_profileData);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Nom",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _profileData!['lastname'] ?? "",
                        onSaved: (value) => _lastName = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Prenom",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _profileData!['firstname'] ?? "",
                        onSaved: (value) => _firstName = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre prénom';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _profileData!['email'] ?? "",
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) => _email = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Veuillez entrer un email valide';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Sexe',
                          border: OutlineInputBorder(),
                        ),
                        value: _gender ?? _profileData!['sex'],
                        items: ['MALE', 'FEMALE', 'OTHER']
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _gender = value;
                          // setState(() {
                          //   _gender = value;
                          // });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Veuillez sélectionner votre sexe';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        value: _status ?? _profileData!['status'],
                        items: [
                          'LYCEE',
                          'COLLEGE',
                          'ETUDIANT',
                          'PERSONNEL',
                          'AUTRES'
                        ]
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) {
                          _status = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Veuillez sélectionner votre status';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _updateAccount(snapshot.data);
                          }
                        },
                        child: Text('Mettre à jour le profil TODO'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgotpassword');
                        },
                        child: Text('Changer de mot de passe'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print("test");
                          print(_lastName);
                          print(_firstName);
                          print(_email);
                          print(_gender);
                          print(_status);
                        },
                        child: Text('print'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text("Aucune donnée"));
            }
          },
        ));
  }
}
