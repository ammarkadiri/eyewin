import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter/widgets.dart';

List<KPIModel> getKpiList(BuildContext context) {
  return [
    KPIModel(
      kpiId: '1',
      title: S.of(context).product,
      backgroundStart: AppColors.colorKPIProduct,
      backgroundMid: AppColors.colorKPIProductLight,
      description: 'Track product performance',
    ),
    KPIModel(
      kpiId: '2',
      title: S.of(context).price,
      backgroundStart: AppColors.colorKPIPrice,
      backgroundMid: AppColors.colorKPIPriceLight,
      description: 'Analyze pricing strategy',
    ),
    KPIModel(
      kpiId: '3',
      title: S.of(context).place,
      backgroundStart: AppColors.colorKPIPlace,
      backgroundMid: AppColors.colorKPIPlaceLight,
      description: 'Evaluate place/distribution effectiveness',
    ),
    KPIModel(
      kpiId: '4',
      title: S.of(context).promo,
      backgroundStart: AppColors.colorKPIPromotion,
      backgroundMid: AppColors.colorKPIPromotionLight,
      description: 'Monitor promotional efforts',
    ),
  ];
}
