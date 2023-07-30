import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_date_provider.g.dart';

@riverpod
class TaskDate extends _$TaskDate {
  @override
  DateTime? build() => null;

  void changeDate(DateTime date) {
    state = date;
  }

  String? getDate() {
    if (state == null) return null;
    return DateFormat('yyyy-MM-dd').format(state!);
  }

  void reset() => state = null;
}

@riverpod
class TaskStartTime extends _$TaskStartTime {
  @override
  DateTime? build() => null;

  void changeTime(DateTime time) {
    state = time;
  }

  String? getTime() {
    if (state == null) return null;
    return DateFormat('hh:mm').format(state!);
  }

  void reset() => state = null;
}

@riverpod
class TaskEndTime extends _$TaskEndTime {
  @override
  DateTime? build() => null;

  void changeTime(DateTime time) {
    state = time;
  }

  String? getTime() {
    if (state == null) return null;
    return DateFormat('hh:mm').format(state!);
  }

  void reset() => state = null;
}
