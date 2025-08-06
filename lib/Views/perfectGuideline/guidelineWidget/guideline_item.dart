import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/clust_item.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/guideline_filter_provider.dart';
import 'package:provider/provider.dart';

class GuidelineItem extends StatelessWidget {
  final double productWidth;
  final List<ScrollController> rowControllers;
  final int clusterCount;
  final int index;
  final ProductMustItem? groupedProductList;
  final PriceMustItem? groupedPriceList;
  final Guideline? groupedGuidelineList;

  const GuidelineItem({
    super.key,
    required this.productWidth,
    required this.rowControllers,
    required this.clusterCount,
    required this.index,
    this.groupedProductList,
    this.groupedPriceList,
    this.groupedGuidelineList,
  });

  @override
  Widget build(BuildContext context) {
    final tabIndex = Provider.of<TabIndexProvider>(context);
    final currentIndex = tabIndex.currentIndex;

    // Get image
    final String imageUrl =
        currentIndex == 0
            ? groupedProductList?.skuImage ?? ""
            : currentIndex == 1
            ? groupedPriceList?.skuImage ?? ""
            : groupedGuidelineList?.thumbnail ?? "";

    // Get name
    final String name =
        currentIndex == 0
            ? groupedProductList?.skuName ?? ""
            : currentIndex == 1
            ? groupedPriceList?.skuName ?? ""
            : groupedGuidelineList?.description ?? "";

    // Get channelId
    final List<int> channelId =
        currentIndex == 0
            ? (groupedProductList?.channelId ?? [])
            : currentIndex == 1
            ? (groupedPriceList?.channelId ?? [])
            : (groupedGuidelineList?.channelId ?? []);
    print(
      "groupedGuidelineList?.description${groupedGuidelineList?.description}",
    );

    return SizedBox(
      height: 100,
      child: Container(
        child: Row(
          children: [
            // Left image and name container
            Container(
              width: productWidth,
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                children: [
                  if (imageUrl.isNotEmpty) buildImage(imageUrl),
                  buildName(name),
                  if (tabIndex.currentIndex > 1 &&
                      groupedGuidelineList!.isCompetition!)
                    Column(
                      children: [
                        
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CustomAssetImage(
                            imagePath: AppAssets.competitionImage,
                            color: AppColors.primaryBlack,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Vertical Divider
            Container(width: 1, color: AppColors.dividerColor),

            // Cluster Grid
            ClustItem(
              clusterCount: clusterCount,
              item: groupedProductList,
              index: index,
              productWidth: productWidth,
              rowControllers: rowControllers,
              productChannelId: channelId,
              checkRangeByChannel: groupedPriceList?.checkRangeByChannel ?? {},
              collectPriceByChannel:
                  groupedPriceList?.collectPriceByChannel ?? {},
              maxPricesByChannel: groupedPriceList?.maxPricesByChannel ?? {},
              minPricesByChannel: groupedPriceList?.minPricesByChannel ?? {},
            ),
          ],
        ),
      ),
    );
  }

  // Image Builder
  Widget buildImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => const SizedBox(
              width: 60,
              height: 60,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
        errorWidget:
            (context, url, error) => const Icon(Icons.broken_image, size: 60),
      ),
    );
  }

  // Name Builder
  Widget buildName(String name) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AutoSizeText(
          name,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.bold,
          ),
          maxFontSize: 14,
          minFontSize: 8,
        ),
      ),
    );
  }
}
