class Category {
  final int categoryId;
  final String categoryName;
  final String categoryImage;
  final bool comingSoon;
  Category(
      {required this.comingSoon,
      required this.categoryId,
      required this.categoryName,
      required this.categoryImage});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        comingSoon: json['coming_soon'],
        categoryId: json['category_id'],
        categoryName: json['category_name'],
        categoryImage: json['category_icon']);
  }
  Map<String, dynamic> toJson() {
    return {
      'coming_soon': comingSoon,
      "category_id": categoryId,
      "category_icon": categoryImage,
      "category_name": categoryName
    };
  }
}
