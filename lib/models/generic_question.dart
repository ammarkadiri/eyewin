class GenericQuestion {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? nameFr;
  final List<CategoryBrand>? categoryBrands;

  GenericQuestion({
    this.id,
    this.name,
    this.nameAr,
    this.nameFr,
    this.categoryBrands,
  });

  factory GenericQuestion.fromJson(Map<String, dynamic> json) {
    return GenericQuestion(
      id: json['Id'],
      name: json['Name'],
      nameAr: json['NameAr'],
      nameFr: json['NameFr'],
      categoryBrands: (json['CategoryBrands'] as List<dynamic>?)
          ?.map((e) => CategoryBrand.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'NameAr': nameAr,
        'NameFr': nameFr,
        'CategoryBrands': categoryBrands?.map((e) => e.toJson()).toList(),
      };
}

class CategoryBrand {
  final int? brandId;
  final int? categoryId;

  CategoryBrand({this.brandId, this.categoryId});

  factory CategoryBrand.fromJson(Map<String, dynamic> json) {
    return CategoryBrand(
      brandId: json['BrandId'],
      categoryId: json['CategoryId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'BrandId': brandId,
        'CategoryId': categoryId,
      };
}
