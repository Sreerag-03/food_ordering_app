import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/food_item_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodItem> foodItems = [
    FoodItem(id: '1', name: 'Burger', imageUrl: 'https://via.placeholder.com/150', price: 5.99),
    FoodItem(id: '2', name: 'Pizza', imageUrl: 'https://via.placeholder.com/150', price: 9.99),
    FoodItem(id: '3', name: 'Pasta', imageUrl: 'https://via.placeholder.com/150', price: 7.99),
    FoodItem(id: '4', name: 'Sandwich', imageUrl: 'https://via.placeholder.com/150', price: 4.99),
  ];

  List<FoodItem> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = foodItems; // Show all items by default
  }

  void _searchItems(String query) {
    final results = foodItems.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredItems = results;
    });
  }

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
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchItems,
              decoration: InputDecoration(
                hintText: 'Search food...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return FoodItemTile(item: filteredItems[index]);
        },
      ),
    );
  }
}
