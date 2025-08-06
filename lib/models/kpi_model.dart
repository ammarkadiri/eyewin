import 'package:flutter/material.dart';

class KPIModel {
  final String? kpiId;
  final String? title;
  final Map<String, dynamic>? scores;
  final bool? showPercentages;
  final bool? kpiCompleted;
  final String? description;
  final Color? backgroundStart; // First color
  final Color? backgroundMid;
  final Color? background;
  final Type? kpiClass;
  final bool? isTotalAll;

  KPIModel({
    this.kpiId,
    this.title,
    this.scores,
    this.showPercentages,
    this.kpiCompleted,
    this.description,
    this.backgroundStart,
    this.backgroundMid,
    this.background,
    this.kpiClass,
    this.isTotalAll,
  });

  factory KPIModel.fromJson(Map<String, dynamic> json) {
    return KPIModel(
      kpiId: json['kpiId'],
      title: json['title'],
      scores:
          json['scores'] != null
              ? Map<String, dynamic>.from(json['scores'])
              : null,
      showPercentages: json['showPercentages'],
      kpiCompleted: json['kpiCompleted'],
      description: json['description'],
      backgroundStart:
          json['backgroundStart'] != null
              ? Color(json['backgroundStart'])
              : null,
      backgroundMid:
          json['backgroundMid'] != null ? Color(json['backgroundMid']) : null,
      background: json['background'] != null ? Color(json['background']) : null,
      kpiClass: null,
      isTotalAll: json['isTotalAll'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kpiId': kpiId,
      'title': title,
      'scores': scores,
      'showPercentages': showPercentages,
      'kpiCompleted': kpiCompleted,
      'description': description,
      'backgroundStart': backgroundStart?.value,
      'backgroundMid': backgroundMid?.value,
      'background': background?.value,
      'isTotalAll': isTotalAll,
    };
  }
}
