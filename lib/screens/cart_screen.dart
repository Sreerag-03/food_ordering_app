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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cartProvider.decreaseQuantity(item.id);
                        },
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          cartProvider.increaseQuantity(item.id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          cartProvider.removeItem(item.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Text('Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:18.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/summary');
              },
              child: Text('Proceed to Checkout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
            ),
          ),
        ],
      ),
    );
  }
}

