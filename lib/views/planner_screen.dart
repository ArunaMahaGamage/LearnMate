import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/planner_item.dart';
import '../viewmodels/auth_provider.dart';
import '../viewmodels/planner_provider.dart';
import '../components/planner_card.dart';
import '../core/routes.dart';

class PlannerScreen extends ConsumerWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planners = ref.watch(plannerProvider);
    final authState = ref.watch(authProvider);

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
          _addDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<void> _addDialog(BuildContext context, WidgetRef ref) async {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final taskTitleCtrl = TextEditingController();
  final taskDescCtrl = TextEditingController();
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Add Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 8),
          TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
          const SizedBox(height: 8),
          TextField(controller: taskTitleCtrl, decoration: const InputDecoration(labelText: 'Tasks Title')),
          const SizedBox(height: 8),
          TextField(controller: taskDescCtrl, decoration: const InputDecoration(labelText: 'Tasks Description')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final p = PlannerItem(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              userId: ref.read(authControllerProvider).currentUserEmail ?? 'demo',
              title: titleCtrl.text.trim(),
              description: descCtrl.text.trim(),
              date: DateTime.now().add(const Duration(days: 1)),
              status: 'pending',
              tasks: [taskTitleCtrl.text.trim(), taskDescCtrl.text.trim()],
            );
            ref.read(plannerProvider.notifier).addPlanner(p);
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}

Future<void> _showDetails(BuildContext context, WidgetRef ref) async {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final taskTitleCtrl = TextEditingController();
  final taskDescCtrl = TextEditingController();
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Add Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 8),
          TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Description')),
          const SizedBox(height: 8),
          TextField(controller: taskTitleCtrl, decoration: const InputDecoration(labelText: 'Tasks Title')),
          const SizedBox(height: 8),
          TextField(controller: taskDescCtrl, decoration: const InputDecoration(labelText: 'Tasks Description')),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final p = PlannerItem(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              userId: 'demo',
              title: titleCtrl.text.trim(),
              description: descCtrl.text.trim(),
              date: DateTime.now().add(const Duration(days: 1)),
              status: 'pending',
              tasks: [taskTitleCtrl.text.trim(), taskDescCtrl.text.trim()],
            );
            ref.read(plannerProvider.notifier).addPlanner(p);
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}
