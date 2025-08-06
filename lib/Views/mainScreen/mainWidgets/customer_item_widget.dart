import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/mainScreen/mainWidgets/kpi_circle.dart';
import 'package:flutter_salesman_module/components/custom_divider.dart';
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

class CustomerItemWidget extends StatelessWidget {
  final Customer? customer;
  final String clustName;
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
    this.uploadDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.storeAuditScreen,
          arguments: {
            'channelId': channelId,
            'customerName': customer!.name ?? "",
            'customerId': customer!.id,
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
                    customer!.name ?? "Customer Name",
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
                            productFrequency == 0 || productMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIProduct,
                        endColor:
                            productFrequency == 0 || productMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIPlaceLight,
                      ),
                      SizedBox(width: 5),
                      KpiCircles(
                        isShow: true,
                        endColor:
                            priceFrequency == 0 || priceMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIPriceLight,
                        startColor:
                            priceFrequency == 0 || priceMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIPrice,
                      ),
                      SizedBox(width: 5),
                      KpiCircles(
                        isShow: true,
                        startColor:
                            placeFrequency == 0 || placeMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIPlace,
                        endColor:
                            placeFrequency == 0 || placeMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIPlaceLight,
                      ),
                      SizedBox(width: 5),
                      KpiCircles(
                        isShow: true,
                        endColor:
                            promoFrequency == 0 || promoMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIPromotionLight,
                        startColor:
                            promoFrequency == 0 || promoMustItem.isEmpty
                                ? AppColors.lightGrey2Color
                                : AppColors.colorKPIPromotion,
                      ),
                    ],
                  ),
                ],
              ),

              Text(
                clustName,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textGreyColor,
                  height: 1.5,
                ),
              ),
              Text(
                customer!.commercialRegistrationNumber ?? "CRN",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textGreyColor,
                  height: 1,
                ),
              ),
              Consumer<MissionUploadDateProvider>(
                builder: (context, provider, _) {
                  final uploadDate = provider.getUploadDateForCustomer(
                    customer!.id ?? 0,
                  );
                  final timeText = GlobalMethods.formatTimeAgo(uploadDate);
                  return Text(
                    uploadDate != null
                        ? timeText
                        : GlobalMethods.formatTimeAgo(customer?.lastVisitDate),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryBlack,
                    ),
                  );
                },
              ),
              Text(
                customer!.linkedRetailer != null
                    ? "Linked with ${customer!.linkedRetailer!.name}"
                    : "Engage customer to download EYE Win!",
                style: TextStyle(
                  fontSize: 12,
                  color:
                      customer!.linkedRetailer != null
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
