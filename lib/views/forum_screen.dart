import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/forum_provider.dart';
import '../core/routes.dart';

class ForumScreen extends ConsumerWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(forumProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Community Q&A')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (_, i) {
          final q = questions[i];
          return Card(
            child: ListTile(
              title: Text(q.title),
              subtitle: Text(q.content),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.questionDetail,
                arguments: q,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final q = Question(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            userId: 'demo',
            title: 'How to revise science effectively?',
            content: 'Any tips for Grade 10 science exam?',
            tags: ['Science', 'Grade10'],
            createdAt: DateTime.now(),
          );
          ref.read(forumProvider.notifier).addQuestion(q);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
