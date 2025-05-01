import 'package:flutter/material.dart';
import 'package:flutterapp/providers/cart_provider.dart';
import 'package:flutterapp/providers/product_provider.dart';
import 'package:provider/provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: ListView(
        children: cart.items.entries.map((entry) {
          final product = productProvider.getById(entry.key);
          return ListTile(
            leading: Image.asset(product.image, width: 50),
            title: Text(product.name),
            subtitle: Text("Qty: ${entry.value}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => cart.updateQuantity(product.id, entry.value - 1),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => cart.updateQuantity(product.id, entry.value + 1),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cart.removeFromCart(product.id),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
