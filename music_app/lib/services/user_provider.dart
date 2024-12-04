import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _token;
  String? _userEmail;
  String? _userfirstName;

  bool get isAuthenticated => _token != null;
  String? get userEmail => _userEmail;
  String? get userfirstName => _userfirstName;

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://s3-4987.nuage-peda.fr/music/api/authentication_token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        _userEmail = email;
        await _storage.write(key: 'token', value: _token);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erreur lors de la connexion : $e');
      return false;
    }
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    try {
      print('Données envoyées pour l\'inscription : $userData');
      final response = await http.post(
        Uri.parse('https://s3-4987.nuage-peda.fr/music/api/users'),
        headers: {'Content-Type': 'application/ld+json'},
        body: jsonEncode(userData),
      );

      print('Réponse de l\'API inscription : ${response.statusCode}');
      print('Corps de la réponse : ${response.body}');

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Erreur : ${jsonDecode(response.body)}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de l\'inscription : $e');
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userEmail = null;
    await _storage.delete(key: 'token');
    notifyListeners();
  }
}
