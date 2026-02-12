class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final int stock;
  final String category;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()),
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      price: json["price"]?.toString() ?? '0',
      stock: json["stock"] is int
          ? json["stock"]
          : int.tryParse(json["stock"]?.toString() ?? '0') ?? 0,
      category: json["category"] ?? '',
      imageUrl: json["image_url"],
    );
  }
}
