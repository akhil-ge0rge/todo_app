import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/res/colurs.dart';

class CoreUtils {
  const CoreUtils._();
  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showLoader(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Column(
          children: [
            const CircularProgressIndicator(
              color: AppColurs.lightBlue,
            ),
            if (message != null)
              Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColurs.lightBlue,
                ),
              )
          ],
        ),
      ),
    );
  }
}
