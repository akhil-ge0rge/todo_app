import 'package:flutter/material.dart';

import '../model/task_model.dart';

class TodoUtils {
  const TodoUtils._();

  static Future<List<TaskModel>> getTodaysTasks(List<TaskModel> allTask) async {
    final today = DateTime.now();
    if (allTask.isEmpty) return allTask;
    return allTask.where((task) {
      return DateUtils.isSameDay(task.date, today);
    }).toList();
  }

  static Future<List<TaskModel>> getTommorowsTasks(
      List<TaskModel> allTask) async {
    final tommorrow = DateTime.now().add(const Duration(days: 1));
    if (allTask.isEmpty) return allTask;
    return allTask.where((task) {
      return DateUtils.isSameDay(task.date, tommorrow);
    }).toList();
  }

  static Future<List<TaskModel>> getDayAfterTommorowsTasks(
      List<TaskModel> allTask) async {
    final tommorrow = DateTime.now().add(const Duration(days: 2));
    if (allTask.isEmpty) return allTask;
    return allTask.where((task) {
      return DateUtils.isSameDay(task.date, tommorrow);
    }).toList();
  }

  static Future<List<TaskModel>> getLast30daysTasks(
      List<TaskModel> allTask) async {
    final last30Days = DateTime.now().subtract(const Duration(days: 30));
    if (allTask.isEmpty) return allTask;
    return allTask.where((task) {
      return task.date!.isAfter(last30Days) &&
          task.date!.isBefore(DateUtils.dateOnly(DateTime.now()));
    }).toList();
  }

  static Future<List<TaskModel>> getCompletedTasks(
      List<TaskModel> allTask) async {
    if (allTask.isEmpty) return allTask;
    return allTask.where((task) {
      return task.isCompleted;
    }).toList();
  }

  static Future<List<TaskModel>> getCompletedTasksForToday(
      List<TaskModel> allTask) async {
    if (allTask.isEmpty) return allTask;
    final taskForToday = await getTodaysTasks(allTask);
    return taskForToday.where((task) {
      return task.isCompleted;
    }).toList();
  }

  static Future<List<TaskModel>> getActiveTasksForToday(
      List<TaskModel> allTask) async {
    if (allTask.isEmpty) return allTask;

    final taskForToday = await getTodaysTasks(allTask);
    return taskForToday.where((task) {
      return !task.isCompleted;
    }).toList();
  }

  static Future<List<TaskModel>> getInCompletedTasks(
      List<TaskModel> allTask) async {
    if (allTask.isEmpty) return allTask;
    return allTask.where((task) {
      return !task.isCompleted;
    }).toList();
  }
}
