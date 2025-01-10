import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class OrderSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Order Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.items.length,
                itemBuilder: (context, index) {
                  var item = cartProvider.items.values.toList()[index];
                  return ListTile(
                    leading: Image.network(item.imageUrl, width: 50, height: 50),
                    title: Text(item.name),
                    subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Divider(thickness: 2),
            Text(
              'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder for order confirmation logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order Confirmed! 🎉')),
                );
                cartProvider.clearCart(); // Clear cart after confirmation
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Confirm Order',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
                backgroundColor: Colors.green
              ),
            ),
          ],  
        ),
      ),
    );
  }
}
