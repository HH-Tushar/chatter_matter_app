class Journal {
  final String id;
  final String uid;
  final String question;
  final String questionId;
  final String ans;
  final String createdAt;

  Journal({
    required this.id,
    required this.uid,
    required this.question,
    required this.questionId,
    required this.ans,
    required this.createdAt,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'] as String,
      questionId: json['questionId'] as String,
      uid: json['uid'] as String,
      question: json['question'] as String,
      ans: json['ans'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'questionId': questionId,
      'uid': uid,
      'question': question,
      'ans': ans,
      // 'createdAt': createdAt,
    };
  }
}

/// Paginator response for Journal list
class JournalPaginator {
  final int count;
  final String? pageToken;
  final List<Journal> data;

  JournalPaginator({
    required this.count,
    required this.pageToken,
    required this.data,
  });

  factory JournalPaginator.fromJson(Map<String, dynamic> json) {
    final journalsJson = json['data'] as List<dynamic>? ?? [];
    final journals = journalsJson
        .map((e) => Journal.fromJson(e as Map<String, dynamic>))
        .toList();

    return JournalPaginator(
      count: json['count'] as int,
      pageToken: json['pageToken'] as String?,
      data: journals,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'pageToken': pageToken,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
