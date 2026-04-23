class Product {
  final int productId;
  final String productName;
  final String brandName;
  final String categoryName;
  final int price;
  final int cost;
  final String made;
  final String description;
  final String warranty;
  final String rating;
  final String imageUrl;
  final String? tags;

  Product({
    required this.productId,
    required this.productName,
    required this.brandName,
    required this.categoryName,
    required this.price,
    required this.cost,
    required this.made,
    required this.description,
    required this.warranty,
    required this.rating,
    required this.imageUrl,
    this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'] as int,
      productName: json['product_name']?.toString() ?? '',
      brandName: json['brand_name']?.toString() ?? '',
      categoryName: json['category_name']?.toString() ?? '',
      price: json['price'] as int,
      cost: json['cost'] as int,
      made: json['made']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      warranty: json['warranty']?.toString() ?? '',
      rating: json['rating']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      tags: json['tags']?.toString(),
    );
  }
}