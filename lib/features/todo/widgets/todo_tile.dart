import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/fading_text.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/extentions/date_extentions.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/todo/model/task_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      required this.task,
      this.onEdit,
      this.onDelete,
      this.color,
      required this.endIcon,
      this.bottomMargin});
  final TaskModel task;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Widget endIcon;
  final double? bottomMargin;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: bottomMargin == null
              ? null
              : EdgeInsets.only(bottom: bottomMargin!),
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
                      color: color ?? AppColurs.getRandomColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  WhiteSpace(
                    width: 15,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadingText(
                          text: task.title!,
                          overFlow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        WhiteSpace(
                          height: 3,
                        ),
                        FadingText(
                          text: task.description!,
                          overFlow: TextOverflow.ellipsis,
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
                            WhiteSpace(
                              width: 5,
                            ),
                            if (!task.isCompleted)
                              IconButton(
                                onPressed: onEdit,
                                icon: Icon(
                                  MaterialCommunityIcons.circle_edit_outline,
                                  color: AppColurs.light,
                                ),
                              ),
                            WhiteSpace(
                              width: 1,
                            ),
                            IconButton(
                              onPressed: onDelete,
                              icon: Icon(
                                MaterialCommunityIcons.delete_circle,
                                color: AppColurs.light,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              endIcon
            ],
          ),
        ),
      ],
    );
  }
}
