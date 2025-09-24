import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class KpiCard extends StatelessWidget {
  final String tag;
  final String subTitle;
  final int index;
  final KPIModel? kpiItem;
  final bool? isShowPerc;
  final bool? isShowComplete;
  final int customerId;
  const KpiCard({
    super.key,
    required this.tag,
    required this.subTitle,
    required this.index,
    this.kpiItem,
    this.isShowPerc,
    this.isShowComplete,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    final missionProvider = context.watch<MissionUpload2Provider>();
    final loginProvider = context.read<LoginProvider>();
    final mission = missionProvider.getMission(
      customerId,
      loginProvider.user!.userId ?? 0,
    );

    double livePercent = 0.0;
    if (mission == null) {
      livePercent = 0.0;
    } else {
      switch (kpiItem?.kpiId) {
        case "1":
          livePercent = (GlobalMethods.toDouble(mission.productScore) / 100)
              .clamp(0.0, 1.0);
          break;
        case "2":
          livePercent = (GlobalMethods.toDouble(mission.priceScore) / 100)
              .clamp(0.0, 1.0);
          break;
        case "3":
          livePercent = (GlobalMethods.toDouble(mission.placeScore) / 100)
              .clamp(0.0, 1.0);
          break;
        case "4":
          livePercent = (GlobalMethods.toDouble(mission.promoScore) / 100)
              .clamp(0.0, 1.0);
          break;
        default:
          livePercent = 0.0;
      }
    }

    return Hero(
      tag: tag,
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kpiItem!.backgroundStart ?? Colors.black,
              kpiItem!.backgroundMid ?? Colors.black,
              kpiItem!.backgroundStart ?? Colors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        kpiItem!.title ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryWhitColor,
                          fontFamily: AppFontFamily.cairoExtraBold,
                        ),
                      ),
                    ),
                    Text(
                      kpiItem!.kpiId == "1" || kpiItem!.kpiId == "2"
                          ? "${kpiItem!.description} ${S.of(context).skus}"
                          : kpiItem!.kpiId == "3" || kpiItem!.kpiId == "4"
                          ? "${kpiItem!.description} ${S.of(context).guidelines_ps}"
                          : "",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryWhitColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isShowComplete ?? false)
                      Icon(Icons.check, color: AppColors.primaryWhitColor),

                    if (isShowPerc ?? false)
                      CircularPercentIndicator(
                        radius: 30,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        lineWidth: 5,
                        curve: Curves.decelerate,
                        percent: livePercent,
                        animationDuration: 2000,
                        progressColor: AppColors.primaryWhitColor,
                        backgroundColor: AppColors.primaryWhitColor.withValues(
                          alpha: 0.3,
                        ),
                        center: Text(
                          "${(livePercent * 100).toInt()}%",
                          style: const TextStyle(
                            color: AppColors.primaryWhitColor,
                            fontFamily: AppFontFamily.cairoBold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
