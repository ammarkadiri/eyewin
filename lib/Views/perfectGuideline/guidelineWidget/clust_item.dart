import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/channel_data_provider.dart';
import 'package:flutter_salesman_module/utils/provider/guideline_filter_provider.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:provider/provider.dart';

class ClustItem extends StatelessWidget {
  final double productWidth;
  final List<ScrollController> rowControllers;
  final int clusterCount;
  final int index;
  final List<int> productChannelId;
  final Map<int, double>? minPricesByChannel;
  final Map<int, double>? maxPricesByChannel;
  final Map<int, bool>? checkRangeByChannel;
  final Map<int, bool>? collectPriceByChannel;
  final ProductMustItem? item;
  const ClustItem({
    super.key,
    required this.productWidth,
    required this.rowControllers,
    required this.clusterCount,
    required this.index,
    required this.productChannelId,
    this.minPricesByChannel,
    this.maxPricesByChannel,
    this.checkRangeByChannel,
    this.collectPriceByChannel,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChannelDataProvider>();
    final tabIndex = Provider.of<TabIndexProvider>(context);
    return Expanded(
      child: SingleChildScrollView(
        controller: rowControllers[index],
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(provider.channelData!.channelsData!.length, (
            clusterIndex,
          ) {
            final channelId =
                provider.channelData!.channelsData![clusterIndex].id ?? 0;

            final showCircle = productChannelId.contains(channelId);

            final showRange = checkRangeByChannel?[channelId] ?? false;
            final showCollect = collectPriceByChannel?[channelId] ?? false;
            final min = minPricesByChannel?[channelId] ?? 0;
            final max = maxPricesByChannel?[channelId] ?? 0;
            return Row(
              children: [
                Container(
                  color: AppColors.lightGreyColor,
                  width: (MediaQuery.of(context).size.width - productWidth) / 3,
                  child: Center(
                    child:
                        showCircle
                            ? tabIndex.currentIndex == 0 ||
                                    tabIndex.currentIndex == 2 ||
                                    tabIndex.currentIndex == 3
                                ? CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                      tabIndex.currentIndex == 2
                                          ? AppColors.colorKPIPlace
                                          : tabIndex.currentIndex == 3
                                          ? AppColors.colorKPIPromotion
                                          : AppColors.colorKPIProduct,
                                )
                                : showRange
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      GlobalMethods.formatPrice(min),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.colorKPIPrice,
                                        fontFamily: AppFontFamily.cairoBold,
                                      ),
                                    ),
                                    Text(
                                      GlobalMethods.formatPrice(max),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.colorKPIPrice,
                                        fontFamily: AppFontFamily.cairoBold,
                                      ),
                                    ),
                                  ],
                                )
                                : showCollect
                                ? Text(
                                  "Collect Price",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.colorKPIPrice,
                                    fontFamily: AppFontFamily.cairoBold,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                                : SizedBox()
                            : SizedBox.square(dimension: 20),
                  ),
                ),
                Container(
                  width: 1,
                  color: AppColors.dividerColor,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
