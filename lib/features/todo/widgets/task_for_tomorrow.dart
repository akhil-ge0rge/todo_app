import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/todo/apps/task_provider.dart';
import 'package:todo_app/features/todo/widgets/task_expansion_tile.dart';

import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../utils/todo_utils.dart';

class TaskForTommorrow extends ConsumerWidget {
  const TaskForTommorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProviderProvider);
    return FutureBuilder(
      future: TodoUtils.getTommorowsTasks(task),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final color = AppColurs.getRandomColor();
          return TaskExpansionTile(
            color: color,
            title: "Tomorrow's Task's",
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
