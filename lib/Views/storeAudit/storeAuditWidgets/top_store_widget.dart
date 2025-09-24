import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/components/custom_back_icon.dart';
import 'package:flutter_salesman_module/components/custom_divider.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/extentions/nav_extention.dart';
import 'package:flutter_salesman_module/utils/route/routes.dart';

class TopStoreWidget extends StatelessWidget {
  final String customerName;
  const TopStoreWidget({super.key, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryWhitColor,
      child: Column(
        children: [
          Row(
            children: [
              CustomBackIcon(),
              Expanded(
                child: Text(
                  customerName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 125,
                decoration: BoxDecoration(
                  color: AppColors.perfectStoreButtonColor,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CustomAssetImage(
                      imagePath: AppAssets.guidelines,
                      height: 38,
                      width: 38,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.perfectGuidelineScreen);
                        },
                        child: Text(
                          S.of(context).perfect_store_guidelines,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.primaryWhitColor,
                            fontFamily: AppFontFamily.cairoBold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.more_vert,
                  color: AppColors.primaryBlack,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          CustomDivider(
            color: AppColors.dividerColor,
            thickness: 1,
            showShadow: true,
          ),
        ],
      ),
    );
  }
}
