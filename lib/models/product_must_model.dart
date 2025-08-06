class ProductMustItem {
  final int? id;
  final int? skuId;
  final String? skuName;
  final String? skuNameAr;
  final String? skuNameFr;
  final int? skuOrder;
  final String? skuImage;
  final int? categoryId;
  final String? categoryName;
  final int? brandId;
  final String? brandName;
  final bool? isCompetition;
  final List<int>? channelId;
  final List<String>? channelName;
  int? available;
  final String? visitDate;
  final int? dataCollectorUserId;

  ProductMustItem({
    this.id,
    this.skuId,
    this.skuName,
    this.skuNameAr,
    this.skuNameFr,
    this.skuOrder,
    this.skuImage,
    this.categoryId,
    this.categoryName,
    this.brandId,
    this.brandName,
    this.isCompetition,
    this.channelId,
    this.channelName,
    this.available,
    this.visitDate,
    this.dataCollectorUserId,
  });

  ProductMustItem copyWith({
    int? id,
    int? skuId,
    String? skuName,
    String? skuNameAr,
    String? skuNameFr,
    int? skuOrder,
    String? skuImage,
    int? categoryId,
    String? categoryName,
    int? brandId,
    String? brandName,
    bool? isCompetition,
    List<int>? channelId,
    List<String>? channelName,
    int? available,
    String? visitDate,
    int? dataCollectorUserId,
  }) {
    return ProductMustItem(
      id: id ?? this.id,
      skuId: skuId ?? this.skuId,
      skuName: skuName ?? this.skuName,
      skuNameAr: skuNameAr ?? this.skuNameAr,
      skuNameFr: skuNameFr ?? this.skuNameFr,
      skuOrder: skuOrder ?? this.skuOrder,
      skuImage: skuImage ?? this.skuImage,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      isCompetition: isCompetition ?? this.isCompetition,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      available: available ?? this.available,
      visitDate: visitDate ?? this.visitDate,
      dataCollectorUserId: dataCollectorUserId ?? this.dataCollectorUserId,
    );
  }

  factory ProductMustItem.fromJson(Map<String, dynamic> json) =>
      ProductMustItem(
        id: json['Id'],
        skuId: json['SKUId'],
        skuName: json['SKUName'],
        skuNameAr: json['SKUNameAr'],
        skuNameFr: json['SKUNameFr'],
        skuOrder: json['SKUOrder'],
        skuImage: json['SKUImage'],
        categoryId: json['CategoryId'],
        categoryName: json['CategoryName'],
        brandId: json['BrandId'],
        brandName: json['BrandName'],
        isCompetition: json['IsCompetition'],
        channelId:
            (json['channelId'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList(),
        channelName:
            (json['channelName'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        available: json['available'],
        visitDate: json['visitDate'],
        dataCollectorUserId: json['dataCollectorUserId'],
      );

  Map<String, dynamic> toJson() => {
    'Id': id,
    'SKUId': skuId,
    'SKUName': skuName,
    'SKUNameAr': skuNameAr,
    'SKUNameFr': skuNameFr,
    'SKUOrder': skuOrder,
    'SKUImage': skuImage,
    'CategoryId': categoryId,
    'CategoryName': categoryName,
    'BrandId': brandId,
    'BrandName': brandName,
    'IsCompetition': isCompetition,
    'channelId': channelId,
    'channelName': channelName,
    'available': available,
    'visitDate': visitDate,
    'dataCollectorUserId': dataCollectorUserId,
  };

  @override
  String toString() {
    return 'ProductMustItem(id: $id, name: $skuName, available: $available)';
  }
}
