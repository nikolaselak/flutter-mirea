class Product {
  final int id;
  final String imageUrl;
  final int price;
  final String brand;
  final String title;
  final String description;

  Product({
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.brand,
    required this.title,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      brand: json['brand'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'price': price,
      'brand': brand,
      'title': title,
      'description': description,
    };
  }
}
