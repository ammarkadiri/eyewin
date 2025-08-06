/*import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/upload/photo_upload_model.dart';
import 'package:flutter_salesman_module/utils/provider/upload_provider.dart';

class CapturedImagesProvider extends ChangeNotifier {
  final Map<int, Map<int, Map<String, List<PhotoUpload>>>> _images = {};

  Map<int, Map<int, Map<String, List<PhotoUpload>>>> get allImages => _images;

  void addImage(
    int customerId,
    String group,
    int index,
    String imagePath, {
    required MissionUploadProvider missionUploadProvider,
    required int dataCollectorUserId,
    required String visitDate,
    required int categoryId,
  }) {
    final photo = PhotoUpload(
      categoryId: categoryId,
      dataCollectorUserId: dataCollectorUserId,
      location: group,
      photo: imagePath,
      visitDate: visitDate,
    );

    _images.putIfAbsent(customerId, () => {});
    _images[customerId]!.putIfAbsent(categoryId, () => {});
    _images[customerId]![categoryId]!.putIfAbsent(group, () => []);
    _images[customerId]![categoryId]![group]!.add(photo);
    debugPrint('📷 Added Image: $imagePath');
    debugPrint('🧾 Current Image List:');
    _images.forEach((custId, categories) {
      categories.forEach((catId, groups) {
        groups.forEach((grp, photos) {
          for (var img in photos) {
            debugPrint(
              '➡️ customerId: $custId | categoryId: $catId | group: $grp | image: ${img.photo}',
            );
          }
        });
      });
    });
    missionUploadProvider.setPhotoUploads(
      customerId: customerId,
      categoryId: categoryId,
      group: group,
      photoUploads: _images[customerId]![categoryId]![group]!,
    );
    notifyListeners();
  }

  int getTotalImagesByCustomer(int customerId) {
    if (!_images.containsKey(customerId)) return 0;

    int total = 0;

    _images[customerId]!.forEach((categoryId, groupMap) {
      groupMap.forEach((group, photos) {
        total += photos.length;
      });
    });

    return total;
  }

  List<PhotoUpload> getImagesByCustomerCategoryGroup(
    int customerId,
    int categoryId,
    String group,
  ) {
    return _images[customerId]?[categoryId]?[group] ?? [];
  }

  void removeImage(
    int customerId,
    int categoryId,
    String group,
    String imagePath,
    MissionUploadProvider missionUploadProvider,
  ) {
    _images[customerId]?[categoryId]?[group]?.removeWhere(
      (img) => img.photo == imagePath,
    );
    missionUploadProvider.removePhotoUpload(
      customerId: customerId,
      photoPath: imagePath,
    );
    notifyListeners();
  }

  void clearImagesForCustomer(int customerId) {
    _images.remove(customerId);
    notifyListeners();
  }
}
*/
