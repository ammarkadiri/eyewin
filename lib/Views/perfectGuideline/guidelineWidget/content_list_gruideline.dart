import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/guideline_item.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/guideline_filter_provider.dart';
import 'package:provider/provider.dart';

class ContentListGruideline extends StatelessWidget {
  final List<ScrollController> rowControllers;
  final int clusterCount;
  final double productWidth;
  final List<ProductMustItem>? groupedProductList;
  final List<PriceMustItem>? groupedPriceList;
  const ContentListGruideline({
    super.key,
    required this.rowControllers,
    required this.clusterCount,
    required this.productWidth,
    this.groupedProductList,
    this.groupedPriceList,
  });

  @override
  Widget build(BuildContext context) {
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: rowControllers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              children: [
                GuidelineItem(
                  clusterCount: clusterCount,
                  index: index,
                  productWidth: productWidth,
                  rowControllers: rowControllers,
                  groupedProductList: tabIndexProvider.productList[index],
                  groupedPriceList:
                      (tabIndexProvider.priceList.length > index)
                          ? tabIndexProvider.priceList[index]
                          : null,
                ),
                Container(
                  height: 1,
                  color: AppColors.dividerColor,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
