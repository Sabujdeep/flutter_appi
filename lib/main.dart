import 'package:flutter/material.dart';
import 'package:task2/models/dashboard.dart';

void main() {
  runApp(const AviioApp());
}

class AviioApp extends StatelessWidget {
  const AviioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aviio Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const AirportDashboard(),
    );
  }
}

