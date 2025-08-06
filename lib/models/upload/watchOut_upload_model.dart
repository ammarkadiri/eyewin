class WatchoutUpload {
  final int categoryId;
  final int brandId;
  final dynamic activityTypeId; // int or empty string
  final int customerId;
  final dynamic price; // double or empty string
  final String description;
  final int dataCollectorUserId;
  final String visitDate;
  final int eventId;
  final List<WatchoutPicture> pictures;

  WatchoutUpload({
    required this.categoryId,
    required this.brandId,
    required this.activityTypeId,
    required this.customerId,
    required this.price,
    required this.description,
    required this.dataCollectorUserId,
    required this.visitDate,
    required this.eventId,
    required this.pictures,
  });

  factory WatchoutUpload.fromJson(Map<String, dynamic> json) {
    return WatchoutUpload(
      categoryId: json['CategoryId'] ?? 0,
      brandId: json['BrandId'] ?? 0,
      activityTypeId: json['ActivityTypeId'],
      customerId: json['CustomerId'] ?? 0,
      price: json['Price'],
      description: json['Description'] ?? '',
      dataCollectorUserId: json['DataCollectorUserId'] ?? 0,
      visitDate: json['VisitDate'] ?? '',
      eventId: json['EventId'] ?? 0,
      pictures:
          (json['Pictures'] as List<dynamic>?)
              ?.map((e) => WatchoutPicture.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CategoryId": categoryId,
      "BrandId": brandId,
      "ActivityTypeId": activityTypeId,
      "CustomerId": customerId,
      "Price": price,
      "Description": description,
      "DataCollectorUserId": dataCollectorUserId,
      "VisitDate": visitDate,
      "EventId": eventId,
      "Pictures": pictures.map((e) => e.toJson()).toList(),
    };
  }
}

class WatchoutPicture {
  final String photo;

  WatchoutPicture({required this.photo});

  factory WatchoutPicture.fromJson(Map<String, dynamic> json) {
    return WatchoutPicture(photo: json['Photo'] ?? '');
  }

  Map<String, dynamic> toJson() => {'Photo': photo};
}
