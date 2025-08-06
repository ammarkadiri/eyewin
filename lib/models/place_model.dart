import 'package:flutter_salesman_module/models/guidline_model.dart';

class PlaceMustItem {
  final int? groupId;
  final String? name;
  final DateTime? startDate;
  final DateTime? expiryDate;
  final String? location;
  final int? categoryId;
  final String? categoryName;
  final String? thumbnail;
  final String? pdf;
  final bool? isCompetition;
  final List<Guideline?>? guidelines;
  final List<int>? channelId;
  final List<String>? channelName;

  PlaceMustItem({
    this.groupId,
    this.name,
    this.startDate,
    this.expiryDate,
    this.location,
    this.categoryId,
    this.categoryName,
    this.thumbnail,
    this.pdf,
    this.isCompetition,
    this.guidelines,
    this.channelId,
    this.channelName,
  });

  factory PlaceMustItem.fromJson(Map<String, dynamic> json) {
    return PlaceMustItem(
      groupId: json['GroupId'],
      name: json['Name'],
      startDate:
          json['StartDate'] != null
              ? DateTime.tryParse(json['StartDate'])
              : null,
      expiryDate:
          json['ExpiryDate'] != null
              ? DateTime.tryParse(json['ExpiryDate'])
              : null,
      location: json['Location'],
      categoryId: json['CategoryId'],
      categoryName: json['CategoryName'],
      thumbnail: json['Thumbnail'],
      pdf: json['PDF'],
      isCompetition: json['IsCompetition'],
      guidelines:
          (json['Guidelines'] as List<dynamic>?)
              ?.map((item) => Guideline.fromJson(item))
              .toList(),
      channelId: (json['ChannelId'] as List?)?.map((e) => e as int).toList(),
      channelName:
          (json['ChannelName'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GroupId': groupId,
      'Name': name,
      'StartDate': startDate?.toIso8601String(),
      'ExpiryDate': expiryDate?.toIso8601String(),
      'Location': location,
      'CategoryId': categoryId,
      'CategoryName': categoryName,
      'Thumbnail': thumbnail,
      'PDF': pdf,
      'IsCompetition': isCompetition,
      'Guidelines': guidelines?.map((e) => e!.toJson()).toList(),
      'ChannelId': channelId,
      'ChannelName': channelName,
    };
  }

  PlaceMustItem copyWith({
    int? groupId,
    String? name,
    DateTime? startDate,
    DateTime? expiryDate,
    String? location,
    int? categoryId,
    String? categoryName,
    String? thumbnail,
    String? pdf,
    bool? isCompetition,
    List<Guideline?>? guidelines,
    List<int>? channelId,
    List<String>? channelName,
  }) {
    return PlaceMustItem(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      expiryDate: expiryDate ?? this.expiryDate,
      location: location ?? this.location,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      thumbnail: thumbnail ?? this.thumbnail,
      pdf: pdf ?? this.pdf,
      isCompetition: isCompetition ?? this.isCompetition,
      guidelines: guidelines ?? this.guidelines,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
    );
  }
}
