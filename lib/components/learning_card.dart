import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LearningCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback? onTap;

  const LearningCard({super.key, required this.lesson, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(lesson.title),
        subtitle: Text('${lesson.subject} • ${lesson.type}'),
        trailing: Icon(lesson.offlineAvailable ? Icons.offline_pin : Icons.cloud_download),
        onTap: onTap,
      ),
    );
  }
}
