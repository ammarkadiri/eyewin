import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/models/upload/mission_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/photo_upload_model.dart';
import 'package:flutter_salesman_module/utils/enum/price_select_type.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

final box = GetStorage();

class MissionUpload2Provider extends ChangeNotifier {
  final Map<String, MissionUploadDetails> _missions = {};
  final Set<String> _notAvailableItems = {};

  String _key(int customerId, int userId) => '$customerId-$userId';
  String _notAvailableKey(
    int customerId,
    int userId,
    int categoryId,
    String group,
  ) => '$customerId-$userId-$categoryId-$group';

  MissionUploadDetails? getMission(int customerId, int userId) {
    return _missions[_key(customerId, userId)];
  }

  Future<void> saveMissionsToStorage() async {
    try {
      final List<Map<String, dynamic>> jsonList =
          _missions.values.map((mission) => mission.toJson()).toList();

      await box.write('missions', jsonList);

      debugPrint('💾 Saved ${jsonList.length} missions to storage');
    } catch (e) {
      debugPrint('❌ Error saving missions: $e');
    }
  }

  Future<void> loadMissionsFromStorage() async {
    try {
      final jsonList = box.read<List<dynamic>>('missions') ?? [];
      final missions =
          jsonList
              .map(
                (e) => MissionUploadDetails.fromJson(e as Map<String, dynamic>),
              )
              .toList();

      _missions.clear();
      for (var mission in missions) {
        final key = _key(mission.customerId, mission.dataCollectorUserId);
        _missions[key] = mission;
      }

      debugPrint('📦 Total missions loaded: ${_missions.length}');
      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error loading missions: $e');
    }
  }

  Future<void> clearAllMissions() async {
    try {
      _missions.clear();
      _notAvailableItems.clear();

      await box.remove('missions');

      debugPrint("✅ All missions cleared from memory and local storage.");

      // Notify listeners
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error clearing all missions: $e");
    }
  }

  Future<void> clearMission({
    required int customerId,
    required int userId,
  }) async {
    final key = _key(customerId, userId);

    if (_missions.containsKey(key)) {
      _missions.remove(key);

      await saveMissionsToStorage();

      notifyListeners();
    } else {
      debugPrint(
        '⚠️ No mission found to clear for customerId: $customerId, userId: $userId',
      );
    }
  }

  Future<void> initializeMission({
    required int customerId,
    required int userId,
    String? customerNameByDC,
    String? visitDate,
    String? customerLongByDC,
    List<PlaceMustItem>? placeItem,
    List<PromoMustItem>? promoItem,
    List<ProductMustItem>? productList,

    List<PriceMustItem>? priceList,
    String? customerLatByDC,
    String? customerPictureByDC,
    bool? showProduct,
    bool? showPromo,
    bool? showPlace,
    bool? showPrice,
  }) async {
    final key = _key(customerId, userId);

    debugPrint(
      '🔄 Deep copying place items for customer $customerId to avoid shared state',
    );
    final copiedPlaceItems =
        placeItem?.map((place) {
          final copiedGuidelines =
              place.guidelines
                  ?.map((guideline) {
                    if (guideline == null) return null;
                    return Guideline(
                      id: guideline.id,
                      description: guideline.description,
                      guidelineId: guideline.guidelineId,
                      pdf: guideline.pdf,
                      thumbnail: guideline.thumbnail,
                      groupThumbnail: guideline.groupThumbnail,
                      isCompetition: guideline.isCompetition,
                      channelId: guideline.channelId,
                      channelName: guideline.channelName,
                      groupId: guideline.groupId,
                      groupName: guideline.groupName,
                      abidedBy: null,
                      dataCollectorUserId: null,
                      visitDate: null,
                    );
                  })
                  .toList()
                  .cast<Guideline?>();

          return PlaceMustItem(
            groupId: place.groupId,
            categoryId: place.categoryId,
            categoryName: place.categoryName,
            name: place.name,
            thumbnail: place.thumbnail,
            isCompetition: place.isCompetition,
            guidelines: copiedGuidelines,
          );
        }).toList() ??
        [];

    // Deep copy promo items to avoid shared state between customers
    debugPrint(
      '🔄 Deep copying promo items for customer $customerId to avoid shared state',
    );
    final copiedPromoItems =
        promoItem?.map((promo) {
          final copiedGuidelines =
              promo.guidelines?.map((guideline) {
                return Guideline(
                  id: guideline.id,
                  description: guideline.description,
                  guidelineId: guideline.guidelineId,
                  pdf: guideline.pdf,
                  thumbnail: guideline.thumbnail,
                  groupThumbnail: guideline.groupThumbnail,
                  isCompetition: guideline.isCompetition,
                  channelId: guideline.channelId,
                  channelName: guideline.channelName,
                  groupId: guideline.groupId,
                  groupName: guideline.groupName,
                  abidedBy: null, // Reset selection state for each customer
                  dataCollectorUserId: null,
                  visitDate: null,
                );
              }).toList();

          return PromoMustItem(
            groupId: promo.groupId,
            categoryId: promo.categoryId,
            categoryName: promo.categoryName,
            name: promo.name,
            thumbnail: promo.thumbnail,
            isCompetition: promo.isCompetition,
            guidelines: copiedGuidelines,
          );
        }).toList() ??
        [];

    final mission = MissionUploadDetails(
      customerId: customerId,
      dataCollectorUserId: userId,
      showPlace: showPlace ?? false,
      showPrice: showPrice ?? false,
      showProduct: showProduct ?? false,
      showPromo: showPromo ?? false,
      visitDate: '',
      price: priceList ?? [],
      priceScore: '',
      priceScoreCompetition: '',
      place: copiedPlaceItems,
      placeScore: '',
      placeScoreCompetition: '',
      promo: copiedPromoItems,
      promoScore: '',
      promoScoreCompetition: '',

      product: productList ?? [],
      productScore: '',
      productScoreCompetition: '',

      photo: [],
      watchOut: [],
      genericQuestionsData: [],
      timeIn: null,
      timeOut: null,
      totalScore: null,
      totalScoreCompetition: null,
      pointsEarned: null,
      visitMaxPoints: null,
      customerNameByDC: customerNameByDC,
      customerLongByDC: customerLongByDC,
      customerLatByDC: customerLatByDC,
      customerPictureByDC: customerPictureByDC,
    );

    _missions[key] = mission;
    await saveMissionsToStorage();
    notifyListeners();
  }

