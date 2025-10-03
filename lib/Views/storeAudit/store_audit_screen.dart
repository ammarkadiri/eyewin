import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/kpi_details_screen.dart';
import 'package:flutter_salesman_module/Views/storeAudit/storeAuditWidgets/kpi_container.dart';
import 'package:flutter_salesman_module/Views/storeAudit/storeAuditWidgets/top_store_widget.dart';
import 'package:flutter_salesman_module/Views/takePictureForCategroies/take_picture_main_screen.dart';
import 'package:flutter_salesman_module/api/upload_api.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/components/custom_button.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/models/category_model.dart';
import 'package:flutter_salesman_module/models/channel_data_model.dart';
import 'package:flutter_salesman_module/models/customer_model.dart';
import 'package:flutter_salesman_module/models/kpi_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/get_mission_upload.dart';
import 'package:flutter_salesman_module/utils/provider/loader_provider.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload_mission_date.dart';
import 'package:flutter_salesman_module/utils/provider/channel_data_provider.dart';
import 'package:flutter_salesman_module/utils/services/buttonPresses/mission_complete_button.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:provider/provider.dart';

class StoreAuditScreen extends StatefulWidget {
  final int channelId;
  final String customerName;
  final int customerId;
  final String customerPicture;
  final Customer? customer;
  final bool isImageMandatory;

  const StoreAuditScreen({
    super.key,
    required this.channelId,
    required this.customerName,
    required this.customerId,
    required this.customerPicture,
    this.customer,
    required this.isImageMandatory,
  });

  @override
  State<StoreAuditScreen> createState() => _StoreAuditScreenState();
}

