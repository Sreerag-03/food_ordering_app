import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                var item = cartProvider.items.values.toList()[index];
                return ListTile(
                  leading: Image.network(item.imageUrl),
                  title: Text(item.name),
                  subtitle: Text('\$${item.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      cartProvider.removeItem(item.id);
                    },
                  ),
                );
              },
            ),
          ),
          Text('Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/summary');
            },
            child: Text('Proceed to Checkout'),
          ),
        ],
      ),
    );
  }
}
