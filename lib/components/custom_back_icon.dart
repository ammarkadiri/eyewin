import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      padding: EdgeInsets.zero,
      alignment:
          GlobalMethods.getLocale() == "ar"
              ? Alignment.centerRight
              : Alignment.centerLeft,

      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
