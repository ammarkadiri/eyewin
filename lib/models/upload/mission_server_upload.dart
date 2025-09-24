import 'package:flutter_salesman_module/models/upload/generic_question_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/watchOut_upload_model.dart';
import 'package:image_picker/image_picker.dart';

class MissionUploadServerModel {
  final int customerId;
  final int dataCollectorUserId;
  final double? totalScore;
  final double? totalScoreCompetition;
  final String visitDate;
  final double? pointsEarned;
  final double? visitMaxPoints;
  final String? timeIn;
  final String? timeOut;

  final List<PriceUpload> price;
  final String priceScore;
  final String priceScoreCompetition;

  List<PlaceUpload> place;
  final String placeScore;
  final String placeScoreCompetition;

  final List<PromoUpload> promo;
  final String promoScore;
  final String promoScoreCompetition;

  List<ProductUpload> product;
  final String productScore;
  final String? productScoreCompetition;

  final List<PhotoUpload> photo;
  final List<WatchoutUpload> watchOut;
  final List<GenericQuestionUpload> genericQuestionsData;

  final String? customerNameByDC;
  final String? customerLongByDC;
  final String? customerLatByDC;
  final String? customerPictureByDC;

  MissionUploadServerModel({
    required this.customerId,
    required this.dataCollectorUserId,
    this.totalScore,
    this.totalScoreCompetition,
    required this.visitDate,
    this.pointsEarned,
    this.visitMaxPoints,
    this.timeIn,
    this.timeOut,
    required this.price,
    required this.priceScore,
    required this.priceScoreCompetition,
    required this.place,
    required this.placeScore,
    required this.placeScoreCompetition,
    required this.promo,
    required this.promoScore,
    required this.promoScoreCompetition,
    required this.product,
    required this.productScore,
    this.productScoreCompetition,
    required this.photo,
    required this.watchOut,
    required this.genericQuestionsData,
    this.customerNameByDC,
    this.customerLongByDC,
    this.customerLatByDC,
    this.customerPictureByDC,
  });

