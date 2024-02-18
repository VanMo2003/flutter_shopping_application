import 'package:flutter/material.dart';
import 'package:shopping_application/values/route_value.dart';
import 'package:shopping_application/view/screens/cart_screen.dart';
import 'package:shopping_application/view/screens/home_screen.dart';
import 'package:shopping_application/view/screens/sign_up_screen.dart';

import 'view/screens/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  RouteValue.routeNameToLogin: (context) => const LoginScreen(),
  RouteValue.routeNameToSignUp: (context) => const SignUpScreen(),
  RouteValue.routeNameToHome: (context) => const HomeScreen(),
  // RouteValue.routeNameToDetail: (context) => const DetailProductScreen(),
  RouteValue.routeNameToCart: (context) => const CartScreen(),
};
