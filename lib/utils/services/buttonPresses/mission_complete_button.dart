import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/upload/mission_server_upload.dart';
import 'package:flutter_salesman_module/utils/provider/get_mission_upload.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:provider/provider.dart';

/*void completeMissionClicked() {
  double productScore = 0,
      priceScore = 0,
      placeScore = 0,
      promoScore = 0,
      kpiCount = 0,
      kpiCountCompetition = 0;

  double productScoreCompetition = 0,
      priceScoreCompetition = 0,
      placeScoreCompetition = 0,
      promoScoreCompetition = 0;

  if (customer.showProduct) {
    if (productScores['PercentageScore'] != null) {
      productScore = productScores['PercentageScore'] as double;
      mission.productScore = productScore.toString();
      kpiCount++;
    } else {
      mission.productScore = null;
    }
    if (productScores['PercentageScoreCompetition'] != null) {
      productScoreCompetition =
          productScores['PercentageScoreCompetition'] as double;
      mission.productScoreCompetition = productScoreCompetition.toString();
      kpiCountCompetition++;
    } else {
      mission.productScoreCompetition = null;
    }
  } else {
    mission.productScore = null;
    mission.productScoreCompetition = null;
  }

  if (customer.showPrice) {
    if (priceScores['PercentageScore'] != null) {
      priceScore = priceScores['PercentageScore'] as double;
      mission.priceScore = priceScore.toString();
      kpiCount++;
    } else {
      mission.priceScore = null;
    }
    if (priceScores['PercentageScoreCompetition'] != null) {
      priceScoreCompetition =
          priceScores['PercentageScoreCompetition'] as double;
      mission.priceScoreCompetition = priceScoreCompetition.toString();
      kpiCountCompetition++;
    } else {
      mission.priceScoreCompetition = null;
    }
  } else {
    mission.priceScore = null;
    mission.priceScoreCompetition = null;
  }

  if (customer.showPlace) {
    if (placeScores['PercentageScore'] != null) {
      placeScore = placeScores['PercentageScore'] as double;
      mission.placeScore = placeScore.toString();
      kpiCount++;
    } else {
      mission.placeScore = null;
    }
    if (placeScores['PercentageScoreCompetition'] != null) {
      placeScoreCompetition =
          placeScores['PercentageScoreCompetition'] as double;
      mission.placeScoreCompetition = placeScoreCompetition.toString();
      kpiCountCompetition++;
    } else {
      mission.placeScoreCompetition = null;
    }
  } else {
    mission.placeScore = null;
    mission.placeScoreCompetition = null;
  }

  if (customer.showPromo) {
    if (promoScores['PercentageScore'] != null) {
      promoScore = promoScores['PercentageScore'] as double;
      mission.promoScore = promoScore.toString();
      kpiCount++;
    } else {
      mission.promoScore = null;
    }
    if (promoScores['PercentageScoreCompetition'] != null) {
      promoScoreCompetition =
          promoScores['PercentageScoreCompetition'] as double;
      mission.promoScoreCompetition = promoScoreCompetition.toString();
      kpiCountCompetition++;
    } else {
      mission.promoScoreCompetition = null;
    }
  } else {
    mission.promoScore = null;
    mission.promoScoreCompetition = null;
  }

  if (kpiCount > 0) {
    double totalScore =
        (productScore + priceScore + placeScore + promoScore) / kpiCount;
    mission.totalScore = totalScore.toString();
    mission.pointsEarned = 0;
    if (totalScore > 0 && scorePointsRanges != null) {
      for (var range in scorePointsRanges) {
        if (totalScore >= range.scoreFrom && totalScore < range.scoreTo + 1) {
          mission.pointsEarned = range.pointsEarned;
          break;
        }
      }
    }
  } else {
    mission.totalScore = null;
    mission.totalScoreCompetition = null;
  }

  if (kpiCountCompetition > 0) {
    double totalScoreCompetition =
        (productScoreCompetition +
            priceScoreCompetition +
            placeScoreCompetition +
            promoScoreCompetition) /
        kpiCountCompetition;
    mission.totalScoreCompetition = totalScoreCompetition.toString();
  } else {
    mission.totalScoreCompetition = null;
  }

  if (mission.completedDate == null || mission.completedDate!.isEmpty) {
    DBQuery.getInstance(context).setMissionCompleted(mission);
  } else if (mission.uploadedDate == null || mission.uploadedDate!.isEmpty) {
    DBQuery.getInstance(context).updateMission(mission);
    uploadMission();
  }

  loadCompleteButton();
}*/

