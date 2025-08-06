import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/constants/app_font_family.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController controller;
  final TextStyle? labelStyle;
  final bool useUnderlineBorder;
  final Color? hintTextColor;
  final bool alwaysShowLabel;
  final double borderRadius;
  final double hintTextSize;
  final String hintFontFamily;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;

  // Add this parameter
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    this.label,
    required this.hint,
    this.icon,
    required this.controller,
    this.obscureText = false,
    this.labelStyle,
    this.useUnderlineBorder = true,
    this.hintTextColor,
    this.alwaysShowLabel = false,
    this.borderRadius = 8.0,
    this.hintTextSize = 12,
    this.contentPadding,
    this.hintFontFamily = AppFontFamily.cairoRegular,
    this.focusNode,
    this.keyboardType, // add here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder enabledBorder =
        useUnderlineBorder
            ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))
            : OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(borderRadius),
            );

    final InputBorder focusedBorder =
        useUnderlineBorder
            ? UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            )
            : OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            );

    return TextField(
      controller: controller,
      obscureText: obscureText,
      focusNode: focusNode,
      keyboardType: keyboardType, // pass here
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        floatingLabelBehavior:
            label == null
                ? FloatingLabelBehavior.never
                : alwaysShowLabel
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintTextColor ?? Colors.grey.shade500,
          fontSize: hintTextSize,
          fontFamily: hintFontFamily,
        ),
        prefixIcon: icon != null ? Icon(icon) : null,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
