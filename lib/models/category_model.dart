class CategoryList {
  final int? categoryId;
  final String? categoryName;

  CategoryList({
    this.categoryId,
    this.categoryName,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
      categoryId: json['CategoryId'],
      categoryName: json['CategoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CategoryId': categoryId,
      'CategoryName': categoryName,
    };
  }
}
