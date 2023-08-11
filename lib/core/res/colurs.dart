import 'dart:math';
import 'dart:ui';

class AppColurs {
  const AppColurs._();
  static const Color darkBackground = Color(0xFF2a2b2e);
  static const Color light = Color(0xFFFFFFFF);
  static const Color red = Color(0xffd80000);
  static const Color lightBlue = Color(0xFF027EB5);
  static const Color darkGrey = Color(0xFF707870);
  static const Color lightGrey = Color(0xFF667781);
  static const Color green = Color(0xFF0AA31E);
  static const Color yellow = Color(0xFFF9F988);
  static const Color lightBackground = Color(0x58797777);
  static const Color greyBackground = Color(0xFF282C33);

  static const colors = [
    Color(0xffd80000),
    Color(0xff027eb5),
    Color(0xfff50fcf),
    Color(0xffac0ff5),
    Color(0xff0aa31e),
    Color(0xfff9f900),
  ];

  static Color getRandomColor() {
    final random = Random();
    int randomIndex = random.nextInt(AppColurs.colors.length);
    return AppColurs.colors.elementAt(randomIndex);
  }
}
