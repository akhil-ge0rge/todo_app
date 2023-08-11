import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/todo/apps/task_provider.dart';
import 'package:todo_app/features/todo/widgets/todo_tile.dart';

class ActiveTasks extends ConsumerWidget {
  const ActiveTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(taskProviderProvider.notifier).getActiveTasksForToday(),
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
                return TodoTile(
                  task: task,
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
