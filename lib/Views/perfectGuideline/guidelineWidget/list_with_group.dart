import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/guideline_item.dart';

class ListWithGroup extends StatelessWidget {
  final List<ScrollController> rowControllers;
  final int clusterCount;
  final double productWidth;
  final List<Guideline>? guidelineList;

  const ListWithGroup({
    Key? key,
    required this.rowControllers,
    required this.clusterCount,
    required this.productWidth,
    this.guidelineList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (guidelineList == null || guidelineList!.isEmpty) {
      return const Center(child: Text("No guidelines available"));
    }

    return Expanded(
      child: GroupedListView<Guideline, GroupHeader>(
        elements: guidelineList!,
        groupBy:
            (guideline) => GroupHeader(
              groupName: guideline.groupName ?? 'Unknown Group',
              thumbnail: guideline.groupThumbnail,
            ),
        groupSeparatorBuilder:
            (GroupHeader group) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.groupName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlack,
                      ),
                    ),
                    if (group.thumbnail != null && group.thumbnail!.isNotEmpty)
                      const SizedBox(height: 10),
                    if (group.thumbnail != null && group.thumbnail!.isNotEmpty)
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: group.thumbnail ?? "",
                          height: 200,
                          width: 100,
                          fit: BoxFit.contain,
                          placeholder:
                              (_, __) => const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                          errorWidget:
                              (_, __, ___) =>
                                  const Icon(Icons.broken_image, size: 60),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        itemBuilder: (context, guideline) {
          final index = guidelineList!.indexOf(guideline);
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: AppColors.dividerColor,
              ),
              GuidelineItem(
                clusterCount: clusterCount,
                index: index,
                productWidth: productWidth,
                rowControllers: rowControllers,
                groupedGuidelineList: guideline,
              ),
              Container(height: 1, color: AppColors.dividerColor),
            ],
          );
        },
        itemComparator: (a, b) => a.id!.compareTo(b.id!),
        useStickyGroupSeparators: false,
        floatingHeader: false,
        order: GroupedListOrder.ASC,
      ),
    );
  }
}

class GroupHeader {
  final String groupName;
  final String? thumbnail;

  const GroupHeader({required this.groupName, this.thumbnail});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupHeader &&
          groupName == other.groupName &&
          thumbnail == other.thumbnail;

  @override
  int get hashCode => groupName.hashCode ^ (thumbnail?.hashCode ?? 0);
}
