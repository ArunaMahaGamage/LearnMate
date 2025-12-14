import 'package:flutter/material.dart';
import '../models/lesson.dart';

class ResourceDetailScreen extends StatelessWidget {
  const ResourceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Lesson lesson = ModalRoute.of(context)!.settings.arguments as Lesson;

    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Subject: ${lesson.subject}'),
          Text('Type: ${lesson.type}'),
          const SizedBox(height: 12),
          Text('This resource can be downloaded and used offline.'),
        ]),
      ),
    );
  }
}
