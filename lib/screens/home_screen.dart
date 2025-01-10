import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/food_item_tile.dart';

class HomeScreen extends StatelessWidget {
  final List<FoodItem> foodItems = [
    FoodItem(id: '1', name: 'Burger', imageUrl: 'https://via.placeholder.com/150', price: 5.99),
    FoodItem(id: '2', name: 'Pizza', imageUrl: 'https://via.placeholder.com/150', price: 9.99),
    FoodItem(id: '3', name: 'Pasta', imageUrl: 'https://via.placeholder.com/150', price: 7.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Ordering App'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return FoodItemTile(item: foodItems[index]);
        },
      ),
    );
  }
}
