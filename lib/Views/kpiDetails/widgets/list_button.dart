import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_button.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class ListButtonWidget extends StatelessWidget {
  final String groupTitle;
  final Color backgroundColor;
  final VoidCallback? onTap;
  const ListButtonWidget({
    super.key,
    required this.groupTitle,
    this.backgroundColor = AppColors.buttonGreenTopColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: CustomContainer(
        backgroundColor: backgroundColor,
        onTap: onTap,
        width: MediaQuery.of(context).size.width,
        borderRadius: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'All $groupTitle SKUs available',
                    style: const TextStyle(
                      color: AppColors.primaryWhitColor,
                      fontFamily: AppFontFamily.cairoBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Icon(
                Icons.check,
                color: AppColors.primaryWhitColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
