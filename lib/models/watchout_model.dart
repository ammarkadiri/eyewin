class WatchoutData {
  final List<WatchoutCategory>? categories;
  final List<WatchoutActivityType>? activityTypes;
  final List<WatchoutEvent>? events;

  WatchoutData({
    this.categories,
    this.activityTypes,
    this.events,
  });

  factory WatchoutData.fromJson(Map<String, dynamic> json) {
    return WatchoutData(
      categories: (json['Categories'] as List?)?.map((e) => WatchoutCategory.fromJson(e)).toList(),
      activityTypes: (json['ActivityTypes'] as List?)?.map((e) => WatchoutActivityType.fromJson(e)).toList(),
      events: (json['Events'] as List?)?.map((e) => WatchoutEvent.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (categories != null) 'Categories': categories!.map((e) => e.toJson()).toList(),
        if (activityTypes != null) 'ActivityTypes': activityTypes!.map((e) => e.toJson()).toList(),
        if (events != null) 'Events': events!.map((e) => e.toJson()).toList(),
      };
}

class WatchoutCategory {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? nameFr;
  final List<WatchoutBrand>? brands;

  WatchoutCategory({
    this.id,
    this.name,
    this.nameAr,
    this.nameFr,
    this.brands,
  });

  factory WatchoutCategory.fromJson(Map<String, dynamic> json) {
    return WatchoutCategory(
      id: json['Id'],
      name: json['Name'],
      nameAr: json['NameAr'],
      nameFr: json['NameFr'],
      brands: (json['Brands'] as List?)?.map((e) => WatchoutBrand.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'NameAr': nameAr,
        'NameFr': nameFr,
        if (brands != null) 'Brands': brands!.map((e) => e.toJson()).toList(),
      };
}

class WatchoutBrand {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? nameFr;
  final bool? isCompetition;

  WatchoutBrand({
    this.id,
    this.name,
    this.nameAr,
    this.nameFr,
    this.isCompetition,
  });

  factory WatchoutBrand.fromJson(Map<String, dynamic> json) {
    return WatchoutBrand(
      id: json['Id'],
      name: json['Name'],
      nameAr: json['NameAr'],
      nameFr: json['NameFr'],
      isCompetition: json['IsCompetition'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'NameAr': nameAr,
        'NameFr': nameFr,
        'IsCompetition': isCompetition,
      };
}

class WatchoutActivityType {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? nameFr;

  WatchoutActivityType({
    this.id,
    this.name,
    this.nameAr,
    this.nameFr,
  });

  factory WatchoutActivityType.fromJson(Map<String, dynamic> json) {
    return WatchoutActivityType(
      id: json['Id'],
      name: json['Name'],
      nameAr: json['NameAr'],
      nameFr: json['NameFr'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'NameAr': nameAr,
        'NameFr': nameFr,
      };
}

class WatchoutEvent {
  final int? id;
  final String? name;
  final String? nameAr;
  final String? nameFr;

  WatchoutEvent({
    this.id,
    this.name,
    this.nameAr,
    this.nameFr,
  });

  factory WatchoutEvent.fromJson(Map<String, dynamic> json) {
    return WatchoutEvent(
      id: json['Id'],
      name: json['Name'],
      nameAr: json['NameAr'],
      nameFr: json['NameFr'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'NameAr': nameAr,
        'NameFr': nameFr,
      };
}
