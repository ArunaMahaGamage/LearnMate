import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressState {
  final int completedLessons;
  final int completedQuizzes;
  final double score;

  ProgressState({required this.completedLessons, required this.completedQuizzes, required this.score});

  ProgressState copyWith({int? completedLessons, int? completedQuizzes, double? score}) {
    return ProgressState(
      completedLessons: completedLessons ?? this.completedLessons,
      completedQuizzes: completedQuizzes ?? this.completedQuizzes,
      score: score ?? this.score,
    );
  }
}

final progressProvider = StateNotifierProvider<ProgressNotifier, ProgressState>((ref) {
  return ProgressNotifier();
});

class ProgressNotifier extends StateNotifier<ProgressState> {
  ProgressNotifier() : super(ProgressState(completedLessons: 0, completedQuizzes: 0, score: 0));

  void markLessonComplete() => state = state.copyWith(completedLessons: state.completedLessons + 1);
  void markQuizComplete(double quizScore) => state = state.copyWith(completedQuizzes: state.completedQuizzes + 1, score: (state.score + quizScore) / 2);
}
