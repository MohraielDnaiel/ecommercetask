import 'package:flutter/material.dart';
import 'package:flutterapp/data/models/CartItem.dart';
import 'package:flutterapp/presentation/pages/product/checkout.dart';
import 'package:flutterapp/providers/cart_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.cartItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE2),
      appBar: AppBar(
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF5EFE2),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Checkout",
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final CartItem item = cartItems[index];
                      return _buildCartItem(
                        context,
                        item: item, 
                        onRemove: () => cart.removeFromCart(item), 
                        onQuantityChanged: (newQty) => cart.updateQuantity(item, newQty), 
                        onSizeChanged: (newSize) {
                          cart.updateAttributes(item, {'Size': newSize});
                        },
                      );
                    },
                  ),
          ),
          Divider(
            thickness: 2,
            color: Colors.grey[400],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSummarySection(
                      itemCount: cart.itemCount,
                      subtotal: cart.totalPrice,
                      deliveryFee: 3,
                      total: cart.totalPrice + 3,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CheckoutPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Proceed to Checkout",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
    BuildContext context, {
    required CartItem item,
    required VoidCallback onRemove,
    required Function(int) onQuantityChanged,
    required Function(String) onSizeChanged,
  }) {
    final product = item.product;
    final quantity = item.quantity;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: onRemove, 
                ),
              ],
            ),
            if (item.attributes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: item.attributes.entries
                      .map((e) => Text(
                            "${e.key}: ${e.value}",
                            style: TextStyle(color: Colors.grey[600]),
                          ))
                      .toList(),
                ),
              ),
            Text(
              product.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("Qty: ", style: TextStyle(color: Colors.black)),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.black),
                  onPressed: () {
                    if (quantity > 1) onQuantityChanged(quantity - 1); 
                  },
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    onQuantityChanged(quantity + 1); 
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Size:", style: TextStyle(color: Colors.black)),
                DropdownButton<String>(
                  value: item.attributes['Size'],
                  items: ['S', 'M', 'L', 'XL']
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text(size, style: const TextStyle(color: Colors.black)),
                          ))
                      .toList(),
                  onChanged: (newSize) {
                    if (newSize != null) {
                      onSizeChanged(newSize);
                    }
                  },
                  hint: const Text("Select Size", style: TextStyle(color: Colors.black)),
                  dropdownColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection({
    required int itemCount,
    required double subtotal,
    required double deliveryFee,
    required double total,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Summary ($itemCount items):",
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        _buildPriceRow("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
        _buildPriceRow("Delivery Fee", "\$${deliveryFee.toStringAsFixed(2)}"),
        Divider(
          thickness: 2,
          color: Colors.grey[400],
        ),
        _buildPriceRow("Total", "\$${total.toStringAsFixed(2)}", isTotal: true),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Text(
            value,
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