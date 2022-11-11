import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final String authToken;
  final String userId;

  List<OrderItem> _orders = [];

  Orders(this.authToken, this._orders, this.userId);

  List<OrderItem> get orders {
    return [..._orders];
  }

  static const String firebaseUrl =
      "https://fluttershopapp2022-default-rtdb.firebaseio.com";

  Future<void> fitchOrders() async {
    final url = Uri.parse('$firebaseUrl/Orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final extractedData = json.decode(response.body); //as Map<String, dynamic>;
    if (extractedData == null || extractedData.isEmpty) {
      return;
    }
    final List<OrderItem> loadedOrders = [];
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData["amount"],
          products: (orderData["products"] as List<dynamic>)
              .map((product) => CartItem(
                  id: product["id"],
                  title: product["title"],
                  price: product["price"],
                  quantity: product["quantity"]))
              .toList(),
          dateTime: DateTime.parse(orderData["date"])));
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    });
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final addingDate = DateTime.now();
    final url = Uri.parse('$firebaseUrl/Orders/$userId.json?auth=$authToken');
    final response = await http.post(url,
        body: json.encode({
          "amount": total,
          "date": addingDate.toIso8601String(),
          "products": cartProducts
              .map((cartProduct) => {
                    "id": cartProduct.id,
                    "title": cartProduct.title,
                    "price": cartProduct.price,
                    "quantity": cartProduct.quantity
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
          amount: total,
          dateTime: addingDate,
          id: json.decode(response.body)["name"],
          products: cartProducts,
        ));
    notifyListeners();
  }
}
