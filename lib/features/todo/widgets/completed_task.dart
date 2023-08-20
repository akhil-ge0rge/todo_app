import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/todo/apps/task_provider.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

import '../utils/todo_utils.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProviderProvider);
    return FutureBuilder(
      future: TodoUtils.getCompletedTasksForToday(task),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Completed Tasks",
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
                  bottomMargin: isLast ? null : 10,
                  endIcon: Icon(
                    AntDesign.checkcircle,
                    color: AppColurs.green,
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
