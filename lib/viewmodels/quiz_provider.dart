import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quiz.dart';

final quizProvider = StateNotifierProvider<QuizNotifier, Quiz?>((ref) {
  return QuizNotifier();
});

class QuizNotifier extends StateNotifier<Quiz?> {
  QuizNotifier() : super(null);

  void loadDummy() {
    state = Quiz(
      id: 'quiz1',
      title: 'Math Basics',
      subject: 'Mathematics',
      createdAt: DateTime.now(),
      questions: [
        QuizQuestion(question: '2 + 2 = ?', options: ['3', '4', '5'], correctIndex: 1),
        QuizQuestion(question: '5 - 3 = ?', options: ['1', '2', '3'], correctIndex: 1),
      ],
    );
  }
}
