class FoodItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price; 
  final double quantity;

  FoodItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
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
