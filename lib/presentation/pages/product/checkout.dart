import 'package:flutter/material.dart';
import 'package:flutterapp/providers/cart_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.cartItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE2), // Set background color
      appBar: AppBar(
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.black), // Ensure text is visible
        ),
        backgroundColor: const Color(0xFFF5EFE2), // Match background color
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black), // For back button
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Cart Items List
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Text(
                          "Cart is empty",
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      )
                    : ListView.separated(
                        itemCount: cartItems.length,
                        separatorBuilder: (_, __) => const Divider(
                          color: Colors.grey, // Make divider visible
                          thickness: 0.5,
                        ),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          final product = item.product;

                          return Card(
                            color: Colors.white, // Card stands out against background
                            elevation: 0,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: _buildProductImage(product.image),
                              title: Text(
                                product.name,
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Qty: ${item.quantity}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  if (item.attributes.isNotEmpty)
                                    ...item.attributes.entries.map(
                                      (e) => Text(
                                        "${e.key}: ${e.value}",
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                ],
                              ),
                              trailing: Text(
                                "\$${(product.price * item.quantity).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 16),

              // Shipping Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Shipping to:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "123 Fashion Street, NY 10001",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 8),
                ],
              ),

              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),

              // Summary Section
              Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildSummary(
                    subtotal: cart.totalPrice,
                    delivery: 3.0,
                    total: cart.totalPrice + 3.0,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Confirm Order Button
              ElevatedButton(
                onPressed: () {
                  cart.clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order Placed!")),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Confirm Order",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return const Icon(Icons.shopping_bag, size: 50, color: Colors.black);
    }
    return Image.network(
      imageUrl,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.broken_image,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSummary({
    required double subtotal,
    required double delivery,
    required double total,
  }) {
    return Column(
      children: [
        _summaryRow("Subtotal", subtotal),
        _summaryRow("Delivery", delivery),
        const Divider(color: Colors.grey, thickness: 1),
        _summaryRow("Total", total, isTotal: true),
      ],
    );
  }

  Widget _summaryRow(String title, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}