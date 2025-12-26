import 'package:flutter/material.dart';

import '../application/model/journal_model.dart';
import '../application/repo/journal_repo.dart';

class JournalProvider extends ChangeNotifier {
  JournalProvider() {
    init();
  }
  bool isLoading = false;
  bool isPaginating = false;
  bool reachEnd = false;
  bool addingHomeJournal = false;
  bool addingJournal = false;

  final JournalRepo _journalRepo = JournalRepo();

  JournalPaginator? journalPaginator;
  List<Journal> journalList = [];

  init() async {
    getJournal();
  }

  void resetPaginator() async {
    journalPaginator = null;
    journalList = [];
    getJournal();
  }

  void getJournal() async {
    if (journalPaginator == null) {
      isLoading = true;
    } else {
      isPaginating = true;
    }
    if (journalPaginator != null && journalPaginator?.pageToken == null) {
      reachEnd = true;
      return;
    }
    notifyListeners();

    final (data, error) = await _journalRepo.getJournals();

    if (data != null) {
      journalList.addAll(data.data);
    }

    isLoading = false;
    isPaginating = false;
    notifyListeners();
  }

  Future<Journal?> addJournal({
    bool isHome = false,
    required String question,
    required String questionId,
    required String ans,
  }) async {
    if (isHome) {
      addingHomeJournal = true;
    } else {
      addingJournal = true;
    }

    notifyListeners();

    final (data, error) = await _journalRepo.addJournal(
      Journal(
        ans: ans,
        question: question,
        createdAt: "",
        id: "",
        uid: "",
        questionId: questionId,
      ),
    );

    if (data != null) {
      journalList.insert(0, data);
    }

    addingJournal = false;
    addingHomeJournal = false;
    notifyListeners();
    return data;
  }

  Future<bool?> deleteJournal({required String journalId}) async {
    notifyListeners();

    final (data, error) = await _journalRepo.deleteJournal(journalId);

    if (data != null) {
      journalList.removeWhere((t) => t.id == journalId);
    }

    addingJournal = false;
    addingHomeJournal = false;
    notifyListeners();
    return data;
  }
}
