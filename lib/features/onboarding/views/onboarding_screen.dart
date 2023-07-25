import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/core/common/widgets/fading_text.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/features/onboarding/views/widgets/first_page.dart';
import 'package:todo_app/features/onboarding/views/widgets/second_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColurs.darkBackground,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: const [
                OnBoardingFirstPage(),
                OnBoardingSecondPage(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10)
                  .copyWith(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Ionicons.chevron_forward_circle,
                          color: AppColurs.light,
                          size: 30,
                        ),
                        FadingText(
                          text: "skip",
                          color: AppColurs.light,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect:
                        const ExpandingDotsEffect(dotWidth: 10, dotHeight: 10),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
