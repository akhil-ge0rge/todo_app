import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SCircleWidget extends StatelessWidget {
  const SCircleWidget(
      {super.key,
      required this.wid,
      this.radius,
      required this.height,
      required this.width,
      required this.color});
  final Widget wid;
  final double? radius;
  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 80),
          ),
        ),
      ),
      child: Container(
        height: height.h,
        width: width.w,
        color: color,
        child: wid,
      ),
    );
  }
}
