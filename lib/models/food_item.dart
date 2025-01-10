class FoodItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price; 
  int quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      quantity: json['quantity'].toDouble(),
    );
  }
}
