import 'package:get_storage/get_storage.dart';
import 'package:flutter_salesman_module/models/upload/mission_upload_model.dart';

class MissionStorageHelper {
  static final _storage = GetStorage();

  // Unique key for each user
  static String _storageKey(int userId) => 'mission_$userId';

  /// Save mission by userId
  static void saveMission(int userId, MissionUploadDetails mission) {
    print('Saving mission for userId: $userId');
    print('Mission data: ${mission.toJson()}');
    _storage.write(_storageKey(userId), mission.toJson());
  }

  /// Load mission by userId
  static MissionUploadDetails? loadMission(int userId) {
    print('Loading mission for userId: $userId');
    final json = _storage.read(_storageKey(userId));
    print('Loaded data: $json');
    if (json != null && json is Map) {
      return MissionUploadDetails.fromJson(Map<String, dynamic>.from(json));
    }
    return null;
  }

  /// Clear saved mission
  static void clearMission(int userId) {
    print('Clearing mission for userId: $userId');
    _storage.remove(_storageKey(userId));
  }

  /// Check if mission exists
  static bool hasMission(int userId) {
    final exists = _storage.hasData(_storageKey(userId));
    print('Has mission for userId: $userId => $exists');
    return exists;
  }
}