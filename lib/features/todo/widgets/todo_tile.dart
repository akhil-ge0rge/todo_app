import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/common/widgets/fading_text.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/extentions/date_extentions.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/todo/model/task_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.task,
  });
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColurs.lightGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                      color: AppColurs.getRandomColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  WhiteSpace(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadingText(
                        text: task.title!,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      WhiteSpace(
                        height: 3,
                      ),
                      FadingText(
                        text: task.description!,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      WhiteSpace(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: AppColurs.darkBackground,
                              border: Border.all(
                                  width: .3, color: AppColurs.darkGrey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "${task.startTime!.timeOnly} | ${task.endTime!.timeOnly}",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: AppColurs.light),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
