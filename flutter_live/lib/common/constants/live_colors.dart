import 'dart:ui';

class LiveColors {
  static const int divider = 0xFFE5E5E5;
  static const int appPrimary = 0xFFFF0000;
  static const int text1 = 0xFF333333;
  static const int text2 = 0xFF666666;
  static const int text3 = 0xFF999999;
  static const int text4 = 0xFFFFBA00;
  static const int notice = 0xFFFF6135;
  static const int rankSubBar = 0xFFFF3E08;
  static const int lightGrey = 0xFFCCCCCC;
  static const int toastWarnBg = 0xFFF9F5;
  static const int white = 0xFFFFFFFF;

  static Color getColor(int colorInt){
    return Color(colorInt);
  }
}
