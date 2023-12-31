import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/todo/apps/task_provider.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../utils/todo_utils.dart';

class ActiveTasks extends ConsumerWidget {
  const ActiveTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProviderProvider);
    return FutureBuilder(
      future: TodoUtils.getActiveTasksForToday(task),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Pending Tasks",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColurs.light.withOpacity(.6)),
              ),
            );
          }
          return ColoredBox(
            color: AppColurs.lightBackground,
            child: ListView.separated(
              separatorBuilder: (context, index) => WhiteSpace(
                height: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final task = snapshot.data!.elementAt(index);
                final isLast = index == snapshot.data!.length - 1;
                return TodoTile(
                  task: task,
                  onDelete: () {
                    ref
                        .read(taskProviderProvider.notifier)
                        .deleteTask(task.id!);
                  },
                  onEdit: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTaskScreen(
                            task: task,
                          ),
                        ));
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
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
