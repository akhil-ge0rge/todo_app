import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/common/widgets/filled_SField.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/helper/db_helper.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/authentication/view/sign_in_screen.dart';
import 'package:todo_app/features/todo/views/add_task_screen.dart';
import 'package:todo_app/features/todo/widgets/active_task.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final tabTextStyle = GoogleFonts.poppins(
        color: AppColurs.darkBackground,
        fontSize: 16,
        fontWeight: FontWeight.bold);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: IconButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        await DBHelper.deleteUser();
                        navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                            (route) => false);
                      },
                      icon: const Icon(
                        AntDesign.logout,
                        color: AppColurs.light,
                      ),
                    ),
                  ),
                  Text(
                    "Task Management",
                    style: GoogleFonts.poppins(
                        color: AppColurs.light,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: AppColurs.light,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTaskScreen(),
                          ));
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColurs.darkBackground,
                    ),
                  ),
                ],
              ),
              WhiteSpace(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const FilledSField(
                  height: 50,
                  width: double.maxFinite,
                  prefixIcon: Icon(
                    AntDesign.search1,
                    color: AppColurs.lightGrey,
                  ),
                  suffixIcon: Icon(
                    FontAwesome.sliders,
                    color: AppColurs.lightGrey,
                  ),
                  hintText: "Search",
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesome.tasks,
                  size: 20,
                  color: AppColurs.light,
                ),
                WhiteSpace(
                  width: 10,
                ),
                Text(
                  "Today's Taks",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppColurs.light,
                      fontSize: 18),
                ),
              ],
            ),
            WhiteSpace(
              height: 25,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColurs.light,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  color: AppColurs.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelPadding: EdgeInsets.zero,
                isScrollable: false,
                labelColor: AppColurs.lightBlue,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 24,
                  color: AppColurs.lightBlue,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: AppColurs.light,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: screenWidth * 0.5,
                      child: Center(
                        child: Text(
                          "Pending",
                          style: tabTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: screenWidth * 0.5,
                      child: Center(
                        child: Text(
                          "Completed",
                          style: tabTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            WhiteSpace(
              height: 20,
            ),
            SizedBox(
              height: screenHeight * 0.26,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    const ActiveTasks(),
                    Container(color: Colors.green, child: Text("data")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
