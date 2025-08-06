import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class CustomAssetImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  const CustomAssetImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  bool get _isNetwork =>
      imagePath.startsWith('http') || imagePath.startsWith('https');

  @override
  Widget build(BuildContext context) {
    if (_isNetwork) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        color: color,
        fit: fit,
        placeholder:
            (context, url) => SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        errorWidget:
            (context, url, error) =>
                Icon(Icons.broken_image, size: width ?? 40),
      );
    } else {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        color: color,
        fit: fit,
      );
    }
  }
}
