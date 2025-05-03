import 'package:flutter/material.dart';
import 'package:flutterapp/providers/cart_provider.dart';
import 'package:flutterapp/providers/product_provider.dart';
import 'package:flutterapp/providers/favoritesProvider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final product = productProvider.getById(widget.productId);  // Get product
    final cart = Provider.of<CartProvider>(context, listen: false);
    final favProvider = Provider.of<FavoritesProvider>(context);

    final isFavorite = favProvider.isFavorite(product.id);  // Check if the product is favorite

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: () {
              favProvider.toggleFavorite(product.id);  // Toggle favorite status
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(product.image, height: 300),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("\$${product.price}", style: const TextStyle(fontSize: 20, color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text(product.description, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 16),
                  const Text("Color", style: TextStyle(fontWeight: FontWeight.bold)),
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.brown, radius: 10),
                      SizedBox(width: 10),
                      CircleAvatar(backgroundColor: Colors.orange, radius: 10),
                      SizedBox(width: 10),
                      CircleAvatar(backgroundColor: Colors.grey, radius: 10),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text("Size", style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: ['S', 'M', 'L', 'XL'].map((size) {
                      final isSelected = size == selectedSize;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: SizeChip(label: size, selected: isSelected),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: selectedSize == null
                          ? null
                          : () {
                              cart.addToCart(product, attributes: {'Size': selectedSize});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Added to cart with size $selectedSize')),
                              );
                            },
                      child: const Text("Add to Cart"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SizeChip extends StatelessWidget {
  final String label;
  final bool selected;
  const SizeChip({super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? Colors.black : Colors.grey),
        color: selected ? Colors.black : Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
