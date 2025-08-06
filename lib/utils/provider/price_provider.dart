/*import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/upload/price_upload_model.dart';
import 'package:flutter_salesman_module/utils/enum/price_select_type.dart';
import 'package:flutter_salesman_module/utils/provider/upload_provider.dart';

import '../../models/price_model.dart';

class PriceSelectionProvider with ChangeNotifier {
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
    required List<PriceMustItem> priceItems,
  }) {
    final customerMap = _customerSelections.putIfAbsent(customerId, () => {});
    customerMap[itemId] = selection;

    final selectionStatus = _customerSelections[customerId] ?? {};

    final priceUploads =
        selectionStatus.entries
            .where((entry) => entry.value != null)
            .map(
              (entry) => PriceMustItem(
                skuId: int.tryParse(entry.key) ?? 0,
                hasIssue: entry.value == SelectionType.correct ? 0 : 1,
                price: _customerEnteredPrices[customerId]?[entry.key],
                visitDate: visitDate,
                dataCollectorUserId: dataCollectorUserId,
              ),
            )
            .toList();
    final perc = getCorrectPercentageWithOutCom(customerId, priceItems);
    final compScore = getCorrectCompetitionPercentage(customerId, priceItems);
    missionUploadProvider.setPriceUploads(
      customerId: int.parse(customerId),
      priceUploads: priceUploads,
      priceScore: perc.toString(),
      priceScoreCompetition: compScore.toString(),
    );

    notifyListeners();
  }

  void setSelectionWithPrice(
    String customerId,
    String itemId,
    SelectionType? selection,
    double? price, {
    required MissionUploadProvider missionUploadProvider,
    required int dataCollectorUserId,
    required String visitDate,
    required List<PriceMustItem> priceItems,
  }) {
    final customerMap = _customerSelections.putIfAbsent(customerId, () => {});
    customerMap[itemId] = selection;

    final priceMap = _customerEnteredPrices.putIfAbsent(customerId, () => {});
    priceMap[itemId] = price;

    final selectionStatus = _customerSelections[customerId] ?? {};
    final priceUploads =
        selectionStatus.entries
            .map(
              (entry) => PriceMustItem(
                skuId: int.tryParse(entry.key) ?? 0,
                hasIssue:
                    entry.value == null
                        ? null
                        : (entry.value == SelectionType.correct ? 0 : 1),
                price: _customerEnteredPrices[customerId]?[entry.key],
                visitDate: visitDate,
                dataCollectorUserId: dataCollectorUserId,
              ),
            )
            .toList();
    final perc = getCorrectPercentageWithOutCom(customerId, priceItems);
    final compScore = getCorrectCompetitionPercentage(customerId, priceItems);
    missionUploadProvider.setPriceUploads(
      customerId: int.parse(customerId),
      priceUploads: priceUploads,
      priceScore: perc.toString(),
      priceScoreCompetition: compScore.toString(),
    );

    notifyListeners();
  }

  double getCorrectPercentage(String customerId) {
    final customerMap = _customerSelections[customerId];
    if (customerMap == null || customerMap.isEmpty) return 0;

    final selected = customerMap.values.where((s) => s != null).toList();
    final correct = selected.where((s) => s == SelectionType.correct).length;

    if (selected.isEmpty) return 0;

    return (correct / selected.length) * 100;
  }

  double getCorrectPercentageWithOutCom(
    String customerId,
    List<PriceMustItem> priceItems,
  ) {
    final customerMap = _customerSelections[customerId];

    if (customerMap == null || customerMap.isEmpty) {
      return 0;
    }
    final itemById = {
      for (var item in priceItems)
        if (item.id != null) item.id!: item,
    };

    int correctCount = 0;
    int totalNonCompSelected = 0;

    for (var entry in customerMap.entries) {
      final id = int.tryParse(entry.key);
      final selection = entry.value;

      if (id == null || selection == null) continue;

      final item = itemById[id];
      if (item == null) continue;

      if (item.isCompetition != true) {
        totalNonCompSelected++;

        if (selection == SelectionType.correct) {
          correctCount++;
        }
      }
    }

    if (totalNonCompSelected == 0) {
      return 0;
    }

    final percentage = (correctCount / totalNonCompSelected) * 100;

    return percentage;
  }

  double getCorrectCompetitionPercentage(
    String customerId,
    List<PriceMustItem> priceItems,
  ) {
    final customerMap = _customerSelections[customerId];

    if (customerMap == null || customerMap.isEmpty) {
      return 0;
    }

    final itemById = {
      for (var item in priceItems)
        if (item.id != null) item.id!: item,
    };

    int correctCount = 0;
    int totalCompSelected = 0;

    for (var entry in customerMap.entries) {
      final id = int.tryParse(entry.key);
      final selection = entry.value;

      if (id == null || selection == null) continue;

      final item = itemById[id];
      if (item == null) continue;

      if (item.isCompetition == true) {
        totalCompSelected++;

        if (selection == SelectionType.correct) {
          correctCount++;
        }
      }
    }

    if (totalCompSelected == 0) {
      return 0;
    }

    final percentage = (correctCount / totalCompSelected) * 100;

    return percentage;
  }

  int getSelectionCount(String customerId) {
    final customerMap = _customerSelections[customerId];
    if (customerMap == null) return 0;
    return customerMap.length;
  }
}*/
