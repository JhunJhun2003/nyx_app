import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/services/cart_service.dart';
import 'pages/splash_screen.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sessionService = SessionService();
  await sessionService.init();

  final cartService = CartService();

  runApp(MyApp(sessionService: sessionService, cartService: cartService));
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
        ChangeNotifierProvider<SessionService>.value(value: sessionService),
        ChangeNotifierProvider<CartService>.value(value: cartService),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nyx Project',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreen(
          // ✅ Show splash screen first
          sessionService: sessionService,
          cartService: cartService,
        ),
      ),
    );
  }
}