class _StoreAuditScreenState extends State<StoreAuditScreen> {
  List<KPIModel> kpiList = [];
  ChannelsData? matchingChannel;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    matchingChannel = GlobalMethods.getChannelById(widget.channelId, context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalMethods.checkBatteryLevel(context);
      _initializeMission();
    });
  }

  // List<ProductMustItem> listOfProducts = [];
  Future<void> _initializeMission() async {
    final loginProvider = context.read<LoginProvider>();
    final missionProvider = context.read<MissionUpload2Provider>();

    final customerId = widget.customerId;
    final dataCollectorUserId = loginProvider.user!.userId!;

    final mission = missionProvider.getMission(
      widget.customerId,
      dataCollectorUserId,
    );
    if (mission == null) {
      kpiList = GlobalMethods.getKpiList(
        widget.channelId,
        context,
        matchingChannel,
        widget.customer,
      );
      final hasKpiId1 = kpiList.any((kpi) => kpi.kpiId == '1');
      final hasKpiId2 = kpiList.any((kpi) => kpi.kpiId == '2');
      final hasKpiId3 = kpiList.any((kpi) => kpi.kpiId == '3');
      final hasKpiId4 = kpiList.any((kpi) => kpi.kpiId == '4');

      missionProvider.initializeMission(
        customerId: customerId,
        userId: dataCollectorUserId,
        showProduct: hasKpiId1,
        showPrice: hasKpiId2,
        showPlace: hasKpiId3,
        showPromo: hasKpiId4,
        customerNameByDC: widget.customerName,
        customerPictureByDC: widget.customerPicture,
        placeItem: matchingChannel!.placeMustItems ?? [],
        productList: matchingChannel!.productMustItems ?? [],
        promoItem: matchingChannel!.promoMustItems ?? [],
        priceList: matchingChannel!.priceMustItems ?? [],
      );
    } else {
      missionProvider.updateMission(
        clustProducts: matchingChannel!.productMustItems ?? [],
        clustPlaces: matchingChannel!.placeMustItems ?? [],
        clustPromo: matchingChannel!.promoMustItems ?? [],
        clustPrice: matchingChannel!.priceMustItems ?? [],
        customerId: customerId,
        userId: dataCollectorUserId,
      );
      kpiList = GlobalMethods.getKpiList(
        widget.channelId,
        matcingProducts: mission.product,
        matchingPlaces: mission.place,
        matchingPromo: mission.promo,
        matchingPrices: mission.price,
        context,
        matchingChannel,
        widget.customer,
        showProduct: mission.showProduct,
        showPrice: mission.showPrice,
        showPlace: mission.showPlace,
        showPromo: mission.showPromo,
      );
      setState(() {});
    }

    // Hide loader after initialization is complete
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
    final missionProvider = Provider.of<MissionUpload2Provider>(context);
    final userId = loginProvider.user!.userId ?? 0;
    final categories = matchingChannel?.categories ?? [];

    // Rebuild KPI list when mission changes
    final currentMission = missionProvider.getMission(
      widget.customerId,
      userId,
    );
    if (currentMission != null) {
      kpiList = GlobalMethods.getKpiList(
        widget.channelId,
        matcingProducts: currentMission.product,
        matchingPlaces: currentMission.place,
        matchingPromo: currentMission.promo,
        matchingPrices: currentMission.price,
        context,
        matchingChannel,
        widget.customer,
        showProduct: currentMission.showProduct,
        showPrice: currentMission.showPrice,
        showPlace: currentMission.showPlace,
        showPromo: currentMission.showPromo,
      );
    }

    final isCompletedPromo = missionProvider.isPromoCompletedFromMission(
      customerId: widget.customerId,
      userId: userId,
      currentChannelPromos: matchingChannel?.promoMustItems,
    );
    final isCompletedPlace = missionProvider.isPlaceCompletedFromMission(
      customerId: widget.customerId,
      userId: loginProvider.user!.userId ?? 0,
      currentChannelPlaces: matchingChannel?.placeMustItems,
    );
    final isCompletedPrice =
        missionProvider.getSelectionCount(widget.customerId, userId) > 0;

    final isDone = missionProvider.isCompleted(
      customerId: widget.customerId,
      userId: userId,
    );
    final missionProvider2 = context.watch<MissionUpload2Provider>();
    final imageCount = missionProvider2.getTotalImagesByCustomer(
      customerId: widget.customerId,
      userId: loginProvider.user!.userId ?? 0,
    );
    final unAvImages = missionProvider2.getNotAvailableItems(
      customerId: widget.customerId,
      userId: loginProvider.user!.userId ?? 0,
    );

    final mission = missionProvider.getMission(widget.customerId, userId);
    if (mission == null || _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final showProduct = mission.showProduct ? isDone : null;
    final showPrice = mission.showPrice ? isCompletedPrice : null;
    final showPlace = mission.showPlace ? isCompletedPlace : null;
    final showPromo = mission.showPromo ? isCompletedPromo : null;
    final showCategoryImages =
        (widget.isImageMandatory &&
            (imageCount + unAvImages.length) >= (categories.length * 2)) ||
        (!widget.isImageMandatory);
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
                        showCategoryImages,
                      ].whereType<bool>().every((e) => e))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Consumer<LoaderProvider>(
                            builder: (context, loaderProvider, child) {
                              final isUploading = loaderProvider.isLoading(
                                'mission_upload',
                              );

                              return CustomContainer(
                                onTap:
                                    isUploading
                                        ? null
                                        : () async {
                                          final loaderProvider =
                                              context.read<LoaderProvider>();
                                          final missionServerProvider =
                                              Provider.of<
                                                MissionUploadServerProvider
                                              >(context, listen: false);

                                          // Start loading
                                          loaderProvider.show('mission_upload');

                                          try {
                                            final date =
                                                GlobalMethods.getFormattedGmtDate();

                                            final missionServ =
                                                missionServerProvider
                                                    .getMission(
                                                      widget.customerId,
                                                      userId,
                                                    );

                                            if (missionServ != null &&
                                                missionServ.totalScore !=
                                                    null) {
                                              await UploadApi.uploadMissionApi(
                                                loginProvider.user?.userName ??
                                                    "",
                                                userId.toString(),
                                                date,
                                                loginProvider.user?.token ?? "",
                                                missionServ,
                                              );

                                              Navigator.pop(context);
                                              final provider =
                                                  context
                                                      .read<
                                                        ChannelDataProvider
                                                      >();
                                              provider.fetchChannelData(
                                                loginProvider.user?.userName ??
                                                    "",
                                                loginProvider.user?.token ?? "",
                                                DateTime.now()
                                                    .toUtc()
                                                    .toIso8601String(),
                                                loginProvider.user?.userId
                                                        .toString() ??
                                                    "",
                                                () => loginProvider.logout(
                                                  context,
                                                ),
                                                context,
                                              );

                                              var missionProvider =
                                                  context
                                                      .read<
                                                        MissionUpload2Provider
                                                      >();
                                              missionProvider =
                                                  context
                                                      .read<
                                                        MissionUpload2Provider
                                                      >();
                                              await missionProvider
                                                  .loadMissionsFromStorage();
                                              missionProvider.clearMission(
                                                customerId: widget.customerId,
                                                userId: userId,
                                              );
                                              context
                                                  .read<
                                                    MissionUploadDateProvider
                                                  >()
                                                  .setUploadDateForCustomer(
                                                    mission.customerId,
                                                    DateTime.tryParse(
                                                      mission.timeOut!,
                                                    )!,
                                                  );
                                            } else {
                                              completeMissionPress(
                                                context,
                                                widget.customerId,
                                                loginProvider.user!.userId ?? 0,
                                              );
                                            }
                                          } catch (e) {
                                            debugPrint('Upload error: $e');
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Upload failed: ${e.toString()}',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          } finally {
                                            // Stop loading
                                            loaderProvider.hide(
                                              'mission_upload',
                                            );
                                          }
                                        },
                                height: 70,
                                borderRadius: 15,
                                showShadow: true,
                                gradient:
                                    isUploading
                                        ? [
                                          Colors.grey.shade400,
                                          Colors.grey.shade500,
                                          Colors.grey.shade400,
                                        ]
                                        : [
                                          AppColors.primaryRed,
                                          AppColors.buttonRedMidColor,
                                          AppColors.primaryRed,
                                        ],
                                child:
                                    isUploading
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(Colors.white),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              S.of(context).uploading,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                        : _buildCardRow(
                                          "",
                                          mission.totalScore != null
                                              ? S
                                                  .of(context)
                                                  .upload_your_mission
                                              : S.of(context).complete_mission,
                                          centerText: true,
                                          checkTrue: true,
                                        ),
                              );
                            },
                          ),
                        ),
                      Text(
                        S.of(context).store_check,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlack,
                        ),
                      ),
                      //     const SizedBox(height: 20),

                      // Watchout
                      // _buildWatchoutCard(),

                      // Generic Questions
                      /* if ((matchingChannel?.genericQuestions ?? []).isNotEmpty)
                        _buildGenericQuestionCard(
                          matchingChannel!.genericQuestions!.length,
                        ),*/

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

  /* Widget _buildWatchoutCard() {
    return CustomContainer(
      onTap: () {
      },
      height: 70,
      borderRadius: 15,
      showShadow: true,
      gradient: [
        AppColors.buttonRedTopColor,
        AppColors.buttonRedMidColor,
        AppColors.buttonRedTopColor,
      ],
      child: _buildCardRow(AppAssets.watchOutImage, S.of(context).add_watchout),
    );
  }

  Widget _buildGenericQuestionCard(int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CustomContainer(
        onTap: () {
        },
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
  }*/

  Widget _buildCameraCard(List<CategoryList> categories) {
    final loginProvider = context.read<LoginProvider>();
    final missionProvider2 = context.watch<MissionUpload2Provider>();
    final imageCount = missionProvider2.getTotalImagesByCustomer(
      customerId: widget.customerId,
      userId: loginProvider.user!.userId ?? 0,
    );
    final displayText =
        imageCount > 0
            ? '$imageCount ${imageCount > 1 ? S.of(context).pictures_taken : S.of(context).picture_taken}'
            : S.of(context).take_pictures;
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
              color: AppColors.darkGrey.withValues(alpha: 0.7),
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
    final loginProvider = context.read<LoginProvider>();
    final missionProvider = Provider.of<MissionUpload2Provider>(context);
    final userId = loginProvider.user!.userId ?? 0;
    final mission = missionProvider.getMission(widget.customerId, userId);
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
                        listProducts:
                            mission!.product.isNotEmpty
                                ? mission.product
                                : matchingChannel!.productMustItems,
                        listPlace:
                            mission.place.isNotEmpty
                                ? mission.place
                                : matchingChannel!.placeMustItems,
                        listPrice:
                            mission.price.isNotEmpty
                                ? mission.price
                                : matchingChannel!.priceMustItems,
                        listPromo:
                            mission.promo.isNotEmpty
                                ? mission.promo
                                : matchingChannel!.promoMustItems,
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
