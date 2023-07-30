import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/core/res/media_res.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/features/authentication/controller/authentication_controller.dart';

class OTPVerificationScreen extends ConsumerWidget {
  final String verificationId;
  const OTPVerificationScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(),
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
              onCompleted: (otp) async {
                CoreUtils.showLoader(context);
                await ref.read(authControllerProvider).verifyOTP(
                    context: context, otp: otp, verificationId: verificationId);
              },
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
