import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/constants/colors.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color backgroundColor;
  final List<Color>? gradient; 
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final bool showShadow;
  const CustomContainer({
    Key? key,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.gradient,
    this.borderRadius = 10,
    this.boxShadow,
    this.padding,
    this.margin,
    this.child,
    this.border,
    this.onTap,
    this.showShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: gradient == null ? backgroundColor : null,
          gradient: gradient != null ? LinearGradient(colors: gradient!) : null,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow:
              showShadow
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ]
                  : null,
          border: border,
        ),
        child: child,
      ),
    );
  }
}
