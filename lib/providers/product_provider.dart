import 'package:flutter/material.dart';
import 'package:flutterapp/data/models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: ' Basic Top',
      image: 'assets/c1.jpg',
      price: 99,
      description: 'Stylish basic top, perfect for summer.',
    ),
    Product(
      id: '2',
      name: 'jeeb',
      image: 'assets/c2.jpg',
      price: 150,
      description: 'Warm and elegant jeeb ',
    ),
      Product(
      id: '3',
      name: 'Black top',
     image: 'assets/c3.jpg',
      price: 150,
      description: 'Elegant and classy top .',
    ),
      Product(
      id: '4',
      name: 'Colored Top',
      image: 'assets/c4.jpg',
      price: 150,
      description: 'classic top.',
    ),
  ];

  List<Product> _filteredProducts = [];

  ProductProvider() {
    _filteredProducts = _allProducts;
  }

  List<Product> get products => _filteredProducts;

  Product getById(String id) =>
      _allProducts.firstWhere((product) => product.id == id);

  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _allProducts;
    } else {
      _filteredProducts = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void toggleFavorite(String id) {
    // Find the product by id and toggle the favorite status
    final product = _allProducts.firstWhere((p) => p.id == id);
    product.isFavorite = !product.isFavorite;
    
    // Optionally, update the filtered products as well (if they are part of the view)
    // This will make sure the UI updates when a product is marked as favorite
    notifyListeners();
  }

  // Helper to get only favorite products
  List<Product> get favorites => _allProducts.where((product) => product.isFavorite).toList();
}
