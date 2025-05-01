import 'package:flutter/material.dart';
import 'package:flutterapp/data/models/product.dart';


class CartProvider extends ChangeNotifier {
  final Map<String, int> _items = {}; // productId: quantity

  Map<String, int> get items => _items;

  void addToCart(Product product) {
    _items.update(product.id, (qty) => qty + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int qty) {
    if (qty <= 0) {
      removeFromCart(productId);
    } else {
      _items[productId] = qty;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
