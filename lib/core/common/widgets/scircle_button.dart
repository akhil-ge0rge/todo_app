import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/colurs.dart';
import 'fading_text.dart';

class SCircleButton extends StatelessWidget {
  const SCircleButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.width,
    required this.height,
    required this.textColor,
    required this.fontSize,
    required this.bgColor,
    this.fontWeight,
  });
  final VoidCallback? onPressed;
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final Color textColor;
  final Color bgColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Container(
          height: height.h,
          width: width.w,
          color: bgColor,
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: fontWeight ?? FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
