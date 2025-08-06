import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            offset: Offset(0, -4),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Version 3.20', style: TextStyle(fontSize: 9)),
            Row(
              children: [
                Text(
                  'Powered by',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 9),
                ),
                SizedBox(width: 5),
                CustomAssetImage(
                  imagePath: AppAssets.eye2Small,
                  width: 50,
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
