import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/extentions/date_extentions.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../../../core/res/colurs.dart';
import '../apps/task_provider.dart';
import '../utils/todo_utils.dart';
import 'task_expansion_tile.dart';

class TaskForDayAfterTomorrow extends ConsumerWidget {
  const TaskForDayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProviderProvider);
    return FutureBuilder(
      future: TodoUtils.getDayAfterTommorowsTasks(task),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final color = AppColurs.getRandomColor();
          return TaskExpansionTile(
            color: color,
            title: "${snapshot.data!.first.date!.dateOnly} Task's",
            subTitle: "Tommorrow's tasks are shown here",
            children: snapshot.data!.map((task) {
              final isLast = snapshot.data!
                      .indexWhere((element) => element.id == task.id) ==
                  snapshot.data!.length - 1;
              return TodoTile(
                task: task,
                color: color,
                onDelete: () {
                  ref.read(taskProviderProvider.notifier).deleteTask(task.id!);
                },
                bottomMargin: isLast ? null : 10,
                endIcon: Switch(
                  value: task.isCompleted,
                  onChanged: (_) {
                    task.isCompleted = true;
                    ref
                        .watch(taskProviderProvider.notifier)
                        .markAsCompleted(task);
                  },
                ),
              );
            }).toList(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
