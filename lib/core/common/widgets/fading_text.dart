import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colurs.dart';

class FadingText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const FadingText({
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.fade,
      textAlign: textAlign ?? TextAlign.left,
      style: GoogleFonts.poppins(
        color: color ?? AppColurs.light,
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
