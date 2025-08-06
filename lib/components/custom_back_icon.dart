import 'package:flutter/material.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
