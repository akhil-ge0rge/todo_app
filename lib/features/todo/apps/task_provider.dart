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

  Future<List<TaskModel>> getTodaysTasks() async {
    final today = DateTime.now();
    if (state.isEmpty) return state;
    return state.where((task) {
      return DateUtils.isSameDay(task.date, today);
    }).toList();
  }

  Future<List<TaskModel>> getTommorowsTasks() async {
    final tommorrow = DateTime.now().add(const Duration(days: 1));
    if (state.isEmpty) return state;
    return state.where((task) {
      return DateUtils.isSameDay(task.date, tommorrow);
    }).toList();
  }

  Future<List<TaskModel>> getDayAfterTommorowsTasks() async {
    final tommorrow = DateTime.now().add(const Duration(days: 2));
    if (state.isEmpty) return state;
    return state.where((task) {
      return DateUtils.isSameDay(task.date, tommorrow);
    }).toList();
  }

  Future<List<TaskModel>> getLast30daysTasks() async {
    final last30Days = DateTime.now().subtract(const Duration(days: 30));
    if (state.isEmpty) return state;
    return state.where((task) {
      return task.date!.isAfter(last30Days) &&
          task.date!.isBefore(DateUtils.dateOnly(DateTime.now()));
    }).toList();
  }

  Future<void> markAsCompleted(TaskModel task) async {
    await DBHelper.updateTask(task);
    refresh();
  }

  Future<List<TaskModel>> getCompletedTasks() async {
    if (state.isEmpty) return state;
    return state.where((task) {
      return task.isCompleted;
    }).toList();
  }

  Future<List<TaskModel>> getInCompletedTasks() async {
    if (state.isEmpty) return state;
    return state.where((task) {
      return !task.isCompleted;
    }).toList();
  }

  Color randomColor() {
    final random = Random();
    int randomIndex = random.nextInt(AppColurs.colors.length);
    return AppColurs.colors.elementAt(randomIndex);
  }
}
