import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/resource_provider.dart';
import '../components/learning_card.dart';
import '../core/routes.dart';
import '../models/lesson.dart';

class ResourceLibraryScreen extends ConsumerWidget {
  const ResourceLibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resources = ref.watch(resourcesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Resources')),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (_, i) {
          final r = resources[i];
          return LearningCard(
            lesson: r,
            onTap: () => Navigator.pushNamed(context, Routes.resourceDetail, arguments: r),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final l = Lesson(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: 'Grade 10 Science Notes',
            subject: 'Science',
            type: 'pdf',
            downloadUrl: 'https://example.com/notes.pdf',
            offlineAvailable: true,
            createdAt: DateTime.now(),
          );
          ref.read(resourcesProvider.notifier).addResource(l);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
