import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/upload/mission_server_upload.dart';

class MissionUploadServerProvider with ChangeNotifier {
  final List<MissionUploadServerModel> _missionReadyList = [];

  List<MissionUploadServerModel> get missionReadyList => _missionReadyList;
  MissionUploadServerModel? getMission(int customerId, int userId) {
    try {
      return _missionReadyList.firstWhere(
        (m) => m.customerId == customerId && m.dataCollectorUserId == userId,
      );
    } catch (e) {
      return null;
    }
  }

  void addMissionReady(MissionUploadServerModel mission) {
    _missionReadyList.add(mission);
    notifyListeners();
  }

  void clearMissionReady() {
    _missionReadyList.clear();
    notifyListeners();
  }

 }
