import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../providers/cart_provider.dart';

class FoodItemTile extends StatelessWidget {
  final FoodItem item;

  FoodItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Card(
      child: ListTile(
        leading: Image.network(item.imageUrl),
        title: Text(item.name),
        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () {
            cartProvider.addItem(item);
          },
        ),
      ),
    );
  }
}
