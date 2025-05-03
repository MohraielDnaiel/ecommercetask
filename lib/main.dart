import 'package:flutter/material.dart';
import 'package:flutterapp/presentation/pages/auth/login_page.dart';
import 'package:flutterapp/presentation/pages/auth/splash_page.dart';
import 'package:flutterapp/presentation/pages/product/MainNavigation.dart';
import 'package:flutterapp/presentation/pages/product/cart_page.dart';
import 'package:flutterapp/providers/favoritesProvider.dart';
import 'package:flutterapp/providers/product_provider.dart';
import 'package:flutterapp/providers/cart_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProxyProvider<ProductProvider, CartProvider>(
          create: (context) => CartProvider([]),
          update: (context, productProvider, cartProvider) {
            return cartProvider!..updateProducts(productProvider.products);
          },
        ),
        ChangeNotifierProxyProvider<ProductProvider, FavoritesProvider>(
          create: (_) => FavoritesProvider(),
          update: (_, productProvider, favoritesProvider) {
            if (favoritesProvider != null) {
              favoritesProvider.setProductProvider(productProvider);
            }
            return favoritesProvider!;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/': (context) => const MainNavigation(),
        '/cart': (context) => const CartPage(),
        // Uncomment the next line if you add the FavoritesPage later
        // '/favorites': (context) => const FavoritesPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }
}