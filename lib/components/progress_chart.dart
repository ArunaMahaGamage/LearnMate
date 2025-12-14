import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  final int lessons;
  final int quizzes;
  final double score; // 0..100

  const ProgressChart({super.key, required this.lessons, required this.quizzes, required this.score});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Progress', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Lessons: $lessons'),
                Text('Quizzes: $quizzes'),
                Text('Score: ${score.toStringAsFixed(1)}'),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: score / 100),
          ],
        ),
      ),
    );
  }
}
