import 'package:flutter/material.dart';

class KpiCircles extends StatelessWidget {
  final bool isShow;
  final Color startColor;
  final Color endColor;

  // Update constructor to accept two colors for gradient
  const KpiCircles({
    super.key,
    required this.isShow,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isShow) return const SizedBox.shrink();

    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [startColor, endColor, startColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
