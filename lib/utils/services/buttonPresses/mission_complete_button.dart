import 'package:flutter/material.dart'; 
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
  missionProvider.setTotalScoresAndTimeOut(
    customerId: customerId,
    userId: userId,
  );

  //missionProvider.setTotalScoresAndTimeOut(customerId);

  /* final mission = missionProvider.getMission(customerId);
  if (kpiList.isEmpty) return;

  final hasKpiId1 = kpiList.any((kpi) => kpi.kpiId == '1');
  final hasKpiId2 = kpiList.any((kpi) => kpi.kpiId == '2');
  final hasKpiId3 = kpiList.any((kpi) => kpi.kpiId == '3');
  final hasKpiId4 = kpiList.any((kpi) => kpi.kpiId == '4');

  double? productScore,
      priceScore,
      placeScore,
      promoScore,
      kpiCount = 0,
      kpiCountCompetition = 0,
      priceScoreCompetition,
      placeScoreCompetition,
      totalScore,
      totalScoreCompitition,
      promoScoreCompetition;

  double? productScoreCompetition;

  /// Product (kpiId = 1)
  if (hasKpiId1 && mission != null) {
    final ps = mission.productScore;
    if (ps.isNotEmpty) {
      productScore = double.tryParse(ps) ?? 0;
      kpiCount++;
    } else {
      productScore = null;
    }

    final psc = mission.productScoreCompetition;
    if (psc != null && psc.isNotEmpty) {
      productScoreCompetition = double.tryParse(psc);
      kpiCountCompetition++;
    } else {
      productScoreCompetition = null;
    }
  } else {
    productScore = null;
    productScoreCompetition = null;
  }

  /// Price (kpiId = 2)
  if (hasKpiId2 && mission != null) {
    final ps = mission.priceScore;
    if (ps.isNotEmpty) {
      priceScore = double.tryParse(ps) ?? 0;
      kpiCount++;
    } else {
      priceScore = null;
    }

    final psc = mission.priceScoreCompetition;
    if (psc.isNotEmpty) {
      priceScoreCompetition = double.tryParse(psc);
      kpiCountCompetition++;
    } else {
      priceScoreCompetition = null;
    }
  } else {
    priceScore = null;
    priceScoreCompetition = null;
  }

  /// Place (kpiId = 3)
  if (hasKpiId3 && mission != null) {
    final ps = mission.placeScore;
    if (ps.isNotEmpty) {
      placeScore = double.tryParse(ps) ?? 0;
      kpiCount++;
    } else {
      placeScore = null;
    }

    final psc = mission.placeScoreCompetition;
    if (psc.isNotEmpty) {
      placeScoreCompetition = double.tryParse(psc);
      kpiCountCompetition++;
    } else {
      placeScoreCompetition = null;
    }
  } else {
    placeScore = null;
    placeScoreCompetition = null;
  }

  /// Promo (kpiId = 4)
  if (hasKpiId4 && mission != null) {
    final ps = mission.promoScore;
    if (ps.isNotEmpty) {
      promoScore = double.tryParse(ps) ?? 0;
      kpiCount++;
    } else {
      promoScore = null;
    }

    final psc = mission.promoScoreCompetition;
    if (psc.isNotEmpty) {
      promoScoreCompetition = double.tryParse(psc);
      kpiCountCompetition++;
    } else {
      promoScoreCompetition = null;
    }
  } else {
    promoScore = null;
    promoScoreCompetition = null;
  }

  if (kpiCount > 0) {
    totalScore =
        (productScore ?? 0) +
        (priceScore ?? 0) +
        (placeScore ?? 0) +
        (promoScore ?? 0);

    totalScore = totalScore / kpiCount;
  }
  if (kpiCountCompetition > 0) {
    totalScoreCompitition =
        (productScoreCompetition ?? 0) +
        (priceScoreCompetition ?? 0) +
        (placeScoreCompetition ?? 0) +
        (promoScoreCompetition ?? 0);
    totalScoreCompitition = totalScoreCompitition / kpiCountCompetition;
  }*/
}
