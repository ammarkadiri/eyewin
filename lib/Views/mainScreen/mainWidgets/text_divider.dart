import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_divider.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).my_customers,
          style: TextStyle(
            color: AppColors.darkGrey,
            fontSize: 18,
            fontFamily: AppFontFamily.cairoExtraBold,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: CustomDivider(
            color: AppColors.lightGrey2Color,
            thickness: 1,
            showShadow: false,
          ),
        ),
      ],
    );
  }
}
