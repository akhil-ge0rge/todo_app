import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/core/helper/db_helper.dart';
import 'package:todo_app/core/utils/core_utils.dart';
import 'package:todo_app/features/authentication/view/otp_verification_screen.dart';
import 'package:todo_app/features/todo/views/home_screen.dart';

final authRepoProvider =
    Provider((ref) => AuthenticationRepository(auth: FirebaseAuth.instance));

class AuthenticationRepository {
  const AuthenticationRepository({required this.auth});
  final FirebaseAuth auth;

// send otp
  Future<void> sendOTP({
    required String phoneNumber,
    required BuildContext context,
  }) async {
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
            builder: (_) => OTPVerificationScreen(
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // verify otp

  Future<void> verifyOTP({
    required BuildContext context,
    required String otp,
    required String verificationId,
  }) async {
    try {
      void showSnackBar(String message) =>
          CoreUtils.showSnackBar(context: context, message: message);

      final credentaial = PhoneAuthProvider.credential(
        smsCode: otp,
        verificationId: verificationId,
      );
      final navigator = Navigator.of(context);

      final userCredential = await auth.signInWithCredential(credentaial);

      if (userCredential.user != null) {
        await DBHelper.createUser(isVerified: true);
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      } else {
        showSnackBar("Error Occured : Failed to Sign Up User");
      }
    } on FirebaseException catch (e) {
      CoreUtils.showSnackBar(
          context: context, message: "${e.code}${e.message}");
    } catch (e) {
      CoreUtils.showSnackBar(
          context: context,
          message: "505 : Error Occured : Failed to Sign Up User");
    }
  }
}
