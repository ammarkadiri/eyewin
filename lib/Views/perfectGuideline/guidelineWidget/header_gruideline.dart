import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_weight.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/channel_data_provider.dart';
import 'package:provider/provider.dart';

class HeaderGuideline extends StatelessWidget {
  final ScrollController headerController;
  final int clusterCount;
  final double productWidth;
  const HeaderGuideline({
    super.key,
    required this.headerController,
    required this.clusterCount,
    required this.productWidth,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChannelDataProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          SizedBox(
            width: productWidth,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).kpi_product,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryBlack,
                      fontWeight: AppFontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    S.of(context).prd_guideline_header,
                    style: TextStyle(
                      fontSize: 8,
                      color: AppColors.primaryBlack,
                      fontWeight: AppFontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 100,
            color: AppColors.dividerColor,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: headerController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  provider.channelData!.channelsData!.length,
                  (clusterIndex) {
                    return Row(
                      children: [
                        Container(
                          width:
                              (MediaQuery.of(context).size.width -
                                  productWidth) /
                              3,
                          height: 100,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                provider
                                        .channelData!
                                        .channelsData![clusterIndex]
                                        .name ??
                                    "",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primaryBlack,
                                  fontWeight: AppFontWeight.bold,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 100,
                          color: AppColors.dividerColor,
                          margin: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
