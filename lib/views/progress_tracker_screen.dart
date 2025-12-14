import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/progress_provider.dart';
import '../components/progress_chart.dart';

class ProgressTrackerScreen extends ConsumerWidget {
  const ProgressTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          ProgressChart(lessons: progress.completedLessons, quizzes: progress.completedQuizzes, score: progress.score),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => ref.read(progressProvider.notifier).markLessonComplete(), child: const Text('Complete Lesson')),
          ElevatedButton(onPressed: () => ref.read(progressProvider.notifier).markQuizComplete(80), child: const Text('Complete Quiz (80)')),
        ]),
      ),
    );
  }
}
