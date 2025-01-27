class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double rating;
  final int ratingCount;
  late int quantity;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.ratingCount,
    this.quantity = 1, // Default quantity is 1
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      rating: json['rating']['rate'].toDouble(),
      ratingCount: json['rating']['count'],
      quantity: json['quantity'] ?? 1, // Provide a default value of 1
    );
  }

  // Method to convert Product to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'image': image,
    'rating': {'rate': rating, 'count': ratingCount},
    'quantity': quantity,
  };

  // Copy method to create a new instance with modified values
  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? image,
    double? rating,
    int? ratingCount,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      quantity: quantity ?? this.quantity,
    );
  }
}
