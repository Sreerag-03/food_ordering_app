import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/order_summary_screen.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        title: 'Food Ordering App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/cart': (context) => CartScreen(),
          '/summary': (context) => OrderSummaryScreen(),
        },
      ),
    );
  }
}
