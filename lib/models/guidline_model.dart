class Guideline {
  final int? id;
  final int? guidelineId;
  final String? description;
  final String? pdf;
  final String? thumbnail;
  bool? isCompetition;
  final String? groupThumbnail;
  final List<int>? channelId;
  final List<String>? channelName;
  final int? groupId;
  final String? groupName;
  int? abidedBy;
  final String? visitDate;
  int? dataCollectorUserId;

  Guideline({
    this.id,
    this.guidelineId,
    this.description,
    this.pdf,
    this.thumbnail,
    this.isCompetition,
    this.groupThumbnail,
    this.channelId,
    this.channelName,
    this.groupId,
    this.groupName,
    this.abidedBy,
    this.visitDate,
    this.dataCollectorUserId,
  });

  factory Guideline.fromJson(Map<String, dynamic> json) {
    return Guideline(
      id: json['Id'],
      guidelineId: json['GuidelineId'],
      description: json['Description'],
      pdf: json['PDF'],
      thumbnail: json['Thumbnail'],
      isCompetition: json['IsCompetition'], // ✅ fixed casing
      groupThumbnail: json['GroupThumbnail'],
      channelId:
          json['ChannelId'] != null ? List<int>.from(json['ChannelId']) : null,
      channelName:
          json['ChannelName'] != null
              ? List<String>.from(json['ChannelName'])
              : null,
      groupId: json['GroupId'],
      groupName: json['GroupName'],
      abidedBy: json['AbidedBy'],
      visitDate: json['VisitDate'],
      dataCollectorUserId: json['DataCollectorUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'GuidelineId': guidelineId,
      'Description': description,
      'PDF': pdf,
      'Thumbnail': thumbnail,
      'IsCompetition': isCompetition, // ✅ fixed casing
      'GroupThumbnail': groupThumbnail,
      'ChannelId': channelId,
      'ChannelName': channelName,
      'GroupId': groupId,
      'GroupName': groupName,
      'AbidedBy': abidedBy,
      'VisitDate': visitDate,
      'DataCollectorUserId': dataCollectorUserId,
    };
  }

  Guideline copyWith({
    int? id,
    int? guidelineId,
    String? description,
    String? pdf,
    String? thumbnail,
    bool? isCompetition,
    String? groupThumbnail,
    List<int>? channelId,
    List<String>? channelName,
    int? groupId,
    String? groupName,
    int? abidedBy,
    String? visitDate,
    int? dataCollectorUserId,
  }) {
    return Guideline(
      id: id ?? this.id,
      guidelineId: guidelineId ?? this.guidelineId,
      description: description ?? this.description,
      pdf: pdf ?? this.pdf,
      thumbnail: thumbnail ?? this.thumbnail,
      isCompetition: isCompetition ?? this.isCompetition,
      groupThumbnail: groupThumbnail ?? this.groupThumbnail,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      abidedBy: abidedBy ?? this.abidedBy,
      visitDate: visitDate ?? this.visitDate,
      dataCollectorUserId: dataCollectorUserId ?? this.dataCollectorUserId,
    );
  }
}
