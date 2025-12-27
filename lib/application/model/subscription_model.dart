import 'dart:convert';

class SubscriptionPackages {
  final bool success;
  final List<Package> data;

  SubscriptionPackages({required this.success, required this.data});

  factory SubscriptionPackages.fromRawJson(String str) =>
      SubscriptionPackages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscriptionPackages.fromJson(Map<String, dynamic> json) =>
      SubscriptionPackages(
        success: json["success"],
        data: List<Package>.from(json["data"].map((x) => Package.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Package {
  final String id;
  final List<dynamic> features;
  final DateTime createdAt;
  final List<String> categoryIds;
  final String pricePerMonth;
  final String pricePerYear;
  final int questions;
  final String packageName;
  final String packageType;
  final DateTime updatedAt;

  Package({
    required this.id,
    required this.features,
    required this.createdAt,
    required this.categoryIds,
    required this.pricePerMonth,
    required this.questions,
    required this.packageName,
    required this.packageType,
    required this.updatedAt,
    required this.pricePerYear,
  });

  factory Package.fromRawJson(String str) => Package.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"],
    features: List<dynamic>.from(json["features"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    categoryIds: List<String>.from(json["categoryIds"].map((x) => x)),
    pricePerMonth: json["pricePerMonth"].toString(),
    pricePerYear: json["pricePerMonth"].toString(),
    questions: json["questions"],
    packageName: json["packageName"],
    packageType: json["packageType"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "features": List<dynamic>.from(features.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "categoryIds": List<dynamic>.from(categoryIds.map((x) => x)),
    "pricePerMonth": pricePerMonth,
    "questions": questions,
    "packageName": packageName,
    "packageType": packageType,
    "updatedAt": updatedAt.toIso8601String(),
  };
}
