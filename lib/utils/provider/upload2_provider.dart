import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/models/upload/mission_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/photo_upload_model.dart';
import 'package:flutter_salesman_module/utils/enum/price_select_type.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class MissionUpload2Provider extends ChangeNotifier {
  final Map<String, MissionUploadDetails> _missions = {};

  String _key(int customerId, int userId) => '$customerId-$userId';
  MissionUploadDetails? getMission(int customerId, int userId) {
    return _missions[_key(customerId, userId)];
  }

  Future<void> saveMissionsToStorage() async {
    try {
      final List<Map<String, dynamic>> jsonList =
          _missions.values.map((mission) => mission.toJson()).toList();

      await box.write('missions', jsonList);
      debugPrint('✅ Missions saved to storage.');

      // Print all missions after saving
      for (var mission in _missions.values) {
        printMissionDetails(
          customerId: mission.customerId,
          userId: mission.dataCollectorUserId,
        );
      }
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

        // Print details after adding each mission
        printMissionDetails(
          customerId: mission.customerId,
          userId: mission.dataCollectorUserId,
        );
      }

      debugPrint('✅ Loaded ${_missions.length} missions from storage.');

      notifyListeners();
    } catch (e) {
      debugPrint('❌ Error loading missions: $e');
    }
  }

  void initializeMission({
    required int customerId,
    required int userId,
    required String visitDate,
  }) {
    final key = _key(customerId, userId);

    final mission = MissionUploadDetails(
      customerId: customerId,
      dataCollectorUserId: userId,
      visitDate: visitDate,
      price: [],
      priceScore: '',
      priceScoreCompetition: '',
      place: [],
      placeScore: '',
      placeScoreCompetition: '',
      promo: [],
      promoScore: '',
      promoScoreCompetition: '',

      product: [],
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
      customerNameByDC: null,
      customerLongByDC: null,
      customerLatByDC: null,
      customerPictureByDC: null,
    );

    _missions[key] = mission;
    notifyListeners();
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
      _missions[key] = mission.copyWith(product: productList);
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

    final groupProducts =
        products.where((p) => groupProductIds.contains(p.id)).toList();

    final allNull = groupProducts.every((p) => p.available == null);

    List<ProductMustItem> updatedProducts;

    if (allNull) {
      updatedProducts =
          products.map((product) {
            if (groupProductIds.contains(product.id)) {
              final newAvailable = (product.id == productId) ? 0 : 1;

              return product.copyWith(available: newAvailable);
            }
            return product;
          }).toList();
    } else {
      updatedProducts =
          products.map((product) {
            if (product.id == productId) {
              final current = product.available ?? 0;
              final newAvailable = current == 1 ? 0 : 1;

              return product.copyWith(available: newAvailable);
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
    required SelectionType selection,
    double? price,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      return;
    }

    final prices = mission.price;

    final hasIssueValue = (selection == SelectionType.correct) ? 0 : 1;

    final updatedPriceItem = priceItem.copyWith(
      hasIssue: hasIssueValue,
      dataCollectorUserId: userId,
      price: price,
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
    for (var p in mission.price) {
      print("sssssssssssssssssssssssssssssss${p.hasIssue}");
    }
    notifyListeners();
  }

  int getSelectionCount(int customerId, int userId) {
    final key = _key(customerId, userId);
    final mission = _missions[key];
    if (mission == null) return 0;
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
      _missions[key] = mission.copyWith(place: placeList);
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

    for (var place in mission.place) {
      if (place.groupId == groupId) {
        for (var guideline in place.guidelines!) {
          if (guideline != null && guideline.id == guidelineId) {
            guideline.abidedBy = selection == SelectionType.correct ? 1 : 0;
            guideline.dataCollectorUserId = userId;
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
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return false;

    final allGuidelines =
        mission.place
            .expand((item) => item.guidelines ?? [])
            .where((g) => g != null)
            .cast<Guideline>()
            .toList();

    if (allGuidelines.isEmpty) return false;

    final allSelected = allGuidelines.every((g) => g.abidedBy != null);

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
      debugPrint(
        '❌ No mission found for customerId: $customerId, userId: $userId',
      );
      return;
    }

    int nonCompetitionCount = 0;
    int nonCompetitionCorrectCount = 0;

    int competitionCount = 0;
    int competitionCorrectCount = 0;

    for (var place in mission.place) {
      debugPrint(
        '🟡 Place: ${place.channelName} isCompetition: ${place.isCompetition}',
      );

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

    debugPrint('🟡 Total non-competition guidelines: $nonCompetitionCount');
    debugPrint(
      '✅ Correct non-competition guidelines: $nonCompetitionCorrectCount',
    );
    debugPrint(
      '📊 Non-competition correct percentage: ${nonCompPercentage.toStringAsFixed(2)}%',
    );

    debugPrint('🟡 Total competition guidelines: $competitionCount');
    debugPrint('✅ Correct competition guidelines: $competitionCorrectCount');
    debugPrint(
      '📊 Competition correct percentage: ${compPercentage.toStringAsFixed(2)}%',
    );

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
      _missions[key] = mission.copyWith(promo: promoList);
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
      debugPrint(
        '❌ Mission not found for customerId: $customerId, userId: $userId',
      );
      return;
    }

    for (var promo in mission.promo) {
      if (promo.groupId == groupId) {
        for (var guideline in promo.guidelines!) {
          if (guideline.id == guidelineId) {
            guideline.abidedBy = selection == SelectionType.correct ? 1 : 0;
            guideline.dataCollectorUserId = userId;
          }
        }
      }
    }
    debugPrint(
      '📥 selectPromoGuideline called with: '
      'customerId: $customerId, userId: $userId, '
      'groupId: $groupId, guidelineId: $guidelineId, '
      'selection: $selection',
    );
    updatePromoScores(customerId: customerId, userId: userId);
    notifyListeners();
    await saveMissionsToStorage();
  }

  bool isPromoCompletedFromMission({
    required int customerId,
    required int userId,
  }) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) return false;

    final allGuidelines =
        mission.promo
            .expand((item) => item.guidelines ?? [])
            .where((g) => g != null)
            .cast<Guideline>()
            .toList();

    if (allGuidelines.isEmpty) return false;

    final allSelected = allGuidelines.every((g) => g.abidedBy != null);

    return allSelected;
  }

  void updatePromoScores({required int customerId, required int userId}) {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      debugPrint(
        '❌ No mission found for customerId: $customerId, userId: $userId',
      );
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

    debugPrint('🟡 Total non-competition guidelines: $nonCompetitionCount');
    debugPrint(
      '✅ Correct non-competition guidelines: $nonCompetitionCorrectCount',
    );
    debugPrint(
      '📊 Non-competition correct percentage: ${nonCompPercentage.toStringAsFixed(2)}%',
    );

    debugPrint('🟡 Total competition guidelines: $competitionCount');
    debugPrint('✅ Correct competition guidelines: $competitionCorrectCount');
    debugPrint(
      '📊 Competition correct percentage: ${compPercentage.toStringAsFixed(2)}%',
    );

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

    print('🔍 Getting promo selection for:');
    print('Customer ID: $customerId, User ID: $userId');
    print('Group ID: $groupId, Guideline ID: $guidelineId');
    print('Generated key: $key');
    print('Mission found: ${mission != null}');

    if (mission == null) return null;

    final promos = mission.promo;
    print('Total promo groups: ${mission.promo}');

    for (var promo in promos) {
      print('Checking promo with groupId: ${promo.groupId}');
      if (promo.groupId == groupId) {
        final guidelines = promo.guidelines;
        print('Promo group matched. Guidelines: ${guidelines?.length ?? 0}');
        if (guidelines == null) continue;

        for (var guideline in guidelines) {
          print('Checking guideline with id: ${guideline.id}');
          if (guideline.id == guidelineId) {
            print('✅ Guideline matched. abidedBy: ${guideline.abidedBy}');
            if (guideline.abidedBy == 1) {
              return SelectionType.correct;
            } else if (guideline.abidedBy == 0) {
              return SelectionType.incorrect;
            } else {
              print('⚠️ abidedBy is neither 0 nor 1');
              return null;
            }
          }
        }
      }
    }

    print('❌ Guideline not found in any matching promo group.');
    return null;
  }

  //----------------------------------------------------------End of Promo Methods---------------------------------

  Future<void> addImage({
    required int customerId,
    required int userId,
    required int categoryId,
    required String group,
    required String imagePath,
    required String visitDate,
    required int dataCollectorUserId,
  }) async {
    final key = _key(customerId, userId);
    final mission = _missions[key];

    if (mission == null) {
      debugPrint('❌ Mission not found for $customerId - $userId');
      return;
    }

    final photo = PhotoUpload(
      categoryId: categoryId,
      dataCollectorUserId: dataCollectorUserId,
      location: group,
      photo: imagePath,
      visitDate: visitDate,
    );

    final updatedPhotos = List<PhotoUpload>.from(mission.photo);
    updatedPhotos.add(photo);

    _missions[key] = mission.copyWith(photo: updatedPhotos);

    debugPrint('📷 Added Image: $imagePath');
    debugPrint('🧾 Current Image List for mission:');
    for (var img in updatedPhotos) {
      debugPrint(
        '➡️ categoryId: ${img.categoryId} | group: ${img.location} | image: ${img.photo}',
      );
    }

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

  Future<void> removeImage({
    required int customerId,
    required int userId,
    required int categoryId,
    required String group,
    required String imagePath,
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

    debugPrint(
      '🗑️ Removed image: $imagePath for category $categoryId and group "$group"',
    );
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

  void printMissionDetails({required int customerId, required int userId}) {
    final mission = getMission(customerId, userId);
    if (mission == null) {
      debugPrint(
        '❌ No mission found for customer $customerId and user $userId.',
      );
      return;
    }

    debugPrint(
      '************************** customerId: $customerId **************************** userId: $userId ********************',
    );
    debugPrint("---------");
    debugPrint('dataCollectorUserId: ${mission.dataCollectorUserId}');
    debugPrint("---------");
    debugPrint('totalScore: ${mission.totalScore}');
    debugPrint("---------");
    debugPrint('totalScoreCompetition: ${mission.totalScoreCompetition}');
    debugPrint("---------");
    debugPrint('visitDate: ${mission.visitDate}');
    debugPrint("---------");
    debugPrint('pointsEarned: ${mission.pointsEarned}');
    debugPrint("---------");
    debugPrint('visitMaxPoints: ${mission.visitMaxPoints}');
    debugPrint("---------");
    debugPrint('timeIn: ${mission.timeIn}');
    debugPrint("---------");
    debugPrint('timeOut: ${mission.timeOut}');
    debugPrint(
      '*******************************************************************',
    );

    debugPrint('Products:');
    debugPrint("---------");
    debugPrint('productScore: ${mission.productScore}');
    debugPrint("---------");
    debugPrint('productScoreCompetition: ${mission.productScoreCompetition}');
    debugPrint("---------");
    for (final product in mission.product) {
      debugPrint(
        '➡️ product ID: ${product.id}, Available: ${product.available}, Is Competition: ${product.isCompetition}',
      );
    }

    debugPrint(
      '*******************************************************************',
    );
    debugPrint('Prices:');
    debugPrint("---------");
    debugPrint('priceScore: ${mission.priceScore}');
    debugPrint("---------");
    debugPrint('priceScoreCompetition: ${mission.priceScoreCompetition}');
    debugPrint("---------");
    for (final price in mission.price) {
      debugPrint(
        '➡️ Price ID: ${price.id}, DataCollectorUserId: ${price.dataCollectorUserId}, Has Issue: ${price.hasIssue}, Is Competition: ${price.isCompetition} --- Price: ${price.price}',
      );
    }

    debugPrint(
      '*******************************************************************',
    );
    debugPrint('Places:');
    debugPrint("---------");
    debugPrint('placeScore: ${mission.placeScore}');
    debugPrint("---------");
    debugPrint('placeScoreCompetition: ${mission.placeScoreCompetition}');
    debugPrint("---------");
    for (final place in mission.place) {
      if (place.guidelines == null || place.guidelines!.isEmpty) {
        debugPrint('No guidelines in place: ${place.name}');
        continue;
      }
      debugPrint(
        '➡️ place ID: ${place.groupId}, place: ${place.channelName}, AbidedBy: ${place.guidelines!.length}',
      );
      for (var guideline in place.guidelines!) {
        debugPrint(
          '➡️ place guideline ID: ${guideline!.id}, DataCollectorUserId: ${guideline.dataCollectorUserId}, AbidedBy: ${guideline.abidedBy}',
        );
      }
    }

    debugPrint(
      '*******************************************************************',
    );
    debugPrint('Promo:');
    debugPrint("---------");
    debugPrint('promoScore: ${mission.promoScore}');
    debugPrint("---------");
    debugPrint('promoScoreCompetition: ${mission.promoScoreCompetition}');
    debugPrint("---------");
    for (final promo in mission.promo) {
      if (promo.guidelines == null || promo.guidelines!.isEmpty) {
        debugPrint('No guidelines in promo: ${promo.name}');
        continue;
      }
      debugPrint(
        '➡️ promo ID: ${promo.groupId}, promo: ${promo.categoryName}, AbidedBy: ${promo.guidelines!.length}',
      );
      for (var guideline in promo.guidelines!) {
        debugPrint(
          '➡️ promo guideline ID: ${guideline.id}, DataCollectorUserId: ${guideline.dataCollectorUserId}, AbidedBy: ${guideline.abidedBy}',
        );
      }
    }

    debugPrint(
      '*******************************************************************',
    );
    debugPrint('Photos:');
    debugPrint("---------");
    for (final photo in mission.photo) {
      debugPrint(
        '🖼️ photoPath: ${photo.photo}, categoryId: ${photo.categoryId}, location(group): ${photo.location}',
      );
    }

    debugPrint(
      '*******************************************************************',
    );
  }
}
