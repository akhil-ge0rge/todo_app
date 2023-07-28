import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/features/authentication/view/otp_verification_screen.dart';

class AuthenticationRepository {
  const AuthenticationRepository({required this.auth});
  final FirebaseAuth auth;

  sendOTP({required String phoneNumber, required BuildContext context}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
        CoreUtils.showSnackBar(
            context: context,
            message: "${exception.code} : ${exception.message}");
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPVerificationScreen(),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