void completeMissionPress(BuildContext context, int customerId, int userId) {
  final missionProvider = Provider.of<MissionUpload2Provider>(
    context,
    listen: false,
  );

  final missionServerProvider = Provider.of<MissionUploadServerProvider>(
    context,
    listen: false,
  );
  missionProvider.setTotalScoresAndTimeOut(
    customerId: customerId,
    userId: userId,
  );

  List<PlaceUpload> place = [];

  List<PromoUpload> promo = [];
  final mission = missionProvider.getMission(customerId, userId);
  for (var places in mission!.place) {
    for (var guidline in places.guidelines!) {
      place.add(
        PlaceUpload(
          abidedBy: guidline!.abidedBy,
          dataCollectorUserId: userId,
          guidelineId: guidline.guidelineId,
          visitDate: guidline.visitDate,
        ),
      );
    }
  }
  for (var promos in mission.promo) {
    for (var guidline in promos.guidelines!) {
      promo.add(
        PromoUpload(
          abidedBy: guidline.abidedBy,
          dataCollectorUserId: userId,
          guidelineId: guidline.guidelineId,
          visitDate: guidline.visitDate,
        ),
      );
    }
  }
  final price =
      mission.price
          .map(
            (p) => PriceUpload(
              dataCollectorUserId: p.dataCollectorUserId,
              hasIssue: p.hasIssue,
              skuId: p.skuId,
              visitDate: p.visitDate,
              Price: p.price.toString(),
            ),
          )
          .toList();

  final product =
      mission.product
          .map(
            (p) => ProductUpload(
              dataCollectorUserId: userId,
              available: p.available,
              skuId: p.skuId,
              visitDate: p.visitDate,
            ),
          )
          .toList();
  final photo =
      mission.photo
          .map(
            (p) => PhotoUpload(
              dataCollectorUserId: userId.toString(),
              categoryId: p.categoryId.toString(),
              photo: p.photo,
              photoBase64: p.photoBase64, // Include base64 data
              visitDate: p.visitDate,
              location: p.location,
            ),
          )
          .toList();

  final visitDate = DateTime.now().toUtc().toIso8601String();
  final missionReady = MissionUploadServerModel(
    customerId: customerId,
    dataCollectorUserId: userId,
    visitDate: visitDate,
    timeIn: mission.timeIn,
    timeOut: mission.timeOut,
    customerLatByDC: mission.customerLatByDC,
    customerLongByDC: mission.customerLongByDC,
    customerNameByDC: mission.customerNameByDC,
    customerPictureByDC: mission.customerPictureByDC,
    pointsEarned: 0,
    totalScore: mission.totalScore,
    visitMaxPoints: 0,
    totalScoreCompetition: mission.totalScoreCompetition,
    productScoreCompetition: mission.productScoreCompetition,
    price: price,
    priceScore: mission.priceScore,
    priceScoreCompetition: mission.priceScoreCompetition,
    place: place,
    placeScore: mission.placeScore,
    placeScoreCompetition: mission.placeScoreCompetition,
    promo: promo,
    promoScore: mission.promoScore,
    promoScoreCompetition: mission.promoScoreCompetition,
    product: product,
    productScore: mission.productScore,
    photo: photo,
    watchOut: [],
    genericQuestionsData: [],
  );
  missionServerProvider.addMissionReady(missionReady);
}
