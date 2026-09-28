import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const Sirius());
}

class Sirius extends StatelessWidget {
  const Sirius({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sirius',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}