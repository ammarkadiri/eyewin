import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/models/upload/generic_question_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/photo_upload_model.dart'; 
import 'package:flutter_salesman_module/models/upload/watchOut_upload_model.dart';

class MissionUploadDetails {
  final int customerId;
  final int dataCollectorUserId;
  final double? totalScore;
  final double? totalScoreCompetition;
  final String visitDate;
  final double? pointsEarned;
  final double? visitMaxPoints;
  final String? timeIn;
  final String? timeOut;

  final List<PriceMustItem> price;
  final String priceScore;
  final String priceScoreCompetition;

  List<PlaceMustItem> place;
  final String placeScore;
  final String placeScoreCompetition;

  final List<PromoMustItem> promo;
  final String promoScore;
  final String promoScoreCompetition;

  List<ProductMustItem> product;
  final String productScore;
  final String? productScoreCompetition;

  final List<PhotoUpload> photo;
  final List<WatchoutUpload> watchOut;
  final List<GenericQuestionUpload> genericQuestionsData;

  final String? customerNameByDC;
  final double? customerLongByDC;
  final double? customerLatByDC;
  final String? customerPictureByDC;

  MissionUploadDetails({
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

  factory MissionUploadDetails.fromJson(Map<String, dynamic> json) {
    return MissionUploadDetails(
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
              ?.map((e) => PriceMustItem.fromJson(e))
              .toList() ??
          [],
      priceScore: json['PriceScore'] ?? '',
      priceScoreCompetition: json['PriceScoreCompetition'] ?? '',
      place:
          (json['Place'] as List<dynamic>?)
              ?.map((e) => PlaceMustItem.fromJson(e))
              .toList() ??
          [],
      placeScore: json['PlaceScore'] ?? '',
      placeScoreCompetition: json['PlaceScoreCompetition'] ?? '',
      promo:
          (json['Promo'] as List<dynamic>?)
              ?.map((e) => PromoMustItem.fromJson(e))
              .toList() ??
          [],
      promoScore: json['PromoScore'] ?? '',
      promoScoreCompetition: json['PromoScoreCompetition'] ?? '',
      product:
          (json['Product'] as List<dynamic>?)
              ?.map((e) => ProductMustItem.fromJson(e))
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
      customerLongByDC: (json['CustomerLongbyDC'] as num?)?.toDouble(),
      customerLatByDC: (json['CustomerLatbyDC'] as num?)?.toDouble(),
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

extension MissionUploadDetailsCopy on MissionUploadDetails {
  MissionUploadDetails copyWith({
    List<ProductMustItem>? product,
    String? productScore,
    String? productScoreCompetition,
    List<PriceMustItem>? price,
    String? priceScore,
    String? priceScoreCompetition,
    List<PlaceMustItem>? place,
    String? placeScore,
    String? placeScoreCompetition,
    List<PromoMustItem>? promo,
    String? promoScore,
    String? promoScoreCompetition,
    List<PhotoUpload>? photo,
    List<WatchoutUpload>? watchOut,
    List<GenericQuestionUpload>? genericQuestionsData,
    String? timeIn,
    String? timeOut,
    double? totalScore,
    double? totalScoreCompetition,
    double? pointsEarned,
  }) {
    return MissionUploadDetails(
      customerId: customerId,
      dataCollectorUserId: dataCollectorUserId,
      totalScore: totalScore,
      totalScoreCompetition: totalScoreCompetition,
      visitDate: visitDate,
      pointsEarned: pointsEarned,
      visitMaxPoints: visitMaxPoints,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      price: price ?? this.price,
      priceScore: priceScore ?? this.priceScore,
      priceScoreCompetition:
          priceScoreCompetition ?? this.priceScoreCompetition,
      place: place ?? this.place,
      placeScore: placeScore ?? this.placeScore,
      placeScoreCompetition:
          placeScoreCompetition ?? this.placeScoreCompetition,
      promo: promo ?? this.promo,
      promoScore: promoScore ?? this.promoScore,
      promoScoreCompetition:
          promoScoreCompetition ?? this.promoScoreCompetition,
      product: product ?? this.product,
      productScore: productScore ?? this.productScore,
      productScoreCompetition:
          productScoreCompetition ?? this.productScoreCompetition,
      photo: photo ?? this.photo,
      watchOut: watchOut ?? this.watchOut,
      genericQuestionsData: genericQuestionsData ?? this.genericQuestionsData,
      customerNameByDC: customerNameByDC,
      customerLatByDC: customerLatByDC,
      customerLongByDC: customerLongByDC,
      customerPictureByDC: customerPictureByDC,
    );
  }
}
