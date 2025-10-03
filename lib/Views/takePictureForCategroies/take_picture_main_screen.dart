import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/widgets/group_name.dart';
import 'package:flutter_salesman_module/components/custom_asset_image.dart';
import 'package:flutter_salesman_module/generated/l10n.dart';
import 'package:flutter_salesman_module/models/category_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:flutter_salesman_module/utils/provider/upload2_provider.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class TakePictureMainScreen extends StatefulWidget {
  final List<CategoryList>? categories;
  final int customerId;
  const TakePictureMainScreen({
    super.key,
    this.categories,
    required this.customerId,
  });

  @override
  State<TakePictureMainScreen> createState() => _TakePictureMainScreenState();
}

class _TakePictureMainScreenState extends State<TakePictureMainScreen> {
  final ImagePicker _picker = ImagePicker();
  Future<bool> _isAndroid13OrAbove() async {
    final version = await DeviceInfoPlugin().androidInfo;
    return version.version.sdkInt >= 33;
  }

  Future<void> _pickImage(String group, int index, int categoryId) async {
    final missionProvider2 = context.read<MissionUpload2Provider>();
    final loginProvider = context.read<LoginProvider>();

    final images = missionProvider2.getImagesByCustomerCategoryGroup(
      customerId: widget.customerId,
      categoryId: categoryId,
      group: group,
      userId: loginProvider.user!.userId ?? 0,
    );

    if (images.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only capture up to 5 images.')),
      );
      return;
    }

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );

    if (source == null) return;

    final permission =
        source == ImageSource.camera
            ? Permission.camera
            : Platform.isIOS
            ? Permission.photos
            : Platform.isAndroid && await _isAndroid13OrAbove()
            ? Permission.photos
            : Permission.storage;

    final status = await permission.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Permission denied')));
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final user = loginProvider.user;

      if (missionProvider2.isNotAvailableForCategory(
        customerId: widget.customerId,
        categoryId: categoryId,
        group: group,
        userId: user!.userId ?? 0,
      )) {
        missionProvider2.toggleNotAvailable(
          customerId: widget.customerId,
          userId: user.userId ?? 0,
          categoryId: categoryId,
          group: group,
        );
      }
      final originalFile = File(pickedFile.path);
      final originalSize = await originalFile.length();
      print(
        "📸 Original image size: ${(originalSize / 1024).toStringAsFixed(2)} KB",
      );

      // 🔹 Compress the image before saving
      final compressedFile = await GlobalMethods.compressImage(originalFile);
      final compressedXFile = XFile(compressedFile!.path);
      final compressedSize = await compressedFile.length();
      print(
        "✅ Compressed image size: ${(compressedSize / 1024).toStringAsFixed(2)} KB",
      );

      // 🔹 Now add the image
      missionProvider2.addImage(
        customerId: widget.customerId,
        userId: user.userId ?? 0,
        categoryId: categoryId,
        group: group,
        imagePath: compressedXFile,
        dataCollectorUserId: user.userId!,
        itemId: widget.categories![index].categoryId ?? 0,
      );
    }
  }

  /*
  Future<void> _pickImage(String group, int index, int categoryId) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );

    if (source == null) return;

    final permission =
        source == ImageSource.camera
            ? Permission.camera
            : Platform.isIOS
            ? Permission.photos
            : Platform.isAndroid && await _isAndroid13OrAbove()
            ? Permission.photos
            : Permission.storage;

    final status = await permission.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Permission denied')));
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      final user = loginProvider.user;
      final capturedImagesProvider = Provider.of<MissionUpload2Provider>(
        context,
        listen: false,
      );
      capturedImagesProvider.addImage(
        customerId: widget.customerId,
        userId: loginProvider.user!.userId ?? 0,
        categoryId: categoryId,
        group: group,
        imagePath: pickedFile,
        dataCollectorUserId: user!.userId!,
        itemId: widget.categories![index].categoryId ?? 0,
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            automaticallyImplyLeading: false,
            leadingWidth: 40,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            backgroundColor: AppColors.buttonBlueTopColor,
            forceElevated: true,

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: 40,
                bottom: 60,
                right: 40,
              ),
              title: Text(
                S.of(context).pictures,
                style: TextStyle(color: AppColors.primaryWhitColor),
              ),
              background: Hero(
                tag: "take_picture_for_category",
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.buttonBlueTopColor,
                        AppColors.buttonBlueMidColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return Column(
                children: [
                  _buildGroupSection(
                    title: S.of(context).secondary_displays,
                    categories: widget.categories,
                    topPadding: 0,
                  ),
                  _buildGroupSection(
                    title: S.of(context).primary_displays,
                    categories: widget.categories,
                    topPadding: 20,
                  ),
                  const SizedBox(height: 40),
                ],
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  } // Helper Methods

  Widget _buildGroupSection({
    required String title,
    required List<CategoryList>? categories,
    required double topPadding,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        children: [
          GroupNameWidget(
            groupTitle: title,
            backgroundStart: AppColors.buttonBlueTopColor,
            backgroundMid: AppColors.buttonBlueMidColor.withValues(alpha: 0.5),
          ),
          GroupedListView<CategoryList, String>(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            elements: categories?.whereType<CategoryList>().toList() ?? [],
            groupBy: (item) => item.categoryName ?? '',
            groupSeparatorBuilder: _buildGroupSeparator,
            itemBuilder: (context, category) {
              final index = widget.categories!.indexOf(category);
              final group = title;
              return _buildCategoryItem(group, index, category.categoryId ?? 0);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGroupSeparator(String groupTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        groupTitle,
        style: const TextStyle(
          fontSize: 20,
          color: AppColors.primaryBlack,
          fontFamily: AppFontFamily.cairoBold,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String group, int index, int categoryId) {
    final missionProvider2 = context.watch<MissionUpload2Provider>();
    final loginProvider = context.read<LoginProvider>();
    final images = missionProvider2.getImagesByCustomerCategoryGroup(
      customerId: widget.customerId,
      categoryId: categoryId,
      group: group,
      userId: loginProvider.user!.userId ?? 0,
    );
    final hasImages = images.isNotEmpty;
    final isNotAvailable = missionProvider2.isNotAvailableForCategory(
      customerId: widget.customerId,
      categoryId: categoryId,
      group: group,
      userId: loginProvider.user!.userId ?? 0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageCard(AppAssets.camera, group, index, categoryId),
          const SizedBox(width: 10),
          if (!hasImages && !isNotAvailable)
            _buildUnavailableCard(group, index, categoryId)
          else if (isNotAvailable)
            _buildNotAvailableSelectedCard(group, index, categoryId)
          else
            Expanded(
              child: SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, i) {
                    final image = images[i];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _buildImageWidget(image),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              missionProvider2.removeImage(
                                customerId: widget.customerId,
                                categoryId: categoryId,
                                group: group,
                                imagePath: image.photo,
                                userId: loginProvider.user!.userId ?? 0,
                              );
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageCard(
    String imagePath,
    String group,
    int index,
    int categoryId,
  ) {
    return GestureDetector(
      onTap: () => _pickImage(group, index, categoryId),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryWhitColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: CustomAssetImage(imagePath: imagePath, width: 60, height: 60),
        ),
      ),
    );
  }

  Widget _buildUnavailableCard(String group, int index, int categoryId) {
    return GestureDetector(
      onTap: () {
        final loginProvider = Provider.of<LoginProvider>(
          context,
          listen: false,
        );
        final capturedImagesProvider = Provider.of<MissionUpload2Provider>(
          context,
          listen: false,
        );
        capturedImagesProvider.toggleNotAvailable(
          customerId: widget.customerId,
          userId: loginProvider.user!.userId ?? 0,
          categoryId: categoryId,
          group: group,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryWhitColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).not_available,
              style: TextStyle(
                color: AppColors.lightGrey2Color,
                fontFamily: AppFontFamily.cairoBold,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 10),
            CustomAssetImage(
              imagePath: AppAssets.cameraNoGrey,
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotAvailableSelectedCard(
    String group,
    int index,
    int categoryId,
  ) {
    return GestureDetector(
      onTap: () {
        final loginProvider = Provider.of<LoginProvider>(
          context,
          listen: false,
        );
        final capturedImagesProvider = Provider.of<MissionUpload2Provider>(
          context,
          listen: false,
        );
        capturedImagesProvider.toggleNotAvailable(
          customerId: widget.customerId,
          userId: loginProvider.user!.userId ?? 0,
          categoryId: categoryId,
          group: group,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red, // Red background when not available is selected
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).not_available,
              style: TextStyle(
                color: AppColors.lightGrey2Color,
                fontFamily: AppFontFamily.cairoBold,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 10),
            CustomAssetImage(
              imagePath: AppAssets.cameraNoGrey,
              width: 60,
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(dynamic image) {
    // Check if we have base64 data
    if (image.photoBase64 != null && image.photoBase64.isNotEmpty) {
      try {
        Uint8List bytes = base64Decode(image.photoBase64);
        return Image.memory(bytes, width: 100, height: 100, fit: BoxFit.cover);
      } catch (e) {
        debugPrint('Error decoding base64 image: $e');
        // Fallback to file if base64 fails
      }
    }

    // Fallback to file display
    return Image.file(
      File(image.photo.path),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}
