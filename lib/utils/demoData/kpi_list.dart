import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

final List<KPIModel> kpiList = [
  KPIModel(
    kpiId: '1',
    title: 'Product',
    backgroundStart: AppColors.colorKPIProduct,
    backgroundMid: AppColors.colorKPIProductLight,
    description: 'Track product performance',
    
  ),
  KPIModel(
    kpiId: '2',
    title: 'Price',
    backgroundStart: AppColors.colorKPIPrice,
    backgroundMid: AppColors.colorKPIPriceLight,
    description: 'Analyze pricing strategy',
  ),
  KPIModel(
    kpiId: '3',
    title: 'Place',
    backgroundStart: AppColors.colorKPIPlace,
    backgroundMid: AppColors.colorKPIPlaceLight,
    description: 'Evaluate place/distribution effectiveness',
  ),
  KPIModel(
    kpiId: '4',
    title: 'Promotion',
    backgroundStart: AppColors.colorKPIPromotion,
    backgroundMid: AppColors.colorKPIPromotionLight,
    description: 'Monitor promotional efforts',
  ),
];
