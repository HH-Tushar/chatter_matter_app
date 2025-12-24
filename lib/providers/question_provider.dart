import 'package:flutter/material.dart';

import '../application/model/question_model.dart';
import '../application/repo/question_repo.dart';

class QuestionProvider extends ChangeNotifier {
  QuestionProvider() {
    init();
  }
  QuestionPaginator? _questionPaginator;
  List<Question> questionList = [];

  bool isLoading = false;
  bool isPaginating = false;
  bool reachEnd = false;

  final QuestionRepo _questionRepo = QuestionRepo();

  init() async {
    getQuestion();
  }

  void resetPaginator() async {
    _questionPaginator = null;
    questionList = [];
    getQuestion();
  }

  void getQuestion() async {
    if (_questionPaginator == null) {
      isLoading = true;
    } else {
      isPaginating = true;
    }
    if (_questionPaginator != null && _questionPaginator?.pageToken == null) {
      reachEnd = true;
      return;
    }
    notifyListeners();

    final (data, error) = await _questionRepo.getQuestionSet();

    if (data != null) {
      questionList.addAll(data.data);
    }

    isLoading = false;
    isPaginating = false;
    notifyListeners();
  }


}
