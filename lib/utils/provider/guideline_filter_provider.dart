import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/guidline_model.dart'; 
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/models/price_model.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';

class TabIndexProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  List<ProductMustItem> _productList = [];
  List<PriceMustItem> _priceList = [];
  List<Guideline> _guidelinePlaceList = [];
  List<Guideline> _guidelinePromoList = [];
  List<ProductMustItem> get productList => _productList;
  List<PriceMustItem> get priceList => _priceList;
  List<Guideline> get guidelinePlaceList => _guidelinePlaceList;
  List<Guideline> get guidelinePromoList => _guidelinePromoList;
  Future<void> init(BuildContext context) async {
    _currentIndex = 0;
    _productList = GlobalMethods.perfectGuidelinesProducts(context);
    _priceList = [];

    notifyListeners();
  }

  void changeIndex(BuildContext context, int newIndex) {
    _currentIndex = newIndex;

    if (newIndex == 0) {
      _productList = GlobalMethods.perfectGuidelinesProducts(context);
    } else if (newIndex == 1) {
      _priceList = GlobalMethods.perfectGuidelinesPrices(context);
    } else if (newIndex == 2) {
      _guidelinePlaceList = GlobalMethods.perfectGuidelinesPlaces(context);
    } else if (newIndex == 3) {
      _guidelinePromoList = GlobalMethods.perfectGuidelinesPromo(context);
    }
    notifyListeners();
  }
}