  Future<void> updateMission({
    required int customerId,
    required int userId,
    required List<ProductMustItem> clustProducts,
    required List<PlaceMustItem> clustPlaces,
    required List<PromoMustItem> clustPromo,
    required List<PriceMustItem> clustPrice,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      debugPrint("⚠️ No mission found for $customerId - $userId");
      return;
    }

    bool hasChanged = false;

    // ---------------- PRODUCTS ----------------
    final notInClusterProducts =
        mission.product
            .where((mp) => !clustProducts.any((cp) => cp.id == mp.id))
            .toList();

    if (notInClusterProducts.isNotEmpty) {
      debugPrint("⚠️ Products in mission but not in cluster:");
      for (var p in notInClusterProducts) {
        debugPrint(" - ${p.id} | ${p.brandName} ----- ${p.available}");
      }

      final updatedProducts =
          mission.product
              .where(
                (mp) => !notInClusterProducts.any((nic) => nic.id == mp.id),
              )
              .toList();

      _missions[key] = mission.copyWith(product: updatedProducts);
      updateProductScores(customerId: customerId, userId: userId);
      debugPrint(
        "✅ Removed ${notInClusterProducts.length} products from mission.",
      );
      hasChanged = true;

      // Update showProduct to false if product list is now empty
      if (updatedProducts.isEmpty) {
        _missions[key] = _missions[key]!.copyWith(showProduct: false);
        debugPrint("✅ Set showProduct to false - no product items remaining.");
      }
    } else {
      debugPrint("✅ All mission products exist in cluster.");
    }

    // ---------------- PRICES ----------------
    final notInClusterPrices =
        mission.price
            .where((mp) => !clustPrice.any((cp) => cp.id == mp.id))
            .toList();

    if (notInClusterPrices.isNotEmpty) {
      debugPrint("⚠️ Prices in mission but not in cluster:");
      for (var p in notInClusterPrices) {
        debugPrint(" - ${p.id} | ${p.brandName}");
      }

      final updatedPrices =
          mission.price
              .where((mp) => !notInClusterPrices.any((nic) => nic.id == mp.id))
              .toList();

      _missions[key] = _missions[key]!.copyWith(price: updatedPrices);
      updatePriceScores(customerId: customerId, userId: userId);
      debugPrint("✅ Removed ${notInClusterPrices.length} prices from mission.");
      hasChanged = true;

      // Update showPrice to false if price list is now empty
      if (updatedPrices.isEmpty) {
        _missions[key] = _missions[key]!.copyWith(showPrice: false);
        debugPrint("✅ Set showPrice to false - no price items remaining.");
      }
    } else {
      debugPrint("✅ All mission prices exist in cluster.");
    }

    // ---------------- PLACES ----------------
    final notInClusterPlaces =
        mission.place
            .where((mp) => !clustPlaces.any((cp) => cp.groupId == mp.groupId))
            .toList();

    if (notInClusterPlaces.isNotEmpty) {
      debugPrint("⚠️ Places in mission but not in cluster:");
      for (var p in notInClusterPlaces) {
        debugPrint(" - ${p.groupId} | ${p.categoryName}");
      }

      final updatedPlaces =
          mission.place
              .where(
                (mp) =>
                    !notInClusterPlaces.any((nic) => nic.groupId == mp.groupId),
              )
              .toList();

      _missions[key] = _missions[key]!.copyWith(place: updatedPlaces);
      updatePlaceScores(customerId: customerId, userId: userId);
      debugPrint("✅ Removed ${notInClusterPlaces.length} places from mission.");
      hasChanged = true;

      // Update showPlace to false if place list is  empty
      if (updatedPlaces.isEmpty) {
        _missions[key] = _missions[key]!.copyWith(showPlace: false);
        debugPrint("✅ Set showPlace to false - no place items remaining.");
      }
    } else {
      debugPrint("✅ All mission places exist in cluster.");
    }

    // Guidelines inside each place
    final updatedPlacesWithGuidelines =
        _missions[key]!.place.map((mp) {
          final clusterPlace = clustPlaces.firstWhere(
            (cp) => cp.groupId == mp.groupId,
            orElse: () => PlaceMustItem(),
          );

          final updatedGuidelines =
              mp.guidelines
                  ?.where(
                    (g) =>
                        clusterPlace.guidelines?.any(
                          (cg) => cg?.id != null && cg!.id == g?.id,
                        ) ??
                        false,
                  )
                  .toList() ??
              [];

          if (updatedGuidelines.length != (mp.guidelines?.length ?? 0)) {
            debugPrint(
              "⚠️ Removed ${mp.guidelines!.length - updatedGuidelines.length} guidelines from place ${mp.groupId}",
            );
            hasChanged = true;
          }

          updatePlaceScores(customerId: customerId, userId: userId);
          return mp.copyWith(guidelines: updatedGuidelines);
        }).toList();

    _missions[key] = _missions[key]!.copyWith(
      place: updatedPlacesWithGuidelines,
    );

    // ---------------- PROMO ----------------
    final notInClusterPromo =
        mission.promo
            .where((mp) => !clustPromo.any((cp) => cp.groupId == mp.groupId))
            .toList();

    if (notInClusterPromo.isNotEmpty) {
      for (var p in notInClusterPromo) {
        debugPrint(" - ${p.groupId} | ${p.categoryName}");
      }

      final updatedPromo =
          mission.promo
              .where(
                (mp) =>
                    !notInClusterPromo.any((nic) => nic.groupId == mp.groupId),
              )
              .toList();

      _missions[key] = _missions[key]!.copyWith(promo: updatedPromo);
      updatePromoScores(customerId: customerId, userId: userId);
      debugPrint("✅ Removed ${notInClusterPromo.length} promos from mission.");
      hasChanged = true;

      // Update showPromo to false if promo list is   empty
      if (updatedPromo.isEmpty) {
        _missions[key] = _missions[key]!.copyWith(showPromo: false);
      }
    } else {}

    // Guidelines inside each promo
    final updatedPromoWithGuidelines =
        _missions[key]!.promo.map((mp) {
          final clusterPromo = clustPromo.firstWhere(
            (cp) => cp.groupId == mp.groupId,
            orElse: () => PromoMustItem(),
          );

          final updatedGuidelines =
              mp.guidelines
                  ?.where(
                    (g) =>
                        clusterPromo.guidelines?.any(
                          (cg) => cg.id != null && cg.id == g.id,
                        ) ??
                        false,
                  )
                  .toList() ??
              [];

          if (updatedGuidelines.length != (mp.guidelines?.length ?? 0)) {
            debugPrint(
              "⚠️ Removed ${mp.guidelines!.length - updatedGuidelines.length} guidelines from promo ${mp.groupId}",
            );
            hasChanged = true;
          }
          updatePromoScores(customerId: customerId, userId: userId);

          return mp.copyWith(guidelines: updatedGuidelines);
        }).toList();

    _missions[key] = _missions[key]!.copyWith(
      promo: updatedPromoWithGuidelines,
    );

    // ---------------- SAVE ONLY IF CHANGED ----------------
    if (hasChanged) {
      await saveMissionsToStorage();
      notifyListeners();
      debugPrint("💾 Mission updated & saved for $customerId - $userId");
    } else {
      debugPrint("👌 No changes detected, mission not saved.");
    }
  }

