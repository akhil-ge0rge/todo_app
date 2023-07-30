import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/scircle_widget.dart';
import '../../res/colurs.dart';

class FilledSField extends StatelessWidget {
  const FilledSField(
      {super.key,
      this.textEditingController,
      this.readOnly = false,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.keyboardType,
      this.textInputFormatter,
      this.hintStyle,
      required this.height,
      required this.width,
      this.maxLines = 1});

  final TextEditingController? textEditingController;
  final double height;
  final double width;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? textInputFormatter;
  final TextStyle? hintStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return SCircleWidget(
      height: height,
      width: width,
      color: AppColurs.light,
      wid: TextField(
        maxLines: maxLines,
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: textEditingController,
        keyboardType: keyboardType,
        inputFormatters: textInputFormatter,
        readOnly: readOnly,
        cursorColor: AppColurs.darkBackground,
        decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: hintStyle),
        style: GoogleFonts.poppins(
            fontSize: 18,
            color: AppColurs.darkBackground,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
