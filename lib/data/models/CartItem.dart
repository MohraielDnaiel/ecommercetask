// ignore: file_names
// ignore: file_names
// ignore: file_names

import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final Map<String, dynamic> attributes;

  CartItem({
    required this.product,
    required this.quantity,
    this.attributes = const {},
  });

  /// Check if another product + attribute combination is the same
  bool isSame(Product otherProduct, Map<String, dynamic> otherAttributes) {
    return product.id == otherProduct.id &&
           _mapsEqual(attributes, otherAttributes);
  }

  /// Helper method to compare attribute maps
  bool _mapsEqual(Map<String, dynamic> a, Map<String, dynamic> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || b[key] != a[key]) {
        return false;
      }
    }
    return true;
  }
}
