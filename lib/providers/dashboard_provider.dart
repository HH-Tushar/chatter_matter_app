import 'package:flutter/material.dart';

import '../application/model/category_model.dart';
import '../application/repo/dashboard_repo.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider() {
    init();
  }
  bool isLoading = false;
  bool isFetchingCategory = false;
  bool isAddingCategory = false;

  final DashboardRepo _dashboardRepo = DashboardRepo();
  List<Category> categoryList = [];

  init() async {
    getCategoryList();
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
}
