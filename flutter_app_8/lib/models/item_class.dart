class ItemClass {
  final int id;
  final String imageUrl;
  final double price;
  final String brand;
  final String title;
  final String description;

  ItemClass(
    this.id,
    this.imageUrl,
    this.price,
    this.brand,
    this.title,
    this.description,
  );

  factory ItemClass.fromJson(Map<String, dynamic> json) {
    return ItemClass(
      json['id'],
      json['imageUrl'],
      json['price'].toDouble(),
      json['brand'],
      json['title'],
      json['description'],
    );
  }
}
