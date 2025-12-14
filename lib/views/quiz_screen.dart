import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/quiz_provider.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: quiz == null
          ? Center(
        child: ElevatedButton(
          onPressed: () => ref.read(quizProvider.notifier).loadDummy(),
          child: const Text('Load Sample Quiz'),
        ),
      )
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          for (var i = 0; i < quiz.questions.length; i++) _QuestionCard(index: i, question: quiz.questions[i]),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final int index;
  final dynamic question;
  const _QuestionCard({required this.index, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${index + 1}. ${question.question}'),
          const SizedBox(height: 8),
          ...List.generate(
            question.options.length,
                (i) => ListTile(
              leading: const Icon(Icons.radio_button_unchecked),
              title: Text(question.options[i]),
            ),
          )
        ]),
      ),
    );
  }
}
