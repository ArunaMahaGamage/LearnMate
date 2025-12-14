class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({required this.question, required this.options, required this.correctIndex});

  Map<String, dynamic> toMap() => {
    'question': question,
    'options': options,
    'correctIndex': correctIndex,
  };

  static QuizQuestion fromMap(Map<String, dynamic> json) => QuizQuestion(
    question: json['question'],
    options: (json['options'] as List).map((e) => e.toString()).toList(),
    correctIndex: json['correctIndex'],
  );
}

class Quiz {
  final String id;
  final String title;
  final String subject;
  final List<QuizQuestion> questions;
  final DateTime createdAt;

  Quiz({required this.id, required this.title, required this.subject, required this.questions, required this.createdAt});

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'subject': subject,
    'questions': questions.map((q) => q.toMap()).toList(),
    'createdAt': createdAt.toIso8601String(),
  };

  static Quiz fromMap(Map<String, dynamic> json) => Quiz(
    id: json['id'],
    title: json['title'],
    subject: json['subject'],
    questions: (json['questions'] as List).map((e) => QuizQuestion.fromMap(e)).toList(),
    createdAt: DateTime.parse(json['createdAt']),
  );
}
