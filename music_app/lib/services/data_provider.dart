import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  final String _baseUrl = 'https://s3-4987.nuage-peda.fr/music/api';

  List<dynamic> _albums = [];
  List<dynamic> _artists = [];
  List<dynamic> _trendingSongs = [];

  List<dynamic> get albums => _albums;
  List<dynamic> get artists => _artists;
  List<dynamic> get trendingSongs => _trendingSongs;

  Future<void> fetchAlbums() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/albums'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _albums = data['member'] ?? [];
        notifyListeners();
      }
    } catch (e) {
      print('Erreur lors de la récupération des albums : $e');
    }
  }

  Future<void> fetchArtists() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/artists'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _artists = data['member'] ?? [];
        notifyListeners();
      }
    } catch (e) {
      print('Erreur lors de la récupération des artistes : $e');
    }
  }

  Future<void> fetchTrendingSongs() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/songs'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _trendingSongs = (data['member'] as List<dynamic>)
            .where((song) => song['listenCount'] != null)
            .toList()
          ..sort((a, b) => b['listenCount'].compareTo(a['listenCount']));
        notifyListeners();
      }
    } catch (e) {
      print('Erreur lors de la récupération des chansons tendances : $e');
    }
  }
}
