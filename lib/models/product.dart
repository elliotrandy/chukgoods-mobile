class Product {
  final String? id;
  final String name;
  final double price;
  final String description;
  final String category;
  final String? thumbnail;
  final bool isFeatured;
  final DateTime? dateAdded;
  final String? user;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.thumbnail,
    this.isFeatured = false,
    this.dateAdded,
    this.user,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle Django's default serialization format with nested "fields"
    final fields = json['fields'] ?? json;

    return Product(
      id: json['pk'] ?? json['id'],
      name: fields['name'] ?? '',
      price: (fields['price'] ?? 0).toDouble(),
      description: fields['description'] ?? '',
      category: fields['category'] ?? '',
      thumbnail: fields['thumbnail'],
      isFeatured: fields['is_featured'] ?? false,
      dateAdded: fields['date_added'] != null
          ? DateTime.parse(fields['date_added'])
          : null,
      user: fields['user']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'thumbnail': thumbnail,
      'is_featured': isFeatured,
      'date_added': dateAdded?.toIso8601String(),
      'user': user,
    };
  }
}