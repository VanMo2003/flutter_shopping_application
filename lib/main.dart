import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import 'controllers/cart_controller.dart';
import 'controllers/loading_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/user_controller.dart';
import 'firebase_options.dart';
import 'route_name.dart';
import 'view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(momentum());
}

Momentum momentum() {
  return Momentum(
    controllers: [
      UserController(),
      LoadingController(),
      ProductController(),
      CartController(),
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreens(),
    );
  }
}
