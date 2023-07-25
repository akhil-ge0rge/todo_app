import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/common/widgets/fading_text.dart';
import '../../../../core/common/widgets/white_space.dart';
import '../../../../core/res/colurs.dart';
import '../../../../core/res/media_res.dart';

class OnBoardingFirstPage extends StatelessWidget {
  const OnBoardingFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(MediaRes.todo),
          WhiteSpace(height: 50),
          const FadingText(
            text: "To-Do App",
            color: AppColurs.light,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
          WhiteSpace(height: 10),
          Text(
            "Welcome ! Do you want to clear task super fast with ToDO?",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColurs.light,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
