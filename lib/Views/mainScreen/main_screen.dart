import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_salesman_module/Views/mainScreen/mainWidgets/customer_item_widget.dart';
import 'package:flutter_salesman_module/Views/mainScreen/mainWidgets/main_kpi_list.dart';
import 'package:flutter_salesman_module/Views/mainScreen/mainWidgets/text_divider.dart';
import 'package:flutter_salesman_module/Views/mainScreen/mainWidgets/top_user_bar.dart';
import 'package:flutter_salesman_module/components/custom_button.dart';
import 'package:flutter_salesman_module/components/custom_divider.dart';
import 'package:flutter_salesman_module/components/custom_text_field.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/app_text_style.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/extentions/nav_extention.dart';
import 'package:flutter_salesman_module/utils/provider/channel_data_provider.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/route/routes.dart';
import 'package:flutter_salesman_module/widgets/powered_by_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController searchController = TextEditingController();
  late ChannelDataProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loginProvider = context.read<LoginProvider>();
      final user = loginProvider.user;
      provider = context.read<ChannelDataProvider>();
      provider.fetchChannelData(
        user?.userName ?? "",
        user?.token ?? "",
        DateTime.now().toUtc().toIso8601String(),
        user?.userId.toString() ?? "",
        () => loginProvider.logout(context),
        context,
      );
      load();
    });
  }

  Future<void> load() async {
    var missionProvider = context.read<MissionUpload2Provider>();
    missionProvider = context.read<MissionUpload2Provider>();
    await missionProvider.loadMissionsFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.lightGreyColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightGreyColor,
          body: Column(
            children: const [
              TopUserBar(),
              CustomDivider(color: AppColors.dividerColor),
              SizedBox(height: 10),
              Expanded(child: _MainContent()),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _GuidelinesAndKpis(),
        const SizedBox(height: 10),
        const Expanded(child: _CustomerSection()),
      ],
    );
  }
}

class _GuidelinesAndKpis extends StatelessWidget {
  const _GuidelinesAndKpis();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomContainer(
            onTap: () => context.pushNamed(Routes.perfectGuidelineScreen),
            height: 60,
            borderRadius: 15,
            gradient: [
              AppColors.firstBlueColor,
              AppColors.middleBlueColor,
              AppColors.firstBlueColor,
            ],
            showShadow: true,
            child: Row(
              children: [
                Image.asset(AppAssets.guidelines, width: 50, height: 50),
                Expanded(
                  child: Center(
                    child: Text(
                      S.of(context).perfect_store_guidelines,
                      style: TextStyles.buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextDivider(),
          ),
          const MainKpiList(),
        ],
      ),
    );
  }
}

class _CustomerSection extends StatelessWidget {
  const _CustomerSection();

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryWhitColor,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(60)),
          border: Border.all(color: AppColors.dividerColor),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: CustomTextField(
                label: "",
                hint: S.of(context).search_customer,
                controller: searchController,
                useUnderlineBorder: false,
                hintTextColor: AppColors.textGreyColor,
                alwaysShowLabel: true,
                borderRadius: 30,
                hintTextSize: 14,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                onChanged: (value) {
                  context.read<ChannelDataProvider>().searchCustomer(value);
                },
              ),
            ),
            const CustomDivider(
              color: AppColors.dividerColor,
              thickness: 1,
              showShadow: false,
            ),
            const Expanded(child: _CustomerList()),
            const PoweredByWidget(),
          ],
        ),
      ),
    );
  }
}

class _CustomerList extends StatelessWidget {
  const _CustomerList();
  Future<void> _refreshData(BuildContext context) async {
    final loginProvider = context.read<LoginProvider>();
    final provider = context.read<ChannelDataProvider>();
    final user = loginProvider.user;

    await provider.fetchChannelData(
      user?.userName ?? "",
      user?.token ?? "",
      DateTime.now().toUtc().toIso8601String(),
      user?.userId.toString() ?? "",
      () => loginProvider.logout(context),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChannelDataProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          final isNoInternet = provider.error == "No Internet Connection";

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isNoInternet ? Icons.wifi_off : Icons.error,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  isNoInternet
                      ? 'No Internet Connection.\nPlease check your network.'
                      : 'Error: ${provider.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                CustomContainer(
                  width: 100,
                  backgroundColor: AppColors.colorKPIPriceLight,
                  borderRadius: 25,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10,
                      ),

                      child: Text(
                        "Retry",
                        style: TextStyle(
                          color: AppColors.primaryWhitColor,
                          fontFamily: AppFontFamily.cairoBold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final customersWithCluster = provider.customersWithCluster;

        return RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child:
              customersWithCluster.isEmpty
                  ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      SizedBox(height: 100),
                      Center(
                        child: Text(
                          'No channel data found.\nPull down to refresh.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ],
                  )
                  : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: customersWithCluster.length,
                    itemBuilder: (context, index) {
                      final data = customersWithCluster[index];

                      return CustomerItemWidget(
                        customer: data['customer'],
                        clustName: data['cluster'],
                        productFrequency: data['productFrequency'],
                        priceFrequency: data['priceFrequency'],
                        placeFrequency: data['placeFrequency'],
                        promoFrequency: data['promoFrequency'],
                        productMustItem: data['ProductMustItems'],
                        priceMustItem: data['PriceMustItems'],
                        placeMustItem: data['PlaceMustItems'],
                        promoMustItem: data['PromoMustItems'],
                        channelId: data['channelId'],
                        isImageMandatory: data['isImageMandatory'] ?? false,
                        showPlace: data['showPlace'],
                        showPrice: data['showPrice'],
                        showProduct: data['showProduct'],
                        showPromo: data['showPromo'],
                      );
                    },
                  ),
        );
      },
    );
  }
}
