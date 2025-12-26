import '../../core/enums.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String? imageUrl;
  final int? age;

  final AuthProvider provider;

  // Subscription
  final SubscriptionType subscriptionType;
  final int? subscriptionStartedAt;
  final int? subscriptionEndsAt;
  List<String> selectedCategories;
  List<String> favoriteQuestionIds;

  final int createdAt;
  // final int updatedAt;
  // final int? lastLoginAt;

  final UserRole? role;

  final bool? isEmailVerified;
  final bool isActive;
  bool pushNotification;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.imageUrl,
    this.age,
    required this.provider,
    required this.subscriptionType,
    this.subscriptionStartedAt,
    this.subscriptionEndsAt,
    required this.createdAt,
    // required this.updatedAt,
    // this.lastLoginAt,
    this.role,
    required this.selectedCategories,
    this.isEmailVerified,
    required this.isActive,
    required this.pushNotification,
    required this.favoriteQuestionIds,
  });

  /// FROM JSON
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      age: json['age'],
      selectedCategories:
          (json['selectedCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      favoriteQuestionIds:
          (json['favoriteQuestionIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      provider: AuthProvider.values.byName(json['provider']),
      subscriptionType: SubscriptionType.values.byName(
        json['subscriptionType'],
      ),
      subscriptionStartedAt: json['subscriptionStartedAt'],
      subscriptionEndsAt: json['subscriptionEndsAt'],
      createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
      // lastLoginAt: json['lastLoginAt'],
      role: json['role'] != null ? UserRole.values.byName(json['role']) : null,
      isEmailVerified: json['isEmailVerified'],
      isActive: json['isActive'] ?? true,
      pushNotification: json['pushNotification'] ?? false,
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      //  'email': email,
      'imageUrl': imageUrl,
      'age': age,
      // 'provider': provider.name,
      // 'subscriptionType': subscriptionType.name,
      //  'subscriptionStartedAt': subscriptionStartedAt,
      // 'subscriptionEndsAt': subscriptionEndsAt,
      'createdAt': createdAt,
      // 'updatedAt': updatedAt,
      // 'lastLoginAt': lastLoginAt,
      // 'role': role?.name,
      //  'isEmailVerified': isEmailVerified,
      // 'isActive': isActive,
      'pushNotification': pushNotification,
    };
  }
}
