import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/components/custom_button.dart';
import 'package:flutter_salesman_module/components/custom_text_field.dart';
import 'dart:async';

import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/enum/price_select_type.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:provider/provider.dart';

Future<T?> customBottomSheet<T>(
  BuildContext context,
  int customerId, {
  Color? backgroundColor,
  PriceMustItem? priceList,
  List<PriceMustItem?>? priceItems,
}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final GlobalKey _contentKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  final TextEditingController shelfPriceController = TextEditingController();
  final FocusNode shelfPriceFocusNode = FocusNode();
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
    ),
    builder: (context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double maxHeight = screenHeight * 0.80;

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            shelfPriceFocusNode.requestFocus();
            final RenderBox? box =
                _contentKey.currentContext?.findRenderObject() as RenderBox?;
            final double contentHeight = box?.size.height ?? 0;

            if (contentHeight > maxHeight && scrollController.hasClients) {
              try {
                await Future.delayed(const Duration(milliseconds: 300));
                await scrollController.animateTo(
                  50,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
                await Future.delayed(const Duration(milliseconds: 100));
                await scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } catch (_) {}
            }
          });

          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: SizedBox(
                        key: _contentKey,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  CustomAssetImage(
                                    imagePath: priceList!.skuImage ?? "",
                                    height: 180,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          priceList.skuName ??
                                              "Unnamed Product",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFontFamily.cairoBold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        if (priceList.minPrice != null &&
                                            priceList.maxPrice != null)
                                          Row(
                                            children: [
                                              CustomAssetImage(
                                                imagePath: AppAssets.targetGrey,
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                GlobalMethods.formatPrice(
                                                  priceList.minPrice ?? 0,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      AppFontFamily.cairoBold,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                    ),
                                                child: Container(
                                                  width: 5,
                                                  height: 1,
                                                  color: AppColors.primaryBlack,
                                                ),
                                              ),
                                              Text(
                                                GlobalMethods.formatPrice(
                                                  priceList.maxPrice ?? 0,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      AppFontFamily.cairoBold,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),

                              CustomTextField(
                                hint: "Shelf Price",
                                controller: shelfPriceController,
                                useUnderlineBorder: false,
                                borderRadius: 30,
                                focusNode: shelfPriceFocusNode,
                                keyboardType: TextInputType.number,
                              ),

                              SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomContainer(
                                      backgroundColor:
                                          AppColors.primaryWhitColor,
                                      border: Border.all(
                                        color: AppColors.buttonRedMidColor,
                                        width: 1,
                                      ),
                                      borderRadius: 30,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color:
                                                  AppColors.buttonRedMidColor,
                                              fontFamily:
                                                  AppFontFamily.cairoBold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: CustomContainer(
                                      gradient: [
                                        AppColors.colorKPIPrice,
                                        AppColors.colorKPIPriceLight,
                                        AppColors.colorKPIPrice,
                                      ],
                                      borderRadius: 30,
                                      onTap: () {
                                        final shelfPrice = double.tryParse(
                                          shelfPriceController.text.trim(),
                                        );

                                        if (shelfPrice == null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Please enter a valid number",
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        final minPrice = priceList.minPrice;
                                        final maxPrice = priceList.maxPrice;
                                        bool? isCorrect;

                                        if (minPrice == null &&
                                            maxPrice == null) {
                                          isCorrect = null;
                                        } else {
                                          isCorrect =
                                              shelfPrice >=
                                                  (minPrice ??
                                                      double
                                                          .negativeInfinity) &&
                                              shelfPrice <=
                                                  (maxPrice ?? double.infinity);
                                        }

                                        final selectionProvider =
                                            Provider.of<MissionUpload2Provider>(
                                              context,
                                              listen: false,
                                            );
                                        final loginProvider =
                                            Provider.of<LoginProvider>(
                                              context,
                                              listen: false,
                                            );
                                        final user = loginProvider.user;

                                        final type =
                                            isCorrect == null
                                                ? null
                                                : isCorrect
                                                ? SelectionType.correct
                                                : SelectionType.incorrect;
                                        final enteredPrice = double.tryParse(
                                          shelfPriceController.text.trim(),
                                        );
                                        selectionProvider.selectPrice(
                                          customerId: customerId,
                                          userId: user!.userId ?? 0,
                                          selection: type!,
                                          priceItem: priceList,
                                          price: enteredPrice,

                                          productId: priceList.id!,
                                        );

                                        Navigator.pop(context);
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          child: Text(
                                            "Save Price",
                                            style: TextStyle(
                                              color: AppColors.primaryWhitColor,
                                              fontFamily:
                                                  AppFontFamily.cairoBold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
