import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/planner_item.dart';
import '../viewmodels/planner_provider.dart';
import '../components/planner_card.dart';
import '../core/routes.dart';

class PlannerScreen extends ConsumerWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planners = ref.watch(plannerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Study Planner')),
      body: ListView.builder(
        itemCount: planners.length,
        itemBuilder: (_, i) {
          final p = planners[i];
          return PlannerCard(
            item: p,
            onTap: () => Navigator.pushNamed(context, Routes.plannerDetail, arguments: p),
            onDelete: () => ref.read(plannerProvider.notifier).deletePlanner(p.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final p = PlannerItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            userId: 'demo',
            title: 'New Plan',
            description: 'Revise Mathematics',
            date: DateTime.now().add(const Duration(days: 1)),
            status: 'pending',
            tasks: ['Chapter 1', 'Practice 10 questions'],
          );
          ref.read(plannerProvider.notifier).addPlanner(p);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
