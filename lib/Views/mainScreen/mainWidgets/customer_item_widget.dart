import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/mainScreen/mainWidgets/kpi_circle.dart';
import 'package:flutter_salesman_module/components/custom_animated_dialog.dart';
import 'package:flutter_salesman_module/components/custom_divider.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/models/customer_model.dart';
import 'package:flutter_salesman_module/models/place_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/promo_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/extentions/nav_extention.dart';
import 'package:flutter_salesman_module/utils/provider/upload_mission_date.dart';
import 'package:flutter_salesman_module/utils/route/routes.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:provider/provider.dart';

class CustomerItemWidget extends StatefulWidget {
  final Customer? customer;
  final String clustName;
  final bool isImageMandatory;
  final int productFrequency;
  final int placeFrequency;
  final int promoFrequency;
  final int priceFrequency;
  final List<ProductMustItem> productMustItem;
  final List<PriceMustItem> priceMustItem;
  final List<PlaceMustItem> placeMustItem;
  final List<PromoMustItem> promoMustItem;
  final int channelId;
  final DateTime? uploadDate;
  final bool showProduct;
  final bool showPrice;
  final bool showPlace;
  final bool showPromo;
  const CustomerItemWidget({
    super.key,
    this.customer,
    required this.clustName,
    required this.productFrequency,
    required this.placeFrequency,
    required this.promoFrequency,
    required this.priceFrequency,
    required this.productMustItem,
    required this.priceMustItem,
    required this.placeMustItem,
    required this.promoMustItem,
    required this.channelId,
    this.isImageMandatory = false,
    this.uploadDate,
    required this.showProduct,
    required this.showPrice,
    required this.showPlace,
    required this.showPromo,
  });

  @override
  State<CustomerItemWidget> createState() => _CustomerItemWidgetState();
}

class _CustomerItemWidgetState extends State<CustomerItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final dateToCheck = widget.customer?.lastVisitDate;
        print("Last Visit Date: $dateToCheck");

        final todayDate = GlobalMethods.isToday(dateToCheck ?? DateTime.now());
        print("Is Today: $todayDate");
        if (dateToCheck != null && todayDate) {
          showTitleSubtitleDialog(
            context: context,
            title: S.of(context).warning_title,
            subtitle: S
                .of(context)
                .already_completed_mission_today(widget.customer!.name!),
            buttonText: S.of(context).ok,
          );
          return;
        }
        context.pushNamed(
          Routes.storeAuditScreen,
          arguments: {
            'channelId': widget.channelId,
            'customerName': widget.customer!.name ?? "",
            'customerId': widget.customer!.id,
            'customerPicture': widget.customer!.customerImagebyDC ?? "",
            'customer': widget.customer,
            'isImageMandatory': widget.isImageMandatory,
          },
        );
      },
      child: Container(
        color: AppColors.primaryWhitColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.customer!.name ?? "Customer Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkGrey,
                      fontFamily: AppFontFamily.cairoBold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      KpiCircles(
                        isShow: true,
                        startColor:
                            widget.showProduct
                                ? AppColors.colorKPIProduct
                                : AppColors.lightGrey2Color,
                        endColor:
                            widget.showProduct
                                ? AppColors.colorKPIPlaceLight
                                : AppColors.lightGrey2Color,
                      ),
                      SizedBox(width: 5),
                      KpiCircles(
                        isShow: true,
                        endColor:
                            widget.showPrice
                                ? AppColors.colorKPIPriceLight
                                : AppColors.lightGrey2Color,
                        startColor:
                            widget.showPrice
                                ? AppColors.colorKPIPrice
                                : AppColors.lightGrey2Color,
                      ),
                      SizedBox(width: 5),
                      KpiCircles(
                        isShow: true,
                        startColor:
                            widget.showPlace
                                ? AppColors.colorKPIPlace
                                : AppColors.lightGrey2Color,
                        endColor:
                            widget.showPlace
                                ? AppColors.colorKPIPlaceLight
                                : AppColors.lightGrey2Color,
                      ),
                      SizedBox(width: 5),
                      KpiCircles(
                        isShow: true,
                        endColor:
                            widget.showPromo
                                ? AppColors.colorKPIPromotionLight
                                : AppColors.lightGrey2Color,
                        startColor:
                            widget.showPromo
                                ? AppColors.colorKPIPromotion
                                : AppColors.lightGrey2Color,
                      ),
                    ],
                  ),
                ],
              ),

              Text(
                widget.clustName,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textGreyColor,
                  height: 1.5,
                ),
              ),
              Text(
                widget.customer!.commercialRegistrationNumber ?? "CRN",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textGreyColor,
                  height: 1,
                ),
              ),
              Consumer<MissionUploadDateProvider>(
                builder: (context, provider, _) {
                  final utcDate = widget.customer?.lastVisitDate;
                  final now = DateTime.now();
                  final timezoneOffset = now.timeZoneOffset;
                  final localDate = utcDate?.add(timezoneOffset);

                  return Text(
                    GlobalMethods.formatTimeAgo(context, localDate),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryBlack,
                    ),
                  );
                },
              ),
              Text(
                widget.customer!.linkedRetailer != null
                    ? S
                        .of(context)
                        .linked_with(
                          widget.customer!.linkedRetailer!.name ?? "",
                        )
                    : S.of(context).engage_customer,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      widget.customer!.linkedRetailer != null
                          ? AppColors.darkGreenColor
                          : AppColors.buttonRedMidColor,
                ),
              ),
              SizedBox(height: 10),
              CustomDivider(
                color: AppColors.dividerColor,
                thickness: 1,
                showShadow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
