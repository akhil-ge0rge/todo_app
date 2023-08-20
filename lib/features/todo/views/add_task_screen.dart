import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/common/widgets/scircle_button.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/features/todo/apps/task_date_provider.dart';
import 'package:todo_app/features/todo/apps/task_provider.dart';
import 'package:todo_app/features/todo/model/task_model.dart';

import '../../../core/common/widgets/filled_SField.dart';

class AddTaskScreen extends StatefulHookConsumerWidget {
  const AddTaskScreen({super.key, this.task});
  final TaskModel? task;

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.task != null) {
        ref.read(taskDateProvider.notifier).changeDate(widget.task!.date!);
        ref
            .read(taskStartTimeProvider.notifier)
            .changeTime(widget.task!.startTime!);
        ref
            .read(taskEndTimeProvider.notifier)
            .changeTime(widget.task!.endTime!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: widget.task?.title);
    final descriptionController =
        useTextEditingController(text: widget.task?.description);
    final hintStyle = GoogleFonts.poppins(
        fontSize: 15, color: AppColurs.lightGrey, fontWeight: FontWeight.bold);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final dateNotifier = ref.read(taskDateProvider.notifier);
    final startTimeNotifier = ref.read(taskStartTimeProvider.notifier);
    final endTimeNotifier = ref.read(taskEndTimeProvider.notifier);

    final dateProvider = ref.watch(taskDateProvider);
    final startProvider = ref.watch(taskStartTimeProvider);
    final endProvider = ref.watch(taskEndTimeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColurs.light,
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: [
              WhiteSpace(
                height: 25,
              ),
              FilledSField(
                width: double.infinity,
                height: 50,
                textEditingController: titleController,
                hintText: "Add title",
                hintStyle: hintStyle,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
              WhiteSpace(
                height: 15,
              ),
              FilledSField(
                width: double.infinity,
                height: 100,
                textEditingController: descriptionController,
                hintText: "Add description",
                hintStyle: hintStyle,
              ),
              WhiteSpace(
                height: 20,
              ),
              SCircleButton(
                text:
                    dateProvider == null ? "Set Date" : dateNotifier.getDate()!,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      minTime: DateTime.now(),
                      maxTime: DateTime(DateTime.now().year + 1),
                      theme: DatePickerTheme(
                        doneStyle: GoogleFonts.poppins(
                            color: AppColurs.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ), onConfirm: (date) {
                    dateNotifier.changeDate(date);
                  });
                },
                width: double.infinity,
                height: 50,
                textColor: AppColurs.light,
                fontSize: 18,
                bgColor: AppColurs.lightGrey,
                fontWeight: FontWeight.bold,
              ),
              WhiteSpace(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SCircleButton(
                    text: startProvider == null
                        ? "Start Time"
                        : startTimeNotifier.getTime()!,
                    onPressed: () {
                      if (dateProvider == null) {
                        CoreUtils.showSnackBar(
                            context: context,
                            message: "Please Pick a Date First");
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        currentTime: dateProvider,
                        onConfirm: (time) {
                          startTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    width: screenWidth * 0.45,
                    height: 50,
                    textColor: AppColurs.light,
                    fontSize: 18,
                    bgColor: AppColurs.lightGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  SCircleButton(
                    text: endProvider == null
                        ? "End Time"
                        : endTimeNotifier.getTime()!,
                    onPressed: () {
                      if (startProvider == null) {
                        CoreUtils.showSnackBar(
                            context: context,
                            message: "Please Pick Start Time First");
                        return;
                      }
                      DatePicker.showDateTimePicker(
                        context,
                        currentTime: dateProvider,
                        onConfirm: (time) {
                          endTimeNotifier.changeTime(time);
                        },
                      );
                    },
                    width: screenWidth * 0.45,
                    height: 50,
                    textColor: AppColurs.light,
                    fontSize: 18,
                    bgColor: AppColurs.lightGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              WhiteSpace(
                height: 25,
              ),
              SCircleButton(
                text: "Submit",
                onPressed: () async {
                  if (titleController.text.trim().isNotEmpty &&
                      descriptionController.text.trim().isNotEmpty &&
                      dateProvider != null &&
                      startProvider != null &&
                      endProvider != null) {
                    final title = titleController.text;
                    final desc = descriptionController.text;
                    final date = dateProvider;
                    final sTimer = startProvider;
                    final eTimer = endProvider;

                    debugPrint("title $title");
                    debugPrint("dec $desc");
                    debugPrint("date $date");
                    debugPrint("sTimer $sTimer");
                    debugPrint("eTimer $eTimer");
                    final navigator = Navigator.of(context);
                    CoreUtils.showLoader(context);
                    final task = TaskModel(
                      id: widget.task?.id,
                      repeat: widget.task == null ? true : widget.task!.repeat,
                      title: title,
                      description: desc,
                      date: date,
                      startTime: sTimer,
                      endTime: eTimer,
                      remind: widget.task == null ? true : widget.task!.remind,
                    );
                    if (widget.task != null) {
                      await ref
                          .read(taskProviderProvider.notifier)
                          .updateTask(task);
                    } else {
                      await ref
                          .read(taskProviderProvider.notifier)
                          .addTask(task);
                    }
                    navigator
                      ..pop()
                      ..pop();
                  } else {
                    CoreUtils.showSnackBar(
                        context: context, message: "All Field Required");
                  }
                },
                width: double.infinity,
                height: 50,
                textColor: AppColurs.light,
                fontSize: 18,
                bgColor: AppColurs.green,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