  factory MissionUploadServerModel.fromJson(Map<String, dynamic> json) {
    return MissionUploadServerModel(
      customerId: json['CustomerId'] ?? 0,
      dataCollectorUserId: json['DataCollectorUserId'] ?? 0,
      totalScore: (json['TotalScore'] as num?)?.toDouble(),
      totalScoreCompetition:
          (json['TotalScoreCompetition'] as num?)?.toDouble(),
      visitDate: json['VisitDate'] ?? '',
      pointsEarned: (json['PointsEarned'] as num?)?.toDouble(),
      visitMaxPoints: (json['VisitMaxPoints'] as num?)?.toDouble(),
      timeIn: json['TimeIn'],
      timeOut: json['TimeOut'],
      price:
          (json['Price'] as List<dynamic>?)
              ?.map((e) => PriceUpload.fromJson(e))
              .toList() ??
          [],
      priceScore: json['PriceScore'] ?? '',
      priceScoreCompetition: json['PriceScoreCompetition'] ?? '',
      place:
          (json['Place'] as List<dynamic>?)
              ?.map((e) => PlaceUpload.fromJson(e))
              .toList() ??
          [],
      placeScore: json['PlaceScore'] ?? '',
      placeScoreCompetition: json['PlaceScoreCompetition'] ?? '',
      promo:
          (json['Promo'] as List<dynamic>?)
              ?.map((e) => PromoUpload.fromJson(e))
              .toList() ??
          [],
      promoScore: json['PromoScore'] ?? '',
      promoScoreCompetition: json['PromoScoreCompetition'] ?? '',
      product:
          (json['Product'] as List<dynamic>?)
              ?.map((e) => ProductUpload.fromJson(e))
              .toList() ??
          [],
      productScore: json['ProductScore'] ?? '',
      productScoreCompetition: json['productScoreCompetition'],
      photo:
          (json['Photo'] as List<dynamic>?)
              ?.map((e) => PhotoUpload.fromJson(e))
              .toList() ??
          [],
      watchOut:
          (json['WatchOut'] as List<dynamic>?)
              ?.map((e) => WatchoutUpload.fromJson(e))
              .toList() ??
          [],
      genericQuestionsData:
          (json['GenericQuestionsData'] as List<dynamic>?)
              ?.map((e) => GenericQuestionUpload.fromJson(e))
              .toList() ??
          [],
      customerNameByDC: json['CustomerNamebyDC'],
      customerLongByDC: (json['CustomerLongbyDC'] as num?)?.toString(),
      customerLatByDC: (json['CustomerLatbyDC'] as num?)?.toString(),
      customerPictureByDC: json['CustomerPicturebyDC'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustomerId': customerId,
      'DataCollectorUserId': dataCollectorUserId,
      'TotalScore': totalScore,
      'TotalScoreCompetition': totalScoreCompetition,
      'VisitDate': visitDate,
      'PointsEarned': pointsEarned,
      'VisitMaxPoints': visitMaxPoints,
      'TimeIn': timeIn,
      'TimeOut': timeOut,
      'Price': price.map((e) => e.toJson()).toList(),
      'PriceScore': priceScore,
      'PriceScoreCompetition': priceScoreCompetition,
      'Place': place.map((e) => e.toJson()).toList(),
      'PlaceScore': placeScore,
      'PlaceScoreCompetition': placeScoreCompetition,
      'Promo': promo.map((e) => e.toJson()).toList(),
      'PromoScore': promoScore,
      'PromoScoreCompetition': promoScoreCompetition,
      'Product': product.map((e) => e.toJson()).toList(),
      'ProductScore': productScore,
      'productScoreCompetition': productScoreCompetition,
      'Photo': photo.map((e) => e.toJson()).toList(),
      'WatchOut': watchOut.map((e) => e.toJson()).toList(),
      'GenericQuestionsData':
          genericQuestionsData.map((e) => e.toJson()).toList(),
      'CustomerNamebyDC': customerNameByDC,
      'CustomerLongbyDC': customerLongByDC,
      'CustomerLatbyDC': customerLatByDC,
      'CustomerPicturebyDC': customerPictureByDC,
    };
  }

  @override
  String toString() {
    return '''
MissionUploadDetails(
  customerId: $customerId,
  dataCollectorUserId: $dataCollectorUserId,
  visitDate: $visitDate,
  price: $price,
  priceScore: $priceScore,
  priceScoreCompetition: $priceScoreCompetition,
  place: $place,
  placeScore: $placeScore,
  placeScoreCompetition: $placeScoreCompetition,
  promo: $promo,
  promoScore: $promoScore,
  promoScoreCompetition: $promoScoreCompetition,
  product: $product,
  productScore: $productScore,
  productScoreCompetition: $productScoreCompetition,
  photo: $photo,
  watchOut: $watchOut,
  genericQuestionsData: $genericQuestionsData,
  timeIn: $timeIn,
  timeOut: $timeOut,
  totalScore: $totalScore,
  totalScoreCompetition: $totalScoreCompetition,
  pointsEarned: $pointsEarned,
  visitMaxPoints: $visitMaxPoints,
  customerNameByDC: $customerNameByDC,
  customerLongByDC: $customerLongByDC,
  customerLatByDC: $customerLatByDC,
  customerPictureByDC: $customerPictureByDC
)
''';
  }
}

class ProductUpload {
  int? skuId;
  int? available;
  int? dataCollectorUserId;
  String? visitDate;

  ProductUpload({
    this.skuId,
    this.available,
    this.dataCollectorUserId,
    this.visitDate,
  });

  factory ProductUpload.fromJson(Map<String, dynamic> json) => ProductUpload(
    skuId: json['SKUID'],
    available: json['Available'],
    dataCollectorUserId: json['DataCollectorUserId'],
    visitDate: json['visitDate'],
  );

