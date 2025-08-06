/*import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart'; 
import 'package:flutter_salesman_module/utils/provider/upload_provider.dart';

class ProductSelectionProvider with ChangeNotifier {
  final Map<String, Map<int, bool?>> _selectionStatusByCustomer = {};
  final Set<String> _initializedCustomers = {};

  Map<int, bool?> getSelectionStatus(String customerId) =>
      _selectionStatusByCustomer[customerId] ?? {};

  bool? getSelection(String customerId, int id) =>
      _selectionStatusByCustomer[customerId]?[id];

  void toggleSelection(
    String customerId,
    int id,

    List<int> groupProductIds, {
    required MissionUploadProvider missionUploadProvider,
    required int dataCollectorUserId,
    required String visitDate,
    required List<ProductMustItem> productItems,
  }) {
    final map = _selectionStatusByCustomer.putIfAbsent(customerId, () => {});
    final current = map[id];

    if (current == true) {
      map[id] = false;
    } else if (current == false) {
      map[id] = true;
    } else if (current == null) {
      final allNull = groupProductIds.every((groupId) => map[groupId] == null);

      if (allNull) {
        for (var groupId in groupProductIds) {
          map[groupId] = (groupId == id) ? false : true;
        }
      } else {
        map[id] = false;
      }
    }

    notifyListeners();

    final selectionStatus = getSelectionStatus(customerId);

    final productUploads =
        selectionStatus.entries
            .where((entry) => entry.value != null)
            .map(
              (entry) => ProductMustItem(
                available: entry.value == true ? 1 : 0,
                visitDate: visitDate,
                dataCollectorUserId: dataCollectorUserId,
              ),
            )
            .toList();
    final productScore =
        getNormalizedTruePercentage(customerId, productItems) * 100;
    final productScoreCompetition = getCompetitionPercentage(
      customerId,
      productItems,
    );
    missionUploadProvider.setProductUploads(
      customerId: int.parse(customerId),
      productUploads: productUploads,
      productScore: productScore.toString(),
      productScoreCompetition: productScoreCompetition.toString(),
    );
  }

  void initializeSelection(String customerId, List<int> productIds) {
    if (_initializedCustomers.contains(customerId)) return;

    final map = _selectionStatusByCustomer.putIfAbsent(customerId, () => {});
    map.clear();
    for (var id in productIds) {
      map[id] = null;
    }
    _initializedCustomers.add(customerId);
    notifyListeners();
  }

  void addGroupSelection(
    String customerId,
    List<int> groupProductIds, {
    required MissionUploadProvider missionUploadProvider,
    required int dataCollectorUserId,
    required String visitDate,
    required List<ProductMustItem> productItems,
  }) {
    final map = _selectionStatusByCustomer.putIfAbsent(customerId, () => {});
    for (var id in groupProductIds) {
      if (map[id] != true) {
        map[id] = true;
      }
    }
    final selectionStatus = _selectionStatusByCustomer[customerId]!;
    final productUploads =
        selectionStatus.entries
            .where((entry) => entry.value != null)
            .map(
              (entry) => ProductMustItem(
                // skuId: entry.key,
                available: entry.value == true ? 1 : 0,
                visitDate: visitDate,
                dataCollectorUserId: dataCollectorUserId,
              ),
            )
            .toList();
    final productScore =
        getNormalizedTruePercentage(customerId, productItems) * 100;
    missionUploadProvider.setProductUploads(
      customerId: int.parse(customerId),
      productUploads: productUploads,
      productScore: productScore.toString(),
    );
    notifyListeners();
  }

  void resetSelection(String customerId) {
    _selectionStatusByCustomer.remove(customerId);
    _initializedCustomers.remove(customerId);
    notifyListeners();
  }

  double getTruePercentage(
    String customerId,
    List<ProductMustItem> productItems,
  ) {
    final selectionMap = _selectionStatusByCustomer[customerId] ?? {};
    [customerId];
    if (selectionMap.isEmpty) return 0;

    final nonCompetitionProductIds =
        productItems
            .where((item) => item.isCompetition != true)
            .map((item) => item.id)
            .toSet();

    final selected =
        nonCompetitionProductIds
            .map((id) => selectionMap[id])
            .where((v) => v != null)
            .toList();

    final trueCount = selected.where((v) => v == true).length;
    if (selected.isEmpty) return 0;

    return (trueCount / selected.length) * 100;
  }

  double? getCompetitionPercentage(
    String customerId,
    List<ProductMustItem> productItems,
  ) {
    final selectionMap = _selectionStatusByCustomer[customerId] ?? {};
    print('Selection map for customer [$customerId]: $selectionMap');
    if (selectionMap.isEmpty) {
      print('Selection map is empty, returning null');
      return null;
    }

    final competitionProductIds =
        productItems
            .where((item) => item.isCompetition == true)
            .map((item) => item.id)
            .toSet();
    print('Competition Product IDs: $competitionProductIds');

    final selected =
        competitionProductIds
            .map((id) => selectionMap[id])
            .where((v) => v != null)
            .toList();
    print('Selected values: $selected');

    final trueCount = selected.where((v) => v == true).length;
    print('True count: $trueCount / Total selected: ${selected.length}');

    if (selected.isEmpty) {
      print('No selected competition products, returning null');
      return null;
    }

    final percentage = (trueCount / selected.length) * 100;
    print('Competition Percentage: $percentage%');

    return percentage;
  }

  double getNormalizedTruePercentage(
    String customerId,
    List<ProductMustItem> productItems,
  ) {
    return (getTruePercentage(customerId, productItems) / 100).clamp(0.0, 1.0);
  }

  bool isCompleted(String customerId) {
    final map = _selectionStatusByCustomer[customerId];
    if (map == null || map.isEmpty) return false;
    return map.values.every((v) => v != null);
  }
}
*/