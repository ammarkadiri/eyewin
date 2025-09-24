import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;
  final Color color;
  final double indent;
  final double endIndent;
  final bool showShadow;
  const CustomDivider({
    super.key,
    this.thickness = 1.0,
    this.color = Colors.grey,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent),
      child: Container(
        height: thickness,
        decoration: BoxDecoration(
          color: color,
          boxShadow:
              showShadow
                  ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                  : null,
        ),
      ),
    );
  }
}
