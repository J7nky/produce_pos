class Product {
  final int productId;
  final String productName;
  final String description;
  final double price;
  final int productTypeId;
  final bool productAvailable;
  final String currencyId;
  final String carouselImages;
  final int color;
  final int productCategoryId;
  final int popularityScore;

  // Constructor
  Product(
      {required this.productId,
      required this.productName,
      required this.description,
      required this.price,
      required this.productTypeId,
      required this.productAvailable,
      required this.currencyId,
      required this.carouselImages,
      required this.color,
      required this.productCategoryId,
      required this.popularityScore});

  // Method to create a Product from a map (for example, decoding from JSON)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json['product_id'] ?? 0,
        productName: json['product_name'] ?? '',
        description: json['description'] ?? '',
 price: json['price'] != null ? json['price'].toDouble() : 0.0,

        productTypeId: json['product_type_id'] ?? 0,
        productAvailable: json['product_available'] ?? false,
        currencyId: json['fk_currency_id'].toString() ?? "",
        carouselImages: (json['carousel_images'] ?? ''),
        color: json['color'] ?? 0,
        productCategoryId: json['product_category_id'] ?? 0,
        popularityScore: json['popularity_score'] ?? 0);
  }

  // Method to convert Product instance to map (for example, encoding to JSON)
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'description': description,
      'price': price,
      'productTypeId': productTypeId,
      'product_available': productAvailable,
      'fk_currency_id': currencyId,
      'carousel_images': carouselImages,
      'color': color,
      'product_category_id': productCategoryId,
      'popularity_score': popularityScore
    };
  }

  @override
  String toString() {
    return 'Product(productId: $productId, productName: $productName, description: $description, price: $price, productTypeId: $productTypeId, productAvailable: $productAvailable, currencyId: $currencyId, carouselImages: $carouselImages, color: $color, productCategoryId: $productCategoryId, popularityScore: $popularityScore)';
  }
}
