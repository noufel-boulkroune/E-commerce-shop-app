import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((productId, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    } else if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
          productId,
          (cartItems) => CartItem(
              id: cartItems.id,
              title: cartItems.title,
              price: cartItems.price,
              quantity: cartItems.quantity - 1));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void subtractItem(String productId) {
    _items.update(
        productId,
        (itemList) => itemList.quantity == 1
            ? CartItem(
                id: itemList.id,
                title: itemList.title,
                quantity: itemList.quantity,
                price: itemList.price)
            : CartItem(
                id: itemList.id,
                title: itemList.title,
                quantity: itemList.quantity - 1,
                price: itemList.price));
    notifyListeners();
  }

  void addItem(String productId, String title, double price) {
    _items.update(
      productId,
      (itemList) => CartItem(
          id: itemList.id,
          title: itemList.title,
          quantity: itemList.quantity + 1,
          price: itemList.price),

      //n9adro nkhadmo b putIfAbsent
      ifAbsent: () {
        return (CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price));
      },
    );

    notifyListeners();
  }
}
