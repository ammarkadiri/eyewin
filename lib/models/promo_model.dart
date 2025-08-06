import 'package:flutter_salesman_module/models/guidline_model.dart';

class PromoMustItem {
  final int? groupId;
  final String? name;
  final DateTime? expiryDate;
  final int? categoryId;
  final String? categoryName;
  final String? thumbnail;
  final String? pdf;
  final bool? isCompetition;
  final List<Guideline>? guidelines;

  PromoMustItem({
    this.groupId,
    this.name,
    this.expiryDate,
    this.categoryId,
    this.categoryName,
    this.thumbnail,
    this.pdf,
    this.isCompetition,
    this.guidelines,
  });

  factory PromoMustItem.fromJson(Map<String, dynamic> json) {
    return PromoMustItem(
      groupId: json['GroupId'],
      name: json['Name'],
      expiryDate:
          json['ExpiryDate'] != null
              ? DateTime.tryParse(json['ExpiryDate'])
              : null,
      categoryId: json['CategoryId'],
      categoryName: json['CategoryName'],
      thumbnail: json['Thumbnail'],
      pdf: json['PDF'],
      isCompetition: json['IsCompetition'],
      guidelines:
          (json['Guidelines'] as List<dynamic>?)
              ?.map((e) => Guideline.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GroupId': groupId,
      'Name': name,
      'ExpiryDate': expiryDate?.toIso8601String(),
      'CategoryId': categoryId,
      'CategoryName': categoryName,
      'Thumbnail': thumbnail,
      'PDF': pdf,
      'IsCompetition': isCompetition,
      'Guidelines': guidelines?.map((e) => e.toJson()).toList(),
    };
  }
}
