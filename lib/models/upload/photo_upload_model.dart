import 'package:image_picker/image_picker.dart';

class PhotoUpload {
  final String visitDate;
  final XFile photo;
  final String? photoBase64; // Added for base64 storage
  final int categoryId;
  final String location;
  final int dataCollectorUserId;

  PhotoUpload({
    required this.visitDate,
    required this.photo,
    this.photoBase64,
    required this.categoryId,
    required this.location,
    required this.dataCollectorUserId,
  });

  factory PhotoUpload.fromJson(Map<String, dynamic> json) {
    // Handle the photo field - convert string path to XFile
    final photoPath = json['Photo'] ?? '';
    final xFile = photoPath.isNotEmpty ? XFile(photoPath) : XFile('');

    return PhotoUpload(
      visitDate: json['VisitDate'] ?? '',
      photo: xFile,
      photoBase64: json['PhotoBase64'],
      categoryId: json['CategoryId'] ?? 0,
      location: json['Location'] ?? '',
      dataCollectorUserId: json['DataCollectorUserId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "VisitDate": visitDate,
      "Photo":
          photoBase64 ??
          photo.path, // Use base64 if available, otherwise use path
      "PhotoBase64": photoBase64,
      "CategoryId": categoryId,
      "Location": location,
      "DataCollectorUserId": dataCollectorUserId,
    };
  }
}
