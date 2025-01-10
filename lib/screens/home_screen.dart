import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../widgets/food_item_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodItem> foodItems = [
    FoodItem(id: '1', name: 'Burger', imageUrl: 'https://www.thespruceeats.com/thmb/UpVWAcHnFEe_KvQpYsR1a7U-WY0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/SES-your-best-grilled-burger-recipe-7511041-hero-C-c5080fa5f97c4c2b908968527f8a851b.jpg', price: 5.99,quantity: 1),
    FoodItem(id: '2', name: 'Pizza', imageUrl: 'https://www.foodandwine.com/thmb/Wd4lBRZz3X_8qBr69UOu2m7I2iw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg', price: 9.99,quantity: 1),
    FoodItem(id: '3', name: 'Pasta', imageUrl: 'https://www.vincenzosplate.com/wp-content/uploads/2021/08/610x350-Photo-4_862-How-to-Make-CHICKEN-PASTA-Like-an-Italian-V1.jpg', price: 7.99,quantity: 1),
    FoodItem(id: '4', name: 'Sandwich', imageUrl: 'https://wiproappliances.com/cdn/shop/articles/Veg_grilled_cheese_sandwich.jpg?v=1714126819', price: 4.99,quantity: 1),
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
