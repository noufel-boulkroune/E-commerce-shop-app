import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  ProductsProvider(this.authToken, this._items, this.userId);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoritItems {
    return [..._items.where((product) => product.isFavorite)];
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  static const String firebaseUrl =
      "https://fluttershopapp2022-default-rtdb.firebaseio.com";

  Future<void> updateProduct(String id, Product newProduct) async {
    final url = Uri.parse('$firebaseUrl/Products/$id.json?auth=$authToken');
    final productIndex = _items.indexWhere((product) => product.id == id);

    await http.patch(url,
        body: json.encode({
          "title": newProduct.title,
          "price": newProduct.price,
          "description": newProduct.description,
          "imageUrl": newProduct.imageUrl
        }));
    _items[productIndex] = newProduct;

    notifyListeners();
  }

  Future fetchAndSetProducts([bool filterByUser = false]) async {
    String filterString =
        filterByUser == true ? '&orderBy="creatorId"&=equalTo="$userId"' : '';
    final url =
        Uri.parse('$firebaseUrl/Products.json?auth=$authToken$filterString');
    try {
      final response = await http.get(url);
      Map<String, dynamic> productData = json.decode(response.body);
      if (productData.isEmpty) {
        return;
      }
      final favoritesUrl =
          Uri.parse('$firebaseUrl/userFavorites/$userId.json?auth=$authToken');
      final favoritesResponse = await http.get(favoritesUrl);
      final fivoritesData = json.decode(favoritesResponse.body);
      final List<Product> loadedProducts = [];
      productData.forEach(
        (productId, product) {
          loadedProducts.add(Product(
            id: productId,
            title: product["title"],
            description: product["description"],
            price: product["price"],
            imageUrl: product["imageUrl"],
            isFavorite: fivoritesData == null
                ? false
                : fivoritesData[productId] ?? false,
          ));
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      // rethrow;
    }
  }

  Future addProduct(Product product) async {
    final url = Uri.parse('$firebaseUrl/Products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          //"id": product.id,
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "creatorId": userId,
          //"isFavorite": product.isFavorite
        }),
      );

      final newProduct = Product(
          description: product.description,
          price: product.price,
          title: product.title,
          id: jsonDecode(response.body)["name"],
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> removeProduct(String id) async {
    final url = Uri.parse('$firebaseUrl/Products/$id.json?auth=$authToken');
    final productIndex = _items.indexWhere((product) => product.id == id);
    Product? removedProduct = _items[productIndex];
    _items.removeAt(productIndex);
    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException("Could not delete product.");
      }
      removedProduct = null;
    }).catchError((error) {
      _items.insert(productIndex, removedProduct!);
      notifyListeners();
    });

    notifyListeners();
  }
}
