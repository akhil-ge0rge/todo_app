import 'package:flutter/material.dart';
import 'package:todo_app/core/res/colurs.dart';
import '../../../../core/common/widgets/scircle_button.dart';
import '../../../../core/common/widgets/white_space.dart';
import '../../../../core/res/media_res.dart';

class OnBoardingSecondPage extends StatelessWidget {
  const OnBoardingSecondPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(MediaRes.todo),
          WhiteSpace(height: 60),
          SCircleButton(
            onPressed: () {},
            bgColor: AppColurs.light,
            fontSize: 16,
            height: 50,
            fontWeight: FontWeight.w500,
            text: 'Login with phone',
            textColor: AppColurs.darkBackground,
            widht: 300,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
