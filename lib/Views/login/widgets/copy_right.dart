import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';

class CopyRightWidget extends StatelessWidget {
  const CopyRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Powered by',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 9),
              ),
              CustomAssetImage(
                imagePath: AppAssets.eye2Small,
                width: 50,
                height: 15,
              ),
              Text('Version 3.20', style: TextStyle(fontSize: 9)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAssetImage(
                imagePath: AppAssets.equalityBlue,
                width: 40,
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, right: 5),
                child: Text(
                  '© 2025, eQuality SARL',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
