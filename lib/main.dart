import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/services/cart_service.dart';
import 'pages/main_dashboard.dart';
import 'pages/detailsPages/accountpages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sessionService = SessionService();
  await sessionService.init();
  
  // Create CartService instance
  final cartService = CartService();

  runApp(MyApp(
    sessionService: sessionService,
    cartService: cartService,
  ));
}

class MyApp extends StatelessWidget {
  final SessionService sessionService;
  final CartService cartService;
  
  const MyApp({
    super.key, 
    required this.sessionService,
    required this.cartService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide SessionService
        ChangeNotifierProvider<SessionService>.value(value: sessionService),
        // Provide CartService
        ChangeNotifierProvider<CartService>.value(value: cartService),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nyx Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: sessionService.isLoggedIn()
        //     ? MainDashboard(sessionService: sessionService, cartService: cartService)
        //     : MainDashboard(sessionService: sessionService , cartService: cartService,),
        home:MainDashboard(sessionService: sessionService, cartService: cartService),
      ),
    );
  }
}