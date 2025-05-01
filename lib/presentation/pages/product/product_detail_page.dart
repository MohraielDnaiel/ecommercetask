import 'package:flutter/material.dart';
import 'package:flutterapp/providers/cart_provider.dart';
import 'package:flutterapp/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context).getById(productId);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [Icon(Icons.favorite_border)],
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
                  Row(
                    children: const [
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
                    children: const [
                      SizeChip(label: 'S'),
                      SizeChip(label: 'M'),
                      SizeChip(label: 'L'),
                      SizeChip(label: 'XL'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () {
                        cart.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added to cart')),
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
  const SizeChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
