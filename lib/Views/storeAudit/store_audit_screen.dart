import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/kpi_details_screen.dart';
import 'package:flutter_salesman_module/Views/storeAudit/storeAuditWidgets/kpi_container.dart';
import 'package:flutter_salesman_module/Views/storeAudit/storeAuditWidgets/top_store_widget.dart';
import 'package:flutter_salesman_module/Views/takePictureForCategroies/take_picture_main_screen.dart';
import 'package:flutter_salesman_module/api/upload_api.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/components/custom_button.dart';
import 'package:flutter_salesman_module/models/category_model.dart';
import 'package:flutter_salesman_module/models/channel_data_model.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload_mission_date.dart';
import 'package:flutter_salesman_module/utils/services/buttonPresses/mission_complete_button.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:provider/provider.dart';

class StoreAuditScreen extends StatefulWidget {
  final int channelId;
  final String customerName;
  final int customerId;

  const StoreAuditScreen({
    super.key,
    required this.channelId,
    required this.customerName,
    required this.customerId,
  });

  @override
  State<StoreAuditScreen> createState() => _StoreAuditScreenState();
}

class _StoreAuditScreenState extends State<StoreAuditScreen> {
  List<KPIModel> kpiList = [];
  ChannelsData? matchingChannel;

  @override
  void initState() {
    super.initState();
    matchingChannel = GlobalMethods.getChannelById(widget.channelId, context);
    kpiList = GlobalMethods.getKpiList(
      widget.channelId,
      context,
      matchingChannel,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final loginProvider = context.read<LoginProvider>();

      final customerId = widget.customerId;
      final dataCollectorUserId = loginProvider.user!.userId!;
      final visitDate = DateTime.now().toUtc().toIso8601String();

      final missionProvider2 = context.read<MissionUpload2Provider>();
      if (missionProvider2.getMission(
            customerId,
            loginProvider.user!.userId ?? 0,
          ) ==
          null) {
        missionProvider2.initializeMission(
          customerId: customerId,
          userId: dataCollectorUserId,
          visitDate: visitDate,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
    final missionProvider = Provider.of<MissionUpload2Provider>(context);
    final userId = loginProvider.user!.userId ?? 0;
    final categories = matchingChannel?.categories ?? [];

    final isCompletedPromo = missionProvider.isPromoCompletedFromMission(
      customerId: widget.customerId,
      userId: userId,
    );
    final isCompletedPlace = missionProvider.isPlaceCompletedFromMission(
      customerId: widget.customerId,
      userId: loginProvider.user!.userId ?? 0,
    );
    final isCompletedPrice =
        missionProvider.getSelectionCount(widget.customerId, userId) > 0;

    final isDone = missionProvider.isCompleted(
      customerId: widget.customerId,
      userId: userId,
    );

    final hasKpiId1 = kpiList.any((kpi) => kpi.kpiId == '1');
    final hasKpiId2 = kpiList.any((kpi) => kpi.kpiId == '2');
    final hasKpiId3 = kpiList.any((kpi) => kpi.kpiId == '3');
    final hasKpiId4 = kpiList.any((kpi) => kpi.kpiId == '4');

    final showProduct = hasKpiId1 ? isDone : null;
    final showPrice = hasKpiId2 ? isCompletedPrice : null;
    final showPlace = hasKpiId3 ? isCompletedPlace : null;
    final showPromo = hasKpiId4 ? isCompletedPromo : null;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryWhitColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryWhitColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                TopStoreWidget(customerName: widget.customerName),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ([
                        showProduct,
                        showPrice,
                        showPlace,
                        showPromo,
                      ].whereType<bool>().every((e) => e))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: CustomContainer(
                            onTap: () async {
                              final date = GlobalMethods.getFormattedGmtDate();
                              final mission = missionProvider.getMission(
                                widget.customerId,
                                userId,
                              );

                              try {
                                if (mission != null &&
                                    mission.totalScore != null) {
                                  await UploadApi.uploadMissionApi(
                                    loginProvider.user?.userName ?? "",
                                    userId.toString(),
                                    date,
                                    loginProvider.user?.token ?? "",
                                    mission,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Mission uploaded successfully!",
                                      ),
                                    ),
                                  );

                                  context
                                      .read<MissionUploadDateProvider>()
                                      .setUploadDateForCustomer(
                                        mission.customerId,
                                        DateTime.tryParse(mission.timeOut!)!,
                                      );
                                } else {
                                  completeMissionPress(
                                    context,
                                    widget.customerId,
                                    loginProvider.user!.userId ?? 0,
                                  );
                                }
                              } catch (e) {
                                print("$e");
                              }
                            },
                            height: 70,
                            borderRadius: 15,
                            showShadow: true,
                            gradient: [
                              AppColors.primaryRed,
                              AppColors.buttonRedMidColor,
                              AppColors.primaryRed,
                            ],
                            child: _buildCardRow(
                              "",
                              missionProvider
                                          .getMission(
                                            widget.customerId,
                                            userId,
                                          )!
                                          .totalScore !=
                                      null
                                  ? "Upload Mission"
                                  : "Complete your mission",
                              centerText: true,
                              checkTrue: true,
                            ),
                          ),
                        ),
                      const Text(
                        "Store Audit:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Watchout
                      _buildWatchoutCard(),

                      // Generic Questions
                      if ((matchingChannel?.genericQuestions ?? []).isNotEmpty)
                        _buildGenericQuestionCard(
                          matchingChannel!.genericQuestions!.length,
                        ),

                      // Take Picture
                      _buildCameraCard(categories),

                      const SizedBox(height: 20),

                      // KPI Grid
                      _buildKpiGrid(
                        kpiList,
                        isCompletedPrice,
                        isCompletedPlace,
                        isCompletedPromo,
                        isDone,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWatchoutCard() {
    return CustomContainer(
      onTap: () {
        final missionProvider = context.read<MissionUpload2Provider>();
        final loginProvider = context.read<LoginProvider>();
        final userId = loginProvider.user!.userId ?? 0;
        missionProvider.printMissionDetails(
          customerId: widget.customerId,
          userId: userId,
        );
      },
      height: 70,
      borderRadius: 15,
      showShadow: true,
      gradient: [
        AppColors.buttonRedTopColor,
        AppColors.buttonRedMidColor,
        AppColors.buttonRedTopColor,
      ],
      child: _buildCardRow(AppAssets.watchOutImage, "Add a Watchout"),
    );
  }

  Widget _buildGenericQuestionCard(int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CustomContainer(
        onTap: () {},
        height: 70,
        borderRadius: 15,
        showShadow: true,
        gradient: [
          AppColors.buttonGreenTopColor,
          AppColors.buttonGreenMidColor,
          AppColors.buttonGreenTopColor,
        ],
        child: _buildCardRow(
          AppAssets.genericQuiestions,
          "Answer $count Questions",
        ),
      ),
    );
  }

  Widget _buildCameraCard(List<CategoryList> categories) {
    final loginProvider = context.read<LoginProvider>();
    final missionProvider2 = context.watch<MissionUpload2Provider>();
    final imageCount = missionProvider2.getTotalImagesByCustomer(
      customerId: widget.customerId,
      userId: loginProvider.user!.userId ?? 0,
    );

    final displayText =
        imageCount > 0
            ? '$imageCount Picture${imageCount > 1 ? 's' : ''} Taken'
            : 'Take pictures of all your categories';
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Hero(
        tag: "take_picture_for_category",
        child: CustomContainer(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (_) => TakePictureMainScreen(
                      categories: categories,
                      customerId: widget.customerId,
                    ),
              ),
            );
          },
          height: 70,
          borderRadius: 15,
          showShadow: true,
          gradient: [
            AppColors.buttonBlueTopColor,
            AppColors.buttonBlueMidColor,
          ],
          child: _buildCardRow(
            AppAssets.camera,
            displayText,
            centerText: true,
            checkTrue: true,
          ),
        ),
      ),
    );
  }

  Widget _buildCardRow(
    String icon,
    String title, {
    bool centerText = false,
    bool checkTrue = false,
  }) {
    final loginProvider = context.read<LoginProvider>();
    final missionProvider2 = context.read<MissionUpload2Provider>();
    final imageCount = missionProvider2.getTotalImagesByCustomer(
      customerId: widget.customerId,
      userId: loginProvider.user!.userId ?? 0,
    );
    return Row(
      children: [
        if (icon != "")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomAssetImage(
              imagePath: icon,
              width: 50,
              height: 50,
              color: AppColors.darkGrey.withOpacity(0.7),
            ),
          ),
        Expanded(
          child: Center(
            child: Text(
              title,
              textAlign: centerText ? TextAlign.center : TextAlign.start,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (imageCount > 0 && checkTrue)
          Icon(Icons.check, size: 26, color: AppColors.primaryWhitColor),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _buildKpiGrid(
    List<KPIModel> kpis,

    bool donePrice,
    bool donePlace,
    bool donePromo,
    bool productdone,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kpis.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2.2,
      ),
      itemBuilder: (context, index) {
        final kpi = kpis[index];
        final kpiId = kpi.kpiId;

        final completed =
            kpiId == "1"
                ? productdone
                : kpiId == "2"
                ? donePrice
                : kpiId == "3"
                ? donePlace
                : kpiId == "4"
                ? donePromo
                : false;

        return GestureDetector(
          onTap:
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (_) => KpiDetailsScreen(
                        index: int.parse(kpiId ?? ""),
                        item: kpi,
                        customerId: widget.customerId,
                        listProducts: matchingChannel!.productMustItems,
                        listPlace: matchingChannel!.placeMustItems,
                        listPrice: matchingChannel!.priceMustItems,
                        listPromo: matchingChannel!.promoMustItems,
                      ),
                ),
              ),
          child: KpiCard(
            index: int.parse(kpiId ?? ""),
            customerId: widget.customerId,
            subTitle: kpi.description ?? "",
            tag: 'kpi_item_$kpiId',
            kpiItem: kpi,
            isShowComplete: completed,
            isShowPerc: completed,
          ),
        );
      },
    );
  }
}
