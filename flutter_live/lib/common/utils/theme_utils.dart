import 'package:flutter/material.dart';
import 'package:flutter_live/common/constants/live_colors.dart';

class ThemeUtils {
  static Theme getTextFieldTheme(Widget textField) {
    return Theme(
      data: ThemeData(
          primaryColor: LiveColors.getColor(LiveColors.lightGrey),
          accentColor: LiveColors.getColor(LiveColors.lightGrey),
          hintColor: LiveColors.getColor(LiveColors.lightGrey)),
      child: textField,
    );
  }
}
