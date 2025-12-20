class Question {
  final String id;
  final String title;
  final bool isBabyQuestion;

  Question({
    required this.id,
    required this.title,
    required this.isBabyQuestion,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      isBabyQuestion: json['isBabyQuestion'],
      title: json['title'] as String,
    );
  }
}

/// Paginator response for Question list
class QuestionPaginator {
  final int count;
  final String? pageToken;
  final List<Question> data;

  QuestionPaginator({
    required this.count,
    required this.pageToken,
    required this.data,
  });

  factory QuestionPaginator.fromJson(Map<String, dynamic> json) {
    final questionsJson = json['data'] as List<dynamic>? ?? [];
    final questions = questionsJson
        .map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList();

    return QuestionPaginator(
      count: json['count'] as int,
      pageToken: json['pageToken'] as String?,
      data: questions,
    );
  }
}
