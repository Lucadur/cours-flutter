import 'dart:async';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  double volumePrefere = 50;
  bool notificationsEnabled = false;
  List<String> stylesSelectionnes = [];

  DateTime? date;
  Future<Null> datePicker() async {
    DateTime? choice = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2025));
    if (choice != null) {
      setState(() {
        date = choice;
      });
    }
  }

  final styles = [
    'Pop',
    'Rock',
    'Jazz',
    'Classique',
    'Electro',
    'Indie',
    'Hip-Hop',
    'Country'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inscription',
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nom d'utilisateur",
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un nom d'utilisateur";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Adresse mail",
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer une adresse mail";
                  }
                  final RegExp emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if (!emailRegex.hasMatch(value)) {
                    return "Veuillez entrer une adresse mail valide";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Mot de passe",
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un mot de passe";
                  }
                  final RegExp passwordRegex = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                  if (!passwordRegex.hasMatch(value)) {
                    return "Le mot de passe doit contenir au moins 8 caractères, une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text("Styles musicaux que vous aimez"),
              Column(
                children: styles.map((String style) {
                  return CheckboxListTile(
                    title: Text(style),
                    value: stylesSelectionnes.contains(style),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          stylesSelectionnes.add(style);
                        } else {
                          stylesSelectionnes.remove(style);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text("Fréquence d'écoute (par mois)"),
              Slider(
                value: volumePrefere,
                min: 0,
                max: 100,
                divisions: 10,
                label: volumePrefere.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    volumePrefere = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("Activer les notifications"),
                value: notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  datePicker();
                },
                child: Column(
                  children: [
                    const Text("Votre date de naissance:"),
                    Text((date ?? DateTime.now()).toString().split(' ')[0]),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Nom d'utilisateur validé");
                      print("Styles préférés: $stylesSelectionnes");
                      print("Fréquence d'écoute: $volumePrefere");
                      print("Notifications activées: $notificationsEnabled");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Formulaire soumis avec succès!")),
                      );
                    }
                  },
                  child: const Text('S\'inscrire'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
