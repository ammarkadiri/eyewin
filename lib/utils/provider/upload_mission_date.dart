import 'package:flutter/material.dart';

class MissionUploadDateProvider extends ChangeNotifier {
  final Map<int, DateTime> _uploadDates = {};

  // Get upload date for customerId
  DateTime? getUploadDateForCustomer(int customerId) {
    final date = _uploadDates[customerId];

    return date;
  }

  // Set upload date for customerId
  void setUploadDateForCustomer(int customerId, DateTime uploadDate) {
    _uploadDates[customerId] = uploadDate;
    notifyListeners();
  }

  // Remove upload date for customerId
  void removeUploadDateForCustomer(int customerId) {
    if (_uploadDates.containsKey(customerId)) {
      _uploadDates.remove(customerId);
      notifyListeners();
    }
  }
}
