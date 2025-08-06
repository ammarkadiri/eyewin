class Customer {
  final int? id;
  final String? name;
  final String? commercialRegistrationNumber;
  final String? contactDetails;
  final double? latitude;
  final double? longitude;
  final double? productScore;
  final double? priceScore;
  final double? placeScore;
  final double? promoScore;
  final double? totalScore;
  final double? lastVisitProductScore;
  final double? lastVisitPriceScore;
  final double? lastVisitPlaceScore;
  final double? lastVisitPromoScore;
  final double? lastVisitTotalScore;
  final int? productKPIVisits;
  final int? priceKPIVisits;
  final int? placeKPIVisits;
  final int? promoKPIVisits;
  final DateTime? lastVisitDate;
  final DateTime? productLastVisitDate;
  final DateTime? priceLastVisitDate;
  final DateTime? placeLastVisitDate;
  final DateTime? promoLastVisitDate;
  final int? lastSalesPoints;
  final double? lastSalesAmount;
  final double? totalSalesAmount;
  final int? totalSalesPoints;
  final int? lastVisitPoints;
  final int? lastVisitMaxPoints;
  final int? totalMaxPoints;
  final int? totalScorePoints;
  final int? claimedPoints;
  final LinkedRetailer? linkedRetailer;
  final List<dynamic>? salesTarget;
  final Program? program;
  final dynamic kpis;
  final dynamic displayCustomer;
  final String? currency;
  final String? customerImagebyDC;
  final String? customerNamebyDC;
  final String? customerLongbyDC;
  final String? customerLatbyDC;

  Customer({
    this.id,
    this.name,
    this.commercialRegistrationNumber,
    this.contactDetails,
    this.latitude,
    this.longitude,
    this.productScore,
    this.priceScore,
    this.placeScore,
    this.promoScore,
    this.totalScore,
    this.lastVisitProductScore,
    this.lastVisitPriceScore,
    this.lastVisitPlaceScore,
    this.lastVisitPromoScore,
    this.lastVisitTotalScore,
    this.productKPIVisits,
    this.priceKPIVisits,
    this.placeKPIVisits,
    this.promoKPIVisits,
    this.lastVisitDate,
    this.productLastVisitDate,
    this.priceLastVisitDate,
    this.placeLastVisitDate,
    this.promoLastVisitDate,
    this.lastSalesPoints,
    this.lastSalesAmount,
    this.totalSalesAmount,
    this.totalSalesPoints,
    this.lastVisitPoints,
    this.lastVisitMaxPoints,
    this.totalMaxPoints,
    this.totalScorePoints,
    this.claimedPoints,
    this.linkedRetailer,
    this.salesTarget,
    this.program,
    this.kpis,
    this.displayCustomer,
    this.currency,
    this.customerImagebyDC,
    this.customerNamebyDC,
    this.customerLongbyDC,
    this.customerLatbyDC,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['Id'],
        name: json['Name'],
        commercialRegistrationNumber: json['CommercialRegistrationNumber'],
        contactDetails: json['ContactDetails'],
        latitude: (json['Latitude'] as num?)?.toDouble(),
        longitude: (json['Longitude'] as num?)?.toDouble(),
        productScore: (json['ProductScore'] as num?)?.toDouble(),
        priceScore: (json['PriceScore'] as num?)?.toDouble(),
        placeScore: (json['PlaceScore'] as num?)?.toDouble(),
        promoScore: (json['PromoScore'] as num?)?.toDouble(),
        totalScore: (json['TotalScore'] as num?)?.toDouble(),
        lastVisitProductScore: (json['LastVisitProductScore'] as num?)?.toDouble(),
        lastVisitPriceScore: (json['LastVisitPriceScore'] as num?)?.toDouble(),
        lastVisitPlaceScore: (json['LastVisitPlaceScore'] as num?)?.toDouble(),
        lastVisitPromoScore: (json['LastVisitPromoScore'] as num?)?.toDouble(),
        lastVisitTotalScore: (json['LastVisitTotalScore'] as num?)?.toDouble(),
        productKPIVisits: json['ProductKPIVisits'],
        priceKPIVisits: json['PriceKPIVisits'],
        placeKPIVisits: json['PlaceKPIVisits'],
        promoKPIVisits: json['PromoKPIVisits'],
        lastVisitDate: json['LastVisitDate'] != null ? DateTime.parse(json['LastVisitDate']) : null,
        productLastVisitDate: json['ProductLastVisitDate'] != null ? DateTime.tryParse(json['ProductLastVisitDate']) : null,
        priceLastVisitDate: json['PriceLastVisitDate'] != null ? DateTime.tryParse(json['PriceLastVisitDate']) : null,
        placeLastVisitDate: json['PlaceLastVisitDate'] != null ? DateTime.tryParse(json['PlaceLastVisitDate']) : null,
        promoLastVisitDate: json['PromoLastVisitDate'] != null ? DateTime.tryParse(json['PromoLastVisitDate']) : null,
        lastSalesPoints: json['LastSalesPoints'],
        lastSalesAmount: (json['LastSalesAmount'] as num?)?.toDouble(),
        totalSalesAmount: (json['TotalSalesAmount'] as num?)?.toDouble(),
        totalSalesPoints: json['TotalSalesPoints'],
        lastVisitPoints: json['LastVisitPoints'],
        lastVisitMaxPoints: json['LastVisitMaxPoints'],
        totalMaxPoints: json['TotalMaxPoints'],
        totalScorePoints: json['TotalScorePoints'],
        claimedPoints: json['ClaimedPoints'],
        linkedRetailer: json['LinkedRetailer'] != null ? LinkedRetailer.fromJson(json['LinkedRetailer']) : null,
        salesTarget: json['SalesTarget'],
        program: json['Program'] != null ? Program.fromJson(json['Program']) : null,
        kpis: json['KPIs'],
        displayCustomer: json['DisplayCustomer'],
        currency: json['Currency'],
        customerImagebyDC: json['CustomerImagebyDC'],
        customerNamebyDC: json['CustomerNamebyDC'],
        customerLongbyDC: json['CustomerLongbyDC'],
        customerLatbyDC: json['CustomerLatbyDC'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'CommercialRegistrationNumber': commercialRegistrationNumber,
        'ContactDetails': contactDetails,
        'Latitude': latitude,
        'Longitude': longitude,
        'ProductScore': productScore,
        'PriceScore': priceScore,
        'PlaceScore': placeScore,
        'PromoScore': promoScore,
        'TotalScore': totalScore,
        'LastVisitProductScore': lastVisitProductScore,
        'LastVisitPriceScore': lastVisitPriceScore,
        'LastVisitPlaceScore': lastVisitPlaceScore,
        'LastVisitPromoScore': lastVisitPromoScore,
        'LastVisitTotalScore': lastVisitTotalScore,
        'ProductKPIVisits': productKPIVisits,
        'PriceKPIVisits': priceKPIVisits,
        'PlaceKPIVisits': placeKPIVisits,
        'PromoKPIVisits': promoKPIVisits,
        'LastVisitDate': lastVisitDate?.toIso8601String(),
        'ProductLastVisitDate': productLastVisitDate?.toIso8601String(),
        'PriceLastVisitDate': priceLastVisitDate?.toIso8601String(),
        'PlaceLastVisitDate': placeLastVisitDate?.toIso8601String(),
        'PromoLastVisitDate': promoLastVisitDate?.toIso8601String(),
        'LastSalesPoints': lastSalesPoints,
        'LastSalesAmount': lastSalesAmount,
        'TotalSalesAmount': totalSalesAmount,
        'TotalSalesPoints': totalSalesPoints,
        'LastVisitPoints': lastVisitPoints,
        'LastVisitMaxPoints': lastVisitMaxPoints,
        'TotalMaxPoints': totalMaxPoints,
        'TotalScorePoints': totalScorePoints,
        'ClaimedPoints': claimedPoints,
        'LinkedRetailer': linkedRetailer?.toJson(),
        'SalesTarget': salesTarget,
        'Program': program?.toJson(),
        'KPIs': kpis,
        'DisplayCustomer': displayCustomer,
        'Currency': currency,
        'CustomerImagebyDC': customerImagebyDC,
        'CustomerNamebyDC': customerNamebyDC,
        'CustomerLongbyDC': customerLongbyDC,
        'CustomerLatbyDC': customerLatbyDC,
      };
}

class LinkedRetailer {
  final int? id;
  final String? code;
  final String? name;
  final String? mobileNumber;
  final String? profilePicture;
  final bool? verified;

  LinkedRetailer({
    this.id,
    this.code,
    this.name,
    this.mobileNumber,
    this.profilePicture,
    this.verified,
  });

  factory LinkedRetailer.fromJson(Map<String, dynamic> json) => LinkedRetailer(
        id: json['Id'],
        code: json['Code'],
        name: json['Name'],
        mobileNumber: json['MobileNumber'],
        profilePicture: json['ProfilePicture'],
        verified: json['Verified'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Code': code,
        'Name': name,
        'MobileNumber': mobileNumber,
        'ProfilePicture': profilePicture,
        'Verified': verified,
      };
}

class Program {
  final int? id;
  final String? name;
  final String? frequency;
  final String? pdf;
  final String? rewardTypeName;
  final double? salesWeight;
  final double? productWeight;
  final double? priceWeight;
  final double? placeWeight;
  final double? promoWeight;
  final double? productTarget;
  final double? priceTarget;
  final double? placeTarget;
  final double? promoTarget;
  final String? notes;

  Program({
    this.id,
    this.name,
    this.frequency,
    this.pdf,
    this.rewardTypeName,
    this.salesWeight,
    this.productWeight,
    this.priceWeight,
    this.placeWeight,
    this.promoWeight,
    this.productTarget,
    this.priceTarget,
    this.placeTarget,
    this.promoTarget,
    this.notes,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json['Id'],
        name: json['Name'],
        frequency: json['Frequency'],
        pdf: json['PDF'],
        rewardTypeName: json['RewardTypeName'],
        salesWeight: (json['SalesWeight'] as num?)?.toDouble(),
        productWeight: (json['ProductWeight'] as num?)?.toDouble(),
        priceWeight: (json['PriceWeight'] as num?)?.toDouble(),
        placeWeight: (json['PlaceWeight'] as num?)?.toDouble(),
        promoWeight: (json['PromoWeight'] as num?)?.toDouble(),
        productTarget: (json['ProductTarget'] as num?)?.toDouble(),
        priceTarget: (json['PriceTarget'] as num?)?.toDouble(),
        placeTarget: (json['PlaceTarget'] as num?)?.toDouble(),
        promoTarget: (json['PromoTarget'] as num?)?.toDouble(),
        notes: json['Notes'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'Frequency': frequency,
        'PDF': pdf,
        'RewardTypeName': rewardTypeName,
        'SalesWeight': salesWeight,
        'ProductWeight': productWeight,
        'PriceWeight': priceWeight,
        'PlaceWeight': placeWeight,
        'PromoWeight': promoWeight,
        'ProductTarget': productTarget,
        'PriceTarget': priceTarget,
        'PlaceTarget': placeTarget,
        'PromoTarget': promoTarget,
        'Notes': notes,
      };
}
