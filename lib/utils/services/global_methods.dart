import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/models/channel_data_model.dart';
import 'package:flutter_salesman_module/models/customer_model.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/channel_data_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GlobalMethods {
  static String getLocale() {
    final String defaultLocale = Platform.localeName;
    String localeDevice = "";

    if (defaultLocale.contains("fr")) {
      localeDevice = "fr";
    } else if (defaultLocale.contains("en")) {
      localeDevice = "en";
    } else if (defaultLocale.contains("ar")) {
      localeDevice = "ar";
    } else {
      localeDevice = "en";
    }
    return localeDevice;
    // return "ar";
  }

  static Future<void> checkBatteryLevel(BuildContext context) async {
    final battery = Battery();
    final level = await battery.batteryLevel;

    if (level <= 5) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(S.of(context).battery_warning_level_10),
              content: Text('Battery is at $level%. Please charge your phone!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
      ).then((value) {
        Navigator.pop(context);
      });
    } else if (level <= 10) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Low Battery'),
              content: Text('Battery is at $level%. Please charge your phone!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  ///This method to call the login and data API
  static String getFormattedGmtDate() {
    final now = DateTime.now().toUtc();
    final formatter = DateFormat('EEE, dd MMM yyyy HH:mm:ss', 'en_US');
    final formatted = formatter.format(now);
    return '$formatted GMT';
  }

  /// This method to get last visited customer
  static String formatTimeAgo(BuildContext context, DateTime? lastVisitDate) {
    if (lastVisitDate == null) return "Visited date not available";

    final localLastVisit =
        lastVisitDate.toLocal(); // convert server UTC date to local
    final now = DateTime.now(); // local time
    final diff = now.difference(localLastVisit);

    if (diff.inDays >= 7) {
      final weeks = (diff.inDays / 7).floor();
      return "${S.of(context).visited} ${weeks == 1 ? S.of(context).one_week_ago : S.of(context).weeks_ago(weeks)}";
    } else if (diff.inDays >= 1) {
      return "${S.of(context).visited} ${diff.inDays == 1 ? S.of(context).yesterday : S.of(context).days_ago(diff.inDays)}";
    } else if (diff.inHours >= 1) {
      return "${S.of(context).visited} ${diff.inHours == 1 ? S.of(context).an_hour_ago : "${diff.inHours} ${S.of(context).hours}"}";
    } else if (diff.inMinutes >= 1) {
      return "${S.of(context).visited} ${diff.inMinutes == 1 ? S.of(context).a_minute_ago : "${diff.inMinutes} ${S.of(context).mins}"}";
    } else {
      return "${S.of(context).visited} ${"${diff.inSeconds} ${S.of(context).secs}"}";
    }
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  ///This method is visit date to upload mission tio server
  static String stringDate() {
    // Get current UTC time
    final nowUtc = DateTime.now().toUtc();

    // Format it with +0000 hardcoded (like Android does)
    final formatter = DateFormat("yyyy-MM-dd HH:mm:ss '+0000'", 'en');
    return formatter.format(nowUtc);
  }

  static String getLocationFromGroup(String group) {
    switch (group.toLowerCase()) {
      case 'primary':
        return 'Primary Displays'; // or localize this string as needed
      case 'secondary':
        return 'Secondary Displays'; // or localize this string as needed
      default:
        return group; // fallback to original group string
    }
  }

  static String extractErrorMessage(String error) {
    try {
      final jsonPart =
          error.startsWith('Exception: ') ? error.substring(10).trim() : error;

      final decoded = json.decode(jsonPart);
      if (decoded is Map && decoded.containsKey('Message')) {
        return decoded['Message'].toString();
      }
    } catch (_) {}
    return error;
  }

  static void showApiErrorMessage(
    BuildContext context,
    String title,
    String description,
  ) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
      messageText: Text(
        description,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
    ).show(context);
  }

  static ChannelsData? getChannelById(int channelId, BuildContext context) {
    final provider = Provider.of<ChannelDataProvider>(context, listen: false);
    return provider.channelData?.channelsData?.cast<ChannelsData?>().firstWhere(
      (channel) => channel?.id == channelId,
      orElse: () => null,
    );
  }

  static List<KPIModel> getKpiList(
    int channelId,
    BuildContext context,
    matchingChannel,
    Customer? customer, {
    bool? showProduct,
    bool? showPrice,
    bool? showPlace,
    bool? showPromo,
  }) {
    if (matchingChannel == null) return [];

    List<Guideline> listGuidLinesPromo = [];
    List<Guideline> listGuidLinesPlace = [];
    List<KPIModel> listKpi = [];

    for (var promo in matchingChannel.promoMustItems ?? []) {
      for (var guidlines in promo.guidelines ?? []) {
        listGuidLinesPromo.add(
          Guideline(
            description: guidlines.description,
            guidelineId: guidlines.guidelineId,
            id: guidlines.id,
            pdf: guidlines.pdf,
            thumbnail: guidlines.thumbnail,
          ),
        );
      }
    }
    for (var place in matchingChannel.placeMustItems ?? []) {
      for (var guidlines in place.guidelines ?? []) {
        listGuidLinesPlace.add(
          Guideline(
            description: guidlines.description,
            guidelineId: guidlines.guidelineId,
            id: guidlines.id,
            pdf: guidlines.pdf,
            thumbnail: guidlines.thumbnail,
          ),
        );
      }
    }

    if (showProduct ??
        (matchingChannel.productKPIFrequency != null &&
                matchingChannel.productKPIFrequency! >
                    customer!.productKPIVisits) &&
            (matchingChannel.productMustItems != null &&
                matchingChannel.productMustItems!.isNotEmpty)) {
      listKpi.add(
        KPIModel(
          title: S.of(context).product,
          backgroundStart: AppColors.colorKPIProduct,
          backgroundMid: AppColors.colorKPIProductLight,
          kpiId: "1",
          description: matchingChannel.productMustItems!.length.toString(),
          showPercentages: false,
        ),
      );
    }

    if (showPrice ??
        (matchingChannel.priceKPIFrequency != null &&
                matchingChannel.priceKPIFrequency! >
                    customer!.priceKPIVisits) &&
            (matchingChannel.priceMustItems != null &&
                matchingChannel.priceMustItems!.isNotEmpty)) {
      listKpi.add(
        KPIModel(
          backgroundStart: AppColors.colorKPIPrice,
          backgroundMid: AppColors.colorKPIPriceLight,
          kpiId: "2",
          title: S.of(context).price,
          description: matchingChannel.priceMustItems!.length.toString(),
          showPercentages: false,
        ),
      );
    }

    if (showPlace ??
        (matchingChannel.placeKPIFrequency != null &&
                matchingChannel.placeKPIFrequency! >
                    customer!.placeKPIVisits) &&
            (matchingChannel.placeMustItems != null &&
                matchingChannel.placeMustItems!.isNotEmpty)) {
      listKpi.add(
        KPIModel(
          backgroundStart: AppColors.colorKPIPlace,
          backgroundMid: AppColors.colorKPIPlaceLight,
          kpiId: '3',
          title: S.of(context).place,
          description: listGuidLinesPlace.length.toString(),
          showPercentages: false,
        ),
      );
    }

    if (showPromo ??
        (matchingChannel.promoKPIFrequency != null &&
                matchingChannel.promoKPIFrequency! >
                    customer!.promoKPIVisits) &&
            (matchingChannel.promoMustItems != null &&
                matchingChannel.promoMustItems!.isNotEmpty)) {
      listKpi.add(
        KPIModel(
          kpiId: '4',
          title: S.of(context).promo,
          backgroundStart: AppColors.colorKPIPromotion,
          backgroundMid: AppColors.colorKPIPromotionLight,
          description: listGuidLinesPromo.length.toString(),
          showPercentages: false,
        ),
      );
    }

    return listKpi;
  }

  /// this method to make the double number as int and ex:1,500
  static String formatPrice(double value) {
    final int intValue = value.toInt();
    return NumberFormat('#,###').format(intValue);
  }

  /// This method to group all products for all channels
  static List<ProductMustItem> perfectGuidelinesProducts(BuildContext context) {
    final provider = context.read<ChannelDataProvider>();
    final Map<int?, ProductMustItem> productMap = {};

    for (var channel in provider.channelData?.channelsData ?? []) {
      for (var product in channel.productMustItems ?? []) {
        if (productMap.containsKey(product.skuId)) {
          final existing = productMap[product.skuId]!;

          if (!(existing.channelId?.contains(channel.id) ?? false)) {
            existing.channelId?.add(channel.id ?? 0);
            existing.channelName?.add(channel.name ?? '');
          } else {}
        } else {
          final newItem = ProductMustItem(
            id: product.id,
            skuId: product.skuId,
            skuName: product.skuName,
            skuNameAr: product.skuNameAr,
            skuNameFr: product.skuNameFr,
            skuOrder: product.skuOrder,
            skuImage: product.skuImage,
            categoryId: product.categoryId,
            categoryName: product.categoryName,
            brandId: product.brandId,
            brandName: product.brandName,
            isCompetition: product.isCompetition,
            channelId: [channel.id ?? 0],
            channelName: [channel.name ?? ''],
          );
          productMap[product.skuId] = newItem;
        }
      }
    }

    return productMap.values.toList();
  }

  /// This method to group all prices for all channels
  static List<PriceMustItem> perfectGuidelinesPrices(BuildContext context) {
    final provider = context.read<ChannelDataProvider>();
    final Map<int?, PriceMustItem> priceMap = {};

    final channels = provider.channelData?.channelsData ?? [];

    for (var channel in channels) {
      final prices = channel.priceMustItems ?? [];

      for (var price in prices) {
        if (priceMap.containsKey(price.skuId)) {
          final existing = priceMap[price.skuId]!;

          if (!(existing.channelId?.contains(channel.id) ?? false)) {
            existing.channelId?.add(channel.id ?? 0);
            existing.channelName?.add(channel.name ?? '');

            existing.checkRangeByChannel?[channel.id ?? 0] =
                price.checkRange ?? false;
            existing.collectPriceByChannel?[channel.id ?? 0] =
                price.collectPrice ?? false;
            existing.minPricesByChannel?[channel.id ?? 0] = price.minPrice ?? 0;
            existing.maxPricesByChannel?[channel.id ?? 0] = price.maxPrice ?? 0;
          }
        } else {
          final channelId = channel.id ?? 0;
          final newItem = PriceMustItem(
            id: price.id,
            skuId: price.skuId,
            skuName: price.skuName,
            skuNameAr: price.skuNameAr,
            skuNameFr: price.skuNameFr,
            skuOrder: price.skuOrder,
            skuImage: price.skuImage,
            categoryId: price.categoryId,
            categoryName: price.categoryName,
            brandId: price.brandId,
            brandName: price.brandName,
            isCompetition: price.isCompetition,
            channelId: [channelId],
            channelName: [channel.name ?? ''],
            checkRangeByChannel: {channelId: price.checkRange ?? false},
            collectPriceByChannel: {channelId: price.collectPrice ?? false},
            minPricesByChannel: {channelId: price.minPrice ?? 0},
            maxPricesByChannel: {channelId: price.maxPrice ?? 0},
          );
          priceMap[price.skuId] = newItem;
        }
      }
    }

    return priceMap.values.toList();
  }

  static List<Guideline> perfectGuidelinesPlaces(BuildContext context) {
    final provider = context.read<ChannelDataProvider>();
    final Map<int?, Guideline> guidelineMap = {};
    final channels = provider.channelData?.channelsData ?? [];

    for (var channel in channels) {
      final places = channel.placeMustItems ?? [];

      for (var place in places) {
        final guidelines = place.guidelines ?? [];

        for (var guideline in guidelines) {
          if (guideline == null) continue;

          final guidelineId = guideline.guidelineId;
          final channelId = channel.id ?? 0;
          final channelName = channel.name ?? '';

          if (guidelineMap.containsKey(guidelineId)) {
            // Already added this guidelineId — append channel data
            final existing = guidelineMap[guidelineId]!;

            if (!existing.channelId!.contains(channelId)) {
              existing.channelId!.add(channelId);
            }
            if (!existing.channelName!.contains(channelName)) {
              existing.channelName!.add(channelName);
            }
          } else {
            // First time seeing this guidelineId — create new entry

            guidelineMap[guidelineId] = Guideline(
              id: guideline.id,
              description: guideline.description,
              guidelineId: guideline.guidelineId,
              pdf: guideline.pdf,
              thumbnail: guideline.thumbnail,
              groupThumbnail: place.thumbnail,
              isCompetition: place.isCompetition,
              channelId: [channelId],
              channelName: [channelName],
              groupId: place.groupId,
              groupName: place.name,
            );
          }
        }
      }
    }

    final result = guidelineMap.values.toList();

    return result;
  }

  static List<Guideline> perfectGuidelinesPromo(BuildContext context) {
    final provider = context.read<ChannelDataProvider>();
    final Map<int?, Guideline> guidelineMap = {};
    final channels = provider.channelData?.channelsData ?? [];

    for (var channel in channels) {
      final promotions = channel.promoMustItems ?? [];

      for (var promo in promotions) {
        final guidelines = promo.guidelines ?? [];

        for (var guideline in guidelines) {
          final guidelineId = guideline.guidelineId;
          final channelId = channel.id ?? 0;
          final channelName = channel.name ?? '';

          if (guidelineMap.containsKey(guidelineId)) {
            // Already added this guidelineId — append channel data
            final existing = guidelineMap[guidelineId]!;

            if (!existing.channelId!.contains(channelId)) {
              existing.channelId!.add(channelId);
            }
            if (!existing.channelName!.contains(channelName)) {
              existing.channelName!.add(channelName);
            }
          } else {
            guidelineMap[guidelineId] = Guideline(
              id: guideline.id,
              description: guideline.description,
              guidelineId: guideline.guidelineId,
              pdf: guideline.pdf,
              thumbnail: guideline.thumbnail,
              groupThumbnail: promo.thumbnail,
              isCompetition: promo.isCompetition,
              channelId: [channelId],
              channelName: [channelName],
              groupId: promo.groupId,
              groupName: promo.name,
            );
          }
        }
      }
    }

    final result = guidelineMap.values.toList();

    return result;
  }

  static double toDouble(String? value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }
}
