import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/content_list_gruideline.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/header_gruideline.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/list_with_group.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/guideline_filter_provider.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';

class DualScrollLists extends StatefulWidget {
  final List<ProductMustItem>? groupedProductList;
  final List<PriceMustItem>? groupedPriceList;
  final List<Guideline>? groupedGuidelinePlaceList;
  const DualScrollLists({
    super.key,
    this.groupedProductList,
    this.groupedPriceList,
    this.groupedGuidelinePlaceList,
  });

  @override
  _DualScrollListsState createState() => _DualScrollListsState();
}

class _DualScrollListsState extends State<DualScrollLists> {
  late LinkedScrollControllerGroup _controllersGroup;
  late ScrollController _headerController;
  late List<ScrollController> _rowControllers;
  final int clusterCount = 2;

  @override
  void initState() {
    super.initState();
    _controllersGroup = LinkedScrollControllerGroup();
    _headerController = _controllersGroup.addAndGet();
    int length = 0;

    if (widget.groupedProductList != null) {
      length = widget.groupedProductList!.length;
    } else if (widget.groupedPriceList != null) {
      length = widget.groupedPriceList!.length;
    } else if (widget.groupedGuidelinePlaceList != null) {
      length = widget.groupedGuidelinePlaceList!.length;
    }
    _rowControllers = List.generate(
      length,
      (_) => _controllersGroup.addAndGet(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _headerController.dispose();
    for (final controller in _rowControllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);

    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.primaryWhitColor,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderGuideline(
              headerController: _headerController,
              clusterCount: clusterCount,
              productWidth: MediaQuery.of(context).size.width / 1.5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: AppColors.dividerColor,
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            ),
            tabIndexProvider.currentIndex > 1
                ? ListWithGroup(
                  rowControllers: _rowControllers,
                  clusterCount: clusterCount,
                  productWidth: MediaQuery.of(context).size.width / 1.5,
                  guidelineList:
                      tabIndexProvider.currentIndex == 2
                          ? tabIndexProvider.guidelinePlaceList
                          : tabIndexProvider.guidelinePromoList,
                )
                : ContentListGruideline(
                  rowControllers: _rowControllers,
                  clusterCount: clusterCount,
                  productWidth: MediaQuery.of(context).size.width / 1.5,
                  groupedProductList: tabIndexProvider.productList,
                  groupedPriceList: tabIndexProvider.priceList,
                ),
          ],
        ),
      ),
    );
  }
}
