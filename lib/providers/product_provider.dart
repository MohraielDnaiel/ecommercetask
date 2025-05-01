import 'package:flutter/material.dart';
import 'package:flutterapp/data/models/product.dart';


class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Red Dress',
      image: 'assets/woman.png',
      price: 99,
      description: 'Stylish red dress, perfect for summer.',
    ),
    Product(
      id: '2',
      name: 'Black Jacket',
      image: 'assets/woman.png',
      price: 150,
      description: 'Warm and elegant black jacket.',
    ),
  ];

  List<Product> get products => _products;

  Product getById(String id) => _products.firstWhere((p) => p.id == id);
}
