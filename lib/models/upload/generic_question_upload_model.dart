class GenericQuestionUpload {
  final int genericQuestionId;
  final int dataCollectorUserId;
  final int customerId;
  final String visitDate;
  final List<CategoryBrand> categoryBrand;

  GenericQuestionUpload({
    required this.genericQuestionId,
    required this.dataCollectorUserId,
    required this.customerId,
    required this.visitDate,
    required this.categoryBrand,
  });

  factory GenericQuestionUpload.fromJson(Map<String, dynamic> json) {
    return GenericQuestionUpload(
      genericQuestionId: json['GenericQuestionId'] ?? 0,
      dataCollectorUserId: json['DataCollectorUserId'] ?? 0,
      customerId: json['CustomerId'] ?? 0,
      visitDate: json['VisitDate'] ?? '',
      categoryBrand:
          (json['CategoryBrand'] as List<dynamic>?)
              ?.map((e) => CategoryBrand.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GenericQuestionId': genericQuestionId,
      'DataCollectorUserId': dataCollectorUserId,
      'CustomerId': customerId,
      'VisitDate': visitDate,
      'CategoryBrand': categoryBrand.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryBrand {
  final String brandId;
  final String categoryId;

  CategoryBrand({required this.brandId, required this.categoryId});

  factory CategoryBrand.fromJson(Map<String, dynamic> json) {
    return CategoryBrand(
      brandId: json['BrandId'] ?? '',
      categoryId: json['CategoryId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'BrandId': brandId,
    'CategoryId': categoryId,
  };
}
