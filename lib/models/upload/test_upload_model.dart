class MissionUploadModel {
  int customerId;
  int dataCollectorUserId;
  double? totalScore;
  double? totalScoreCompetition;
  String? visitDate;
  double? pointsEarned;
  double? visitMaxPoints;
  String? timeIn;
  String? timeOut;
  List<PriceItem> price;
  List<PlaceItem> place;
  List<PromoItem> promo;
  List<ProductItem> product;
  List<PhotoItem> photo;
  List<WatchoutItem> watchOut;
  List<GenericQuestionItem> genericQuestionsData;
  CustomerByDC? infoAddedByDC;

  MissionUploadModel({
    required this.customerId,
    required this.dataCollectorUserId,
    this.totalScore,
    this.totalScoreCompetition,
    this.visitDate,
    this.pointsEarned,
    this.visitMaxPoints,
    this.timeIn,
    this.timeOut,
    this.price = const [],
    this.place = const [],
    this.promo = const [],
    this.product = const [],
    this.photo = const [],
    this.watchOut = const [],
    this.genericQuestionsData = const [],
    this.infoAddedByDC,
  });
}

// Nested Classes
class PriceItem {
  int skuId;
  double? price;
  dynamic hasIssue;
  String? visitDate;
  int dataCollectorUserId;

  PriceItem({
    required this.skuId,
    this.price,
    this.hasIssue,
    this.visitDate,
    required this.dataCollectorUserId,
  });
}

class PlaceItem {
  int guidelineId;
  int abidedBy;
  String? visitDate;
  int dataCollectorUserId;

  PlaceItem({
    required this.guidelineId,
    required this.abidedBy,
    this.visitDate,
    required this.dataCollectorUserId,
  });
}

class PromoItem {
  int guidelineId;
  int abidedBy;
  String? visitDate;
  int dataCollectorUserId;

  PromoItem({
    required this.guidelineId,
    required this.abidedBy,
    this.visitDate,
    required this.dataCollectorUserId,
  });
}

class ProductItem {
  int skuId;
  int available;
  String? visitDate;
  int dataCollectorUserId;

  ProductItem({
    required this.skuId,
    required this.available,
    this.visitDate,
    required this.dataCollectorUserId,
  });
}

class PhotoItem {
  String? photo;
  int? categoryId;
  String? location;
  String? visitDate;
  int dataCollectorUserId;

  PhotoItem({
    this.photo,
    this.categoryId,
    this.location,
    this.visitDate,
    required this.dataCollectorUserId,
  });
}

class WatchoutItem {
  int eventId;
  int categoryId;
  int brandId;
  dynamic activityTypeId;
  int customerId;
  dynamic price;
  String description;
  List<PhotoItem> pictures;
  String? visitDate;
  int dataCollectorUserId;

  WatchoutItem({
    required this.eventId,
    required this.categoryId,
    required this.brandId,
    this.activityTypeId,
    required this.customerId,
    this.price,
    required this.description,
    this.pictures = const [],
    this.visitDate,
    required this.dataCollectorUserId,
  });
}

class GenericQuestionItem {
  int genericQuestionId;
  int customerId;
  int dataCollectorUserId;
  String? visitDate;
  List<CategoryBrand> categoryBrand;

  GenericQuestionItem({
    required this.genericQuestionId,
    required this.customerId,
    required this.dataCollectorUserId,
    this.visitDate,
    this.categoryBrand = const [],
  });
}

class CategoryBrand {
  int? brandId;
  int? categoryId;

  CategoryBrand({this.brandId, this.categoryId});
}

class CustomerByDC {
  String? customerName;
  double? customerLongitude;
  double? customerLatitude;
  String? customerPicture;

  CustomerByDC({
    this.customerName,
    this.customerLongitude,
    this.customerLatitude,
    this.customerPicture,
  });
}
