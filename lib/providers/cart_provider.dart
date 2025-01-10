import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, FoodItem> _items = {};

  Map<String, FoodItem> get items => _items;

  double get totalPrice {
    return _items.values.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  CartProvider() {
    _loadCartData(); // Load cart data on app start
  }

  void addItem(FoodItem item) {
    if (_items.containsKey(item.id)) {
      _items.update(
        item.id,
        (existingItem) => FoodItem(
          id: existingItem.id,
          name: existingItem.name,
          imageUrl: existingItem.imageUrl,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(item.id, () => item);
    }
    _saveCartData();
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    _saveCartData();
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    _saveCartData();
    notifyListeners();
  }

  void increaseQuantity(String id) {
    _items.update(
      id,
      (existingItem) => FoodItem(
        id: existingItem.id,
        name: existingItem.name,
        imageUrl: existingItem.imageUrl,
        price: existingItem.price,
        quantity: existingItem.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (_items.containsKey(id) && _items[id]!.quantity > 1) {
      _items.update(
        id,
        (existingItem) => FoodItem(
          id: existingItem.id,
          name: existingItem.name,
          imageUrl: existingItem.imageUrl,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> _saveCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartData = jsonEncode(
      _items.map((key, item) => MapEntry(
            key,
            {
              'id': item.id,
              'name': item.name,
              'imageUrl': item.imageUrl,
              'price': item.price,
              'quantity': item.quantity,
            },
          )),
    );
    await prefs.setString('cart', cartData);
  }

  Future<void> _loadCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartData = prefs.getString('cart');

    if (cartData != null) {
      Map<String, dynamic> decodedData = jsonDecode(cartData);
      _items = decodedData.map((key, item) {
        return MapEntry(
          key,
          FoodItem(
            id: item['id'],
            name: item['name'],
            imageUrl: item['imageUrl'],
            price: item['price'],
            quantity: item['quantity'],
          ),
        );
      });
      notifyListeners();
    }
  }
}

