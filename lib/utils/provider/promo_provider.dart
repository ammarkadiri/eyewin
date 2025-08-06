/*import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/models/upload/promo_upload_model.dart';
import 'package:flutter_salesman_module/utils/enum/price_select_type.dart';
import 'package:flutter_salesman_module/utils/provider/upload_provider.dart';

class PromoSelectionProvider with ChangeNotifier {
  final Map<String, Map<String, SelectionType?>> _customerSelections = {};
  final Map<String, Map<String, double?>> _customerEnteredPrices = {};

  double? getEnteredPrice(String customerId, String itemId) =>
      _customerEnteredPrices[customerId]?[itemId];

  SelectionType? getSelection(String customerId, String itemId) =>
      _customerSelections[customerId]?[itemId];

  void select(
    String customerId,
    String itemId,
    SelectionType? selection, {
    required MissionUploadProvider missionUploadProvider,
    required int dataCollectorUserId,
    required String visitDate,
    required List<PromoMustItem> promoItems,
  }) {
    final customerMap = _customerSelections.putIfAbsent(customerId, () => {});
    customerMap[itemId] = selection;
    final selectionStatus = _customerSelections[customerId] ?? {};
    final promoUploads =
        selectionStatus.entries
            .where((entry) => entry.value != null)
            .map(
              (entry) => PromoUpload(
                abidedBy: entry.value == SelectionType.correct ? 1 : 0,
                guidelineId: int.parse(itemId),
                visitDate: visitDate,
                dataCollectorUserId: dataCollectorUserId,
              ),
            )
            .toList();
    final promoScore = getCorrectPercentage(
      customerId: customerId,
      promoItems: promoItems,
    ).clamp(0.0, 100.0);
    final promoScoreCompetition = getCompetitionScore(
      customerId: customerId,
      promoItems: promoItems,
    ).clamp(0.0, 100.0);
    missionUploadProvider.setPromoUploads(
      customerId: int.parse(customerId),
      promoScore: promoScore.toString(),
      promoScoreCompetition: promoScoreCompetition.toString(),
      promoUploads: promoUploads,
    );
    notifyListeners();
  }

  double getCorrectPercentage({
    required String customerId,
    required List<PromoMustItem> promoItems,
  }) {
    final customerMap = _customerSelections[customerId];
    if (customerMap == null || customerMap.isEmpty) return 0;

    final nonCompetitionGuidelineIds =
        promoItems
            .where((promo) => promo.isCompetition != true)
            .expand((promo) => promo.guidelines ?? [])
            .map((guideline) => guideline.id.toString())
            .toList();

    final selected =
        nonCompetitionGuidelineIds
            .map((id) => customerMap[id])
            .where((s) => s != null)
            .toList();

    final correct = selected.where((s) => s == SelectionType.correct).length;

    if (selected.isEmpty) return 0;

    return (correct / selected.length) * 100;
  }

  double getCompetitionScore({
    required String customerId,
    required List<PromoMustItem> promoItems,
  }) {
    final customerMap = _customerSelections[customerId];
    if (customerMap == null || customerMap.isEmpty) return 0;

    // ✅ Get only competition guideline IDs
    final competitionGuidelineIds =
        promoItems
            .where((item) => item.isCompetition == true)
            .expand((item) => item.guidelines ?? [])
            .map((guideline) => guideline.id.toString())
            .toList();

    // ✅ Get selected competition guidelines
    final selected =
        competitionGuidelineIds
            .map((id) => customerMap[id])
            .where((s) => s != null)
            .toList();

    final correct = selected.where((s) => s == SelectionType.correct).length;

    if (selected.isEmpty) return 0;

    return (correct / selected.length) * 100;
  }

  bool isCompleted({
    required String customerId,
    required List<PromoMustItem> promoItems,
  }) {
    final customerMap = _customerSelections[customerId];
    if (customerMap == null || customerMap.isEmpty) return false;

    final allGuidelineIds =
        promoItems
            .expand((item) => item.guidelines ?? [])
            .map((g) => g.id.toString())
            .toList();

    final selectedCount =
        allGuidelineIds.where((id) => customerMap[id] != null).length;

    return selectedCount == allGuidelineIds.length;
  }

  int getSelectionCount(String customerId) {
    final customerMap = _customerSelections[customerId];
    if (customerMap == null) return 0;
    return customerMap.length;
  }
}*/
