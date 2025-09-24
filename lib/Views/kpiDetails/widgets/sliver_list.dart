import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/widgets/group_name.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/widgets/list_button.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/widgets/list_content.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class SliverListWidget extends StatefulWidget {
  final List<PlaceMustItem>? placeItem;
  final List<PromoMustItem>? promoItem;
  final List<ProductMustItem>? productList;
  final List<PriceMustItem?>? priceList;
  final Guideline? guidlineItem;
  final KPIModel item;
  final int kpiId;
  final int customerId;
  const SliverListWidget({
    super.key,
    this.placeItem,
    this.promoItem,
    this.productList,
    this.priceList,
    this.guidlineItem,
    required this.kpiId,
    required this.item,
    required this.customerId,
  });

  @override
  State<SliverListWidget> createState() => _SliverListWidgetState();
}

class _SliverListWidgetState extends State<SliverListWidget> {
  late Map<String, ProductMustItem> lastItemsByGroup;

  @override
  void initState() {
    super.initState();
    lastItemsByGroup = {};

    if (widget.kpiId == 1 && widget.productList != null) {
      final groups = <String, List<ProductMustItem>>{};
      for (var item in widget.productList!) {
        final key = item.categoryName ?? 'Unknown';
        groups.putIfAbsent(key, () => []).add(item);
      }
      groups.forEach((key, list) {
        lastItemsByGroup[key] = list.last;
      });

      Future.microtask(() {
        final providerProduct = Provider.of<MissionUpload2Provider>(
          context,
          listen: false,
        );
        final loginProvider = context.read<LoginProvider>();
        final userId = loginProvider.user?.userId ?? 0;
        final mission = providerProduct.getMission(widget.customerId, userId);

        if (mission != null && (mission.product.isEmpty)) {
          providerProduct.initializeProductList(
            customerId: widget.customerId,
            userId: userId,
            productList: widget.productList!,
          );
        }
      });
    }
    if (widget.kpiId == 3 && widget.placeItem != null) {
      Future.microtask(() {
        final providerProduct = Provider.of<MissionUpload2Provider>(
          context,
          listen: false,
        );
        final loginProvider = context.read<LoginProvider>();
        final userId = loginProvider.user?.userId ?? 0;
        final mission = providerProduct.getMission(widget.customerId, userId);

        if (mission != null && (mission.place.isEmpty)) {
          providerProduct.initializePlaceList(
            customerId: widget.customerId,
            userId: userId,
            placeList: widget.placeItem!,
          );
        }
      });
    }
    if (widget.kpiId == 4 && widget.promoItem != null) {
      Future.microtask(() {
        final providerProduct = Provider.of<MissionUpload2Provider>(
          context,
          listen: false,
        );
        final loginProvider = context.read<LoginProvider>();
        final userId = loginProvider.user?.userId ?? 0;
        final mission = providerProduct.getMission(widget.customerId, userId);

        if (mission != null && (mission.promo.isEmpty)) {
          providerProduct.initializePromoList(
            customerId: widget.customerId,
            userId: userId,
            promoList: widget.promoItem!,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.kpiId == 1) _buildProductItems(),
        if (widget.kpiId == 2) _buildPriceItems(),
        if (widget.kpiId == 3) _buildPlaceItems(),
        if (widget.kpiId == 4) _buildPromoItems(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildGroupedList<T>({
    required List<T> elements,
    required String Function(T) groupBy,
    required Widget Function(String) groupSeparatorBuilder,
    required Widget Function(BuildContext, T) itemBuilder,
  }) {
    return GroupedListView<T, String>(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      elements: elements,
      groupBy: groupBy,
      groupSeparatorBuilder: groupSeparatorBuilder,
      itemBuilder: itemBuilder,
      order: GroupedListOrder.ASC,
      useStickyGroupSeparators: true,
      floatingHeader: false,
    );
  }

  Widget _buildProductItems() {
    final products = widget.productList!.whereType<ProductMustItem>().toList();
    final loginProvider = Provider.of<LoginProvider>(context);
    final user = loginProvider.user;

    return _buildGroupedList<ProductMustItem>(
      elements: products,
      groupBy: (p) => p.categoryName ?? '',
      groupSeparatorBuilder:
          (group) => GroupNameWidget(
            groupTitle: group,
            backgroundStart: widget.item.backgroundStart,
            backgroundMid: widget.item.backgroundMid?.withValues(alpha: 0.5),
          ),
      itemBuilder: (context, product) {
        final groupName = product.categoryName ?? '';
        final groupIds =
            products
                .where((p) => p.categoryName == groupName)
                .map((p) => p.id!)
                .toList();
        final isLast = lastItemsByGroup[groupName] == product;

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                final missionProvider = context.read<MissionUpload2Provider>();

                missionProvider.toggleProductSelection(
                  customerId: widget.customerId,
                  productId: product.id!,
                  userId: loginProvider.user!.userId ?? 0,
                  groupProductIds: groupIds,
                  dataCollectorUserId: user!.userId!,
                  visitDate: DateTime.now().toUtc().toIso8601String(),
                  productItems: products,
                );
              },
              child: ListContentWidget(
                productList: product,
                kpiId: 1,
                custmoerId: widget.customerId,
                placeItems: widget.placeItem,
                promoItems: widget.promoItem,
                priceItems: widget.priceList,
              ),
            ),
            if (isLast)
              ListButtonWidget(
                onTap: () async {
                  final provider = context.read<MissionUpload2Provider>();
                  final selectionStatus = provider.getSelectionStatus(
                    customerId: widget.customerId,
                    userId: loginProvider.user!.userId ?? 0,
                  );
                  final allSelected = groupIds.every(
                    (id) => selectionStatus[id] == true,
                  );
                  if (allSelected) return;

                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: Text(S.of(context).warning_title),
                          content: Text(
                            S.of(context).are_you_sure_to_set_all_available,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(S.of(context).no),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(S.of(context).yes),
                            ),
                          ],
                        ),
                  );

                  if (confirmed == true) {
                    final loginProvider = Provider.of<LoginProvider>(
                      context,
                      listen: false,
                    );
                    final user = loginProvider.user;
                    provider.addGroupSelection(
                      customerId: widget.customerId,
                      userId: loginProvider.user!.userId ?? 0,
                      groupProductIds: groupIds,
                      dataCollectorUserId: user!.userId!,
                      visitDate: DateTime.now().isUtc.toString(),
                      productItems: products,
                    );
                  }
                },
                groupTitle: groupName,
                backgroundColor:
                    context
                            .watch<MissionUpload2Provider>()
                            .getSelectionStatus(
                              customerId: widget.customerId,
                              userId: loginProvider.user!.userId ?? 0,
                            )
                            .entries
                            .where((e) => groupIds.contains(e.key))
                            .every((e) => e.value == true)
                        ? AppColors.buttonGreenTopColor
                        : Colors.grey,
              ),
          ],
        );
      },
    );
  }

  Widget _buildPriceItems() {
    final prices = widget.priceList!.whereType<PriceMustItem>().toList();
    return _buildGroupedList<PriceMustItem>(
      elements: prices,
      groupBy: (p) => p.categoryName ?? '',
      groupSeparatorBuilder:
          (group) => GroupNameWidget(
            groupTitle: group,
            backgroundStart: widget.item.backgroundStart,
            backgroundMid: widget.item.backgroundMid?.withValues(alpha: 0.5),
          ),
      itemBuilder:
          (context, price) => Column(
            children: [
              ListContentWidget(
                priceList: price,
                kpiId: 2,
                custmoerId: widget.customerId,
                placeItems: widget.placeItem,
                promoItems: widget.promoItem,
                priceItems: widget.priceList,
              ),
            ],
          ),
    );
  }

  Widget _buildPlaceItems() {
    final places = widget.placeItem!.whereType<PlaceMustItem>().toList();
    return _buildGroupedList<PlaceMustItem>(
      elements: places,
      groupBy: (p) => p.location ?? '',
      groupSeparatorBuilder: (group) {
        final first = places.firstWhere(
          (e) => e.location == group,
          orElse: () => PlaceMustItem(categoryName: "No Category"),
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                group,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryBlack,
                  fontFamily: AppFontFamily.cairoBold,
                ),
              ),
            ),
            GroupNameWidget(
              groupTitle: first.categoryName ?? '',
              backgroundStart: widget.item.backgroundStart,
              backgroundMid: widget.item.backgroundMid?.withValues(alpha: 0.5),
            ),
          ],
        );
      },
      itemBuilder:
          (context, place) => _buildImageCard(
            name: place.name,
            thumbnail: place.thumbnail,
            isCompetition: place.isCompetition ?? false,
            categoryName: place.categoryName ?? '',
            content: ListContentWidget(
              placeItem: place,
              kpiId: 3,
              custmoerId: widget.customerId,
              placeItems: widget.placeItem,
              promoItems: widget.promoItem,
              priceItems: widget.priceList,
            ),
          ),
    );
  }

  Widget _buildPromoItems() {
    final promos = widget.promoItem!.whereType<PromoMustItem>().toList();
    return _buildGroupedList<PromoMustItem>(
      elements: promos,
      groupBy: (p) => p.name ?? '',
      groupSeparatorBuilder: (group) {
        final first = promos.firstWhere(
          (e) => e.name == group,
          orElse: () => PromoMustItem(categoryName: "No Category"),
        );
        return GroupNameWidget(
          groupTitle: first.categoryName ?? '',
          backgroundStart: widget.item.backgroundStart,
          backgroundMid: widget.item.backgroundMid?.withValues(alpha: 0.5),
        );
      },
      itemBuilder:
          (context, promo) => _buildImageCard(
            name: promo.name,
            thumbnail: promo.thumbnail,
            isCompetition: promo.isCompetition ?? false,
            categoryName: promo.categoryName ?? '',
            content: ListContentWidget(
              promoItem: promo,
              kpiId: 4,
              custmoerId: widget.customerId,
              placeItems: widget.placeItem,
              promoItems: widget.promoItem,
              priceItems: widget.priceList,
            ),
          ),
    );
  }

  Widget _buildImageCard({
    required String? name,
    required String? thumbnail,
    required bool isCompetition,
    required String categoryName,
    required Widget content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primaryWhitColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name ?? '',
                    style: const TextStyle(
                      fontFamily: AppFontFamily.cairoBold,
                      fontSize: 16,
                    ),
                  ),
                  if (isCompetition)
                    CustomAssetImage(
                      imagePath: AppAssets.competitionImage,
                      width: 20,
                      height: 20,
                      color: AppColors.primaryBlack,
                    ),
                ],
              ),
            ),
            if (thumbnail != null)
              CachedNetworkImage(
                imageUrl: thumbnail,
                height: 200,
                width: 100,
                fit: BoxFit.contain,
                placeholder:
                    (context, url) => const SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.broken_image, size: 60),
              ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(thickness: 3, color: AppColors.dividerGrey),
            ),
            content,
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
