import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_back_icon.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class TopBarGuideline extends StatelessWidget {
  const TopBarGuideline({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomBackIcon(),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              S.of(context).guidelines_ps,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryWhitColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.of(context).change_filter,
              style: TextStyle(fontSize: 11, color: AppColors.filterGreyColor),
            ),
          ),
        ),
      ],
    );
  }
}
