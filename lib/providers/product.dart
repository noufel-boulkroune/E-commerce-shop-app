import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toogleFavorite(String userId, String authToken) async {
    const String firebaseUrl = "";
    final oldStatus = isFavorite;
    final url = Uri.parse(
        '$firebaseUrl/userFavorites/$userId/$id.json?auth=$authToken');
    try {
      final response = await http.put(url,
          body: json.encode(
            !isFavorite,
          ));

      isFavorite = !isFavorite;
      notifyListeners();
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      print("object");
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
