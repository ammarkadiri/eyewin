/*import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/models/upload/mission_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/photo_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/place_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/price_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/product_upload_model.dart';
import 'package:flutter_salesman_module/models/upload/promo_upload_model.dart';

class MissionUploadProvider extends ChangeNotifier {
  final Map<int, MissionUploadDetails> _missions = {};

  MissionUploadDetails? getMission(int customerId) => _missions[customerId];

  void initializeMission({
    required int customerId,
    required int dataCollectorUserId,
    required String visitDate,
  }) {
    _missions[customerId] = MissionUploadDetails(
      customerId: customerId, //done
      dataCollectorUserId: dataCollectorUserId, //done
      visitDate: visitDate, //done
      price: [], //done
      priceScore: '', //done
      priceScoreCompetition: '', //done
      place: [], //done
      placeScore: '', //done
      placeScoreCompetition: '', //done
      promo: [], //done
      promoScore: '', //done
      promoScoreCompetition: '', //done
      product: [], //done
      productScore: '', //done
      productScoreCompetition: '', //done
      photo: [], //done
      watchOut: [],
      genericQuestionsData: [],
      timeIn: null, //done
      timeOut: null, //done
      totalScore: null, //done
      totalScoreCompetition: null, //done
      pointsEarned: null, //done
      visitMaxPoints: null,
      customerNameByDC: null,
      customerLongByDC: null,
      customerLatByDC: null,
      customerPictureByDC: null,
    );
    notifyListeners();
  }

  void setProductUploads({
    required int customerId,
    required List<ProductMustItem> productUploads,
    String? productScore,
    String? productScoreCompetition,
  }) {
    final missionDetails = _missions[customerId];
    if (missionDetails == null) {
      return;
    }
    print("saaaaaaaaaaaaasasfasfasf$productScoreCompetition");
    _missions[customerId] = missionDetails.copyWith(
      product: productUploads,
      productScore: productScore ?? missionDetails.productScore,
      productScoreCompetition: productScoreCompetition,
    );

    notifyListeners();
  }

  void setPriceUploads({
    required int customerId,
    String? priceScore,
    String? priceScoreCompetition,
    required List<PriceMustItem> priceUploads,
  }) {
    final missionDetails = _missions[customerId];
    if (missionDetails == null) {
      return;
    }

    _missions[customerId] = missionDetails.copyWith(
      price: priceUploads,
      priceScore: priceScore ?? missionDetails.priceScore,
      priceScoreCompetition: priceScoreCompetition,
    );

    notifyListeners();
  }

  void setPlaceUploads({
    required int customerId,
    String? placeScore,
    String? placeScoreCompetition,
    required List<PlaceMustItem> placeUploads,
  }) {
    final missionDetails = _missions[customerId];
    if (missionDetails == null) {
      return;
    }

    _missions[customerId] = missionDetails.copyWith(
      place: placeUploads,
      placeScore: placeScore,
      placeScoreCompetition: placeScoreCompetition,
    );

    notifyListeners();
  }

  void setPromoUploads({
    required int customerId,
    String? promoScore,
    String? promoScoreCompetition,
    required List<PromoMustItem> promoUploads,
  }) {
    final missionDetails = _missions[customerId];
    if (missionDetails == null) {
      return;
    }

    _missions[customerId] = missionDetails.copyWith(
      promo: promoUploads,
      promoScore: promoScore,
      promoScoreCompetition: promoScoreCompetition,
    );

    notifyListeners();
  }

  void setPhotoUploads({
    required int customerId,
    required int categoryId,
    required String group,
    required List<PhotoUpload> photoUploads,
  }) {
    final missionDetails = _missions[customerId];
    if (missionDetails == null) {
      return;
    }

    final currentPhotos = missionDetails.photo;

    final filteredPhotos =
        currentPhotos.where((photo) {
          return !(photo.categoryId == categoryId && photo.location == group);
        }).toList();

    filteredPhotos.addAll(photoUploads);

    _missions[customerId] = missionDetails.copyWith(photo: filteredPhotos);

    notifyListeners();
  }

  void removePhotoUpload({required int customerId, required String photoPath}) {
    final missionDetails = _missions[customerId];
    if (missionDetails == null) {
      return;
    }

    final updatedPhotos =
        missionDetails.photo
            .where((photo) => photo.photo != photoPath)
            .toList();

    _missions[customerId] = missionDetails.copyWith(photo: updatedPhotos);

    notifyListeners();
  }

  void setTimeIn({required int customerId, required String timeIn}) {
    final missionDetails = _missions[customerId];
    if (missionDetails == null) {
      return;
    }

    _missions[customerId] = missionDetails.copyWith(timeIn: timeIn);
    notifyListeners();
  }

  void setTotalScoresAndTimeOut(int customerId) {
    final missionDetails = _missions[customerId];
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

    // Compute total scores
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

    _missions[customerId] = missionDetails.copyWith(
      totalScore: totalScore,
      totalScoreCompetition: totalScoreCompetition,
      timeOut: formattedTime,
      pointsEarned: 0,
    );

    notifyListeners();
    final updatedMission = _missions[customerId];
    if (updatedMission != null) {
      for (var price in updatedMission.price) {
        print("price id ${price.skuId}---${price.hasIssue}");
      }

      print("======= Mission Details for Customer $customerId =======");
      print("Product Score: ${updatedMission.productScore}");
      print("Price Score: ${updatedMission.priceScore}");
      print("Place Score: ${updatedMission.placeScore}");
      print("Promo Score: ${updatedMission.promoScore}");
      print(
        "Product Score (Competition): ${updatedMission.productScoreCompetition}",
      );
      print(
        "Price Score (Competition): ${updatedMission.priceScoreCompetition}",
      );
      print(
        "Place Score (Competition): ${updatedMission.placeScoreCompetition}",
      );
      print(
        "Promo Score (Competition): ${updatedMission.promoScoreCompetition}",
      );
      print("Total Score: ${updatedMission.totalScore}");
      print(
        "Total Score (Competition): ${updatedMission.totalScoreCompetition}",
      );
      print("Time In: ${updatedMission.timeIn}");
      print("Time Out: ${updatedMission.timeOut}");
      print("===============================================");
    }
  }
}*/