  Map<String, dynamic> toJson() => {
    'SKUID': skuId,
    'Available': available,
    'DataCollectorUserId': dataCollectorUserId,
    'visitDate': visitDate,
  };
}

class PriceUpload {
  int? dataCollectorUserId;
  int? skuId;
  int? hasIssue;
  String? visitDate;
  String? Price;

  PriceUpload({
    this.dataCollectorUserId,
    this.skuId,
    this.hasIssue,
    this.visitDate,
    this.Price,
  });

  factory PriceUpload.fromJson(Map<String, dynamic> json) => PriceUpload(
    dataCollectorUserId: json['DataCollectorUserId'],
    skuId: json['SKUID'],
    hasIssue: json['HasIssue'],
    visitDate: json['visitDate'],
    Price: json['Price'],
  );

  Map<String, dynamic> toJson() => {
    'DataCollectorUserId': dataCollectorUserId,
    'SKUID': skuId,
    'HasIssue': hasIssue,
    'visitDate': visitDate,
    'Price': Price,
  };
}

class PlaceUpload {
  int? abidedBy;
  int? guidelineId;
  int? dataCollectorUserId;
  String? visitDate;

  PlaceUpload({
    this.abidedBy,
    this.guidelineId,
    this.dataCollectorUserId,
    this.visitDate,
  });

  factory PlaceUpload.fromJson(Map<String, dynamic> json) => PlaceUpload(
    abidedBy: json['AbidedBy'],
    guidelineId: json['GuidelineId'],
    dataCollectorUserId: json['DataCollectorUserId'],
    visitDate: json['visitDate'],
  );

  Map<String, dynamic> toJson() => {
    'AbidedBy': abidedBy,
    'GuidelineId': guidelineId,
    'DataCollectorUserId': dataCollectorUserId,
    'visitDate': visitDate,
  };
}

class PromoUpload {
  int? abidedBy;
  int? guidelineId;
  int? dataCollectorUserId;
  String? visitDate;
  PromoUpload({
    this.abidedBy,
    this.guidelineId,
    this.dataCollectorUserId,
    this.visitDate,
  });

  factory PromoUpload.fromJson(Map<String, dynamic> json) => PromoUpload(
    abidedBy: json['AbidedBy'],
    guidelineId: json['GuidelineId'],
    dataCollectorUserId: json['DataCollectorUserId'],
    visitDate: json['visitDate'],
  );

  Map<String, dynamic> toJson() => {
    'AbidedBy': abidedBy,
    'GuidelineId': guidelineId,
    'DataCollectorUserId': dataCollectorUserId,
    'visitDate': visitDate,
  };
}

class PhotoUpload {
  XFile? photo;
  String? photoBase64; // Added for base64 storage
  String? visitDate;
  String? categoryId;
  String? location;
  String? dataCollectorUserId;
  String? CustomerID;
  String? ItemID;

  PhotoUpload({
    this.photo,
    this.photoBase64,
    this.visitDate,
    this.categoryId,
    this.location,
    this.dataCollectorUserId,
    this.CustomerID,
    this.ItemID,
  });

  factory PhotoUpload.fromJson(Map<String, dynamic> json) {
    return PhotoUpload(
      photo: json['Photo'],
      photoBase64: json['PhotoBase64'],
      visitDate: json['VisitDate'],
      categoryId: json['CategoryId'],
      location: json['Location'],
      dataCollectorUserId: json['DataCollectorUserId'],
      CustomerID: json['CustomerID'],
      ItemID: json['ItemID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Photo': photoBase64, // Send base64 as the main Photo field
      'PhotoBase64': photoBase64,
      'VisitDate': visitDate,
      'CategoryId': categoryId,
      'Location': location,
      'DataCollectorUserId': dataCollectorUserId,
      'CustomerID': CustomerID,
      'ItemID': ItemID,
    };
  }
}
