import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/planner_item.dart';
import '../viewmodels/planner_provider.dart';

class PlannerDetailScreen extends ConsumerWidget {
  const PlannerDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlannerItem item = ModalRoute.of(context)!.settings.arguments as PlannerItem;

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.description),
          const SizedBox(height: 8),
          Text('Date: ${item.date.toLocal()}'),
          const SizedBox(height: 8),
          Text('Tasks: ${item.tasks.join(', ')}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final updated = PlannerItem(
                id: item.id,
                userId: item.userId,
                title: item.title,
                description: item.description,
                date: item.date,
                status: item.status == 'pending' ? 'completed' : 'pending',
                tasks: item.tasks,
              );
              ref.read(plannerProvider.notifier).updatePlanner(updated);
              Navigator.pop(context);
            },
            child: Text(item.status == 'pending' ? 'Mark Completed' : 'Mark Pending'),
          )
        ]),
      ),
    );
  }
}
