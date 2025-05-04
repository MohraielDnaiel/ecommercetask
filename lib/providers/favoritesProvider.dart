// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutterapp/data/models/product.dart';
import 'package:flutterapp/providers/product_provider.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String> _favoriteProductIds = [];  
  ProductProvider? _productProvider;


  List<Product> get favorites {
  
    return _productProvider?.products
            .where((p) => _favoriteProductIds.contains(p.id))
            .toList() ??
        [];
  }


  void setProductProvider(ProductProvider provider) {
    _productProvider = provider;
    notifyListeners();  // التحديث عندما يتم تعيين الـ ProductProvider
  }

void toggleFavorite(String productId) {
  if (_favoriteProductIds.contains(productId)) {
    _favoriteProductIds.remove(productId);  // إزالة المنتج من المفضلة
  } else {
    _favoriteProductIds.add(productId);  // إضافة المنتج إلى المفضلة
  }
  print("Favorites Updated: $_favoriteProductIds");  // طباعة الـ IDs المفضلة
  notifyListeners();
}


  // التحقق إذا كان المنتج في المفضلة
  bool isFavorite(String productId) => _favoriteProductIds.contains(productId);
}
