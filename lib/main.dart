import 'package:flutter/material.dart';
import 'package:nyxproject/services/session_service.dart';
import 'pages/main_dashboard.dart'; // Main

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sessionService = SessionService();
  await sessionService.init();

  runApp(MyApp(sessionService: sessionService));
}

class MyApp extends StatelessWidget {
  final SessionService sessionService;
  const MyApp({required this.sessionService, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: sessionService.isLoggedIn()
      //     ? MainDashboard(sessionService: sessionService)
      //     : LoginPage(sessionService: sessionService),
      home:MainDashboard(sessionService: sessionService),
      // home: const ProductDetails(),
    );
  }
}