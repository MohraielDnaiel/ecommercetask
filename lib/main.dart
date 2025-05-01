import 'package:flutter/material.dart';
import 'package:flutterapp/providers/cart_provider.dart';
import 'package:flutterapp/providers/product_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/splash_page.dart';
import 'presentation/pages/product/home_page.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()), // 
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
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
