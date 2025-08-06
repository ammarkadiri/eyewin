import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/components/custom_buttom_sheet.dart';
import 'package:flutter_salesman_module/components/custom_button.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/enum/price_select_type.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:provider/provider.dart';

class ListContentWidget extends StatelessWidget {
  final PlaceMustItem? placeItem;
  final PromoMustItem? promoItem;
  final List<PlaceMustItem?>? placeItems;
  final List<PromoMustItem?>? promoItems;
  final List<PriceMustItem?>? priceItems;
  final ProductMustItem? productList;
  final PriceMustItem? priceList;
  final Guideline? guidlineItem;
  final int kpiId;
  final int custmoerId;

  const ListContentWidget({
    super.key,
    this.placeItem,
    this.promoItem,
    this.productList,
    this.priceList,
    this.guidlineItem,
    required this.kpiId,
    required this.custmoerId,
    required this.placeItems,
    required this.promoItems,
    this.priceItems,
  });

  @override
  Widget build(BuildContext context) {
    switch (kpiId) {
      case 1:
        return _buildProductItem(context);
      case 2:
        return _buildPriceItem(context);
      case 3:
        return _buildGuidelinesList(context, placeItem?.guidelines ?? []);
      case 4:
        return _buildGuidelinesList(context, promoItem?.guidelines ?? []);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildProductItem(BuildContext context) {
    final selectionProvider = context.watch<MissionUpload2Provider>();
    final loginProvider = Provider.of<LoginProvider>(context);
    final user = loginProvider.user;
    final isSelected = selectionProvider.getSelection(
      customerId: custmoerId,
      productId: productList?.id ?? 0,
      userId: user!.userId ?? 0,
    );
    final bgColor = isSelected == false ? Colors.red : Colors.green;

    return _buildCard(
      context: context,
      imageUrl: productList?.skuImage,
      iscomp: productList?.isCompetition,
      title: productList?.skuName,
      trailing: _buildIconCircle(
        icon: isSelected == null || isSelected ? Icons.check : Icons.close,
        backgroundColor: bgColor,
        isCompetition: productList?.isCompetition ?? false,
      ),
    );
  }

  Widget _buildPriceItem(BuildContext context) {
    final selectionProvider = context.watch<MissionUpload2Provider>();
    final loginProvider = context.read<LoginProvider>();

    final userId = loginProvider.user!.userId ?? 0;

    final selected = selectionProvider.getSelectionByUserId(
      customerId: custmoerId,
      userId: userId,
      productId: priceList!.id!,
    );

    final enteredPrice = selectionProvider.getEnteredPrice(
      customerId: custmoerId,
      userId: userId,
      productId: priceList!.id!,
    );

    // Debug print outputs
    debugPrint('getSelectionByUserId output: $selected');
    debugPrint('getEnteredPrice output: $enteredPrice');

    return _buildCard(
      context: context,
      imageUrl: priceList?.skuImage,
      title: priceList?.skuName,
      iscomp: priceList?.isCompetition,
      subtitleWidgets: [
        if (priceList?.minPrice != null && priceList?.maxPrice != null)
          _buildPriceRange(priceList!),
        if (enteredPrice != null && enteredPrice > 0)
          _buildEnteredPrice(enteredPrice),
      ],
      trailing: _buildPriceActions(context, selected),
    );
  }

  Widget _buildPriceRange(PriceMustItem item) => Row(
    children: [
      CustomAssetImage(
        imagePath: AppAssets.priceTargetImage,
        width: 15,
        height: 15,
      ),
      const SizedBox(width: 5),
      Text(GlobalMethods.formatPrice(item.minPrice ?? 0)),
      const SizedBox(width: 10),
      Container(width: 5, height: 1, color: AppColors.primaryBlack),
      const SizedBox(width: 10),
      Text(GlobalMethods.formatPrice(item.maxPrice ?? 0)),
    ],
  );

  Widget _buildEnteredPrice(double price) => Row(
    children: [
      CustomAssetImage(imagePath: AppAssets.actualPrice, width: 15, height: 15),
      const SizedBox(width: 5),
      Text(GlobalMethods.formatPrice(price)),
    ],
  );

  Widget _buildPriceActions(BuildContext context, SelectionType? selected) {
    if (priceList!.checkRange!) {
      return Row(
        children: [
          _buildSelectableIcon(
            context: context,
            isSelected: selected == SelectionType.correct,
            icon: Icons.check,
            color: AppColors.buttonGreenTopColor,
            onTap: () => _handlePriceSelection(context, SelectionType.correct),
          ),
          const SizedBox(width: 5),
          _buildSelectableIcon(
            context: context,
            isSelected: selected == SelectionType.incorrect,
            icon: Icons.close,
            color: AppColors.buttonRedTopColor,
            onTap:
                () => _handlePriceSelection(context, SelectionType.incorrect),
          ),
        ],
      );
    } else if (priceList!.collectPrice!) {
      return CustomContainer(
        gradient: [
          AppColors.colorKPIPrice,
          AppColors.colorKPIPriceLight,
          AppColors.colorKPIPrice,
        ],
        borderRadius: 15,
        onTap:
            () => customBottomSheet(
              context,
              custmoerId,
              priceList: priceList,
              priceItems: priceItems,
            ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            "Capture Price",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void _handlePriceSelection(BuildContext context, SelectionType type) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final selectionProvider = Provider.of<MissionUpload2Provider>(
      context,
      listen: false,
    );
    final user = loginProvider.user;
    if (!priceList!.collectPrice!) {
      selectionProvider.selectPrice(
        customerId: custmoerId,
        userId: user!.userId ?? 0,
        selection: type,
        priceItem: priceList!,

        productId: priceList!.id!,
      );
    } else {
      customBottomSheet(
        context,
        custmoerId,
        priceList: priceList,
        priceItems: priceItems,
      );
    }
  }

  Widget _buildGuidelinesList(
    BuildContext context,
    List<Guideline?> guidelines,
  ) {
    final selectionProvider = context.watch<MissionUpload2Provider>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.separated(
        itemCount: guidelines.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder:
            (_, __) => const Divider(height: 20, color: AppColors.dividerGrey),
        itemBuilder: (context, index) {
          final loginProvider = Provider.of<LoginProvider>(
            context,
            listen: false,
          );
          final user = loginProvider.user;
          final item = guidelines[index];
          if (item == null) return const SizedBox.shrink();

          final selected =
              (kpiId == 3)
                  ? selectionProvider.getPlaceSelection(
                    customerId: custmoerId,
                    userId: user!.userId ?? 0,
                    groupId: placeItem!.groupId!,
                    guidelineId: item.id!,
                  )
                  : (kpiId == 4)
                  ? selectionProvider.getPromoSelection(
                    customerId: custmoerId,
                    userId: user!.userId ?? 0,
                    groupId: promoItem!.groupId!,
                    guidelineId: item.id!,
                  )
                  : null;

          return _buildCard(
            context: context,
            withCardStyle: false,
            title: item.description,
            trailing: Row(
              children: [
                _buildSelectableIcon(
                  context: context,
                  isSelected: selected == SelectionType.correct,
                  icon: Icons.check,
                  color: const Color.fromRGBO(16, 206, 104, 1),
                  onTap: () {
                    debugPrint(
                      "Tapped correct for kpiId=$kpiId, guidelineId=${item.id}",
                    );

                    if (kpiId == 4) {
                      selectionProvider.selectPromoGuideline(
                        customerId: custmoerId,
                        userId: user!.userId ?? 0,
                        groupId: promoItem!.groupId!,
                        guidelineId: item.id!,
                        selection: SelectionType.correct,
                      );
                    } else if (kpiId == 3) {
                      selectionProvider.selectPlaceGuideline(
                        customerId: custmoerId,
                        userId: user!.userId ?? 0,
                        groupId: placeItem!.groupId!,
                        guidelineId: item.id!,
                        selection: SelectionType.correct,
                      );
                    }
                  },
                ),
                const SizedBox(width: 5),
                _buildSelectableIcon(
                  context: context,
                  isSelected: selected == SelectionType.incorrect,
                  icon: Icons.close,
                  color: AppColors.buttonRedTopColor,
                  onTap: () {
                    debugPrint(
                      "Tapped incorrect for kpiId=$kpiId, guidelineId=${item.id}",
                    );

                    if (kpiId == 4) {
                      selectionProvider.selectPromoGuideline(
                        customerId: custmoerId,
                        userId: user!.userId ?? 0,
                        groupId: promoItem!.groupId!,
                        guidelineId: item.id!,
                        selection: SelectionType.incorrect,
                      );
                    } else if (kpiId == 3) {
                      selectionProvider.selectPlaceGuideline(
                        customerId: custmoerId,
                        userId: user!.userId ?? 0,
                        groupId: placeItem!.groupId!,
                        guidelineId: item.id!,
                        selection: SelectionType.incorrect,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    String? imageUrl,
    String? title,
    bool? iscomp,
    List<Widget>? subtitleWidgets,
    required Widget trailing,
    bool withCardStyle = true,
  }) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                height: 60,
                width: 60,
                fit: BoxFit.contain,
                placeholder:
                    (_, __) => const CircularProgressIndicator(strokeWidth: 2),
                errorWidget:
                    (_, __, ___) => const Icon(Icons.broken_image, size: 60),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: AppFontFamily.cairoBold,
                        ),
                      ),
                    if (subtitleWidgets != null) ...subtitleWidgets,
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 10),
                  iscomp ?? false
                      ? CustomAssetImage(
                        imagePath: AppAssets.competitionImage,
                        width: 15,
                        height: 15,
                        color: AppColors.primaryBlack,
                      )
                      : SizedBox.square(dimension: 15),
                  SizedBox(height: 10),
                  trailing,
                  SizedBox(height: 10),
                  SizedBox.square(dimension: 25),
                ],
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );

    if (!withCardStyle) return content;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryWhitColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6),
          ],
        ),
        child: content,
      ),
    );
  }

  Widget _buildSelectableIcon({
    required BuildContext context,
    required bool isSelected,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Opacity(
      opacity: isSelected ? 1.0 : 0.3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(child: Icon(icon, color: AppColors.primaryWhitColor)),
        ),
      ),
    );
  }

  Widget _buildIconCircle({
    required IconData icon,
    required Color backgroundColor,
    required bool isCompetition,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      child: Center(child: Icon(icon, color: AppColors.primaryWhitColor)),
    );
  }
}