  //----------------------------------------------------------Start of Products Methods---------------------------------
  void initializeProductList({
    required int customerId,
    required int userId,
    required List<ProductMustItem> productList,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission != null) {
      _missions[key] = mission.copyWith(
        product: productList,
        showProduct: productList.isNotEmpty,
      );
      notifyListeners();
    }
  }

  Future<void> toggleProductSelection({
    required int customerId,
    required int userId,
    required int productId,
    required List<int> groupProductIds,
    required int dataCollectorUserId,
    required String visitDate,
    required List<ProductMustItem> productItems,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    final products = mission.product;

    String visitDate = GlobalMethods.stringDate();
    final groupProducts =
        products.where((p) => groupProductIds.contains(p.id)).toList();

    final allNull = groupProducts.every((p) => p.available == null);

    List<ProductMustItem> updatedProducts;

    if (allNull) {
      updatedProducts =
          products.map((product) {
            if (groupProductIds.contains(product.id)) {
              final newAvailable = (product.id == productId) ? 0 : 1;

              return product.copyWith(
                available: newAvailable,
                visitDate: visitDate,
              );
            }
            return product;
          }).toList();
    } else {
      updatedProducts =
          products.map((product) {
            if (product.id == productId) {
              final current = product.available ?? 0;
              final newAvailable = current == 1 ? 0 : 1;

              return product.copyWith(
                available: newAvailable,
                visitDate: visitDate,
              );
            }
            return product;
          }).toList();
    }
    final updatedMission = mission.copyWith(product: updatedProducts);

    _missions[key] = updatedMission;

    updateProductScores(customerId: customerId, userId: userId);
    notifyListeners();
    await saveMissionsToStorage();
  }

  Map<int, bool> getSelectionStatus({
    required int customerId,
    required int userId,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return {};

    final statusMap = <int, bool>{};

    for (final product in mission.product) {
      final isSelected = product.available == 1;
      if (product.id != null) {
        statusMap[product.id!] = isSelected;
      }
    }

    return statusMap;
  }

  void addGroupSelection({
    required int customerId,
    required int userId,
    required List<int> groupProductIds,
    required int dataCollectorUserId,
    required String visitDate,
    required List<ProductMustItem> productItems,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }
    final updatedProducts =
        mission.product.map((product) {
          if (groupProductIds.contains(product.id)) {
            return product.copyWith(
              available: 1,
              visitDate: visitDate,
              dataCollectorUserId: dataCollectorUserId,
            );
          }
          return product;
        }).toList();
    _missions[key] = mission.copyWith(product: updatedProducts);
    updateProductScores(customerId: customerId, userId: userId);
    notifyListeners();
  }

  bool? getSelection({
    required int customerId,
    required int userId,
    required int productId,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];
    if (mission == null) return null;

    final product = mission.product.firstWhere(
      (p) => p.id == productId,
      orElse: () => ProductMustItem(),
    );

    if (product.available == null) return null;

    return product.available == 1;
  }

  void updateProductScores({required int customerId, required int userId}) {
    final key = _key(customerId, userId);
    final mission = _missions[key];
    if (mission == null) return;

    final nonCompetitionProducts =
        mission.product.where((p) => p.isCompetition != true).toList();
    final competitionProducts =
        mission.product.where((p) => p.isCompetition == true).toList();

    final nonCompSelected =
        nonCompetitionProducts.where((p) => p.available == 1).length;
    final compSelected =
        competitionProducts.where((p) => p.available == 1).length;

    final nonCompPercent =
        nonCompetitionProducts.isEmpty
            ? 0
            : nonCompSelected / nonCompetitionProducts.length;
    final compPercent =
        competitionProducts.isEmpty
            ? 0
            : compSelected / competitionProducts.length;

    _missions[key] = mission.copyWith(
      productScore: (nonCompPercent * 100).toStringAsFixed(2),
      productScoreCompetition: (compPercent * 100).toStringAsFixed(2),
    );

    notifyListeners();
  }

  bool isCompleted({required int customerId, required int userId}) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null || mission.product.isEmpty) return false;

    return mission.product.every((product) => product.available != null);
  }

