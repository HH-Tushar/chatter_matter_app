

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryList {
    final bool success;
    final List<Category> data;

    CategoryList({
        required this.success,
        required this.data,
    });



    factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        success: json["success"],
        data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
    );

}





class Category {
  final String id;
  final String title;
  final String subTitle;
  final String colorPalette;
  final String colorCode;
  final int questionCount;
  final int favoritesCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    required this.id,
    required this.title,
    required this.colorPalette,
    required this.colorCode,
    required this.subTitle,
    required this.questionCount,
    required this.favoritesCount,
    this.createdAt,
    this.updatedAt,
  });
  factory Category.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    // Handle potential null or missing fields with default values
    final timestamp = data?['createdAt'] as Timestamp?;
    final timestamp2 = data?['updatedAt'] as Timestamp?;

    return Category(
      id: doc.id,
      title: data?['title'] ?? '',
      subTitle: data?['subTitle'] ?? '',
      colorCode: data?['colorCode'] ?? '#FFFFFF',
      questionCount: data?['questionCount'] ?? 0,
      favoritesCount: data?['favoritesCount'] ?? 0,
      colorPalette: data?['colorPalette'],
      createdAt: timestamp?.toDate() ?? DateTime.now(),
      updatedAt: timestamp2?.toDate() ?? DateTime.now(),
    );
  }



factory Category.fromJson(Map<String, dynamic> json, {String? id}) {
  final createdAtTimestamp = json['createdAt'];
  final updatedAtTimestamp = json['updatedAt'];

  return Category(
    id: id ?? json['id'] ?? '',
    title: json['title'] ?? '',
    subTitle: json['subTitle'] ?? '',
    colorPalette: json['colorPalette'] ?? '',
    colorCode: json['colorCode'] ?? '#FFFFFF',

    questionCount: json['questionCount'] ?? 0,
    favoritesCount: json['favoritesCount'] ?? 0,

    createdAt: createdAtTimestamp is Timestamp
        ? createdAtTimestamp.toDate()
        : createdAtTimestamp is String
            ? DateTime.tryParse(createdAtTimestamp)
            : null,

    updatedAt: updatedAtTimestamp is Timestamp
        ? updatedAtTimestamp.toDate()
        : updatedAtTimestamp is String
            ? DateTime.tryParse(updatedAtTimestamp)
            : null,
  );
}



  
}




