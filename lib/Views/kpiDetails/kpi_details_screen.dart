import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/widgets/sliver_list.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class KpiDetailsScreen extends StatelessWidget {
  final KPIModel item;
  final int index;
  final int customerId;
  final List<ProductMustItem>? listProducts;
  final List<PriceMustItem>? listPrice;
  final List<PlaceMustItem>? listPlace;
  final List<PromoMustItem>? listPromo;

  const KpiDetailsScreen({
    super.key,
    required this.item,
    required this.index,
    required this.customerId,
    this.listProducts,
    this.listPrice,
    this.listPlace,
    this.listPromo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          _KpiSliverAppBar(item: item),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, _) => SliverListWidget(
                productList: listProducts,
                item: item,
                placeItem: listPlace,
                priceList: listPrice,
                promoItem: listPromo,
                kpiId: int.parse(item.kpiId.toString()),
                customerId: customerId,
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiSliverAppBar extends StatelessWidget {
  final KPIModel item;

  const _KpiSliverAppBar({required this.item});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250,
      automaticallyImplyLeading: false,
      leadingWidth: 40,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      backgroundColor: item.backgroundStart ?? Colors.black,
      forceElevated: true,
      actions: [_ChangeFilterButton(item)],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 40, bottom: 60),
        title: Text(
          item.title ?? "",
          style: const TextStyle(color: Colors.white),
        ),
        background: Hero(
          tag: 'kpi_item_${item.kpiId}',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  item.backgroundStart ?? Colors.black,
                  item.backgroundMid ?? Colors.black,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
          ),
        ),
      ),
    );
  }
}

class _ChangeFilterButton extends StatelessWidget {
  final KPIModel item;
  const _ChangeFilterButton(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryWhitColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            "Change Filter",
            style: TextStyle(
              fontSize: 11,
              color: item.backgroundStart ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
