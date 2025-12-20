import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Answers {
  final String id;
  final String title;
  final String content;
  final List<String> answers;
  final DateTime createdAt;

  Answers({
    required this.id,
    required this.title,
    required this.content,
    required this.answers,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'answers': answers,
    'createdAt': createdAt.toIso8601String(),
  };

  static Answers fromMap(Map<String, dynamic> json) => Answers(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    answers: (json['answers'] as List).map((e) => e.toString()).toList(),
    createdAt: DateTime.parse(json['createdAt']),
  );
}

final answerProvider = StateNotifierProvider<AnswerNotifier, List<Answers>>((
    ref,
    ) {
  return AnswerNotifier();
});

class AnswerNotifier extends StateNotifier<List<Answers>> {
  AnswerNotifier() : super([]) {
    load();
  }

  final _firestore = FirebaseFirestore.instance;

  Future<void> load() async {
    final snap = await _firestore
        .collection('answers')
        .get();
    state = snap.docs
        .map((d) => Answers.fromMap({'id': d.id, ...d.data()}))
        .toList();
  }

  Future<void> addQuestion(Answers q) async {
    state = [q, ...state];
    await _firestore.collection('forum').doc(q.id).set(q.toMap());
  }

  Future<void> addAnswer(String questionId, Map<String, dynamic> answer) async {
    Map<String, dynamic> allAnswer = {};
    allAnswer[DateTime.now().millisecondsSinceEpoch.toString()] = answer;
    await _firestore.collection('answers').doc(questionId).set({
      DateTime.now().millisecondsSinceEpoch.toString(): answer,
    },);

  }
}