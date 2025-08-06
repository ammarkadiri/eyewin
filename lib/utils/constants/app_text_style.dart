import 'package:flutter/material.dart';

import 'app_font_family.dart';
import 'colors.dart';

class TextStyles {
  static TextStyle textTitleStyle = TextStyle(
    fontSize: 24,
    color: AppColors.primaryBlack,
    fontFamily: AppFontFamily.cairoBold,
  );

  static TextStyle hintTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.darkGrey,
  );
  static TextStyle buttonTextStyle = TextStyle(
    color: AppColors.primaryWhitColor,
    fontSize: 14,
    fontFamily: AppFontFamily.cairoBold,
  );
}
