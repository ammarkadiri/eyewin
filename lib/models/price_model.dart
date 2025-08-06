class PriceMustItem {
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
  final bool? collectPrice;
  final bool? checkRange;
  final double? minPrice;
  final double? maxPrice;
  final double? ptt;
  final List<int>? channelId;
  final List<String>? channelName;
  final Map<int, bool>? checkRangeByChannel;
  final Map<int, bool>? collectPriceByChannel;
  final Map<int, double>? minPricesByChannel;
  final Map<int, double>? maxPricesByChannel;
  final String? visitDate;
  final int? dataCollectorUserId;
  final int? hasIssue;
  final double? price;

  PriceMustItem({
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
    this.collectPrice,
    this.checkRange,
    this.minPrice,
    this.maxPrice,
    this.ptt,
    this.channelId,
    this.channelName,
    this.checkRangeByChannel,
    this.collectPriceByChannel,
    this.minPricesByChannel,
    this.maxPricesByChannel,
    this.visitDate,
    this.dataCollectorUserId,
    this.hasIssue,
    this.price,
  });

  PriceMustItem copyWith({
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
    bool? collectPrice,
    bool? checkRange,
    double? minPrice,
    double? maxPrice,
    double? ptt,
    List<int>? channelId,
    List<String>? channelName,
    Map<int, bool>? checkRangeByChannel,
    Map<int, bool>? collectPriceByChannel,
    Map<int, double>? minPricesByChannel,
    Map<int, double>? maxPricesByChannel,
    String? visitDate,
    int? dataCollectorUserId,
    int? hasIssue,
    double? price,
  }) {
    return PriceMustItem(
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
      collectPrice: collectPrice ?? this.collectPrice,
      checkRange: checkRange ?? this.checkRange,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      ptt: ptt ?? this.ptt,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      checkRangeByChannel: checkRangeByChannel ?? this.checkRangeByChannel,
      collectPriceByChannel:
          collectPriceByChannel ?? this.collectPriceByChannel,
      minPricesByChannel: minPricesByChannel ?? this.minPricesByChannel,
      maxPricesByChannel: maxPricesByChannel ?? this.maxPricesByChannel,
      visitDate: visitDate ?? this.visitDate,
      dataCollectorUserId: dataCollectorUserId ?? this.dataCollectorUserId,
      hasIssue: hasIssue ?? this.hasIssue,
      price: price ?? this.price,
    );
  }

  factory PriceMustItem.fromJson(Map<String, dynamic> json) => PriceMustItem(
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
    brandName: json['BrandName']?.trim(),
    isCompetition: json['IsCompetition'],
    collectPrice: json['CollectPrice'],
    checkRange: json['CheckRange'],
    minPrice:
        (json['MinPrice'] != null)
            ? (json['MinPrice'] as num).toDouble()
            : null,
    maxPrice:
        (json['MaxPrice'] != null)
            ? (json['MaxPrice'] as num).toDouble()
            : null,
    ptt: (json['PTT'] != null) ? (json['PTT'] as num).toDouble() : null,
    channelId:
        (json['channelId'] != null) ? List<int>.from(json['channelId']) : null,
    channelName:
        (json['channelName'] != null)
            ? List<String>.from(json['channelName'])
            : null,

    // ADD THESE MISSING FIELDS:
    visitDate: json['VisitDate'],
    dataCollectorUserId: json['DataCollectorUserId'],
    hasIssue: json['HasIssue'],
    price: (json['Price'] != null) ? (json['Price'] as num).toDouble() : null,
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
    'CollectPrice': collectPrice,
    'CheckRange': checkRange,
    'MinPrice': minPrice,
    'MaxPrice': maxPrice,
    'PTT': ptt,
    'channelId': channelId,
    'channelName': channelName,

    // ADD THESE MISSING FIELDS:
    'VisitDate': visitDate,
    'DataCollectorUserId': dataCollectorUserId,
    'HasIssue': hasIssue,
    'Price': price,
  };
}
