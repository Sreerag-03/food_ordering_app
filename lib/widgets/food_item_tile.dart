import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../providers/cart_provider.dart';

class FoodItemTile extends StatefulWidget {
  final FoodItem item;

  const FoodItemTile({required this.item});

  @override
  _FoodItemTileState createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateAddToCart() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Hero(
            tag: widget.item.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(widget.item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            ),
          ),
          title: Text(widget.item.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('\$${widget.item.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart, color: Colors.green),
            onPressed: () {
              cartProvider.addItem(widget.item);
              _animateAddToCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.item.name} added to cart!')),
              );
            },
          ),
        ),
      ),
    );
  }
}
