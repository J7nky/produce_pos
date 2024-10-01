class Product {
  int productId;
  String productName;
  String description;
  double price;
  int productTypeId;
  String productStatus;
  int currencyId;
  String image;
  String carouselImages;
  int color;
  String categoryName;

  // Constructor
  Product({
    required this.productId,
    required this.productName,
    required this.description,
    required this.price,
    required this.productTypeId,
    required this.productStatus,
    required this.currencyId,
    required this.image,
    required this.carouselImages,
    required this.color,
    required this.categoryName,
  });

  // Method to create a Product from a map (for example, decoding from JSON)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      description: json['description'] ?? '',
      price: json['price'].toDouble() ?? 0, // Ensure the price is a double
      productTypeId: json['productTypeId'] ?? 0,
      productStatus: json['product_status'] ?? '',
      currencyId: json['fk_currency_id'] ?? 0,
      image: json['image'] ?? '',
      carouselImages: (json['carousel_images'] ?? ''),
      color: json['color'] ?? 0,
      categoryName: json['category_name'] ?? '',
    );
  }

  // Method to convert Product instance to map (for example, encoding to JSON)
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'description': description,
      'price': price,
      'productTypeId': productTypeId,
      'product_status': productStatus,
      'fk_currency_id': currencyId,
      'image': image,
      'carousel_images': carouselImages,
      'color': color,
      'category_name': categoryName,
    };
  }
}
