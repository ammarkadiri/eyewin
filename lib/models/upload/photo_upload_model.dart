class PhotoUpload {
  final String visitDate;
  final String photo;
  final int categoryId;
  final String location;
  final int dataCollectorUserId;

  PhotoUpload({
    required this.visitDate,
    required this.photo,
    required this.categoryId,
    required this.location,
    required this.dataCollectorUserId,
  });

  factory PhotoUpload.fromJson(Map<String, dynamic> json) {
    return PhotoUpload(
      visitDate: json['VisitDate'] ?? '',
      photo: json['Photo'] ?? '',
      categoryId: json['CategoryId'] ?? 0,
      location: json['Location'] ?? '',
      dataCollectorUserId: json['DataCollectorUserId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "VisitDate": visitDate,
      "Photo": photo,
      "CategoryId": categoryId,
      "Location": location,
      "DataCollectorUserId": dataCollectorUserId,
    };
  }
}