  //----------------------------------------------------------End of Products Methods---------------------------------

  //----------------------------------------------------------Start of Price Methods---------------------------------
  Future<void> selectPrice({
    required int customerId,
    required int userId,
    required int productId,
    required PriceMustItem priceItem,
    SelectionType? selection,
    double? price,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    final prices = mission.price;

    final int? hasIssueValue =
        selection == null ? null : (selection == SelectionType.correct ? 0 : 1);

    String visitDate = GlobalMethods.stringDate();
    final updatedPriceItem = priceItem.copyWith(
      hasIssue: hasIssueValue,
      dataCollectorUserId: userId,
      price: price,
      visitDate: visitDate,
    );

    final index = prices.indexWhere((p) => p.id == productId);

    List<PriceMustItem> updatedPrices;

    if (index >= 0) {
      updatedPrices = List.from(prices);
      updatedPrices[index] = updatedPriceItem;
    } else {
      updatedPrices = List.from(prices)..add(updatedPriceItem);
    }

    _missions[key] = mission.copyWith(price: updatedPrices);
    updatePriceScores(customerId: customerId, userId: userId);
    notifyListeners();
    await saveMissionsToStorage();
  }

  SelectionType? getSelectionByUserId({
    required int userId,
    required int customerId,
    required int productId,
  }) {
    final mission = _missions['$customerId-$userId'];
    if (mission == null) return null;

    final price = mission.price.firstWhere(
      (p) => p.id == productId,
      orElse: () => PriceMustItem(),
    );

    if (price.hasIssue == null) return null;

    return price.hasIssue == 0
        ? SelectionType.correct
        : SelectionType.incorrect;
  }

  double? getEnteredPrice({
    required int userId,
    required int customerId,
    required int productId,
  }) {
    final mission = _missions['$customerId-$userId'];
    if (mission == null) return null;

    final priceItem = mission.price.firstWhere(
      (p) => p.id == productId,
      orElse: () => PriceMustItem(),
    );

    return priceItem.price;
  }

  void updatePriceScores({required int customerId, required int userId}) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    final prices = mission.price;

    if (prices.isEmpty) {
      _missions[key] = mission.copyWith(
        priceScore: '0.00',
        priceScoreCompetition: '0.00',
      );
      notifyListeners();
      return;
    }

    int correctNonCompCount = 0;
    int totalNonCompSelected = 0;
    int correctCompCount = 0;
    int totalCompSelected = 0;

    for (var priceItem in prices) {
      if (priceItem.id == null || priceItem.hasIssue == null) continue;

      if (priceItem.isCompetition == true) {
        totalCompSelected++;
        if (priceItem.hasIssue == 0) {
          correctCompCount++;
        }
      } else {
        totalNonCompSelected++;
        if (priceItem.hasIssue == 0) {
          correctNonCompCount++;
        }
      }
    }

    final nonCompPercentage =
        totalNonCompSelected == 0
            ? 0
            : (correctNonCompCount / totalNonCompSelected) * 100;
    final compPercentage =
        totalCompSelected == 0
            ? 0
            : (correctCompCount / totalCompSelected) * 100;

    _missions[key] = mission.copyWith(
      priceScore: nonCompPercentage.toStringAsFixed(2),
      priceScoreCompetition: compPercentage.toStringAsFixed(2),
    );
    notifyListeners();
  }

