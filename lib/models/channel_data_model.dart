import 'package:flutter_salesman_module/models/category_model.dart';
import 'package:flutter_salesman_module/models/customer_model.dart';
import 'package:flutter_salesman_module/models/document_model.dart';
import 'package:flutter_salesman_module/models/generic_question.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';

class ChannelsData {
  int? id;
  String? name;
  bool? showSuggestedPriceLabel;
  bool? isPointsRewardSystem;
  bool? imagesMandatory;
  bool? hideCustomers;
  int? productKPIFrequency;
  int? priceKPIFrequency;
  int? placeKPIFrequency;
  int? promoKPIFrequency;

  List<Customer>? customers;
  List<ProductMustItem>? productMustItems;
  List<PriceMustItem>? priceMustItems;
  List<PlaceMustItem>? placeMustItems;
  List<PromoMustItem>? promoMustItems;

  List<dynamic>? rewards;
  List<dynamic>? claimedRewards;
  List<dynamic>? scorePoints;
  List<dynamic>? salesPoints;

  List<CategoryList>? categories;
  List<Document>? documents;
  dynamic programs;
  dynamic watchOut;
  List<GenericQuestion>? genericQuestions;

  ChannelsData({
    this.id,
    this.name,
    this.showSuggestedPriceLabel,
    this.isPointsRewardSystem,
    this.imagesMandatory,
    this.hideCustomers,
    this.productKPIFrequency,
    this.priceKPIFrequency,
    this.placeKPIFrequency,
    this.promoKPIFrequency,
    this.customers,
    this.productMustItems,
    this.priceMustItems,
    this.placeMustItems,
    this.promoMustItems,
    this.rewards,
    this.claimedRewards,
    this.scorePoints,
    this.salesPoints,
    this.categories,
    this.documents,
    this.programs,
    this.watchOut,
    this.genericQuestions,
  });

  factory ChannelsData.fromJson(Map<String, dynamic> json) {
    return ChannelsData(
      id: json['Id'],
      name: json['Name'],
      showSuggestedPriceLabel: json['ShowSuggestedPriceLabel'],
      isPointsRewardSystem: json['isPointsRewardSystem'],
      imagesMandatory: json['ImagesMandatory'],
      hideCustomers: json['HideCustomers'],
      productKPIFrequency: json['ProductKPIFrequency'],
      priceKPIFrequency: json['PriceKPIFrequency'],
      placeKPIFrequency: json['PlaceKPIFrequency'],
      promoKPIFrequency: json['PromoKPIFrequency'],
      customers:
          (json['Customers'] as List?)
              ?.map((v) => Customer.fromJson(v))
              .toList(),
      productMustItems:
          (json['ProductMustItems'] as List?)
              ?.map((v) => ProductMustItem.fromJson(v))
              .toList(),
      priceMustItems:
          (json['PriceMustItems'] as List?)
              ?.map((v) => PriceMustItem.fromJson(v))
              .toList(),
      placeMustItems:
          (json['PlaceMustItems'] as List?)
              ?.map((v) => PlaceMustItem.fromJson(v))
              .toList(),
      promoMustItems:
          (json['PromoMustItems'] as List?)
              ?.map((v) => PromoMustItem.fromJson(v))
              .toList(),
      rewards: json['Rewards'] as List?,
      claimedRewards: json['ClaimedRewards'] as List?,
      scorePoints: json['ScorePoints'] as List?,
      salesPoints: json['SalesPoints'] as List?,
      categories:
          (json['Categories'] as List?)
              ?.map((v) => CategoryList.fromJson(v))
              .toList(),
      documents:
          (json['Documents'] as List?)
              ?.map((v) => Document.fromJson(v))
              .toList(),
      programs: json['Programs'],
      watchOut: json['WatchOut'],
      genericQuestions:
          (json['GenericQuestions'] as List?)
              ?.map((v) => GenericQuestion.fromJson(v))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'ShowSuggestedPriceLabel': showSuggestedPriceLabel,
      'isPointsRewardSystem': isPointsRewardSystem,
      'ImagesMandatory': imagesMandatory,
      'HideCustomers': hideCustomers,
      'ProductKPIFrequency': productKPIFrequency,
      'PriceKPIFrequency': priceKPIFrequency,
      'PlaceKPIFrequency': placeKPIFrequency,
      'PromoKPIFrequency': promoKPIFrequency,
      if (customers != null)
        'Customers': customers!.map((v) => v.toJson()).toList(),
      if (productMustItems != null)
        'ProductMustItems': productMustItems!.map((v) => v.toJson()).toList(),
      if (priceMustItems != null)
        'PriceMustItems': priceMustItems!.map((v) => v.toJson()).toList(),
      if (placeMustItems != null)
        'PlaceMustItems': placeMustItems!.map((v) => v.toJson()).toList(),
      if (promoMustItems != null)
        'PromoMustItems': promoMustItems!.map((v) => v.toJson()).toList(),
      if (rewards != null) 'Rewards': rewards,
      if (claimedRewards != null) 'ClaimedRewards': claimedRewards,
      if (scorePoints != null) 'ScorePoints': scorePoints,
      if (salesPoints != null) 'SalesPoints': salesPoints,
      if (categories != null)
        'Categories': categories!.map((v) => v.toJson()).toList(),
      if (documents != null)
        'Documents': documents!.map((v) => v.toJson()).toList(),
      'Programs': programs,
      'WatchOut': watchOut,
      if (genericQuestions != null)
        'GenericQuestions': genericQuestions!.map((v) => v.toJson()).toList(),
    };
  }
}
