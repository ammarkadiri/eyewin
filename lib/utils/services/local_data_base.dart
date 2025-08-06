import 'package:flutter_salesman_module/models/upload/mission_upload_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalDataBase {
  final box = GetStorage();

  Future<void> saveOrUpdateMission(MissionUploadDetails newMission) async {
    try {
      print(
        '🔄 Starting saveOrUpdateMission for customerId: ${newMission.customerId}, dataCollectorUserId: ${newMission.dataCollectorUserId}',
      );
      final jsonList = box.read<List<dynamic>>('missions') ?? [];
      print('📥 Loaded missions count from storage: ${jsonList.length}');

      List<MissionUploadDetails> missions =
          jsonList
              .map(
                (e) => MissionUploadDetails.fromJson(e as Map<String, dynamic>),
              )
              .toList();

      print('📊 Deserialized missions count: ${missions.length}');
      final index = missions.indexWhere(
        (m) =>
            m.customerId == newMission.customerId &&
            m.dataCollectorUserId == newMission.dataCollectorUserId,
      );

      if (index == -1) {
        print('➕ Adding new mission');
        missions.add(newMission);
      } else {
        print('✏️ Updating existing mission at index $index');
        missions[index] = newMission;
      }

      await box.write('missions', missions.map((m) => m.toJson()).toList());
      print(
        '✅ Missions saved successfully. Total missions now: ${missions.length}',
      );
    } catch (e) {
      print('❌ Error saving missions: $e');
    }
  }

  Future<List<MissionUploadDetails>> loadMissions() async {
    try {
      final jsonList = box.read<List<dynamic>>('missions') ?? [];
      final missions =
          jsonList
              .map(
                (e) => MissionUploadDetails.fromJson(e as Map<String, dynamic>),
              )
              .toList();

      print('✅ Loaded ${missions.length} missions from local storage.');

      for (var i = 0; i < missions.length; i++) {
        final mission = missions[i];
        print('--- Mission #$i ---');
        print('CustomerId: ${mission.customerId}');
        print('DataCollectorUserId: ${mission.dataCollectorUserId}');
        print('Product Count: ${mission.product.length}');
        print('Product Score: ${mission.productScore}');
        print('Product Competition Score: ${mission.productScoreCompetition}');

        for (var j = 0; j < mission.product.length; j++) {
          final product = mission.product[j];
          print(
            '  Product #$j: id=${product.id}, available=${product.available}, isCompetition=${product.isCompetition}',
          );
        }

        print('Price Count: ${mission.price.length}');
        print('Price Score: ${mission.priceScore}');
        print('Price Competition Score: ${mission.priceScoreCompetition}');
        for (var j = 0; j < mission.price.length; j++) {
          final price = mission.price[j];
          print('  Price #$j: id=${price.id}, available=${price.hasIssue}');
        }

        print('Place Count: ${mission.place.length}');
        for (var j = 0; j < mission.place.length; j++) {
          final place = mission.place[j];
          print('  Place #$j: id=${place.name}, available=${place.thumbnail}');
        }

        print('Promo Count: ${mission.promo.length}');
        for (var j = 0; j < mission.promo.length; j++) {
          final promo = mission.promo[j];
          print('  Promo #$j: id=${promo.name}, available=${promo.thumbnail}');
        }

        print('------------------');
      }

      return missions;
    } catch (e) {
      print('❌ Error loading missions: $e');
      return [];
    }
  }
}