  int getSelectionCount(int customerId, int userId) {
    final key = _key(customerId, userId);
    final mission = _missions[key];
    if (mission == null) return 0;

    // Check if all price items have hasIssue and collectPrice as null
    final allNull = mission.price.every(
      (price) => price.hasIssue == null && price.price == null,
    );

    if (allNull) return 0;

    final priceLength = mission.price.length;
    return priceLength;
  }

  //----------------------------------------------------------End of Price Methods---------------------------------
  //----------------------------------------------------------Start of Place Methods---------------------------------
  void initializePlaceList({
    required int customerId,
    required int userId,
    required List<PlaceMustItem> placeList,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission != null) {
      _missions[key] = mission.copyWith(
        place: placeList,
        showPlace: placeList.isNotEmpty,
      );
      notifyListeners();
    } else {
      debugPrint('❌ Mission not found for $customerId - $userId');
    }
  }

  Future<void> selectPlaceGuideline({
    required int customerId,
    required int userId,
    required int groupId,
    required int guidelineId,
    required SelectionType selection,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    String visitDate = GlobalMethods.stringDate();

    for (var place in mission.place) {
      if (place.groupId == groupId) {
        for (var guideline in place.guidelines ?? []) {
          if (guideline != null) {
            if (guideline.id == guidelineId) {
              guideline.abidedBy = selection == SelectionType.correct ? 1 : 0;
              guideline.dataCollectorUserId = userId;
              guideline.visitDate = visitDate;
            }
          }
        }
      }
    }

    updatePlaceScores(customerId: customerId, userId: userId);
    notifyListeners();
    await saveMissionsToStorage();
  }

  bool isPlaceCompletedFromMission({
    required int customerId,
    required int userId,
    List<PlaceMustItem>? currentChannelPlaces,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return false;

    // Get all guidelines from originally initialized place items
    final allInitializedGuidelines =
        mission.place
            .expand((item) => item.guidelines ?? [])
            .where((g) => g != null)
            .cast<Guideline>()
            .toList();

    if (allInitializedGuidelines.isEmpty) return false;

    // If current channel places are provided, filter out disabled items
    List<Guideline> guidelinesToCheck = allInitializedGuidelines;

    if (currentChannelPlaces != null) {
      // Get groupIds that are still available in current channel data
      final availableGroupIds =
          currentChannelPlaces.map((p) => p.groupId).toSet();

      // Only check guidelines from place items that are still available
      guidelinesToCheck =
          mission.place
              .where((item) => availableGroupIds.contains(item.groupId))
              .expand((item) => item.guidelines ?? [])
              .where((g) => g != null)
              .cast<Guideline>()
              .toList();
    }

    if (guidelinesToCheck.isEmpty) return false;

    // Check if all available guidelines have been selected
    final allSelected = guidelinesToCheck.every((g) => g.abidedBy != null);

    return allSelected;
  }

  SelectionType? getPlaceSelection({
    required int customerId,
    required int userId,
    required int groupId,
    required int guidelineId,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];
    if (mission == null) return null;

    final places = mission.place;

    for (var place in places) {
      if (place.groupId == groupId) {
        final guidelines = place.guidelines;
        if (guidelines == null) continue;

        for (var guideline in guidelines) {
          if (guideline != null && guideline.id == guidelineId) {
            if (guideline.abidedBy == 1) {
              return SelectionType.correct;
            } else if (guideline.abidedBy == 0) {
              return SelectionType.incorrect;
            } else {
              return null;
            }
          }
        }
      }
    }

    return null;
  }

  void updatePlaceScores({required int customerId, required int userId}) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    int nonCompetitionCount = 0;
    int nonCompetitionCorrectCount = 0;

    int competitionCount = 0;
    int competitionCorrectCount = 0;

    for (var place in mission.place) {
      for (var guideline in place.guidelines!) {
        if (place.isCompetition == false) {
          // Non-competition guidelines
          nonCompetitionCount++;
          if (guideline?.abidedBy == 1) {
            nonCompetitionCorrectCount++;
          }
        } else if (place.isCompetition == true) {
          // Competition guidelines
          competitionCount++;
          if (guideline?.abidedBy == 1) {
            competitionCorrectCount++;
          }
        }
      }
    }

    double nonCompPercentage = 0.0;
    if (nonCompetitionCount > 0) {
      nonCompPercentage =
          (nonCompetitionCorrectCount / nonCompetitionCount) * 100;
    }

    double compPercentage = 0.0;
    if (competitionCount > 0) {
      compPercentage = (competitionCorrectCount / competitionCount) * 100;
    }

    _missions[key] = mission.copyWith(
      placeScore: nonCompPercentage.toStringAsFixed(2),
      placeScoreCompetition: compPercentage.toStringAsFixed(2),
    );

    notifyListeners();
  }

  //----------------------------------------------------------End of Place Methods---------------------------------
  //----------------------------------------------------------Start of Promo Methods---------------------------------
  void initializePromoList({
    required int customerId,
    required int userId,
    required List<PromoMustItem> promoList,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission != null) {
      _missions[key] = mission.copyWith(
        promo: promoList,
        showPromo: promoList.isNotEmpty,
      );
      notifyListeners();
    } else {}
  }

  Future<void> selectPromoGuideline({
    required int customerId,
    required int userId,
    required int groupId,
    required int guidelineId,
    required SelectionType selection,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    String visitDate = GlobalMethods.stringDate();
    for (var promo in mission.promo) {
      if (promo.groupId == groupId) {
        for (var guideline in promo.guidelines!) {
          if (guideline.id == guidelineId) {
            guideline.abidedBy = selection == SelectionType.correct ? 1 : 0;
            guideline.dataCollectorUserId = userId;
            guideline.visitDate = visitDate;
          }
        }
      }
    }

    updatePromoScores(customerId: customerId, userId: userId);
    notifyListeners();
    await saveMissionsToStorage();
  }

  bool isPromoCompletedFromMission({
    required int customerId,
    required int userId,
    List<PromoMustItem>? currentChannelPromos,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return false;

    // Get all guidelines from originally initialized promo items
    final allInitializedGuidelines =
        mission.promo
            .expand((item) => item.guidelines ?? [])
            .where((g) => g != null)
            .cast<Guideline>()
            .toList();

    if (allInitializedGuidelines.isEmpty) return false;

    // If current channel promos are provided, filter out disabled items
    List<Guideline> guidelinesToCheck = allInitializedGuidelines;

    if (currentChannelPromos != null) {
      // Get groupIds that are still available in current channel data
      final availableGroupIds =
          currentChannelPromos.map((p) => p.groupId).toSet();

      // Only check guidelines from promo items that are still available
      guidelinesToCheck =
          mission.promo
              .where((item) => availableGroupIds.contains(item.groupId))
              .expand((item) => item.guidelines ?? [])
              .where((g) => g != null)
              .cast<Guideline>()
              .toList();
    }

    if (guidelinesToCheck.isEmpty) return false;

    // Check if all available guidelines have been selected
    final allSelected = guidelinesToCheck.every((g) => g.abidedBy != null);

    return allSelected;
  }

  void updatePromoScores({required int customerId, required int userId}) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    int nonCompetitionCount = 0;
    int nonCompetitionCorrectCount = 0;

    int competitionCount = 0;
    int competitionCorrectCount = 0;

    for (var promo in mission.promo) {
      for (var guideline in promo.guidelines!) {
        if (promo.isCompetition == false) {
          nonCompetitionCount++; // <-- count guidelines for non competition
          if (guideline.abidedBy == 1) {
            nonCompetitionCorrectCount++;
          }
        } else if (promo.isCompetition == true) {
          competitionCount++;
          if (guideline.abidedBy == 1) {
            competitionCorrectCount++;
          }
        }
      }
    }

    double nonCompPercentage = 0.0;
    if (nonCompetitionCount > 0) {
      nonCompPercentage =
          (nonCompetitionCorrectCount / nonCompetitionCount) * 100;
    }

    double compPercentage = 0.0;
    if (competitionCount > 0) {
      compPercentage = (competitionCorrectCount / competitionCount) * 100;
    }

    _missions[key] = mission.copyWith(
      promoScore: nonCompPercentage.toStringAsFixed(2),
      promoScoreCompetition: compPercentage.toStringAsFixed(2),
    );

    notifyListeners();
  }

  SelectionType? getPromoSelection({
    required int customerId,
    required int userId,
    required int groupId,
    required int guidelineId,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return null;

    final promos = mission.promo;

    for (var promo in promos) {
      if (promo.groupId == groupId) {
        final guidelines = promo.guidelines;
        if (guidelines == null) continue;

        for (var guideline in guidelines) {
          if (guideline.id == guidelineId) {
            if (guideline.abidedBy == 1) {
              return SelectionType.correct;
            } else if (guideline.abidedBy == 0) {
              return SelectionType.incorrect;
            } else {
              return null;
            }
          }
        }
      }
    }

    return null;
  }

  //----------------------------------------------------------End of Promo Methods---------------------------------

  Future<void> addImage({
    required int customerId,
    required int userId,
    required int categoryId,
    required String group,
    required XFile imagePath,
    required int dataCollectorUserId,
    required int itemId,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    String? base64String;
    try {
      final file = File(imagePath.path);
      final exists = await file.exists();

      if (!exists) {
        base64String = null;
      } else {
        final bytes = await file.readAsBytes();
        base64String = base64Encode(bytes);
      }
    } catch (e) {
      debugPrint('❌ Error converting image to base64: $e');
      base64String = null;
    }

    String visitDate = GlobalMethods.stringDate();
    final photo = PhotoUpload(
      categoryId: categoryId,
      dataCollectorUserId: dataCollectorUserId,
      location: group,
      photo: imagePath,
      photoBase64: base64String,
      visitDate: visitDate,
    );
    final updatedPhotos = List<PhotoUpload>.from(mission.photo);
    updatedPhotos.add(photo);

    _missions[key] = mission.copyWith(photo: updatedPhotos);

    notifyListeners();
    await saveMissionsToStorage();
  }

  int getTotalImagesByCustomer({required int customerId, required int userId}) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return 0;

    return mission.photo.length;
  }

  List<PhotoUpload> getImagesByCustomerCategoryGroup({
    required int customerId,
    required int userId,
    required int categoryId,
    required String group,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return [];

    return mission.photo
        .where(
          (photo) => photo.categoryId == categoryId && photo.location == group,
        )
        .toList();
  }

  void toggleNotAvailable({
    required int customerId,
    required int userId,
    required int categoryId,
    required String group,
  }) {
    final notAvailableKey = _notAvailableKey(
      customerId,
      userId,
      categoryId,
      group,
    );

    if (_notAvailableItems.contains(notAvailableKey)) {
      _notAvailableItems.remove(notAvailableKey);
    } else {
      _notAvailableItems.add(notAvailableKey);
    }

    notifyListeners();
  }

  bool isNotAvailableForCategory({
    required int customerId,
    required int userId,
    required int categoryId,
    required String group,
  }) {
    final notAvailableKey = _notAvailableKey(
      customerId,
      userId,
      categoryId,
      group,
    );
    return _notAvailableItems.contains(notAvailableKey);
  }

  List<Map<String, dynamic>> getNotAvailableItems({
    required int customerId,
    required int userId,
  }) {
    final items =
        _notAvailableItems
            .where((key) => key.startsWith('$customerId-$userId-'))
            .map((key) {
              final parts = key.split('-');
              return {
                'categoryId': int.tryParse(parts[2]),
                'group': parts
                    .sublist(3)
                    .join('-'), // in case group has hyphens
              };
            })
            .toList();

    return items;
  }

  Future<void> removeImage({
    required int customerId,
    required int userId,
    required int categoryId,
    required String group,
    required XFile imagePath,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return;

    final updatedPhotos = List<PhotoUpload>.from(mission.photo)..removeWhere(
      (img) =>
          img.photo == imagePath &&
          img.categoryId == categoryId &&
          img.location == group,
    );

    _missions[key] = mission.copyWith(photo: updatedPhotos);

    notifyListeners();
    await saveMissionsToStorage();
  }

  void setTotalScoresAndTimeOut({
    required int customerId,
    required int userId,
  }) {
    final key = _key(customerId, userId);
    final missionDetails = _missions[key];
    if (missionDetails == null) return;

    double productScore = double.tryParse(missionDetails.productScore) ?? 0;
    double priceScore = double.tryParse(missionDetails.priceScore) ?? 0;
    double placeScore = double.tryParse(missionDetails.placeScore) ?? 0;
    double promoScore = double.tryParse(missionDetails.promoScore) ?? 0;

    double productScoreCompetition =
        double.tryParse(missionDetails.productScoreCompetition ?? '') ?? 0;
    double priceScoreCompetition =
        double.tryParse(missionDetails.priceScoreCompetition) ?? 0;
    double placeScoreCompetition =
        double.tryParse(missionDetails.placeScoreCompetition) ?? 0;
    double promoScoreCompetition =
        double.tryParse(missionDetails.promoScoreCompetition) ?? 0;

    int normalKpiCount =
        [
          missionDetails.productScore,
          missionDetails.priceScore,
          missionDetails.placeScore,
          missionDetails.promoScore,
        ].where((score) => score.isNotEmpty).length;

    int competitionKpiCount =
        [
          missionDetails.productScoreCompetition,
          missionDetails.priceScoreCompetition,
          missionDetails.placeScoreCompetition,
          missionDetails.promoScoreCompetition,
        ].where((score) => score != null && score.isNotEmpty).length;

    double? totalScore =
        normalKpiCount > 0
            ? ((productScore + priceScore + placeScore + promoScore) /
                normalKpiCount)
            : null;

    double? totalScoreCompetition =
        competitionKpiCount > 0
            ? ((productScoreCompetition +
                    priceScoreCompetition +
                    placeScoreCompetition +
                    promoScoreCompetition) /
                competitionKpiCount)
            : null;

    final now = DateTime.now().toUtc();
    final formattedTime = now.toIso8601String();

    _missions[key] = missionDetails.copyWith(
      totalScore: totalScore,
      totalScoreCompetition: totalScoreCompetition,
      timeOut: formattedTime,
      pointsEarned: 0,
    );

    notifyListeners();
  }
}
