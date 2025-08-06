import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/dual_list_widget.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/guidelineWidget/top_bar.dart';
import 'package:flutter_salesman_module/components/custom_button.dart';
import 'package:flutter_salesman_module/components/custom_filter_tab.dart';
import 'package:flutter_salesman_module/components/custom_loader.dart'
    show GlobalLoader;
import 'package:flutter_salesman_module/models/product_must_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_weight.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/guideline_filter_provider.dart';
import 'package:flutter_salesman_module/utils/provider/loader_provider.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:provider/provider.dart';

class PerfectGuidelineMainScreen extends StatefulWidget {
  const PerfectGuidelineMainScreen({super.key});

  @override
  State<PerfectGuidelineMainScreen> createState() =>
      _PerfectGuidelineMainScreenState();
}

class _PerfectGuidelineMainScreenState extends State<PerfectGuidelineMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late LinkedScrollControllerGroup _controllersGroup;
  late ScrollController _headerController;
  late List<ScrollController> _rowControllers;
  final int clusterCount = 4;

  List<Map<String, dynamic>> filterTab = [
    {"title": "Product", "id": 0},
    {"title": "Pricing", "id": 1},
    {"title": "Placement", "id": 2},
    {"title": "Promotion", "id": 3},
  ];
  List<ProductMustItem> groupedProductList = [];
  bool isReady = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: filterTab.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => loadProductList());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _headerController.dispose();
    for (final controller in _rowControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> loadProductList() async {
    final tabIndexProvider = context.read<TabIndexProvider>();
    tabIndexProvider.init(context);

    setState(() {
      _controllersGroup = LinkedScrollControllerGroup();
      _headerController = _controllersGroup.addAndGet();
      _rowControllers = List.generate(
        groupedProductList.length,
        (_) => _controllersGroup.addAndGet(),
      );
      isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    final isLoading = context.watch<LoaderProvider>().isLoading;

    if (!isReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    _tabController.index = tabIndexProvider.currentIndex;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightGreyColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightGreyColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: TopBarGuideline(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomContainer(
                  backgroundColor: AppColors.primaryWhitColor,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  borderRadius: 17,
                  showShadow: true,
                  child: Center(
                    child: Text(
                      'Document Guidelines',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.filterGreyColor,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomFilterTabBar(
                        tabs: filterTab,
                        controller: _tabController,
                        selectedIndex: tabIndexProvider.currentIndex,
                        onTap: (index) async {
                          tabIndexProvider.changeIndex(context, index);
                          context.read<LoaderProvider>().show('list');
                          await Future.delayed(const Duration(seconds: 2));
                          context.read<LoaderProvider>().hide('list');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              isLoading("list")
                  ? const GlobalLoader(loaderKey: 'list')
                  : tabIndexProvider.currentIndex == 0
                  ? DualScrollLists(
                    groupedProductList: tabIndexProvider.productList,
                  )
                  : tabIndexProvider.currentIndex == 1
                  ? DualScrollLists(
                    groupedPriceList: tabIndexProvider.priceList,
                  )
                  : tabIndexProvider.currentIndex == 2
                  ? DualScrollLists(
                    groupedGuidelinePlaceList:
                        tabIndexProvider.guidelinePlaceList,
                  )
                  : tabIndexProvider.currentIndex == 3
                  ? DualScrollLists(
                    groupedGuidelinePlaceList:
                        tabIndexProvider.guidelinePromoList,
                  )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
