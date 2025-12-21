import 'package:flutter/material.dart';

import '../application/model/category_model.dart';
import '../application/model/subscription_model.dart';
import '../application/repo/dashboard_repo.dart';
import '../application/repo/subscription_repo.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider() {
    init();
  }
  bool isLoading = false;
  bool isFetchingCategory = false;
  bool isFetchingPackages = false;
  bool isAddingCategory = false;

  final DashboardRepo _dashboardRepo = DashboardRepo();
  final SubscriptionRepo _subscriptionRepo = SubscriptionRepo();
  List<Category> categoryList = [];
  // SubscriptionPackages? subscriptionPackages;
  List<Package> subscriptionPackages = [];

  init() async {
    getCategoryList();
    getSubscriptionPacks();
  }

  void getCategoryList() async {
    isFetchingCategory = true;
    notifyListeners();
    final (data, error) = await _dashboardRepo.getCategoryList();
    if (data != null) {
      categoryList = data.data;
    }
    isFetchingCategory = false;
    notifyListeners();
  }

  void getSubscriptionPacks() async {
    isFetchingPackages = true;
    notifyListeners();
    final (data, error) = await _subscriptionRepo.getPackages();
    if (data != null) {
      subscriptionPackages = data.data;
    }
    isFetchingPackages = false;
    notifyListeners();
  }
}
