import 'package:flutter/material.dart';
import 'package:flutterapp/presentation/pages/auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBDD),
      body: Padding(
  padding: const EdgeInsets.all(24.0),
  child: Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [  const SizedBox(height: 20), 
          const Text(
            'Discover Your\nStyle Today',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
           'Shop the latest trends in fashion.\nFind outfits that fit your style and budget, all in one place.',
    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Get started',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/models.jpg',
            fit: BoxFit.cover , 
            width: double.infinity,
          ),
        ),
      ),
    ],
  ),
),);
  }}