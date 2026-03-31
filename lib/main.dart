import 'package:flutter/material.dart';
import 'pages/detailsPages/accountpages/login.dart';
// import 'pages/main_dashboard.dart'; // Main

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const MainDashboard(),
      home: const LoginPage(),
    );
  }
}