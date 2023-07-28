import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/core/common/widgets/scircle_widget.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/core/res/media_res.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              MediaRes.todo,
            ),
            WhiteSpace(
              height: 50,
            ),
            Pinput(
              length: 6,
              onCompleted: (value) {},
              defaultPinTheme: PinTheme(
                textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 23),
                width: 60,
                decoration: BoxDecoration(
                  color: AppColurs.light,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
