import 'package:flutter/material.dart';
import 'package:flutterapp/data/models/product.dart';
import 'package:flutterapp/providers/product_provider.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String> _favoriteProductIds = [];  // يحتوي على الـ IDs فقط
  ProductProvider? _productProvider;

  // الحصول على المنتجات المفضلة
  List<Product> get favorites {
    // التأكد من أن المنتج موجود في المفضلة بناءً على الـ ID
    return _productProvider?.products
            .where((p) => _favoriteProductIds.contains(p.id))
            .toList() ??
        [];
  }

  // تعيين الـ ProductProvider ليتمكن من الوصول إلى المنتجات
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
