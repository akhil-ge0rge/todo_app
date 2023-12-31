import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/core/helper/db_helper.dart';
import 'package:todo_app/core/res/colurs.dart';

import '../model/task_model.dart';

part 'task_provider.g.dart';

@riverpod
class TaskProvider extends _$TaskProvider {
  @override
  List<TaskModel> build() => [];

  void refresh() async {
    final data = await DBHelper.getTasks();
    state = data.map((taskData) {
      return TaskModel.fromMap(taskData);
    }).toList();
  }

  Future<void> addTask(TaskModel task) async {
    await DBHelper.addTask(task);
    refresh();
  }

  Future<void> deleteTask(int taskId) async {
    await DBHelper.deleteTask(taskId);
    refresh();
  }

  Future<void> updateTask(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }
}
