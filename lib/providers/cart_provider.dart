import 'package:flutter/material.dart';
import 'package:flutterapp/data/models/CartItem.dart';
import 'package:flutterapp/data/models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<Product> _allProducts;

  CartProvider(this._allProducts);

  List<CartItem> get cartItems => List.unmodifiable(_items);

  List<Product> get allProducts => List.unmodifiable(_allProducts);

  void updateProducts(List<Product> newProducts) {
    _allProducts = newProducts;
    notifyListeners();
  }

  void addToCart(Product product, {Map<String, dynamic> attributes = const {}}) {
    final index = _findCartItemIndex(product, attributes);

    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product, quantity: 1, attributes: attributes));
    }

    notifyListeners();
  }


  void removeFromCart(CartItem cartItem) {
    _items.remove(cartItem);
    notifyListeners();
  }

  void updateQuantity(CartItem cartItem, int qty) {
    final index = _items.indexOf(cartItem);

    if (index >= 0) {
      if (qty <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = qty;
      }
      notifyListeners();
    }
  }

  /// ✅ Update attributes of a cart item
  void updateAttributes(CartItem cartItem, Map<String, dynamic> newAttributes) {
    final index = _items.indexOf(cartItem);

    if (index >= 0) {
      _items[index] = CartItem(
        product: cartItem.product,
        quantity: cartItem.quantity,
        attributes: newAttributes,
      );
      notifyListeners();
    }
  }

  /// ✅ Calculate total price
  double get totalPrice {
    return _items.fold(
      0.0,
      (total, item) => total + item.product.price * item.quantity,
    );
  }

  /// ✅ Clear the entire cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  /// ✅ Get total quantity of items
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  /// ✅ Helper to find item by product + attributes
  int _findCartItemIndex(Product product, Map<String, dynamic> attributes) {
    return _items.indexWhere((item) => item.isSame(product, attributes));
  }
}
